#include "llvm/ADT/StringExtras.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Operator.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

using namespace llvm;

static cl::opt<std::string> OutputPath(
    "array-profile-out",
    cl::desc("Specify the file path to write the array profile to."),
    cl::value_desc("filepath")
);

namespace {

struct ArrayProfile {
    std::string ArrayName;
    std::string FunctionName;
    std::vector<uint32_t> Dimensions;
    uint32_t ElementBitwidth;
    uint32_t TotalElements;
    bool HasFPElements = false;
    bool IsGlobal = false;
    bool IsParameter = false;
};

struct ArrayProfilerPass : public PassInfoMixin<ArrayProfilerPass> {
    std::unordered_map<std::string, std::vector<uint32_t>> DecayedDimsMap;
    std::map<std::string, ArrayProfile> ProfiledArrays;

    PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
        #define DEBUG_TYPE "array-profiler"

        if (OutputPath.empty()) {
            errs() << "Missing required arguments. Use -array-profile-out=<file>\n";
            return PreservedAnalyses::all();
        }
        profileArrays(M);
        serialize(M);

        return PreservedAnalyses::all();
    }

    void serialize(Module& M) {
        std::ofstream OutFile(OutputPath);
        if (!OutFile.is_open()) {
            errs() << "Error opening file: " << OutputPath << "\n";
            return;
        }

        OutFile << "{\n";
        bool FirstEntry = true;

        for (const auto& It : ProfiledArrays) {
            const std::string& Label = It.first;
            const ArrayProfile& AP = It.second;

            if (AP.Dimensions.empty()) continue;

            if (!FirstEntry) OutFile << ",\n";
            FirstEntry = false;

            OutFile << "\t\"" << Label << "\": {\n";

            OutFile << "\t\t\"ArrayName\": \"" << AP.ArrayName << "\",\n";
            OutFile << "\t\t\"FunctionName\": \"" << AP.FunctionName << "\",\n";
            OutFile << "\t\t\"ElementBitwidth\": " << AP.ElementBitwidth << ",\n";
            OutFile << "\t\t\"TotalElements\": " << AP.TotalElements << ",\n";
            OutFile << "\t\t\"HasFPElements\": " << std::to_string(AP.HasFPElements ? 1 : 0) << ",\n";
            OutFile << "\t\t\"IsGlobal\": " << std::to_string(AP.IsGlobal ? 1 : 0) << ",\n";
            OutFile << "\t\t\"IsParameter\": " << std::to_string(AP.IsParameter ? 1 : 0) << ",\n";

            OutFile << "\t\t\"Dimensions\": [";
            OutFile << AP.Dimensions[0];
            for (int i = 1; i < AP.Dimensions.size(); i++) {
                OutFile << ", " << AP.Dimensions[i];
            }
            OutFile << "]\n\t}";
        }
        OutFile << "\n}";
    }

    void profileArrays(Module& M) {
        buildDecayedDimMapFromDI(M);
        profileGlobalArrays(M);
        profileArrayParameters(M);
        profileAllocatedArrays(M);
    }

    void profileGlobalArrays(Module& M) {
        for (GlobalObject& G : M.getGlobalList()) {
            Type* Ty = G.getValueType();
            if (Ty->isPointerTy()) Ty = Ty->getPointerElementType(); 
            if (!Ty->isArrayTy()) continue;

            const std::string& GlobalName = G.getName().str();
            std::string FunctionName, ArrayName, Label;
            bool IsGlobal = true;
            
            if (GlobalName.find("__const.") != std::string::npos) {
                std::string TempName = GlobalName.substr(9);
                size_t DotPos = TempName.find('.');
                if (DotPos != std::string::npos) {
                    IsGlobal = false;
                    FunctionName = TempName.substr(0, DotPos);
                    ArrayName = TempName.substr(DotPos + 1);
                    Label = FunctionName + "/" + ArrayName;
                }
            }
            if (IsGlobal) {
                FunctionName = "";
                ArrayName = GlobalName;
                Label = GlobalName;
            }

            ArrayProfile AP;
            AP.ArrayName = ArrayName;
            AP.FunctionName = FunctionName;
            AP.IsGlobal = IsGlobal;
            AP.TotalElements = 1;

            Type* ElemTy = Ty;
            while (ElemTy->isArrayTy()) {
                uint32_t DimSize = (uint32_t)ElemTy->getArrayNumElements();
                AP.Dimensions.push_back(DimSize);
                AP.TotalElements *= DimSize;
                ElemTy = ElemTy->getArrayElementType();
            }
            
            AP.ElementBitwidth = ElemTy->getPrimitiveSizeInBits();
            AP.HasFPElements = ElemTy->isFloatingPointTy();
            ProfiledArrays[Label] = AP;
        }
    }

