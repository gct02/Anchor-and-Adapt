; ModuleID = 'data/benchmarks/real/gsm/gsm.c'
source_filename = "data/benchmarks/real/gsm/gsm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Gsm_LPC_Analysis(i16* noundef %indata, i16* noundef %LARc) #0 !dbg !10 {
entry:
  %indata.addr = alloca i16*, align 8
  %LARc.addr = alloca i16*, align 8
  %L_ACF = alloca [9 x i64], align 16
  store i16* %indata, i16** %indata.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %indata.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store i16* %LARc, i16** %LARc.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %LARc.addr, metadata !20, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata [9 x i64]* %L_ACF, metadata !22, metadata !DIExpression()), !dbg !28
  %0 = load i16*, i16** %indata.addr, align 8, !dbg !29
  %arraydecay = getelementptr inbounds [9 x i64], [9 x i64]* %L_ACF, i64 0, i64 0, !dbg !30
  call void @Autocorrelation(i16* noundef %0, i64* noundef %arraydecay), !dbg !31
  %arraydecay1 = getelementptr inbounds [9 x i64], [9 x i64]* %L_ACF, i64 0, i64 0, !dbg !32
  %1 = load i16*, i16** %LARc.addr, align 8, !dbg !33
  call void @Reflection_coefficients(i64* noundef %arraydecay1, i16* noundef %1), !dbg !34
  %2 = load i16*, i16** %LARc.addr, align 8, !dbg !35
  call void @Transformation_to_Log_Area_Ratios(i16* noundef %2), !dbg !36
  %3 = load i16*, i16** %LARc.addr, align 8, !dbg !37
  call void @Quantization_and_coding(i16* noundef %3), !dbg !38
  ret void, !dbg !39
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @Autocorrelation(i16* noundef, i64* noundef) #2

declare void @Reflection_coefficients(i64* noundef, i16* noundef) #2

declare void @Transformation_to_Log_Area_Ratios(i16* noundef) #2

declare void @Quantization_and_coding(i16* noundef) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "data/benchmarks/real/gsm/gsm.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "d3722921f9a4500b1c124a0080ea33be")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "Gsm_LPC_Analysis", scope: !1, file: !1, line: 7, type: !11, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !17)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "word", file: !15, line: 30, baseType: !16)
!15 = !DIFile(filename: "data/benchmarks/real/gsm/gsm_private.h", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "4f2b4f8362ef72e1c64723ce45f8c494")
!16 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!17 = !{}
!18 = !DILocalVariable(name: "indata", arg: 1, scope: !10, file: !1, line: 7, type: !13)
!19 = !DILocation(line: 7, column: 28, scope: !10)
!20 = !DILocalVariable(name: "LARc", arg: 2, scope: !10, file: !1, line: 7, type: !13)
!21 = !DILocation(line: 7, column: 44, scope: !10)
!22 = !DILocalVariable(name: "L_ACF", scope: !10, file: !1, line: 9, type: !23)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 576, elements: !26)
!24 = !DIDerivedType(tag: DW_TAG_typedef, name: "longword", file: !15, line: 31, baseType: !25)
!25 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!26 = !{!27}
!27 = !DISubrange(count: 9)
!28 = !DILocation(line: 9, column: 14, scope: !10)
!29 = !DILocation(line: 11, column: 21, scope: !10)
!30 = !DILocation(line: 11, column: 29, scope: !10)
!31 = !DILocation(line: 11, column: 5, scope: !10)
!32 = !DILocation(line: 12, column: 29, scope: !10)
!33 = !DILocation(line: 12, column: 36, scope: !10)
!34 = !DILocation(line: 12, column: 5, scope: !10)
!35 = !DILocation(line: 13, column: 39, scope: !10)
!36 = !DILocation(line: 13, column: 5, scope: !10)
!37 = !DILocation(line: 14, column: 29, scope: !10)
!38 = !DILocation(line: 14, column: 5, scope: !10)
!39 = !DILocation(line: 15, column: 1, scope: !10)
