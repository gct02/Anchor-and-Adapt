; ModuleID = 'data/benchmarks/real/gemm/gemm.c'
source_filename = "data/benchmarks/real/gemm/gemm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @bbgemm(double* noundef %m1, double* noundef %m2, double* noundef %prod) #0 !dbg !10 {
entry:
  %m1.addr = alloca double*, align 8
  %m2.addr = alloca double*, align 8
  %prod.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %k = alloca i32, align 4
  %j = alloca i32, align 4
  %jj = alloca i32, align 4
  %kk = alloca i32, align 4
  %i_row = alloca i32, align 4
  %k_row = alloca i32, align 4
  %temp_x = alloca double, align 8
  %mul = alloca double, align 8
  store double* %m1, double** %m1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %m1.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store double* %m2, double** %m2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %m2.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store double* %prod, double** %prod.addr, align 8
  call void @llvm.dbg.declare(metadata double** %prod.addr, metadata !20, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %i, metadata !22, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %k, metadata !25, metadata !DIExpression()), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %j, metadata !27, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata i32* %jj, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata i32* %kk, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata i32* %i_row, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata i32* %k_row, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.declare(metadata double* %temp_x, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata double* %mul, metadata !39, metadata !DIExpression()), !dbg !40
  br label %loopjj, !dbg !41

loopjj:                                           ; preds = %entry
  call void @llvm.dbg.label(metadata !42), !dbg !43
  store i32 0, i32* %jj, align 4, !dbg !44
  br label %for.cond, !dbg !46

for.cond:                                         ; preds = %for.inc36, %loopjj
  %0 = load i32, i32* %jj, align 4, !dbg !47
  %cmp = icmp slt i32 %0, 64, !dbg !49
  br i1 %cmp, label %for.body, label %for.end38, !dbg !50

for.body:                                         ; preds = %for.cond
  br label %loopkk, !dbg !51

loopkk:                                           ; preds = %for.body
  call void @llvm.dbg.label(metadata !52), !dbg !54
  store i32 0, i32* %kk, align 4, !dbg !55
  br label %for.cond1, !dbg !57

for.cond1:                                        ; preds = %for.inc33, %loopkk
  %1 = load i32, i32* %kk, align 4, !dbg !58
  %cmp2 = icmp slt i32 %1, 64, !dbg !60
  br i1 %cmp2, label %for.body3, label %for.end35, !dbg !61

for.body3:                                        ; preds = %for.cond1
  br label %loopi, !dbg !62

loopi:                                            ; preds = %for.body3
  call void @llvm.dbg.label(metadata !63), !dbg !65
  store i32 0, i32* %i, align 4, !dbg !66
  br label %for.cond4, !dbg !68

for.cond4:                                        ; preds = %for.inc30, %loopi
  %2 = load i32, i32* %i, align 4, !dbg !69
  %cmp5 = icmp slt i32 %2, 64, !dbg !71
  br i1 %cmp5, label %for.body6, label %for.end32, !dbg !72

for.body6:                                        ; preds = %for.cond4
  br label %loopk, !dbg !73

loopk:                                            ; preds = %for.body6
  call void @llvm.dbg.label(metadata !74), !dbg !76
  store i32 0, i32* %k, align 4, !dbg !77
  br label %for.cond7, !dbg !79

for.cond7:                                        ; preds = %for.inc27, %loopk
  %3 = load i32, i32* %k, align 4, !dbg !80
  %cmp8 = icmp slt i32 %3, 8, !dbg !82
  br i1 %cmp8, label %for.body9, label %for.end29, !dbg !83

