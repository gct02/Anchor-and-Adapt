; ModuleID = 'data/benchmarks/real/floyd_warshall/floyd_warshall.c'
source_filename = "data/benchmarks/real/floyd_warshall/floyd_warshall.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_floyd_warshall([500 x double]* noundef %path) #0 !dbg !10 {
entry:
  %path.addr = alloca [500 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store [500 x double]* %path, [500 x double]** %path.addr, align 8
  call void @llvm.dbg.declare(metadata [500 x double]** %path.addr, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %i, metadata !21, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %j, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %k, metadata !26, metadata !DIExpression()), !dbg !27
  br label %loop1, !dbg !28

loop1:                                            ; preds = %entry
  call void @llvm.dbg.label(metadata !29), !dbg !30
  store i32 0, i32* %k, align 4, !dbg !31
  br label %for.cond, !dbg !33

for.cond:                                         ; preds = %for.inc38, %loop1
  %0 = load i32, i32* %k, align 4, !dbg !34
  %cmp = icmp slt i32 %0, 500, !dbg !36
  br i1 %cmp, label %for.body, label %for.end40, !dbg !37

for.body:                                         ; preds = %for.cond
  br label %loop2, !dbg !38

loop2:                                            ; preds = %for.body
  call void @llvm.dbg.label(metadata !39), !dbg !41
  store i32 0, i32* %i, align 4, !dbg !42
  br label %for.cond1, !dbg !44

for.cond1:                                        ; preds = %for.inc35, %loop2
  %1 = load i32, i32* %i, align 4, !dbg !45
  %cmp2 = icmp slt i32 %1, 500, !dbg !47
  br i1 %cmp2, label %for.body3, label %for.end37, !dbg !48

for.body3:                                        ; preds = %for.cond1
  br label %loop3, !dbg !49

loop3:                                            ; preds = %for.body3
  call void @llvm.dbg.label(metadata !50), !dbg !52
  store i32 0, i32* %j, align 4, !dbg !53
  br label %for.cond4, !dbg !55

for.cond4:                                        ; preds = %for.inc, %loop3
  %2 = load i32, i32* %j, align 4, !dbg !56
  %cmp5 = icmp slt i32 %2, 500, !dbg !58
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !59

for.body6:                                        ; preds = %for.cond4
  %3 = load [500 x double]*, [500 x double]** %path.addr, align 8, !dbg !60
  %4 = load i32, i32* %i, align 4, !dbg !62
  %idxprom = sext i32 %4 to i64, !dbg !60
  %arrayidx = getelementptr inbounds [500 x double], [500 x double]* %3, i64 %idxprom, !dbg !60
  %5 = load i32, i32* %j, align 4, !dbg !63
  %idxprom7 = sext i32 %5 to i64, !dbg !60
  %arrayidx8 = getelementptr inbounds [500 x double], [500 x double]* %arrayidx, i64 0, i64 %idxprom7, !dbg !60
  %6 = load double, double* %arrayidx8, align 8, !dbg !60
  %7 = load [500 x double]*, [500 x double]** %path.addr, align 8, !dbg !64
  %8 = load i32, i32* %i, align 4, !dbg !65
  %idxprom9 = sext i32 %8 to i64, !dbg !64
  %arrayidx10 = getelementptr inbounds [500 x double], [500 x double]* %7, i64 %idxprom9, !dbg !64
  %9 = load i32, i32* %k, align 4, !dbg !66
  %idxprom11 = sext i32 %9 to i64, !dbg !64
  %arrayidx12 = getelementptr inbounds [500 x double], [500 x double]* %arrayidx10, i64 0, i64 %idxprom11, !dbg !64
  %10 = load double, double* %arrayidx12, align 8, !dbg !64
  %11 = load [500 x double]*, [500 x double]** %path.addr, align 8, !dbg !67
  %12 = load i32, i32* %k, align 4, !dbg !68
  %idxprom13 = sext i32 %12 to i64, !dbg !67
  %arrayidx14 = getelementptr inbounds [500 x double], [500 x double]* %11, i64 %idxprom13, !dbg !67
  %13 = load i32, i32* %j, align 4, !dbg !69
  %idxprom15 = sext i32 %13 to i64, !dbg !67
  %arrayidx16 = getelementptr inbounds [500 x double], [500 x double]* %arrayidx14, i64 0, i64 %idxprom15, !dbg !67
  %14 = load double, double* %arrayidx16, align 8, !dbg !67
  %add = fadd double %10, %14, !dbg !70
  %cmp17 = fcmp olt double %6, %add, !dbg !71
  br i1 %cmp17, label %cond.true, label %cond.false, !dbg !60

cond.true:                                        ; preds = %for.body6
  %15 = load [500 x double]*, [500 x double]** %path.addr, align 8, !dbg !72
  %16 = load i32, i32* %i, align 4, !dbg !73
  %idxprom18 = sext i32 %16 to i64, !dbg !72
  %arrayidx19 = getelementptr inbounds [500 x double], [500 x double]* %15, i64 %idxprom18, !dbg !72
  %17 = load i32, i32* %j, align 4, !dbg !74
  %idxprom20 = sext i32 %17 to i64, !dbg !72
  %arrayidx21 = getelementptr inbounds [500 x double], [500 x double]* %arrayidx19, i64 0, i64 %idxprom20, !dbg !72
  %18 = load double, double* %arrayidx21, align 8, !dbg !72
  br label %cond.end, !dbg !60

cond.false:                                       ; preds = %for.body6
  %19 = load [500 x double]*, [500 x double]** %path.addr, align 8, !dbg !75
  %20 = load i32, i32* %i, align 4, !dbg !76
  %idxprom22 = sext i32 %20 to i64, !dbg !75
  %arrayidx23 = getelementptr inbounds [500 x double], [500 x double]* %19, i64 %idxprom22, !dbg !75
  %21 = load i32, i32* %k, align 4, !dbg !77
  %idxprom24 = sext i32 %21 to i64, !dbg !75
  %arrayidx25 = getelementptr inbounds [500 x double], [500 x double]* %arrayidx23, i64 0, i64 %idxprom24, !dbg !75
  %22 = load double, double* %arrayidx25, align 8, !dbg !75
  %23 = load [500 x double]*, [500 x double]** %path.addr, align 8, !dbg !78
  %24 = load i32, i32* %k, align 4, !dbg !79
  %idxprom26 = sext i32 %24 to i64, !dbg !78
  %arrayidx27 = getelementptr inbounds [500 x double], [500 x double]* %23, i64 %idxprom26, !dbg !78
  %25 = load i32, i32* %j, align 4, !dbg !80
  %idxprom28 = sext i32 %25 to i64, !dbg !78
  %arrayidx29 = getelementptr inbounds [500 x double], [500 x double]* %arrayidx27, i64 0, i64 %idxprom28, !dbg !78
  %26 = load double, double* %arrayidx29, align 8, !dbg !78
  %add30 = fadd double %22, %26, !dbg !81
  br label %cond.end, !dbg !60

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi double [ %18, %cond.true ], [ %add30, %cond.false ], !dbg !60
  %27 = load [500 x double]*, [500 x double]** %path.addr, align 8, !dbg !82
  %28 = load i32, i32* %i, align 4, !dbg !83
  %idxprom31 = sext i32 %28 to i64, !dbg !82
  %arrayidx32 = getelementptr inbounds [500 x double], [500 x double]* %27, i64 %idxprom31, !dbg !82
  %29 = load i32, i32* %j, align 4, !dbg !84
  %idxprom33 = sext i32 %29 to i64, !dbg !82
  %arrayidx34 = getelementptr inbounds [500 x double], [500 x double]* %arrayidx32, i64 0, i64 %idxprom33, !dbg !82
  store double %cond, double* %arrayidx34, align 8, !dbg !85
  br label %for.inc, !dbg !86

for.inc:                                          ; preds = %cond.end
  %30 = load i32, i32* %j, align 4, !dbg !87
  %inc = add nsw i32 %30, 1, !dbg !87
  store i32 %inc, i32* %j, align 4, !dbg !87
  br label %for.cond4, !dbg !88, !llvm.loop !89

for.end:                                          ; preds = %for.cond4
  br label %for.inc35, !dbg !92

for.inc35:                                        ; preds = %for.end
  %31 = load i32, i32* %i, align 4, !dbg !93
  %inc36 = add nsw i32 %31, 1, !dbg !93
  store i32 %inc36, i32* %i, align 4, !dbg !93
  br label %for.cond1, !dbg !94, !llvm.loop !95

for.end37:                                        ; preds = %for.cond1
  br label %for.inc38, !dbg !97

for.inc38:                                        ; preds = %for.end37
  %32 = load i32, i32* %k, align 4, !dbg !98
  %inc39 = add nsw i32 %32, 1, !dbg !98
  store i32 %inc39, i32* %k, align 4, !dbg !98
  br label %for.cond, !dbg !99, !llvm.loop !100

for.end40:                                        ; preds = %for.cond
  ret void, !dbg !102
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "data/benchmarks/real/floyd_warshall/floyd_warshall.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "e37d19a2a07eaed4c07f303b65518171")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "kernel_floyd_warshall", scope: !1, file: !1, line: 14, type: !11, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !18)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 32000, elements: !16)
!15 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!16 = !{!17}
!17 = !DISubrange(count: 500)
!18 = !{}
!19 = !DILocalVariable(name: "path", arg: 1, scope: !10, file: !1, line: 14, type: !13)
!20 = !DILocation(line: 14, column: 38, scope: !10)
!21 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 15, type: !22)
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DILocation(line: 15, column: 7, scope: !10)
!24 = !DILocalVariable(name: "j", scope: !10, file: !1, line: 15, type: !22)
!25 = !DILocation(line: 15, column: 10, scope: !10)
!26 = !DILocalVariable(name: "k", scope: !10, file: !1, line: 15, type: !22)
!27 = !DILocation(line: 15, column: 13, scope: !10)
!28 = !DILocation(line: 15, column: 3, scope: !10)
!29 = !DILabel(scope: !10, name: "loop1", file: !1, line: 17)
!30 = !DILocation(line: 17, column: 3, scope: !10)
!31 = !DILocation(line: 17, column: 17, scope: !32)
!32 = distinct !DILexicalBlock(scope: !10, file: !1, line: 17, column: 10)
!33 = !DILocation(line: 17, column: 15, scope: !32)
!34 = !DILocation(line: 17, column: 22, scope: !35)
!35 = distinct !DILexicalBlock(scope: !32, file: !1, line: 17, column: 10)
!36 = !DILocation(line: 17, column: 24, scope: !35)
!37 = !DILocation(line: 17, column: 10, scope: !32)
!38 = !DILocation(line: 17, column: 34, scope: !35)
!39 = !DILabel(scope: !40, name: "loop2", file: !1, line: 19)
!40 = distinct !DILexicalBlock(scope: !35, file: !1, line: 17, column: 34)
!41 = !DILocation(line: 19, column: 5, scope: !40)
!42 = !DILocation(line: 19, column: 18, scope: !43)
!43 = distinct !DILexicalBlock(scope: !40, file: !1, line: 19, column: 12)
!44 = !DILocation(line: 19, column: 16, scope: !43)
!45 = !DILocation(line: 19, column: 23, scope: !46)
!46 = distinct !DILexicalBlock(scope: !43, file: !1, line: 19, column: 12)
!47 = !DILocation(line: 19, column: 25, scope: !46)
!48 = !DILocation(line: 19, column: 12, scope: !43)
!49 = !DILocation(line: 19, column: 35, scope: !46)
!50 = !DILabel(scope: !51, name: "loop3", file: !1, line: 21)
!51 = distinct !DILexicalBlock(scope: !46, file: !1, line: 19, column: 35)
!52 = !DILocation(line: 21, column: 7, scope: !51)
!53 = !DILocation(line: 21, column: 21, scope: !54)
!54 = distinct !DILexicalBlock(scope: !51, file: !1, line: 21, column: 14)
!55 = !DILocation(line: 21, column: 19, scope: !54)
!56 = !DILocation(line: 21, column: 26, scope: !57)
!57 = distinct !DILexicalBlock(scope: !54, file: !1, line: 21, column: 14)
!58 = !DILocation(line: 21, column: 28, scope: !57)
!59 = !DILocation(line: 21, column: 14, scope: !54)
!60 = !DILocation(line: 23, column: 22, scope: !61)
!61 = distinct !DILexicalBlock(scope: !57, file: !1, line: 21, column: 38)
!62 = !DILocation(line: 23, column: 27, scope: !61)
!63 = !DILocation(line: 23, column: 30, scope: !61)
!64 = !DILocation(line: 23, column: 36, scope: !61)
!65 = !DILocation(line: 23, column: 41, scope: !61)
!66 = !DILocation(line: 23, column: 44, scope: !61)
!67 = !DILocation(line: 23, column: 49, scope: !61)
!68 = !DILocation(line: 23, column: 54, scope: !61)
!69 = !DILocation(line: 23, column: 57, scope: !61)
!70 = !DILocation(line: 23, column: 47, scope: !61)
!71 = !DILocation(line: 23, column: 33, scope: !61)
!72 = !DILocation(line: 23, column: 63, scope: !61)
!73 = !DILocation(line: 23, column: 68, scope: !61)
!74 = !DILocation(line: 23, column: 71, scope: !61)
!75 = !DILocation(line: 23, column: 76, scope: !61)
!76 = !DILocation(line: 23, column: 81, scope: !61)
!77 = !DILocation(line: 23, column: 84, scope: !61)
!78 = !DILocation(line: 23, column: 89, scope: !61)
!79 = !DILocation(line: 23, column: 94, scope: !61)
!80 = !DILocation(line: 23, column: 97, scope: !61)
!81 = !DILocation(line: 23, column: 87, scope: !61)
!82 = !DILocation(line: 23, column: 9, scope: !61)
!83 = !DILocation(line: 23, column: 14, scope: !61)
!84 = !DILocation(line: 23, column: 17, scope: !61)
!85 = !DILocation(line: 23, column: 20, scope: !61)
!86 = !DILocation(line: 24, column: 7, scope: !61)
!87 = !DILocation(line: 21, column: 34, scope: !57)
!88 = !DILocation(line: 21, column: 14, scope: !57)
!89 = distinct !{!89, !59, !90, !91}
!90 = !DILocation(line: 24, column: 7, scope: !54)
!91 = !{!"llvm.loop.mustprogress"}
!92 = !DILocation(line: 25, column: 5, scope: !51)
!93 = !DILocation(line: 19, column: 31, scope: !46)
!94 = !DILocation(line: 19, column: 12, scope: !46)
!95 = distinct !{!95, !48, !96, !91}
!96 = !DILocation(line: 25, column: 5, scope: !43)
!97 = !DILocation(line: 26, column: 3, scope: !40)
!98 = !DILocation(line: 17, column: 30, scope: !35)
!99 = !DILocation(line: 17, column: 10, scope: !35)
!100 = distinct !{!100, !37, !101, !91}
!101 = !DILocation(line: 26, column: 3, scope: !32)
!102 = !DILocation(line: 27, column: 1, scope: !10)
