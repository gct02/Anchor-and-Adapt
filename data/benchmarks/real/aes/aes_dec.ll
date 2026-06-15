; ModuleID = 'data/benchmarks/real/aes/aes_dec.c'
source_filename = "data/benchmarks/real/aes/aes_dec.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @decrypt(i32* noundef %statemt, i32* noundef %key, i32 noundef %type) #0 !dbg !10 {
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
    i32 128192, label %sw.bb1
    i32 192192, label %sw.bb1
    i32 192128, label %sw.bb2
    i32 128256, label %sw.bb3
    i32 192256, label %sw.bb3
    i32 256128, label %sw.bb4
    i32 256192, label %sw.bb5
    i32 256256, label %sw.bb6
  ], !dbg !32

sw.bb:                                            ; preds = %entry
  store i32 10, i32* %round_val, align 4, !dbg !33
  store i32 4, i32* %nb, align 4, !dbg !35
  br label %sw.epilog, !dbg !36

sw.bb1:                                           ; preds = %entry, %entry
  store i32 12, i32* %round_val, align 4, !dbg !37
  store i32 6, i32* %nb, align 4, !dbg !38
  br label %sw.epilog, !dbg !39

sw.bb2:                                           ; preds = %entry
  store i32 12, i32* %round_val, align 4, !dbg !40
  store i32 4, i32* %nb, align 4, !dbg !41
  br label %sw.epilog, !dbg !42

sw.bb3:                                           ; preds = %entry, %entry
  store i32 14, i32* %round_val, align 4, !dbg !43
  store i32 8, i32* %nb, align 4, !dbg !44
  br label %sw.epilog, !dbg !45

sw.bb4:                                           ; preds = %entry
  store i32 14, i32* %round_val, align 4, !dbg !46
  store i32 4, i32* %nb, align 4, !dbg !47
  br label %sw.epilog, !dbg !48

sw.bb5:                                           ; preds = %entry
  store i32 14, i32* %round_val, align 4, !dbg !49
  store i32 6, i32* %nb, align 4, !dbg !50
  br label %sw.epilog, !dbg !51

sw.bb6:                                           ; preds = %entry
  store i32 14, i32* %round_val, align 4, !dbg !52
  store i32 8, i32* %nb, align 4, !dbg !53
  br label %sw.epilog, !dbg !54

sw.epilog:                                        ; preds = %entry, %sw.bb6, %sw.bb5, %sw.bb4, %sw.bb3, %sw.bb2, %sw.bb1, %sw.bb
  %3 = load i32*, i32** %statemt.addr, align 8, !dbg !55
  %4 = load i32, i32* %type.addr, align 4, !dbg !56
  %5 = load i32, i32* %round_val, align 4, !dbg !57
  %call7 = call i32 @AddRoundKey(i32* noundef %3, i32 noundef %4, i32 noundef %5), !dbg !58
  %6 = load i32*, i32** %statemt.addr, align 8, !dbg !59
  %7 = load i32, i32* %nb, align 4, !dbg !60
  call void @InversShiftRow_ByteSub(i32* noundef %6, i32 noundef %7), !dbg !61
  br label %decrypt_label4, !dbg !61

decrypt_label4:                                   ; preds = %sw.epilog
  call void @llvm.dbg.label(metadata !62), !dbg !63
  %8 = load i32, i32* %round_val, align 4, !dbg !64
  %sub = sub nsw i32 %8, 1, !dbg !66
  store i32 %sub, i32* %i, align 4, !dbg !67
  br label %for.cond, !dbg !68

for.cond:                                         ; preds = %for.inc, %decrypt_label4
  %9 = load i32, i32* %i, align 4, !dbg !69
  %cmp = icmp sge i32 %9, 1, !dbg !71
  br i1 %cmp, label %for.body, label %for.end, !dbg !72

for.body:                                         ; preds = %for.cond
  %10 = load i32*, i32** %statemt.addr, align 8, !dbg !73
  %11 = load i32, i32* %nb, align 4, !dbg !75
  %12 = load i32, i32* %i, align 4, !dbg !76
  %call8 = call i32 @AddRoundKey_InversMixColumn(i32* noundef %10, i32 noundef %11, i32 noundef %12), !dbg !77
  %13 = load i32*, i32** %statemt.addr, align 8, !dbg !78
  %14 = load i32, i32* %nb, align 4, !dbg !79
  call void @InversShiftRow_ByteSub(i32* noundef %13, i32 noundef %14), !dbg !80
  br label %for.inc, !dbg !81

for.inc:                                          ; preds = %for.body
  %15 = load i32, i32* %i, align 4, !dbg !82
  %dec = add nsw i32 %15, -1, !dbg !82
  store i32 %dec, i32* %i, align 4, !dbg !82
  br label %for.cond, !dbg !83, !llvm.loop !84

