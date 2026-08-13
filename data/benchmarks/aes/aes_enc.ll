; ModuleID = 'data/benchmarks/real/aes/aes_enc.c'
source_filename = "data/benchmarks/real/aes/aes_enc.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @encrypt(i32* noundef %statemt, i32* noundef %key, i32 noundef %type) #0 !dbg !10 {
entry:
  %statemt.addr = alloca i32*, align 8
  %key.addr = alloca i32*, align 8
  %type.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %nb = alloca i32, align 4
  %round_val = alloca i32, align 4
  store i32* %statemt, i32** %statemt.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %statemt.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store i32* %key, i32** %key.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %key.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store i32 %type, i32* %type.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %type.addr, metadata !20, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %i, metadata !22, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %nb, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %round_val, metadata !26, metadata !DIExpression()), !dbg !27
  %0 = load i32, i32* %type.addr, align 4, !dbg !28
  %1 = load i32*, i32** %key.addr, align 8, !dbg !29
  %call = call i32 @KeySchedule(i32 noundef %0, i32* noundef %1), !dbg !30
  %2 = load i32, i32* %type.addr, align 4, !dbg !31
  switch i32 %2, label %sw.epilog [
    i32 128128, label %sw.bb
    i32 192128, label %sw.bb1
    i32 256128, label %sw.bb2
    i32 128192, label %sw.bb3
    i32 192192, label %sw.bb3
    i32 256192, label %sw.bb4
    i32 128256, label %sw.bb5
    i32 192256, label %sw.bb5
    i32 256256, label %sw.bb5
  ], !dbg !32

sw.bb:                                            ; preds = %entry
  store i32 0, i32* %round_val, align 4, !dbg !33
  store i32 4, i32* %nb, align 4, !dbg !35
  br label %sw.epilog, !dbg !36

sw.bb1:                                           ; preds = %entry
  store i32 2, i32* %round_val, align 4, !dbg !37
  store i32 4, i32* %nb, align 4, !dbg !38
  br label %sw.epilog, !dbg !39

sw.bb2:                                           ; preds = %entry
  store i32 4, i32* %round_val, align 4, !dbg !40
  store i32 4, i32* %nb, align 4, !dbg !41
  br label %sw.epilog, !dbg !42

sw.bb3:                                           ; preds = %entry, %entry
  store i32 2, i32* %round_val, align 4, !dbg !43
  store i32 6, i32* %nb, align 4, !dbg !44
  br label %sw.epilog, !dbg !45

sw.bb4:                                           ; preds = %entry
  store i32 4, i32* %round_val, align 4, !dbg !46
  store i32 6, i32* %nb, align 4, !dbg !47
  br label %sw.epilog, !dbg !48

sw.bb5:                                           ; preds = %entry, %entry, %entry
  store i32 4, i32* %round_val, align 4, !dbg !49
  store i32 8, i32* %nb, align 4, !dbg !50
  br label %sw.epilog, !dbg !51

sw.epilog:                                        ; preds = %entry, %sw.bb5, %sw.bb4, %sw.bb3, %sw.bb2, %sw.bb1, %sw.bb
  %3 = load i32*, i32** %statemt.addr, align 8, !dbg !52
  %4 = load i32, i32* %type.addr, align 4, !dbg !53
  %call6 = call i32 @AddRoundKey(i32* noundef %3, i32 noundef %4, i32 noundef 0), !dbg !54
  br label %encrypt_label1, !dbg !54

encrypt_label1:                                   ; preds = %sw.epilog
  call void @llvm.dbg.label(metadata !55), !dbg !56
  store i32 1, i32* %i, align 4, !dbg !57
  br label %for.cond, !dbg !59

for.cond:                                         ; preds = %for.inc, %encrypt_label1
  %5 = load i32, i32* %i, align 4, !dbg !60
  %6 = load i32, i32* %round_val, align 4, !dbg !62
  %add = add nsw i32 %6, 9, !dbg !63
  %cmp = icmp sle i32 %5, %add, !dbg !64
  br i1 %cmp, label %for.body, label %for.end, !dbg !65

for.body:                                         ; preds = %for.cond
  %7 = load i32*, i32** %statemt.addr, align 8, !dbg !66
  %8 = load i32, i32* %nb, align 4, !dbg !68
  call void @ByteSub_ShiftRow(i32* noundef %7, i32 noundef %8), !dbg !69
  %9 = load i32*, i32** %statemt.addr, align 8, !dbg !70
  %10 = load i32, i32* %nb, align 4, !dbg !71
  %11 = load i32, i32* %i, align 4, !dbg !72
  %call7 = call i32 @MixColumn_AddRoundKey(i32* noundef %9, i32 noundef %10, i32 noundef %11), !dbg !73
  br label %for.inc, !dbg !74

for.inc:                                          ; preds = %for.body
  %12 = load i32, i32* %i, align 4, !dbg !75
  %inc = add nsw i32 %12, 1, !dbg !75
  store i32 %inc, i32* %i, align 4, !dbg !75
  br label %for.cond, !dbg !76, !llvm.loop !77

for.end:                                          ; preds = %for.cond
  %13 = load i32*, i32** %statemt.addr, align 8, !dbg !80
  %14 = load i32, i32* %nb, align 4, !dbg !81
  call void @ByteSub_ShiftRow(i32* noundef %13, i32 noundef %14), !dbg !82
  %15 = load i32*, i32** %statemt.addr, align 8, !dbg !83
  %16 = load i32, i32* %type.addr, align 4, !dbg !84
  %17 = load i32, i32* %i, align 4, !dbg !85
  %call8 = call i32 @AddRoundKey(i32* noundef %15, i32 noundef %16, i32 noundef %17), !dbg !86
  ret i32 0, !dbg !87
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @KeySchedule(i32 noundef, i32* noundef) #2

