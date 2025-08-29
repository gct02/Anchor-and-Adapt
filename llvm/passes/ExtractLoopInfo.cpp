#include <fstream>
#include <iostream>
#include <map>
#include <string>
#include <utility>
#include <vector>
#include <stack>

#include "llvm/ADT/StringExtras.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/IVDescriptors.h"
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
    "out-loop", 
    cl::desc("Path to the file to write the loop metadata to"),
    cl::value_desc("filepath")
);

namespace {

struct LoopMetadata {
    std::string Name;
    std::string FunctionName;
    std::map<std::string, uint32_t> Attributes;

    LoopMetadata(const std::string& Name,
                 const std::string& FunctionName = "",
                 const std::map<std::string, uint32_t>& Attributes = {})
        : Name(Name), FunctionName(FunctionName), Attributes(Attributes) {}

    Optional<uint32_t> getAttribute(const std::string& Key) const {
        auto It = Attributes.find(Key);
        if (It != Attributes.end()) return It->second;
        return Optional<uint32_t>();
    }

    void setAttribute(const std::string& Key, uint32_t Value) {
        Attributes[Key] = Value;
    }
};

struct ExtractLoopInfoPass : public ModulePass {
    static char ID;
    ExtractLoopInfoPass() : ModulePass(ID) {}

    std::vector<LoopMetadata*> ModuleLoopMetadata;

    bool runOnModule(Module& M) override {
        #define DEBUG_TYPE "extract-loop-info"

        if (Output.empty()) {
            errs() << "Output file not specified.\n";
            return false;
        }
        extractLoopMetadata(M);
        serializeLoopMetadata(M);

        return false; // Module is not modified
    }

    void serializeLoopMetadata(Module& M) {
        std::ofstream OFS(Output);
        if (!OFS.is_open()) {
            errs() << "Error opening file: " << Output << "\n";
            return;
        }

        OFS << "{\n";

        bool FirstEntry = true;
        for (const auto* It : ModuleLoopMetadata) {
            if (!FirstEntry) OFS << ",\n";
            FirstEntry = false;

            OFS << "  \"" << It->FunctionName << "/" << It->Name << "\": {\n";

            bool FirstAttr = true;
            for (const auto& MDItem : It->Attributes) {
                if (!FirstAttr) OFS << ",\n";
                FirstAttr = false;
                OFS << "    \"" << MDItem.first << "\": " << MDItem.second;
            }
            OFS << "\n  }";
        }
        OFS << "}\n";
    }

    void extractLoopMetadata(Module& M) {
        for (Function& F : M) {
            if (F.isDeclaration() || F.isIntrinsic()) {
                continue;
            }
            std::string FunctionName = F.hasName() ? F.getName().str() : "";

            LoopInfo& LI = getAnalysis<LoopInfoWrapperPass>(F).getLoopInfo();

            for (Loop* L : LI) {
                if (!L->getParentLoop()) {
                    std::stack<Loop*> LoopStack;
                    LoopStack.push(L);

                    while (!LoopStack.empty()) {
                        Loop* CurrentLoop = LoopStack.top();
                        LoopStack.pop();

                        std::string LoopName = getLoopName(CurrentLoop);

                        LoopMetadata* LM = new LoopMetadata(LoopName, FunctionName);
                        LM->setAttribute("Depth", CurrentLoop->getLoopDepth());
                        LM->setAttribute("IsTopLevel", CurrentLoop->getParentLoop() == nullptr ? 1 : 0);
                        LM->setAttribute("HasPerfectlyNestedChild", hasPerfectlyNestedChild(CurrentLoop) ? 1 : 0);
                        LM->setAttribute("IsPartOfPerfectNest", isPartOfPerfectNest(CurrentLoop) ? 1 : 0);
                        ModuleLoopMetadata.push_back(LM);

                        for (Loop* SubLoop : CurrentLoop->getSubLoops()) {
                            LoopStack.push(SubLoop);
                        }
                    }
                }
            }
        }
    }

    bool isTrivialGOTOBlock(const BasicBlock* BB) {
        if (BB->size() != 1) {
            return false;
        }
        const Instruction* Terminator = BB->getTerminator();
        if (auto* Branch = dyn_cast<BranchInst>(Terminator)) {
            return Branch->isUnconditional();
        }
        return false;
    }

    bool hasPerfectlyNestedChild(Loop* Outer) {
        if (!Outer) return false;

        if (Outer->getSubLoops().size() != 1) {
            return false;
        }
        Loop* Inner = Outer->getSubLoops()[0];
        BasicBlock* OuterHeader = Outer->getHeader();
        BasicBlock* InnerPreheader = Inner->getLoopPreheader();
        BasicBlock* InnerHeader = Inner->getHeader();

        for (BasicBlock* Succ : successors(OuterHeader)) {
            if (Succ == InnerPreheader) {
                return true;
            }
            if (isTrivialGOTOBlock(Succ)) {
                BasicBlock* NextSucc = Succ->getTerminator()->getSuccessor(0);
                if (NextSucc == InnerPreheader || NextSucc == InnerHeader) {
                    return true;
                }
            }
        }
        return false;
    }

    bool isPartOfPerfectNest(Loop* L) {
        if (!L) return false;

        if (hasPerfectlyNestedChild(L)) {
            return true;
        }
        if (Loop* ParentLoop = L->getParentLoop()) {
            return hasPerfectlyNestedChild(ParentLoop);
        }
        return false;
    }

    std::string getLoopName(Loop* L) {
        if (auto* Preheader = L->getLoopPreheader()) {
            return Preheader->getName().str();
        } else {
            return L->getHeader()->getName().str();
        }
    }

    void getAnalysisUsage(AnalysisUsage& AU) const override {
        AU.setPreservesAll();
        AU.addRequired<LoopInfoWrapperPass>();
    }

};
// End struct ExtractLoopInfoPass

}
// End namespace

char ExtractLoopInfoPass::ID = 0;
static RegisterPass<ExtractLoopInfoPass> X(
    "extract-loop-info", 
    "Extract loop metadata from the module",
    false /* Only looks at CFG */,
    false /* Analysis Pass */
);