for.body9:                                        ; preds = %for.cond7
  %4 = load i32, i32* %i, align 4, !dbg !84
  %mul10 = mul nsw i32 %4, 64, !dbg !86
  store i32 %mul10, i32* %i_row, align 4, !dbg !87
  %5 = load i32, i32* %k, align 4, !dbg !88
  %6 = load i32, i32* %kk, align 4, !dbg !89
  %add = add nsw i32 %5, %6, !dbg !90
  %mul11 = mul nsw i32 %add, 64, !dbg !91
  store i32 %mul11, i32* %k_row, align 4, !dbg !92
  %7 = load double*, double** %m1.addr, align 8, !dbg !93
  %8 = load i32, i32* %i_row, align 4, !dbg !94
  %9 = load i32, i32* %k, align 4, !dbg !95
  %add12 = add nsw i32 %8, %9, !dbg !96
  %10 = load i32, i32* %kk, align 4, !dbg !97
  %add13 = add nsw i32 %add12, %10, !dbg !98
  %idxprom = sext i32 %add13 to i64, !dbg !93
  %arrayidx = getelementptr inbounds double, double* %7, i64 %idxprom, !dbg !93
  %11 = load double, double* %arrayidx, align 8, !dbg !93
  store double %11, double* %temp_x, align 8, !dbg !99
  br label %loopj, !dbg !100

loopj:                                            ; preds = %for.body9
  call void @llvm.dbg.label(metadata !101), !dbg !102
  store i32 0, i32* %j, align 4, !dbg !103
  br label %for.cond14, !dbg !105

for.cond14:                                       ; preds = %for.inc, %loopj
  %12 = load i32, i32* %j, align 4, !dbg !106
  %cmp15 = icmp slt i32 %12, 8, !dbg !108
  br i1 %cmp15, label %for.body16, label %for.end, !dbg !109

for.body16:                                       ; preds = %for.cond14
  %13 = load double, double* %temp_x, align 8, !dbg !110
  %14 = load double*, double** %m2.addr, align 8, !dbg !112
  %15 = load i32, i32* %k_row, align 4, !dbg !113
  %16 = load i32, i32* %j, align 4, !dbg !114
  %add17 = add nsw i32 %15, %16, !dbg !115
  %17 = load i32, i32* %jj, align 4, !dbg !116
  %add18 = add nsw i32 %add17, %17, !dbg !117
  %idxprom19 = sext i32 %add18 to i64, !dbg !112
  %arrayidx20 = getelementptr inbounds double, double* %14, i64 %idxprom19, !dbg !112
  %18 = load double, double* %arrayidx20, align 8, !dbg !112
  %mul21 = fmul double %13, %18, !dbg !118
  store double %mul21, double* %mul, align 8, !dbg !119
  %19 = load double, double* %mul, align 8, !dbg !120
  %20 = load double*, double** %prod.addr, align 8, !dbg !121
  %21 = load i32, i32* %i_row, align 4, !dbg !122
  %22 = load i32, i32* %j, align 4, !dbg !123
  %add22 = add nsw i32 %21, %22, !dbg !124
  %23 = load i32, i32* %jj, align 4, !dbg !125
  %add23 = add nsw i32 %add22, %23, !dbg !126
  %idxprom24 = sext i32 %add23 to i64, !dbg !121
  %arrayidx25 = getelementptr inbounds double, double* %20, i64 %idxprom24, !dbg !121
  %24 = load double, double* %arrayidx25, align 8, !dbg !127
  %add26 = fadd double %24, %19, !dbg !127
  store double %add26, double* %arrayidx25, align 8, !dbg !127
  br label %for.inc, !dbg !128

for.inc:                                          ; preds = %for.body16
  %25 = load i32, i32* %j, align 4, !dbg !129
  %inc = add nsw i32 %25, 1, !dbg !129
  store i32 %inc, i32* %j, align 4, !dbg !129
  br label %for.cond14, !dbg !130, !llvm.loop !131

for.end:                                          ; preds = %for.cond14
  br label %for.inc27, !dbg !134

for.inc27:                                        ; preds = %for.end
  %26 = load i32, i32* %k, align 4, !dbg !135
  %inc28 = add nsw i32 %26, 1, !dbg !135
  store i32 %inc28, i32* %k, align 4, !dbg !135
  br label %for.cond7, !dbg !136, !llvm.loop !137

