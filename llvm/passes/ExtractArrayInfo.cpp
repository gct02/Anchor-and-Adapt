#include <fstream>
#include <iostream>
#include <unordered_map>
#include <string>
#include <utility>
#include <vector>

#include "llvm/ADT/StringExtras.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Operator.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"

using namespace llvm;

static cl::opt<std::string> Output(
    "out-array",
    cl::desc("File where the metadata should be written to"),
    cl::value_desc("filepath")
);

static cl::opt<bool> Lowered(
    "lowered",
    cl::init(false),
    cl::desc("Flag indicating that the IR being processed is lowered"),
    cl::value_desc("flag")
);


namespace {

struct ArrayInfo {
    std::string Name;
    std::string FunctionName;

    std::unordered_map<std::string, uint32_t> Attributes;
    std::vector<uint32_t> Dimensions;

    std::vector<std::pair<std::string, std::string>> Loads;
    std::vector<std::pair<std::string, std::string>> GEPs;
    std::vector<std::pair<std::string, uint32_t>> Stores;

    ArrayInfo(const std::string& Name, const std::string& FunctionName = "")
        : Name(Name), FunctionName(FunctionName) {}

    Optional<uint32_t> getAttribute(const std::string& Key) const {
        auto It = Attributes.find(Key);
        if (It != Attributes.end()) return It->second;
        return Optional<uint32_t>();
    }

    void setAttribute(const std::string& Key, uint32_t Value) {
        Attributes[Key] = Value;
    }

    void addDimension(uint32_t DimSize) {
        Dimensions.push_back(DimSize);
    }

    void addLoad(const std::string& FunctionName, const std::string& InstName) {
        Loads.emplace_back(FunctionName, InstName);
    }

    void addGEP(const std::string& FunctionName, const std::string& InstName) {
        GEPs.emplace_back(FunctionName, InstName);
    }

    void addStore(const std::string& FunctionName, uint32_t InstIndex) {
        Stores.emplace_back(FunctionName, InstIndex);
    }
};

struct ExtractArrayInfoPass : public ModulePass {
    static char ID;
    ExtractArrayInfoPass() : ModulePass(ID) {}

    std::unordered_map<std::string, ArrayInfo*> GlobalArrayInfoMap;
    std::unordered_map<std::string, ArrayInfo*> LocalArrayInfoMap;

    bool runOnModule(Module& M) override {
        #define DEBUG_TYPE "extract-array-info"

        if (Output.empty()) {
            errs() << "Output file not specified.\n";
            return false;
        }

        assignIndicesToStores(M);

        extractGlobalArrayInfo(M);
        extractLocalArrayInfo(M);

        serializeArrayInfo(M);

        return false;
    }

