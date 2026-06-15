#include "llvm/ADT/StringExtras.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/CFG.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include <fstream>
#include <iostream>
#include <map>
#include <stack>
#include <string>
#include <vector>

using namespace llvm;

static cl::opt<std::string> Output(
    "nests-out", 
    cl::desc("Specify the file path to write the loop nesting info to."),
    cl::value_desc("filepath")
);

namespace {

struct ExtractPerfectNestsPass : public PassInfoMixin<ExtractPerfectNestsPass> {
    std::map<std::string, std::vector<std::string>> PerfectNests;

    PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
        #define DEBUG_TYPE "extract-perfect-nests"

        if (Output.empty()) {
            errs() << "Output file not specified. Use -out=<file>\n";
            return PreservedAnalyses::all();
        }

        auto &FAM = MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();

        getPerfectNests(M, FAM);
        serialize(M);

        return PreservedAnalyses::all();
    }

    void serialize(Module& M) {
        std::ofstream OutFile(Output);
        if (!OutFile.is_open()) {
            errs() << "Error opening file: " << Output << "\n";
            return;
        }

        OutFile << "{\n";
        bool FirstEntry = true;

        for (const auto& It : PerfectNests) {
            if (It.second.size() == 0) continue;
            if (!FirstEntry) OutFile << ",\n";
            FirstEntry = false;

            OutFile << "  \"" << It.first << "\": [";
            OutFile << "\"" << It.second[0] << "\"";

            for (int i = 1; i < It.second.size(); i++) {
                OutFile << ", \"" << It.second[i] << "\"";
            }
            OutFile << "]";
        }
        OutFile << "\n}";
    }

    void getPerfectNests(Module& M, FunctionAnalysisManager &FAM) {
        for (Function& F : M) {
            if (F.isDeclaration() || F.isIntrinsic()) continue;
            std::string FunctionName = F.hasName() ? F.getName().str() : "";
            LoopInfo& LI = FAM.getResult<LoopAnalysis>(F);
            std::stack<Loop*> Stack;

            for (Loop* L : LI) 
                if (!L->getParentLoop()) Stack.push(L);

            while (!Stack.empty()) {
                Loop* L = Stack.top();
                Stack.pop();

                std::string Label = FunctionName + "/" + getLoopName(L);
                PerfectNests[Label] = {Label};

                while (Loop* Nested = getPerfectlyNestedChild(L)) {
                    std::string NestedLabel = FunctionName + "/" + getLoopName(Nested);
                    PerfectNests[Label].push_back(NestedLabel);
                    L = Nested;
                }
                for (Loop* SL : L->getSubLoops()) Stack.push(SL);
            }
        }
    }

    Loop* getPerfectlyNestedChild(Loop* L) {
        if (!L || L->getSubLoops().size() != 1) return nullptr;
        Loop* Inner = L->getSubLoops()[0];
        return isPerfectNest(L, Inner) ? Inner : nullptr;
    }

    bool isPerfectNest(Loop* Outer, Loop* Inner) {
        BasicBlock* OuterHeader = Outer->getHeader();
        BasicBlock* InnerPreheader = Inner->getLoopPreheader();
        BasicBlock* InnerHeader = Inner->getHeader();

        for (BasicBlock* Succ : successors(OuterHeader)) {
            if (Succ == InnerPreheader) return true;
            if (isTrivialGOTOBlock(Succ)) {
                BasicBlock* NextSucc = Succ->getTerminator()->getSuccessor(0);
                if (NextSucc == InnerPreheader || NextSucc == InnerHeader) 
                    return true;
            }
        }
        return false;
    }

    bool isTrivialGOTOBlock(const BasicBlock* BB) {
        if (BB->size() != 1) return false;
        if (auto* Branch = dyn_cast<BranchInst>(BB->getTerminator())) 
            return Branch->isUnconditional();
        return false;
    }

    std::string getLoopName(Loop* L) {
        if (auto* Preheader = L->getLoopPreheader()) 
            return Preheader->getName().str();
        return L->getHeader()->getName().str();
    }
};

}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
    return {
        LLVM_PLUGIN_API_VERSION, "ExtractPerfectNests", LLVM_VERSION_STRING,
        [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "extract-perfect-nests") {
                        MPM.addPass(ExtractPerfectNestsPass());
                        return true;
                    }
                    return false;
                });
        }};
}