for.end29:                                        ; preds = %for.cond7
  br label %for.inc30, !dbg !139

for.inc30:                                        ; preds = %for.end29
  %27 = load i32, i32* %i, align 4, !dbg !140
  %inc31 = add nsw i32 %27, 1, !dbg !140
  store i32 %inc31, i32* %i, align 4, !dbg !140
  br label %for.cond4, !dbg !141, !llvm.loop !142

for.end32:                                        ; preds = %for.cond4
  br label %for.inc33, !dbg !144

for.inc33:                                        ; preds = %for.end32
  %28 = load i32, i32* %kk, align 4, !dbg !145
  %add34 = add nsw i32 %28, 8, !dbg !145
  store i32 %add34, i32* %kk, align 4, !dbg !145
  br label %for.cond1, !dbg !146, !llvm.loop !147

for.end35:                                        ; preds = %for.cond1
  br label %for.inc36, !dbg !149

for.inc36:                                        ; preds = %for.end35
  %29 = load i32, i32* %jj, align 4, !dbg !150
  %add37 = add nsw i32 %29, 8, !dbg !150
  store i32 %add37, i32* %jj, align 4, !dbg !150
  br label %for.cond, !dbg !151, !llvm.loop !152

for.end38:                                        ; preds = %for.cond
  ret void, !dbg !154
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
!1 = !DIFile(filename: "data/benchmarks/real/gemm/gemm.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "85d8d97bdf146fd3cd0058f4cdd2853c")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "bbgemm", scope: !1, file: !1, line: 10, type: !11, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !13, !13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!15 = !{}
!16 = !DILocalVariable(name: "m1", arg: 1, scope: !10, file: !1, line: 10, type: !13)
!17 = !DILocation(line: 10, column: 18, scope: !10)
!18 = !DILocalVariable(name: "m2", arg: 2, scope: !10, file: !1, line: 10, type: !13)
!19 = !DILocation(line: 10, column: 30, scope: !10)
!20 = !DILocalVariable(name: "prod", arg: 3, scope: !10, file: !1, line: 10, type: !13)
!21 = !DILocation(line: 10, column: 42, scope: !10)
!22 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 11, type: !23)
!23 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!24 = !DILocation(line: 11, column: 9, scope: !10)
!25 = !DILocalVariable(name: "k", scope: !10, file: !1, line: 11, type: !23)
!26 = !DILocation(line: 11, column: 12, scope: !10)
!27 = !DILocalVariable(name: "j", scope: !10, file: !1, line: 11, type: !23)
!28 = !DILocation(line: 11, column: 15, scope: !10)
!29 = !DILocalVariable(name: "jj", scope: !10, file: !1, line: 11, type: !23)
!30 = !DILocation(line: 11, column: 18, scope: !10)
!31 = !DILocalVariable(name: "kk", scope: !10, file: !1, line: 11, type: !23)
!32 = !DILocation(line: 11, column: 22, scope: !10)
!33 = !DILocalVariable(name: "i_row", scope: !10, file: !1, line: 12, type: !23)
!34 = !DILocation(line: 12, column: 9, scope: !10)
!35 = !DILocalVariable(name: "k_row", scope: !10, file: !1, line: 12, type: !23)
!36 = !DILocation(line: 12, column: 16, scope: !10)
!37 = !DILocalVariable(name: "temp_x", scope: !10, file: !1, line: 13, type: !14)
!38 = !DILocation(line: 13, column: 10, scope: !10)
!39 = !DILocalVariable(name: "mul", scope: !10, file: !1, line: 13, type: !14)
!40 = !DILocation(line: 13, column: 18, scope: !10)
!41 = !DILocation(line: 13, column: 5, scope: !10)
!42 = !DILabel(scope: !10, name: "loopjj", file: !1, line: 15)
!43 = !DILocation(line: 15, column: 5, scope: !10)
!44 = !DILocation(line: 15, column: 20, scope: !45)
!45 = distinct !DILexicalBlock(scope: !10, file: !1, line: 15, column: 12)
!46 = !DILocation(line: 15, column: 17, scope: !45)
!47 = !DILocation(line: 15, column: 25, scope: !48)
!48 = distinct !DILexicalBlock(scope: !45, file: !1, line: 15, column: 12)
!49 = !DILocation(line: 15, column: 28, scope: !48)
!50 = !DILocation(line: 15, column: 12, scope: !45)
!51 = !DILocation(line: 15, column: 57, scope: !48)
!52 = !DILabel(scope: !53, name: "loopkk", file: !1, line: 17)
!53 = distinct !DILexicalBlock(scope: !48, file: !1, line: 15, column: 57)
!54 = !DILocation(line: 17, column: 9, scope: !53)
!55 = !DILocation(line: 17, column: 24, scope: !56)
!56 = distinct !DILexicalBlock(scope: !53, file: !1, line: 17, column: 16)
!57 = !DILocation(line: 17, column: 21, scope: !56)
!58 = !DILocation(line: 17, column: 29, scope: !59)
!59 = distinct !DILexicalBlock(scope: !56, file: !1, line: 17, column: 16)
!60 = !DILocation(line: 17, column: 32, scope: !59)
!61 = !DILocation(line: 17, column: 16, scope: !56)
!62 = !DILocation(line: 17, column: 61, scope: !59)
!63 = !DILabel(scope: !64, name: "loopi", file: !1, line: 19)
!64 = distinct !DILexicalBlock(scope: !59, file: !1, line: 17, column: 61)
!65 = !DILocation(line: 19, column: 13, scope: !64)
!66 = !DILocation(line: 19, column: 27, scope: !67)
!67 = distinct !DILexicalBlock(scope: !64, file: !1, line: 19, column: 19)
!68 = !DILocation(line: 19, column: 25, scope: !67)
!69 = !DILocation(line: 19, column: 32, scope: !70)
!70 = distinct !DILexicalBlock(scope: !67, file: !1, line: 19, column: 19)
!71 = !DILocation(line: 19, column: 34, scope: !70)
!72 = !DILocation(line: 19, column: 19, scope: !67)
!73 = !DILocation(line: 19, column: 50, scope: !70)
!74 = !DILabel(scope: !75, name: "loopk", file: !1, line: 21)
!75 = distinct !DILexicalBlock(scope: !70, file: !1, line: 19, column: 50)
!76 = !DILocation(line: 21, column: 17, scope: !75)
!77 = !DILocation(line: 21, column: 30, scope: !78)
!78 = distinct !DILexicalBlock(scope: !75, file: !1, line: 21, column: 23)
!79 = !DILocation(line: 21, column: 28, scope: !78)
!80 = !DILocation(line: 21, column: 35, scope: !81)
!81 = distinct !DILexicalBlock(scope: !78, file: !1, line: 21, column: 23)
!82 = !DILocation(line: 21, column: 37, scope: !81)
!83 = !DILocation(line: 21, column: 23, scope: !78)
!84 = !DILocation(line: 23, column: 29, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !1, line: 21, column: 55)
!86 = !DILocation(line: 23, column: 31, scope: !85)
!87 = !DILocation(line: 23, column: 27, scope: !85)
!88 = !DILocation(line: 24, column: 30, scope: !85)
!89 = !DILocation(line: 24, column: 35, scope: !85)
!90 = !DILocation(line: 24, column: 33, scope: !85)
!91 = !DILocation(line: 24, column: 39, scope: !85)
!92 = !DILocation(line: 24, column: 27, scope: !85)
!93 = !DILocation(line: 25, column: 30, scope: !85)
!94 = !DILocation(line: 25, column: 33, scope: !85)
!95 = !DILocation(line: 25, column: 41, scope: !85)
!96 = !DILocation(line: 25, column: 39, scope: !85)
!97 = !DILocation(line: 25, column: 45, scope: !85)
!98 = !DILocation(line: 25, column: 43, scope: !85)
!99 = !DILocation(line: 25, column: 28, scope: !85)
!100 = !DILocation(line: 25, column: 21, scope: !85)
!101 = !DILabel(scope: !85, name: "loopj", file: !1, line: 26)
!102 = !DILocation(line: 26, column: 21, scope: !85)
!103 = !DILocation(line: 26, column: 34, scope: !104)
!104 = distinct !DILexicalBlock(scope: !85, file: !1, line: 26, column: 27)
!105 = !DILocation(line: 26, column: 32, scope: !104)
!106 = !DILocation(line: 26, column: 39, scope: !107)
!107 = distinct !DILexicalBlock(scope: !104, file: !1, line: 26, column: 27)
!108 = !DILocation(line: 26, column: 41, scope: !107)
!109 = !DILocation(line: 26, column: 27, scope: !104)
!110 = !DILocation(line: 28, column: 31, scope: !111)
!111 = distinct !DILexicalBlock(scope: !107, file: !1, line: 26, column: 59)
!112 = !DILocation(line: 28, column: 40, scope: !111)
!113 = !DILocation(line: 28, column: 43, scope: !111)
!114 = !DILocation(line: 28, column: 51, scope: !111)
!115 = !DILocation(line: 28, column: 49, scope: !111)
!116 = !DILocation(line: 28, column: 55, scope: !111)
!117 = !DILocation(line: 28, column: 53, scope: !111)
!118 = !DILocation(line: 28, column: 38, scope: !111)
!119 = !DILocation(line: 28, column: 29, scope: !111)
!120 = !DILocation(line: 29, column: 49, scope: !111)
!121 = !DILocation(line: 29, column: 25, scope: !111)
!122 = !DILocation(line: 29, column: 30, scope: !111)
!123 = !DILocation(line: 29, column: 38, scope: !111)
!124 = !DILocation(line: 29, column: 36, scope: !111)
!125 = !DILocation(line: 29, column: 42, scope: !111)
!126 = !DILocation(line: 29, column: 40, scope: !111)
!127 = !DILocation(line: 29, column: 46, scope: !111)
!128 = !DILocation(line: 30, column: 21, scope: !111)
!129 = !DILocation(line: 26, column: 55, scope: !107)
!130 = !DILocation(line: 26, column: 27, scope: !107)
!131 = distinct !{!131, !109, !132, !133}
!132 = !DILocation(line: 30, column: 21, scope: !104)
!133 = !{!"llvm.loop.mustprogress"}
!134 = !DILocation(line: 31, column: 17, scope: !85)
!135 = !DILocation(line: 21, column: 51, scope: !81)
!136 = !DILocation(line: 21, column: 23, scope: !81)
!137 = distinct !{!137, !83, !138, !133}
!138 = !DILocation(line: 31, column: 17, scope: !78)
!139 = !DILocation(line: 32, column: 13, scope: !75)
!140 = !DILocation(line: 19, column: 46, scope: !70)
!141 = !DILocation(line: 19, column: 19, scope: !70)
!142 = distinct !{!142, !72, !143, !133}
!143 = !DILocation(line: 32, column: 13, scope: !67)
!144 = !DILocation(line: 33, column: 9, scope: !64)
!145 = !DILocation(line: 17, column: 47, scope: !59)
!146 = !DILocation(line: 17, column: 16, scope: !59)
!147 = distinct !{!147, !61, !148, !133}
!148 = !DILocation(line: 33, column: 9, scope: !56)
!149 = !DILocation(line: 34, column: 5, scope: !53)
!150 = !DILocation(line: 15, column: 43, scope: !48)
!151 = !DILocation(line: 15, column: 12, scope: !48)
!152 = distinct !{!152, !50, !153, !133}
!153 = !DILocation(line: 34, column: 5, scope: !45)
!154 = !DILocation(line: 35, column: 1, scope: !10)