    void serializeArrayInfo(Module& M) {
        std::ofstream OutputStream(Output);
        if (!OutputStream.is_open()) {
            errs() << "Error opening file: " << Output << "\n";
            return;
        }

        OutputStream << "{\n  \"Global\": {\n";
        bool FirstEntry = true;
        for (const auto& Pair : GlobalArrayInfoMap) {
            const std::string& Key = Pair.first;
            const ArrayInfo* AI = Pair.second;

            if (!FirstEntry) OutputStream << ",\n";
            FirstEntry = false;

            OutputStream << "    \"" << Key << "\": {\n";
            OutputStream << "      \"Name\": \"" << AI->Name << "\"";

            for (const auto& Attr : AI->Attributes) {
                OutputStream << ",\n      \"" << Attr.first << "\": " << Attr.second;
            }
            OutputStream << ",\n";

            OutputStream << "      \"Dimensions\": [";
            for (size_t i = 0; i < AI->Dimensions.size(); ++i) {
                if (i > 0) OutputStream << ", ";
                OutputStream << AI->Dimensions[i];
            }
            OutputStream << "],\n";

            OutputStream << "      \"Stores\": [";
            for (size_t i = 0; i < AI->Stores.size(); ++i) {
                if (i > 0) OutputStream << ", ";
                OutputStream << "{ \"FunctionName\": \"" << AI->Stores[i].first
                    << "\", \"Index\": " << AI->Stores[i].second << " }";
            }
            OutputStream << "],\n";

            OutputStream << "      \"Loads\": [";
            for (size_t i = 0; i < AI->Loads.size(); ++i) {
                if (i > 0) OutputStream << ", ";
                OutputStream << "{ \"FunctionName\": \"" << AI->Loads[i].first
                    << "\", \"Name\": \"" << AI->Loads[i].second << "\" }";
            }
            OutputStream << "],\n";

            OutputStream << "      \"GEPs\": [";
            for (size_t i = 0; i < AI->GEPs.size(); ++i) {
                if (i > 0) OutputStream << ", ";
                OutputStream << "{ \"FunctionName\": \"" << AI->GEPs[i].first
                    << "\", \"Name\": \"" << AI->GEPs[i].second << "\" }";
            }
            OutputStream << "]\n";
            OutputStream << "    }";
        }
        OutputStream << "\n  },\n";

        OutputStream << "  \"Local\": {\n";
        FirstEntry = true;
        for (const auto& Pair : LocalArrayInfoMap) {
            const std::string& Key = Pair.first;
            const ArrayInfo* AI = Pair.second;

            if (!FirstEntry) OutputStream << ",\n";
            FirstEntry = false;

            OutputStream << "    \"" << Key << "\": {\n";
            OutputStream << "      \"Name\": \"" << AI->Name << "\",\n";
            OutputStream << "      \"FunctionName\": \"" << AI->FunctionName << "\"";

            for (const auto& Attr : AI->Attributes) {
                OutputStream << ",\n      \"" << Attr.first << "\": " << Attr.second;
            }
            OutputStream << ",\n";

            OutputStream << "      \"Dimensions\": [";
            for (size_t i = 0; i < AI->Dimensions.size(); ++i) {
                if (i > 0) OutputStream << ", ";
                OutputStream << AI->Dimensions[i];
            }
            OutputStream << "],\n";

            OutputStream << "      \"Stores\": [";
            for (size_t i = 0; i < AI->Stores.size(); ++i) {
                if (i > 0) OutputStream << ", ";
                OutputStream << "{ \"FunctionName\": \"" << AI->Stores[i].first
                    << "\", \"Index\": " << AI->Stores[i].second << " }";
            }
            OutputStream << "],\n";

            OutputStream << "      \"Loads\": [";
            for (size_t i = 0; i < AI->Loads.size(); ++i) {
                if (i > 0) OutputStream << ", ";
                OutputStream << "{ \"FunctionName\": \"" << AI->Loads[i].first
                    << "\", \"Name\": \"" << AI->Loads[i].second << "\" }";
            }
            OutputStream << "],\n";

            OutputStream << "      \"GEPs\": [";
            for (size_t i = 0; i < AI->GEPs.size(); ++i) {
                if (i > 0) OutputStream << ", ";
                OutputStream << "{ \"FunctionName\": \"" << AI->GEPs[i].first
                    << "\", \"Name\": \"" << AI->GEPs[i].second << "\" }";
            }
            OutputStream << "]\n";
            OutputStream << "    }";
        }
        OutputStream << "\n  }\n}";
    }

    void extractGlobalArrayInfo(Module& M) {
        for (GlobalObject& G : M.getGlobalList()) {
            Type* Ty = G.getValueType();
            if (Ty->isPointerTy()) {
                Ty = Ty->getPointerElementType();
            }
            if (!Ty->isArrayTy()) continue;

            std::string Name = G.getName().str();
            if (Lowered && Name.rfind("empty", 0) == 0) continue;

            if (!Lowered) {
                size_t DotPos = Name.find('.');
                if (DotPos != std::string::npos) {
                    Name = Name.substr(DotPos + 1);
                }
            }
            ArrayInfo* AI = getArrayInfo(Ty, Name, &G, "");
            AI->setAttribute("Global", 1);
            GlobalArrayInfoMap[Name] = AI;
        }
    }

    void extractLocalArrayInfo(Module& M) {
        for (Function& F : M) {
            std::string FunctionName = F.hasName() ? F.getName().str() : "";

            // Array parameters
            for (Argument& A : F.args()) {
                Type* Ty = A.getType();
                if (Ty->isPointerTy()) {
                    uint32_t DecayedDimSize = getDecayedDimSize(&A);
                    if (DecayedDimSize > 0) {
                        Ty = ArrayType::get(Ty->getPointerElementType(), DecayedDimSize);
                    } else {
                        Ty = Ty->getPointerElementType();
                    }
                }
                if (Ty->isArrayTy()) {
                    std::string Name = A.getName().str();
                    ArrayInfo* AI = getArrayInfo(Ty, Name, &A, FunctionName);
                    AI->setAttribute("Param", 1);
                    LocalArrayInfoMap[FunctionName + "/" + Name] = AI;
                }
            }

            // Arrays allocated in the function body
            for (BasicBlock& BB : F) {
                for (Instruction& I : BB) {
                    if (!I.hasName()) continue;
                    if (AllocaInst* AI = dyn_cast<AllocaInst>(&I)) {
                        Type* Ty = AI->getAllocatedType();
                        if (Ty->isPointerTy()) {
                            Ty = Ty->getPointerElementType();
                        }
                        if (Ty->isArrayTy()) {
                            std::string Name = I.getName().str();
                            ArrayInfo* AInfo = getArrayInfo(Ty, Name, AI, FunctionName);
                            AInfo->setAttribute("Alloca", 1);
                            LocalArrayInfoMap[FunctionName + "/" + Name] = AInfo;
                        }
                    }
                }
            }
        }
    }