for.end:                                          ; preds = %for.cond
  %16 = load i32*, i32** %statemt.addr, align 8, !dbg !87
  %17 = load i32, i32* %type.addr, align 4, !dbg !88
  %call9 = call i32 @AddRoundKey(i32* noundef %16, i32 noundef %17, i32 noundef 0), !dbg !89
  ret i32 0, !dbg !90
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @KeySchedule(i32 noundef, i32* noundef) #2

declare i32 @AddRoundKey(i32* noundef, i32 noundef, i32 noundef) #2

declare void @InversShiftRow_ByteSub(i32* noundef, i32 noundef) #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

declare i32 @AddRoundKey_InversMixColumn(i32* noundef, i32 noundef, i32 noundef) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "data/benchmarks/real/aes/aes_dec.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "06bbfd0ba0dff9ff3462e94beba101a7")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "decrypt", scope: !1, file: !1, line: 66, type: !11, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
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
!37 = !DILocation(line: 82, column: 23, scope: !34)
!38 = !DILocation(line: 83, column: 16, scope: !34)
!39 = !DILocation(line: 84, column: 13, scope: !34)
!40 = !DILocation(line: 86, column: 23, scope: !34)
!41 = !DILocation(line: 87, column: 16, scope: !34)
!42 = !DILocation(line: 88, column: 13, scope: !34)
!43 = !DILocation(line: 91, column: 23, scope: !34)
!44 = !DILocation(line: 92, column: 16, scope: !34)
!45 = !DILocation(line: 93, column: 13, scope: !34)
!46 = !DILocation(line: 95, column: 23, scope: !34)
!47 = !DILocation(line: 96, column: 16, scope: !34)
!48 = !DILocation(line: 97, column: 13, scope: !34)
!49 = !DILocation(line: 99, column: 23, scope: !34)
!50 = !DILocation(line: 100, column: 16, scope: !34)
!51 = !DILocation(line: 101, column: 13, scope: !34)
!52 = !DILocation(line: 103, column: 23, scope: !34)
!53 = !DILocation(line: 104, column: 16, scope: !34)
!54 = !DILocation(line: 105, column: 13, scope: !34)
!55 = !DILocation(line: 109, column: 17, scope: !10)
!56 = !DILocation(line: 109, column: 26, scope: !10)
!57 = !DILocation(line: 109, column: 32, scope: !10)
!58 = !DILocation(line: 109, column: 5, scope: !10)
!59 = !DILocation(line: 112, column: 28, scope: !10)
!60 = !DILocation(line: 112, column: 37, scope: !10)
!61 = !DILocation(line: 112, column: 5, scope: !10)
!62 = !DILabel(scope: !10, name: "decrypt_label4", file: !1, line: 115)
!63 = !DILocation(line: 115, column: 5, scope: !10)
!64 = !DILocation(line: 116, column: 14, scope: !65)
!65 = distinct !DILexicalBlock(scope: !10, file: !1, line: 116, column: 5)
!66 = !DILocation(line: 116, column: 24, scope: !65)
!67 = !DILocation(line: 116, column: 12, scope: !65)
!68 = !DILocation(line: 116, column: 10, scope: !65)
!69 = !DILocation(line: 116, column: 29, scope: !70)
!70 = distinct !DILexicalBlock(scope: !65, file: !1, line: 116, column: 5)
!71 = !DILocation(line: 116, column: 31, scope: !70)
!72 = !DILocation(line: 116, column: 5, scope: !65)
!73 = !DILocation(line: 118, column: 37, scope: !74)
!74 = distinct !DILexicalBlock(scope: !70, file: !1, line: 116, column: 42)
!75 = !DILocation(line: 118, column: 46, scope: !74)
!76 = !DILocation(line: 118, column: 50, scope: !74)
!77 = !DILocation(line: 118, column: 9, scope: !74)
!78 = !DILocation(line: 119, column: 32, scope: !74)
!79 = !DILocation(line: 119, column: 41, scope: !74)
!80 = !DILocation(line: 119, column: 9, scope: !74)
!81 = !DILocation(line: 120, column: 5, scope: !74)
!82 = !DILocation(line: 116, column: 37, scope: !70)
!83 = !DILocation(line: 116, column: 5, scope: !70)
!84 = distinct !{!84, !72, !85, !86}
!85 = !DILocation(line: 120, column: 5, scope: !65)
!86 = !{!"llvm.loop.mustprogress"}
!87 = !DILocation(line: 123, column: 17, scope: !10)
!88 = !DILocation(line: 123, column: 26, scope: !10)
!89 = !DILocation(line: 123, column: 5, scope: !10)
!90 = !DILocation(line: 125, column: 5, scope: !10)