    void profileArrayParameters(Module& M) {
        for (Function &F : M) {
            if (F.isDeclaration() || F.isIntrinsic()) continue;
            
            std::string FunctionName = F.hasName() ? F.getName().str() : "";
            if (FunctionName.empty()) continue;

            for (Argument &Arg : F.args()) {
                std::string ArgName = Arg.hasName() ? Arg.getName().str() : "";
                if (ArgName.empty()) continue;

                std::string Label = FunctionName + "/" + ArgName;
                if (DecayedDimsMap.find(Label) == DecayedDimsMap.end()) continue;

                ArrayProfile AP;
                AP.ArrayName = ArgName;
                AP.FunctionName = FunctionName;
                AP.IsParameter = true;
                AP.Dimensions = DecayedDimsMap[Label];
                AP.TotalElements = 1;

                for (uint32_t DimSize : AP.Dimensions) {
                    AP.TotalElements *= DimSize;
                }

                Type* Ty = Arg.getType();
                while (Ty->isPointerTy()) Ty = Ty->getPointerElementType();
                while (Ty->isArrayTy()) Ty = Ty->getArrayElementType();
                
                AP.ElementBitwidth = Ty->getPrimitiveSizeInBits();
                AP.HasFPElements = Ty->isFloatingPointTy();
                ProfiledArrays[Label] = AP;
            }
        }
    }

    void profileAllocatedArrays(Module& M) {
        for (Function &F : M) {
            if (F.isDeclaration() || F.isIntrinsic()) continue;
            
            std::string FunctionName = F.hasName() ? F.getName().str() : "";
            if (FunctionName.empty()) continue;

            for (BasicBlock& BB : F) {
                for (Instruction& I : BB) {
                    if (I.hasName()) {
                        if (AllocaInst* AI = dyn_cast<AllocaInst>(&I)) {
                            Type* Ty = AI->getAllocatedType();
                            if (Ty->isPointerTy()) Ty = Ty->getPointerElementType();
                            if (!Ty->isArrayTy()) continue;
                            
                            std::string ArrayName = I.getName().str();
                            std::string Label = FunctionName + "/" + ArrayName;
                            
                            ArrayProfile AP;
                            AP.ArrayName = ArrayName;
                            AP.FunctionName = FunctionName;
                            AP.TotalElements = 1;

                            Type* ElemTy = Ty;
                            while (ElemTy->isArrayTy()) {
                                uint32_t DimSize = (uint32_t)ElemTy->getArrayNumElements();
                                AP.Dimensions.push_back(DimSize);
                                AP.TotalElements *= DimSize;
                                ElemTy = ElemTy->getArrayElementType();
                            }
                            
                            AP.ElementBitwidth = ElemTy->getPrimitiveSizeInBits();
                            AP.HasFPElements = ElemTy->isFloatingPointTy();
                            ProfiledArrays[Label] = AP;
                        }
                    }
                }
            }
        }
    }

    void buildDecayedDimMapFromDI(Module &M) {
        for (Function &F : M) {
            if (F.isDeclaration() || F.isIntrinsic()) continue;
            
            std::string FunctionName = F.hasName() ? F.getName().str() : "";
            if (FunctionName.empty()) continue;

            DISubprogram *SP = F.getSubprogram();
            if (!SP) continue; // Skip if compiled without -g

            DISubroutineType *SubroutineType = SP->getType();
            DITypeRefArray TypeArray = SubroutineType->getTypeArray();

            unsigned ArgIdx = 0;
            for (Argument &Arg : F.args()) {
                std::string ArgName = Arg.hasName() ? Arg.getName().str() : "";
                if (!ArgName.empty()) {
                    unsigned DIIdx = ArgIdx + 1; // +1 because TypeArray[0] is the return type
                    
                    if (DIIdx < TypeArray.size()) {
                        DIType *ArgType = TypeArray[DIIdx];

                        // Strip away typedefs, const qualifiers, and pointers 
                        while (auto *Derived = dyn_cast_or_null<DIDerivedType>(ArgType)) {
                            ArgType = Derived->getBaseType();
                        }

                        // Check if the original source type was an array
                        if (auto *Composite = dyn_cast_or_null<DICompositeType>(ArgType)) {
                            if (Composite->getTag() == dwarf::DW_TAG_array_type) {
                                std::string Label = FunctionName + "/" + ArgName;
                                std::vector<uint32_t> Dims;
                                DINodeArray Elements = Composite->getElements();
                                
                                for (auto *Element : Elements) {
                                    if (auto *Subrange = dyn_cast<DISubrange>(Element)) {
                                        if (auto *CountNode = Subrange->getCount().dyn_cast<ConstantInt*>()) {
                                            Dims.push_back((uint32_t)CountNode->getZExtValue());
                                        }
                                    }
                                }
                                if (!Dims.empty()) {
                                    DecayedDimsMap[Label] = Dims;
                                }
                            }
                        }
                    }
                }
                ArgIdx++;
            }
        }
    }
};

} // End anonymous namespace

// -----------------------------------------------------------------------------------
// NEW PASS MANAGER REGISTRATION
// -----------------------------------------------------------------------------------
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
    return {
        LLVM_PLUGIN_API_VERSION, "ArrayProfiler", LLVM_VERSION_STRING,
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "array-profiler") {
                        MPM.addPass(ArrayProfilerPass());
                        return true;
                    }
                    return false;
                });
        }};
}