    ArrayInfo* getArrayInfo(Type* ArrayTy, std::string ArrayName, Value* Array,
                            std::string FunctionName = "") {
        if (!ArrayTy->isArrayTy()) {
            errs() << "Error: Type is not an array type.\n";
            return nullptr;
        }
        ArrayInfo* AI = new ArrayInfo(ArrayName, FunctionName);

        uint32_t TotalSize = 1;
        Type* BaseTy = ArrayTy;
        while (BaseTy->isArrayTy()) {
            uint32_t DimSize = BaseTy->getArrayNumElements();
            AI->addDimension(DimSize);
            TotalSize *= DimSize;
            BaseTy = BaseTy->getArrayElementType();
        }
        AI->setAttribute("BaseType", BaseTy->getTypeID());
        AI->setAttribute("BaseBitwidth", BaseTy->getPrimitiveSizeInBits());
        AI->setAttribute("NumDimensions", AI->Dimensions.size());
        AI->setAttribute("TotalSize", TotalSize);
        if (Lowered) {
            collectArrayAccessInfo(AI, Array);
        }
        return AI;
    }

    void collectArrayAccessInfo(ArrayInfo* AccessInfo, Value* Array) {
        for (auto& U : Array->uses()) {
            if (auto* I = dyn_cast<Instruction>(U.getUser())) {
                addUserInstInfo(AccessInfo, I);
                if (auto* GEP = dyn_cast<GEPOperator>(I)) {
                    // If the instruction is a GEPOperator, we need to check its users
                    // to find the actual load/store instructions that uses the array.
                    for (auto GEPUser : GEP->users()) {
                        if (auto* GEPUserInst = dyn_cast<Instruction>(GEPUser)) {
                            addUserInstInfo(AccessInfo, GEPUserInst);
                        }
                    }
                }
            }
        }
    }

    void addUserInstInfo(ArrayInfo* AI, Instruction* Inst) {
        std::string FunctionName = "";

        if (auto* F = Inst->getFunction()) {
            if (F->hasName()) FunctionName = F->getName().str();
        }
        if (FunctionName.empty()) return;

        if (auto* SI = dyn_cast<StoreInst>(Inst)) {
            Optional<uint32_t> StoreIdx = getStoreIndex(*Inst);
            if (!StoreIdx.hasValue()) return;

            AI->addStore(FunctionName, StoreIdx.getValue());
        } else {
            if (!Inst->hasName()) return;

            std::string InstName = Inst->getName().str();

            if (auto* LI = dyn_cast<LoadInst>(Inst)) {
                AI->addLoad(FunctionName, InstName);
            } else if (auto* GEP = dyn_cast<GEPOperator>(Inst)) {
                AI->addGEP(FunctionName, InstName);
            }
        }
    }

    Optional<uint32_t> getStoreIndex(const Instruction& I) const {
        if (auto* MD = I.getMetadata("storeIdx")) {
            if (auto* CAM = dyn_cast<ConstantAsMetadata>(MD->getOperand(0))) {
                if (auto* CI = dyn_cast<ConstantInt>(CAM->getValue())) {
                    return CI->getSExtValue();
                }
            }
        }
        return Optional<uint32_t>();
    }

    void assignIndicesToStores(Module& M) {
        LLVMContext& Ctx = M.getContext();
        for (Function& F : M) {
            uint32_t Idx = 0;
            for (BasicBlock& BB : F) {
                for (Instruction& I : BB) {
                    if (auto* SI = dyn_cast<StoreInst>(&I)) {
                        ConstantInt* CI = ConstantInt::get(Type::getInt32Ty(Ctx), Idx++);
                        MDNode* MD = MDNode::get(Ctx, {ConstantAsMetadata::get(CI)});
                        SI->setMetadata("storeIdx", MD);
                    }
                }
            }
        }
    }

    uint32_t getArgumentAttributeValue(const Argument* Arg, StringRef AttrName) {
        AttributeList Attrs = Arg->getParent()->getAttributes();
        const auto& Attr = Attrs.getParamAttr(Arg->getArgNo(), AttrName);
        auto AttrStr = Attr.getValueAsString();
        if (!AttrStr.empty()) {
            uint32_t AttrValue;
            if (to_integer(AttrStr, AttrValue)) {
                return AttrValue;
            }
        }
        return 0;
    }
    
    uint32_t getDecayedDimSize(const Argument *Arg) {
        return getArgumentAttributeValue(Arg, "fpga.decayed.dim.hint");
    }

};
// End struct ExtractArrayInfoPass

}
// End namespace

char ExtractArrayInfoPass::ID = 0;
static RegisterPass<ExtractArrayInfoPass> X(
    "extract-array-info", 
    "Extract array metadata from the module",
    false /* Only looks at CFG */,
    false /* Analysis Pass */
);