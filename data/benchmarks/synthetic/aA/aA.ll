; ModuleID = 'aA.c'
source_filename = "aA.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @aA(double noundef %alpha, [64 x double]* noundef %A, [64 x double]* noundef %A_out) #0 !dbg !10 {
entry:
  %alpha.addr = alloca double, align 8
  %A.addr = alloca [64 x double]*, align 8
  %A_out.addr = alloca [64 x double]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %buff_A = alloca [64 x [64 x double]], align 16
  %buff_A_out = alloca [64 x [64 x double]], align 16
  store double %alpha, double* %alpha.addr, align 8
  call void @llvm.dbg.declare(metadata double* %alpha.addr, metadata !19, metadata !DIExpression()), !dbg !20
  store [64 x double]* %A, [64 x double]** %A.addr, align 8
  call void @llvm.dbg.declare(metadata [64 x double]** %A.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store [64 x double]* %A_out, [64 x double]** %A_out.addr, align 8
  call void @llvm.dbg.declare(metadata [64 x double]** %A_out.addr, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %i, metadata !25, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.declare(metadata i32* %j, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %k, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata [64 x [64 x double]]* %buff_A, metadata !32, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.declare(metadata [64 x [64 x double]]* %buff_A_out, metadata !36, metadata !DIExpression()), !dbg !37
  br label %lprd_1, !dbg !38

lprd_1:                                           ; preds = %entry
  call void @llvm.dbg.label(metadata !39), !dbg !40
  store i32 0, i32* %i, align 4, !dbg !41
  br label %for.cond, !dbg !43

for.cond:                                         ; preds = %for.inc10, %lprd_1
  %0 = load i32, i32* %i, align 4, !dbg !44
  %cmp = icmp slt i32 %0, 64, !dbg !46
  br i1 %cmp, label %for.body, label %for.end12, !dbg !47

for.body:                                         ; preds = %for.cond
  br label %lprd_2, !dbg !48

lprd_2:                                           ; preds = %for.body
  call void @llvm.dbg.label(metadata !49), !dbg !51
  store i32 0, i32* %j, align 4, !dbg !52
  br label %for.cond1, !dbg !54

for.cond1:                                        ; preds = %for.inc, %lprd_2
  %1 = load i32, i32* %j, align 4, !dbg !55
  %cmp2 = icmp slt i32 %1, 64, !dbg !57
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !58

for.body3:                                        ; preds = %for.cond1
  %2 = load [64 x double]*, [64 x double]** %A.addr, align 8, !dbg !59
  %3 = load i32, i32* %i, align 4, !dbg !61
  %idxprom = sext i32 %3 to i64, !dbg !59
  %arrayidx = getelementptr inbounds [64 x double], [64 x double]* %2, i64 %idxprom, !dbg !59
  %4 = load i32, i32* %j, align 4, !dbg !62
  %idxprom4 = sext i32 %4 to i64, !dbg !59
  %arrayidx5 = getelementptr inbounds [64 x double], [64 x double]* %arrayidx, i64 0, i64 %idxprom4, !dbg !59
  %5 = load double, double* %arrayidx5, align 8, !dbg !59
  %6 = load i32, i32* %i, align 4, !dbg !63
  %idxprom6 = sext i32 %6 to i64, !dbg !64
  %arrayidx7 = getelementptr inbounds [64 x [64 x double]], [64 x [64 x double]]* %buff_A, i64 0, i64 %idxprom6, !dbg !64
  %7 = load i32, i32* %j, align 4, !dbg !65
  %idxprom8 = sext i32 %7 to i64, !dbg !64
  %arrayidx9 = getelementptr inbounds [64 x double], [64 x double]* %arrayidx7, i64 0, i64 %idxprom8, !dbg !64
  store double %5, double* %arrayidx9, align 8, !dbg !66
  br label %for.inc, !dbg !67

for.inc:                                          ; preds = %for.body3
  %8 = load i32, i32* %j, align 4, !dbg !68
  %inc = add nsw i32 %8, 1, !dbg !68
  store i32 %inc, i32* %j, align 4, !dbg !68
  br label %for.cond1, !dbg !69, !llvm.loop !70

for.end:                                          ; preds = %for.cond1
  br label %for.inc10, !dbg !73

for.inc10:                                        ; preds = %for.end
  %9 = load i32, i32* %i, align 4, !dbg !74
  %inc11 = add nsw i32 %9, 1, !dbg !74
  store i32 %inc11, i32* %i, align 4, !dbg !74
  br label %for.cond, !dbg !75, !llvm.loop !76

for.end12:                                        ; preds = %for.cond
  br label %lp1, !dbg !77

lp1:                                              ; preds = %for.end12
  call void @llvm.dbg.label(metadata !78), !dbg !79
  store i32 0, i32* %i, align 4, !dbg !80
  br label %for.cond13, !dbg !82

for.cond13:                                       ; preds = %for.inc30, %lp1
  %10 = load i32, i32* %i, align 4, !dbg !83
  %cmp14 = icmp slt i32 %10, 64, !dbg !85
  br i1 %cmp14, label %for.body15, label %for.end32, !dbg !86

for.body15:                                       ; preds = %for.cond13
  br label %lp2, !dbg !87

lp2:                                              ; preds = %for.body15
  call void @llvm.dbg.label(metadata !88), !dbg !90
  store i32 0, i32* %j, align 4, !dbg !91
  br label %for.cond16, !dbg !93

for.cond16:                                       ; preds = %for.inc27, %lp2
  %11 = load i32, i32* %j, align 4, !dbg !94
  %cmp17 = icmp slt i32 %11, 64, !dbg !96
  br i1 %cmp17, label %for.body18, label %for.end29, !dbg !97

for.body18:                                       ; preds = %for.cond16
  %12 = load double, double* %alpha.addr, align 8, !dbg !98
  %13 = load i32, i32* %i, align 4, !dbg !100
  %idxprom19 = sext i32 %13 to i64, !dbg !101
  %arrayidx20 = getelementptr inbounds [64 x [64 x double]], [64 x [64 x double]]* %buff_A, i64 0, i64 %idxprom19, !dbg !101
  %14 = load i32, i32* %j, align 4, !dbg !102
  %idxprom21 = sext i32 %14 to i64, !dbg !101
  %arrayidx22 = getelementptr inbounds [64 x double], [64 x double]* %arrayidx20, i64 0, i64 %idxprom21, !dbg !101
  %15 = load double, double* %arrayidx22, align 8, !dbg !101
  %mul = fmul double %12, %15, !dbg !103
  %16 = load i32, i32* %i, align 4, !dbg !104
  %idxprom23 = sext i32 %16 to i64, !dbg !105
  %arrayidx24 = getelementptr inbounds [64 x [64 x double]], [64 x [64 x double]]* %buff_A_out, i64 0, i64 %idxprom23, !dbg !105
  %17 = load i32, i32* %j, align 4, !dbg !106
  %idxprom25 = sext i32 %17 to i64, !dbg !105
  %arrayidx26 = getelementptr inbounds [64 x double], [64 x double]* %arrayidx24, i64 0, i64 %idxprom25, !dbg !105
  store double %mul, double* %arrayidx26, align 8, !dbg !107
  br label %for.inc27, !dbg !108

for.inc27:                                        ; preds = %for.body18
  %18 = load i32, i32* %j, align 4, !dbg !109
  %inc28 = add nsw i32 %18, 1, !dbg !109
  store i32 %inc28, i32* %j, align 4, !dbg !109
  br label %for.cond16, !dbg !110, !llvm.loop !111

for.end29:                                        ; preds = %for.cond16
  br label %for.inc30, !dbg !113

for.inc30:                                        ; preds = %for.end29
  %19 = load i32, i32* %i, align 4, !dbg !114
  %inc31 = add nsw i32 %19, 1, !dbg !114
  store i32 %inc31, i32* %i, align 4, !dbg !114
  br label %for.cond13, !dbg !115, !llvm.loop !116

for.end32:                                        ; preds = %for.cond13
  br label %lpwr_1, !dbg !117

lpwr_1:                                           ; preds = %for.end32
  call void @llvm.dbg.label(metadata !118), !dbg !119
  store i32 0, i32* %i, align 4, !dbg !120
  br label %for.cond33, !dbg !122

for.cond33:                                       ; preds = %for.inc50, %lpwr_1
  %20 = load i32, i32* %i, align 4, !dbg !123
  %cmp34 = icmp slt i32 %20, 64, !dbg !125
  br i1 %cmp34, label %for.body35, label %for.end52, !dbg !126

for.body35:                                       ; preds = %for.cond33
  br label %lpwr_2, !dbg !127

lpwr_2:                                           ; preds = %for.body35
  call void @llvm.dbg.label(metadata !128), !dbg !130
  store i32 0, i32* %j, align 4, !dbg !131
  br label %for.cond36, !dbg !133

for.cond36:                                       ; preds = %for.inc47, %lpwr_2
  %21 = load i32, i32* %j, align 4, !dbg !134
  %cmp37 = icmp slt i32 %21, 64, !dbg !136
  br i1 %cmp37, label %for.body38, label %for.end49, !dbg !137

for.body38:                                       ; preds = %for.cond36
  %22 = load i32, i32* %i, align 4, !dbg !138
  %idxprom39 = sext i32 %22 to i64, !dbg !140
  %arrayidx40 = getelementptr inbounds [64 x [64 x double]], [64 x [64 x double]]* %buff_A_out, i64 0, i64 %idxprom39, !dbg !140
  %23 = load i32, i32* %j, align 4, !dbg !141
  %idxprom41 = sext i32 %23 to i64, !dbg !140
  %arrayidx42 = getelementptr inbounds [64 x double], [64 x double]* %arrayidx40, i64 0, i64 %idxprom41, !dbg !140
  %24 = load double, double* %arrayidx42, align 8, !dbg !140
  %25 = load [64 x double]*, [64 x double]** %A_out.addr, align 8, !dbg !142
  %26 = load i32, i32* %i, align 4, !dbg !143
  %idxprom43 = sext i32 %26 to i64, !dbg !142
  %arrayidx44 = getelementptr inbounds [64 x double], [64 x double]* %25, i64 %idxprom43, !dbg !142
  %27 = load i32, i32* %j, align 4, !dbg !144
  %idxprom45 = sext i32 %27 to i64, !dbg !142
  %arrayidx46 = getelementptr inbounds [64 x double], [64 x double]* %arrayidx44, i64 0, i64 %idxprom45, !dbg !142
  store double %24, double* %arrayidx46, align 8, !dbg !145
  br label %for.inc47, !dbg !146

for.inc47:                                        ; preds = %for.body38
  %28 = load i32, i32* %j, align 4, !dbg !147
  %inc48 = add nsw i32 %28, 1, !dbg !147
  store i32 %inc48, i32* %j, align 4, !dbg !147
  br label %for.cond36, !dbg !148, !llvm.loop !149

for.end49:                                        ; preds = %for.cond36
  br label %for.inc50, !dbg !151

for.inc50:                                        ; preds = %for.end49
  %29 = load i32, i32* %i, align 4, !dbg !152
  %inc51 = add nsw i32 %29, 1, !dbg !152
  store i32 %inc51, i32* %i, align 4, !dbg !152
  br label %for.cond33, !dbg !153, !llvm.loop !154

for.end52:                                        ; preds = %for.cond33
  ret void, !dbg !156
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
!1 = !DIFile(filename: "aA.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS/data/benchmarks/synthetic/PowerGear/aA", checksumkind: CSK_MD5, checksum: "e061e1f341b521aa2bc8c85d4d78119e")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "aA", scope: !1, file: !1, line: 5, type: !11, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !18)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !14, !14}
!13 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 4096, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 64)
!18 = !{}
!19 = !DILocalVariable(name: "alpha", arg: 1, scope: !10, file: !1, line: 5, type: !13)
!20 = !DILocation(line: 5, column: 16, scope: !10)
!21 = !DILocalVariable(name: "A", arg: 2, scope: !10, file: !1, line: 5, type: !14)
!22 = !DILocation(line: 5, column: 30, scope: !10)
!23 = !DILocalVariable(name: "A_out", arg: 3, scope: !10, file: !1, line: 5, type: !14)
!24 = !DILocation(line: 5, column: 46, scope: !10)
!25 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 7, type: !26)
!26 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!27 = !DILocation(line: 7, column: 9, scope: !10)
!28 = !DILocalVariable(name: "j", scope: !10, file: !1, line: 7, type: !26)
!29 = !DILocation(line: 7, column: 12, scope: !10)
!30 = !DILocalVariable(name: "k", scope: !10, file: !1, line: 7, type: !26)
!31 = !DILocation(line: 7, column: 15, scope: !10)
!32 = !DILocalVariable(name: "buff_A", scope: !10, file: !1, line: 9, type: !33)
!33 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 262144, elements: !34)
!34 = !{!17, !17}
!35 = !DILocation(line: 9, column: 12, scope: !10)
!36 = !DILocalVariable(name: "buff_A_out", scope: !10, file: !1, line: 10, type: !33)
!37 = !DILocation(line: 10, column: 12, scope: !10)
!38 = !DILocation(line: 10, column: 5, scope: !10)
!39 = !DILabel(scope: !10, name: "lprd_1", file: !1, line: 12)
!40 = !DILocation(line: 12, column: 5, scope: !10)
!41 = !DILocation(line: 12, column: 20, scope: !42)
!42 = distinct !DILexicalBlock(scope: !10, file: !1, line: 12, column: 13)
!43 = !DILocation(line: 12, column: 18, scope: !42)
!44 = !DILocation(line: 12, column: 25, scope: !45)
!45 = distinct !DILexicalBlock(scope: !42, file: !1, line: 12, column: 13)
!46 = !DILocation(line: 12, column: 27, scope: !45)
!47 = !DILocation(line: 12, column: 13, scope: !42)
!48 = !DILocation(line: 12, column: 36, scope: !45)
!49 = !DILabel(scope: !50, name: "lprd_2", file: !1, line: 14)
!50 = distinct !DILexicalBlock(scope: !45, file: !1, line: 12, column: 36)
!51 = !DILocation(line: 14, column: 9, scope: !50)
!52 = !DILocation(line: 14, column: 24, scope: !53)
!53 = distinct !DILexicalBlock(scope: !50, file: !1, line: 14, column: 17)
!54 = !DILocation(line: 14, column: 22, scope: !53)
!55 = !DILocation(line: 14, column: 29, scope: !56)
!56 = distinct !DILexicalBlock(scope: !53, file: !1, line: 14, column: 17)
!57 = !DILocation(line: 14, column: 31, scope: !56)
!58 = !DILocation(line: 14, column: 17, scope: !53)
!59 = !DILocation(line: 16, column: 28, scope: !60)
!60 = distinct !DILexicalBlock(scope: !56, file: !1, line: 14, column: 40)
!61 = !DILocation(line: 16, column: 30, scope: !60)
!62 = !DILocation(line: 16, column: 33, scope: !60)
!63 = !DILocation(line: 16, column: 20, scope: !60)
!64 = !DILocation(line: 16, column: 13, scope: !60)
!65 = !DILocation(line: 16, column: 23, scope: !60)
!66 = !DILocation(line: 16, column: 26, scope: !60)
!67 = !DILocation(line: 17, column: 9, scope: !60)
!68 = !DILocation(line: 14, column: 37, scope: !56)
!69 = !DILocation(line: 14, column: 17, scope: !56)
!70 = distinct !{!70, !58, !71, !72}
!71 = !DILocation(line: 17, column: 9, scope: !53)
!72 = !{!"llvm.loop.mustprogress"}
!73 = !DILocation(line: 18, column: 5, scope: !50)
!74 = !DILocation(line: 12, column: 33, scope: !45)
!75 = !DILocation(line: 12, column: 13, scope: !45)
!76 = distinct !{!76, !47, !77, !72}
!77 = !DILocation(line: 18, column: 5, scope: !42)
!78 = !DILabel(scope: !10, name: "lp1", file: !1, line: 20)
!79 = !DILocation(line: 20, column: 5, scope: !10)
!80 = !DILocation(line: 20, column: 17, scope: !81)
!81 = distinct !DILexicalBlock(scope: !10, file: !1, line: 20, column: 10)
!82 = !DILocation(line: 20, column: 15, scope: !81)
!83 = !DILocation(line: 20, column: 22, scope: !84)
!84 = distinct !DILexicalBlock(scope: !81, file: !1, line: 20, column: 10)
!85 = !DILocation(line: 20, column: 24, scope: !84)
!86 = !DILocation(line: 20, column: 10, scope: !81)
!87 = !DILocation(line: 20, column: 34, scope: !84)
!88 = !DILabel(scope: !89, name: "lp2", file: !1, line: 22)
!89 = distinct !DILexicalBlock(scope: !84, file: !1, line: 20, column: 34)
!90 = !DILocation(line: 22, column: 9, scope: !89)
!91 = !DILocation(line: 22, column: 21, scope: !92)
!92 = distinct !DILexicalBlock(scope: !89, file: !1, line: 22, column: 14)
!93 = !DILocation(line: 22, column: 19, scope: !92)
!94 = !DILocation(line: 22, column: 26, scope: !95)
!95 = distinct !DILexicalBlock(scope: !92, file: !1, line: 22, column: 14)
!96 = !DILocation(line: 22, column: 28, scope: !95)
!97 = !DILocation(line: 22, column: 14, scope: !92)
!98 = !DILocation(line: 24, column: 32, scope: !99)
!99 = distinct !DILexicalBlock(scope: !95, file: !1, line: 22, column: 38)
!100 = !DILocation(line: 24, column: 47, scope: !99)
!101 = !DILocation(line: 24, column: 40, scope: !99)
!102 = !DILocation(line: 24, column: 50, scope: !99)
!103 = !DILocation(line: 24, column: 38, scope: !99)
!104 = !DILocation(line: 24, column: 24, scope: !99)
!105 = !DILocation(line: 24, column: 13, scope: !99)
!106 = !DILocation(line: 24, column: 27, scope: !99)
!107 = !DILocation(line: 24, column: 30, scope: !99)
!108 = !DILocation(line: 25, column: 9, scope: !99)
!109 = !DILocation(line: 22, column: 34, scope: !95)
!110 = !DILocation(line: 22, column: 14, scope: !95)
!111 = distinct !{!111, !97, !112, !72}
!112 = !DILocation(line: 25, column: 9, scope: !92)
!113 = !DILocation(line: 26, column: 5, scope: !89)
!114 = !DILocation(line: 20, column: 30, scope: !84)
!115 = !DILocation(line: 20, column: 10, scope: !84)
!116 = distinct !{!116, !86, !117, !72}
!117 = !DILocation(line: 26, column: 5, scope: !81)
!118 = !DILabel(scope: !10, name: "lpwr_1", file: !1, line: 28)
!119 = !DILocation(line: 28, column: 5, scope: !10)
!120 = !DILocation(line: 28, column: 20, scope: !121)
!121 = distinct !DILexicalBlock(scope: !10, file: !1, line: 28, column: 13)
!122 = !DILocation(line: 28, column: 18, scope: !121)
!123 = !DILocation(line: 28, column: 25, scope: !124)
!124 = distinct !DILexicalBlock(scope: !121, file: !1, line: 28, column: 13)
!125 = !DILocation(line: 28, column: 27, scope: !124)
!126 = !DILocation(line: 28, column: 13, scope: !121)
!127 = !DILocation(line: 28, column: 36, scope: !124)
!128 = !DILabel(scope: !129, name: "lpwr_2", file: !1, line: 30)
!129 = distinct !DILexicalBlock(scope: !124, file: !1, line: 28, column: 36)
!130 = !DILocation(line: 30, column: 9, scope: !129)
!131 = !DILocation(line: 30, column: 24, scope: !132)
!132 = distinct !DILexicalBlock(scope: !129, file: !1, line: 30, column: 17)
!133 = !DILocation(line: 30, column: 22, scope: !132)
!134 = !DILocation(line: 30, column: 29, scope: !135)
!135 = distinct !DILexicalBlock(scope: !132, file: !1, line: 30, column: 17)
!136 = !DILocation(line: 30, column: 31, scope: !135)
!137 = !DILocation(line: 30, column: 17, scope: !132)
!138 = !DILocation(line: 32, column: 39, scope: !139)
!139 = distinct !DILexicalBlock(scope: !135, file: !1, line: 30, column: 40)
!140 = !DILocation(line: 32, column: 28, scope: !139)
!141 = !DILocation(line: 32, column: 42, scope: !139)
!142 = !DILocation(line: 32, column: 13, scope: !139)
!143 = !DILocation(line: 32, column: 19, scope: !139)
!144 = !DILocation(line: 32, column: 22, scope: !139)
!145 = !DILocation(line: 32, column: 25, scope: !139)
!146 = !DILocation(line: 33, column: 9, scope: !139)
!147 = !DILocation(line: 30, column: 37, scope: !135)
!148 = !DILocation(line: 30, column: 17, scope: !135)
!149 = distinct !{!149, !137, !150, !72}
!150 = !DILocation(line: 33, column: 9, scope: !132)
!151 = !DILocation(line: 34, column: 5, scope: !129)
!152 = !DILocation(line: 28, column: 33, scope: !124)
!153 = !DILocation(line: 28, column: 13, scope: !124)
!154 = distinct !{!154, !126, !155, !72}
!155 = !DILocation(line: 34, column: 5, scope: !121)
!156 = !DILocation(line: 35, column: 1, scope: !10)