declare i32 @AddRoundKey(i32* noundef, i32 noundef, i32 noundef) #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

declare void @ByteSub_ShiftRow(i32* noundef, i32 noundef) #2

declare i32 @MixColumn_AddRoundKey(i32* noundef, i32 noundef, i32 noundef) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "data/benchmarks/real/aes/aes_enc.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "04ad24bd3a0ce81150dea46dea06034f")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "encrypt", scope: !1, file: !1, line: 66, type: !11, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !14, !14, !13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!15 = !{}
!16 = !DILocalVariable(name: "statemt", arg: 1, scope: !10, file: !1, line: 66, type: !14)
!17 = !DILocation(line: 66, column: 17, scope: !10)
!18 = !DILocalVariable(name: "key", arg: 2, scope: !10, file: !1, line: 66, type: !14)
!19 = !DILocation(line: 66, column: 39, scope: !10)
!20 = !DILocalVariable(name: "type", arg: 3, scope: !10, file: !1, line: 66, type: !13)
!21 = !DILocation(line: 66, column: 57, scope: !10)
!22 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 67, type: !13)
!23 = !DILocation(line: 67, column: 9, scope: !10)
!24 = !DILocalVariable(name: "nb", scope: !10, file: !1, line: 68, type: !13)
!25 = !DILocation(line: 68, column: 9, scope: !10)
!26 = !DILocalVariable(name: "round_val", scope: !10, file: !1, line: 69, type: !13)
!27 = !DILocation(line: 69, column: 9, scope: !10)
!28 = !DILocation(line: 72, column: 17, scope: !10)
!29 = !DILocation(line: 72, column: 23, scope: !10)
!30 = !DILocation(line: 72, column: 5, scope: !10)
!31 = !DILocation(line: 75, column: 13, scope: !10)
!32 = !DILocation(line: 75, column: 5, scope: !10)
!33 = !DILocation(line: 77, column: 23, scope: !34)
!34 = distinct !DILexicalBlock(scope: !10, file: !1, line: 75, column: 19)
!35 = !DILocation(line: 78, column: 16, scope: !34)
!36 = !DILocation(line: 79, column: 13, scope: !34)
!37 = !DILocation(line: 81, column: 23, scope: !34)
!38 = !DILocation(line: 82, column: 16, scope: !34)
!39 = !DILocation(line: 83, column: 13, scope: !34)
!40 = !DILocation(line: 85, column: 23, scope: !34)
!41 = !DILocation(line: 86, column: 16, scope: !34)
!42 = !DILocation(line: 87, column: 13, scope: !34)
!43 = !DILocation(line: 90, column: 23, scope: !34)
!44 = !DILocation(line: 91, column: 16, scope: !34)
!45 = !DILocation(line: 92, column: 13, scope: !34)
!46 = !DILocation(line: 94, column: 23, scope: !34)
!47 = !DILocation(line: 95, column: 16, scope: !34)
!48 = !DILocation(line: 96, column: 13, scope: !34)
!49 = !DILocation(line: 100, column: 23, scope: !34)
!50 = !DILocation(line: 101, column: 16, scope: !34)
!51 = !DILocation(line: 102, column: 13, scope: !34)
!52 = !DILocation(line: 106, column: 17, scope: !10)
!53 = !DILocation(line: 106, column: 26, scope: !10)
!54 = !DILocation(line: 106, column: 5, scope: !10)
!55 = !DILabel(scope: !10, name: "encrypt_label1", file: !1, line: 109)
!56 = !DILocation(line: 109, column: 5, scope: !10)
!57 = !DILocation(line: 110, column: 12, scope: !58)
!58 = distinct !DILexicalBlock(scope: !10, file: !1, line: 110, column: 5)
!59 = !DILocation(line: 110, column: 10, scope: !58)
!60 = !DILocation(line: 110, column: 17, scope: !61)
!61 = distinct !DILexicalBlock(scope: !58, file: !1, line: 110, column: 5)
!62 = !DILocation(line: 110, column: 22, scope: !61)
!63 = !DILocation(line: 110, column: 32, scope: !61)
!64 = !DILocation(line: 110, column: 19, scope: !61)
!65 = !DILocation(line: 110, column: 5, scope: !58)
!66 = !DILocation(line: 112, column: 26, scope: !67)
!67 = distinct !DILexicalBlock(scope: !61, file: !1, line: 110, column: 42)
!68 = !DILocation(line: 112, column: 35, scope: !67)
!69 = !DILocation(line: 112, column: 9, scope: !67)
!70 = !DILocation(line: 113, column: 31, scope: !67)
!71 = !DILocation(line: 113, column: 40, scope: !67)
!72 = !DILocation(line: 113, column: 44, scope: !67)
!73 = !DILocation(line: 113, column: 9, scope: !67)
!74 = !DILocation(line: 114, column: 5, scope: !67)
!75 = !DILocation(line: 110, column: 37, scope: !61)
!76 = !DILocation(line: 110, column: 5, scope: !61)
!77 = distinct !{!77, !65, !78, !79}
!78 = !DILocation(line: 114, column: 5, scope: !58)
!79 = !{!"llvm.loop.mustprogress"}
!80 = !DILocation(line: 117, column: 22, scope: !10)
!81 = !DILocation(line: 117, column: 31, scope: !10)
!82 = !DILocation(line: 117, column: 5, scope: !10)
!83 = !DILocation(line: 118, column: 17, scope: !10)
!84 = !DILocation(line: 118, column: 26, scope: !10)
!85 = !DILocation(line: 118, column: 32, scope: !10)
!86 = !DILocation(line: 118, column: 5, scope: !10)
!87 = !DILocation(line: 120, column: 5, scope: !10)
