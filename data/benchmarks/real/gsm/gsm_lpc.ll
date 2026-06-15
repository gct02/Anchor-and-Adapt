; ModuleID = 'data/benchmarks/real/gsm/gsm_lpc.c'
source_filename = "data/benchmarks/real/gsm/gsm_lpc.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Autocorrelation(i16* noundef %s, i64* noundef %L_ACF) #0 !dbg !14 {
entry:
  %s.addr = alloca i16*, align 8
  %L_ACF.addr = alloca i64*, align 8
  %k = alloca i32, align 4
  %i = alloca i32, align 4
  %temp = alloca i16, align 2
  %smax = alloca i16, align 2
  %scalauto = alloca i16, align 2
  %n = alloca i16, align 2
  %sp = alloca i16*, align 8
  %sl = alloca i16, align 2
  store i16* %s, i16** %s.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %s.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store i64* %L_ACF, i64** %L_ACF.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %L_ACF.addr, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %k, metadata !26, metadata !DIExpression()), !dbg !28
  call void @llvm.dbg.declare(metadata i32* %i, metadata !29, metadata !DIExpression()), !dbg !30
  call void @llvm.dbg.declare(metadata i16* %temp, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata i16* %smax, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata i16* %scalauto, metadata !35, metadata !DIExpression()), !dbg !36
  call void @llvm.dbg.declare(metadata i16* %n, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata i16** %sp, metadata !39, metadata !DIExpression()), !dbg !40
  call void @llvm.dbg.declare(metadata i16* %sl, metadata !41, metadata !DIExpression()), !dbg !42
  store i16 0, i16* %smax, align 2, !dbg !43
  br label %Autocorrelation_label0, !dbg !44

Autocorrelation_label0:                           ; preds = %entry
  call void @llvm.dbg.label(metadata !45), !dbg !46
  store i32 0, i32* %k, align 4, !dbg !47
  br label %for.cond, !dbg !49

for.cond:                                         ; preds = %for.inc, %Autocorrelation_label0
  %0 = load i32, i32* %k, align 4, !dbg !50
  %cmp = icmp sle i32 %0, 159, !dbg !52
  br i1 %cmp, label %for.body, label %for.end, !dbg !53

for.body:                                         ; preds = %for.cond
  %1 = load i16*, i16** %s.addr, align 8, !dbg !54
  %2 = load i32, i32* %k, align 4, !dbg !54
  %idxprom = sext i32 %2 to i64, !dbg !54
  %arrayidx = getelementptr inbounds i16, i16* %1, i64 %idxprom, !dbg !54
  %3 = load i16, i16* %arrayidx, align 2, !dbg !54
  %call = call signext i16 @gsm_abs(i16 noundef signext %3), !dbg !54
  store i16 %call, i16* %temp, align 2, !dbg !56
  %4 = load i16, i16* %temp, align 2, !dbg !57
  %conv = sext i16 %4 to i32, !dbg !57
  %5 = load i16, i16* %smax, align 2, !dbg !59
  %conv1 = sext i16 %5 to i32, !dbg !59
  %cmp2 = icmp sgt i32 %conv, %conv1, !dbg !60
  br i1 %cmp2, label %if.then, label %if.end, !dbg !61

if.then:                                          ; preds = %for.body
  %6 = load i16, i16* %temp, align 2, !dbg !62
  store i16 %6, i16* %smax, align 2, !dbg !63
  br label %if.end, !dbg !64

if.end:                                           ; preds = %if.then, %for.body
  br label %for.inc, !dbg !65

for.inc:                                          ; preds = %if.end
  %7 = load i32, i32* %k, align 4, !dbg !66
  %inc = add nsw i32 %7, 1, !dbg !66
  store i32 %inc, i32* %k, align 4, !dbg !66
  br label %for.cond, !dbg !67, !llvm.loop !68

for.end:                                          ; preds = %for.cond
  %8 = load i16, i16* %smax, align 2, !dbg !71
  %conv4 = sext i16 %8 to i32, !dbg !71
  %cmp5 = icmp eq i32 %conv4, 0, !dbg !73
  br i1 %cmp5, label %if.then7, label %if.else, !dbg !74

if.then7:                                         ; preds = %for.end
  store i16 0, i16* %scalauto, align 2, !dbg !75
  br label %if.end12, !dbg !76

if.else:                                          ; preds = %for.end
  %9 = load i16, i16* %smax, align 2, !dbg !77
  %conv8 = sext i16 %9 to i64, !dbg !78
  %shl = shl i64 %conv8, 16, !dbg !79
  %call9 = call signext i16 @gsm_norm(i64 noundef %shl), !dbg !80
  %conv10 = sext i16 %call9 to i32, !dbg !80
  %sub = sub nsw i32 4, %conv10, !dbg !81
  %conv11 = trunc i32 %sub to i16, !dbg !82
  store i16 %conv11, i16* %scalauto, align 2, !dbg !83
  br label %if.end12

if.end12:                                         ; preds = %if.else, %if.then7
  %10 = load i16, i16* %scalauto, align 2, !dbg !84
  %conv13 = sext i16 %10 to i32, !dbg !84
  %cmp14 = icmp sgt i32 %conv13, 0, !dbg !86
  br i1 %cmp14, label %land.lhs.true, label %if.end35, !dbg !87

land.lhs.true:                                    ; preds = %if.end12
  %11 = load i16, i16* %scalauto, align 2, !dbg !88
  %conv16 = sext i16 %11 to i32, !dbg !88
  %cmp17 = icmp sle i32 %conv16, 4, !dbg !89
  br i1 %cmp17, label %if.then19, label %if.end35, !dbg !90

if.then19:                                        ; preds = %land.lhs.true
  %12 = load i16, i16* %scalauto, align 2, !dbg !91
  store i16 %12, i16* %n, align 2, !dbg !93
  br label %Autocorrelation_label1, !dbg !94

Autocorrelation_label1:                           ; preds = %if.then19
  call void @llvm.dbg.label(metadata !95), !dbg !96
  store i32 0, i32* %k, align 4, !dbg !97
  br label %for.cond20, !dbg !99

for.cond20:                                       ; preds = %for.inc32, %Autocorrelation_label1
  %13 = load i32, i32* %k, align 4, !dbg !100
  %cmp21 = icmp sle i32 %13, 159, !dbg !102
  br i1 %cmp21, label %for.body23, label %for.end34, !dbg !103

for.body23:                                       ; preds = %for.cond20
  %14 = load i16*, i16** %s.addr, align 8, !dbg !104
  %15 = load i32, i32* %k, align 4, !dbg !104
  %idxprom24 = sext i32 %15 to i64, !dbg !104
  %arrayidx25 = getelementptr inbounds i16, i16* %14, i64 %idxprom24, !dbg !104
  %16 = load i16, i16* %arrayidx25, align 2, !dbg !104
  %17 = load i16, i16* %n, align 2, !dbg !104
  %conv26 = sext i16 %17 to i32, !dbg !104
  %sub27 = sub nsw i32 %conv26, 1, !dbg !104
  %shr = ashr i32 16384, %sub27, !dbg !104
  %conv28 = trunc i32 %shr to i16, !dbg !104
  %call29 = call signext i16 @gsm_mult_r(i16 noundef signext %16, i16 noundef signext %conv28), !dbg !104
  %18 = load i16*, i16** %s.addr, align 8, !dbg !106
  %19 = load i32, i32* %k, align 4, !dbg !107
  %idxprom30 = sext i32 %19 to i64, !dbg !106
  %arrayidx31 = getelementptr inbounds i16, i16* %18, i64 %idxprom30, !dbg !106
  store i16 %call29, i16* %arrayidx31, align 2, !dbg !108
  br label %for.inc32, !dbg !109

for.inc32:                                        ; preds = %for.body23
  %20 = load i32, i32* %k, align 4, !dbg !110
  %inc33 = add nsw i32 %20, 1, !dbg !110
  store i32 %inc33, i32* %k, align 4, !dbg !110
  br label %for.cond20, !dbg !111, !llvm.loop !112

for.end34:                                        ; preds = %for.cond20
  br label %if.end35, !dbg !114

if.end35:                                         ; preds = %for.end34, %land.lhs.true, %if.end12
  %21 = load i16*, i16** %s.addr, align 8, !dbg !115
  store i16* %21, i16** %sp, align 8, !dbg !116
  %22 = load i16*, i16** %sp, align 8, !dbg !117
  %23 = load i16, i16* %22, align 2, !dbg !118
  store i16 %23, i16* %sl, align 2, !dbg !119
  br label %Autocorrelation_label2, !dbg !120

Autocorrelation_label2:                           ; preds = %if.end35
  call void @llvm.dbg.label(metadata !121), !dbg !122
  store i32 8, i32* %k, align 4, !dbg !123
  br label %for.cond36, !dbg !125

for.cond36:                                       ; preds = %for.inc42, %Autocorrelation_label2
  %24 = load i32, i32* %k, align 4, !dbg !126
  %cmp37 = icmp sge i32 %24, 0, !dbg !128
  br i1 %cmp37, label %for.body39, label %for.end43, !dbg !129

for.body39:                                       ; preds = %for.cond36
  %25 = load i64*, i64** %L_ACF.addr, align 8, !dbg !130
  %26 = load i32, i32* %k, align 4, !dbg !132
  %idxprom40 = sext i32 %26 to i64, !dbg !130
  %arrayidx41 = getelementptr inbounds i64, i64* %25, i64 %idxprom40, !dbg !130
  store i64 0, i64* %arrayidx41, align 8, !dbg !133
  br label %for.inc42, !dbg !134

for.inc42:                                        ; preds = %for.body39
  %27 = load i32, i32* %k, align 4, !dbg !135
  %dec = add nsw i32 %27, -1, !dbg !135
  store i32 %dec, i32* %k, align 4, !dbg !135
  br label %for.cond36, !dbg !136, !llvm.loop !137

for.end43:                                        ; preds = %for.cond36
  %28 = load i16, i16* %sl, align 2, !dbg !139
  %conv44 = sext i16 %28 to i64, !dbg !139
  %29 = load i16*, i16** %sp, align 8, !dbg !139
  %arrayidx45 = getelementptr inbounds i16, i16* %29, i64 0, !dbg !139
  %30 = load i16, i16* %arrayidx45, align 2, !dbg !139
  %conv46 = sext i16 %30 to i64, !dbg !139
  %mul = mul nsw i64 %conv44, %conv46, !dbg !139
  %31 = load i64*, i64** %L_ACF.addr, align 8, !dbg !139
  %arrayidx47 = getelementptr inbounds i64, i64* %31, i64 0, !dbg !139
  %32 = load i64, i64* %arrayidx47, align 8, !dbg !139
  %add = add nsw i64 %32, %mul, !dbg !139
  store i64 %add, i64* %arrayidx47, align 8, !dbg !139
  %33 = load i16*, i16** %sp, align 8, !dbg !140
  %incdec.ptr = getelementptr inbounds i16, i16* %33, i32 1, !dbg !140
  store i16* %incdec.ptr, i16** %sp, align 8, !dbg !140
  %34 = load i16, i16* %incdec.ptr, align 2, !dbg !140
  store i16 %34, i16* %sl, align 2, !dbg !140
  %35 = load i16, i16* %sl, align 2, !dbg !141
  %conv48 = sext i16 %35 to i64, !dbg !141
  %36 = load i16*, i16** %sp, align 8, !dbg !141
  %arrayidx49 = getelementptr inbounds i16, i16* %36, i64 0, !dbg !141
  %37 = load i16, i16* %arrayidx49, align 2, !dbg !141
  %conv50 = sext i16 %37 to i64, !dbg !141
  %mul51 = mul nsw i64 %conv48, %conv50, !dbg !141
  %38 = load i64*, i64** %L_ACF.addr, align 8, !dbg !141
  %arrayidx52 = getelementptr inbounds i64, i64* %38, i64 0, !dbg !141
  %39 = load i64, i64* %arrayidx52, align 8, !dbg !141
  %add53 = add nsw i64 %39, %mul51, !dbg !141
  store i64 %add53, i64* %arrayidx52, align 8, !dbg !141
  %40 = load i16, i16* %sl, align 2, !dbg !142
  %conv54 = sext i16 %40 to i64, !dbg !142
  %41 = load i16*, i16** %sp, align 8, !dbg !142
  %arrayidx55 = getelementptr inbounds i16, i16* %41, i64 -1, !dbg !142
  %42 = load i16, i16* %arrayidx55, align 2, !dbg !142
  %conv56 = sext i16 %42 to i64, !dbg !142
  %mul57 = mul nsw i64 %conv54, %conv56, !dbg !142
  %43 = load i64*, i64** %L_ACF.addr, align 8, !dbg !142
  %arrayidx58 = getelementptr inbounds i64, i64* %43, i64 1, !dbg !142
  %44 = load i64, i64* %arrayidx58, align 8, !dbg !142
  %add59 = add nsw i64 %44, %mul57, !dbg !142
  store i64 %add59, i64* %arrayidx58, align 8, !dbg !142
  %45 = load i16*, i16** %sp, align 8, !dbg !143
  %incdec.ptr60 = getelementptr inbounds i16, i16* %45, i32 1, !dbg !143
  store i16* %incdec.ptr60, i16** %sp, align 8, !dbg !143
  %46 = load i16, i16* %incdec.ptr60, align 2, !dbg !143
  store i16 %46, i16* %sl, align 2, !dbg !143
  %47 = load i16, i16* %sl, align 2, !dbg !144
  %conv61 = sext i16 %47 to i64, !dbg !144
  %48 = load i16*, i16** %sp, align 8, !dbg !144
  %arrayidx62 = getelementptr inbounds i16, i16* %48, i64 0, !dbg !144
  %49 = load i16, i16* %arrayidx62, align 2, !dbg !144
  %conv63 = sext i16 %49 to i64, !dbg !144
  %mul64 = mul nsw i64 %conv61, %conv63, !dbg !144
  %50 = load i64*, i64** %L_ACF.addr, align 8, !dbg !144
  %arrayidx65 = getelementptr inbounds i64, i64* %50, i64 0, !dbg !144
  %51 = load i64, i64* %arrayidx65, align 8, !dbg !144
  %add66 = add nsw i64 %51, %mul64, !dbg !144
  store i64 %add66, i64* %arrayidx65, align 8, !dbg !144
  %52 = load i16, i16* %sl, align 2, !dbg !145
  %conv67 = sext i16 %52 to i64, !dbg !145
  %53 = load i16*, i16** %sp, align 8, !dbg !145
  %arrayidx68 = getelementptr inbounds i16, i16* %53, i64 -1, !dbg !145
  %54 = load i16, i16* %arrayidx68, align 2, !dbg !145
  %conv69 = sext i16 %54 to i64, !dbg !145
  %mul70 = mul nsw i64 %conv67, %conv69, !dbg !145
  %55 = load i64*, i64** %L_ACF.addr, align 8, !dbg !145
  %arrayidx71 = getelementptr inbounds i64, i64* %55, i64 1, !dbg !145
  %56 = load i64, i64* %arrayidx71, align 8, !dbg !145
  %add72 = add nsw i64 %56, %mul70, !dbg !145
  store i64 %add72, i64* %arrayidx71, align 8, !dbg !145
  %57 = load i16, i16* %sl, align 2, !dbg !146
  %conv73 = sext i16 %57 to i64, !dbg !146
  %58 = load i16*, i16** %sp, align 8, !dbg !146
  %arrayidx74 = getelementptr inbounds i16, i16* %58, i64 -2, !dbg !146
  %59 = load i16, i16* %arrayidx74, align 2, !dbg !146
  %conv75 = sext i16 %59 to i64, !dbg !146
  %mul76 = mul nsw i64 %conv73, %conv75, !dbg !146
  %60 = load i64*, i64** %L_ACF.addr, align 8, !dbg !146
  %arrayidx77 = getelementptr inbounds i64, i64* %60, i64 2, !dbg !146
  %61 = load i64, i64* %arrayidx77, align 8, !dbg !146
  %add78 = add nsw i64 %61, %mul76, !dbg !146
  store i64 %add78, i64* %arrayidx77, align 8, !dbg !146
  %62 = load i16*, i16** %sp, align 8, !dbg !147
  %incdec.ptr79 = getelementptr inbounds i16, i16* %62, i32 1, !dbg !147
  store i16* %incdec.ptr79, i16** %sp, align 8, !dbg !147
  %63 = load i16, i16* %incdec.ptr79, align 2, !dbg !147
  store i16 %63, i16* %sl, align 2, !dbg !147
  %64 = load i16, i16* %sl, align 2, !dbg !148
  %conv80 = sext i16 %64 to i64, !dbg !148
  %65 = load i16*, i16** %sp, align 8, !dbg !148
  %arrayidx81 = getelementptr inbounds i16, i16* %65, i64 0, !dbg !148
  %66 = load i16, i16* %arrayidx81, align 2, !dbg !148
  %conv82 = sext i16 %66 to i64, !dbg !148
  %mul83 = mul nsw i64 %conv80, %conv82, !dbg !148
  %67 = load i64*, i64** %L_ACF.addr, align 8, !dbg !148
  %arrayidx84 = getelementptr inbounds i64, i64* %67, i64 0, !dbg !148
  %68 = load i64, i64* %arrayidx84, align 8, !dbg !148
  %add85 = add nsw i64 %68, %mul83, !dbg !148
  store i64 %add85, i64* %arrayidx84, align 8, !dbg !148
  %69 = load i16, i16* %sl, align 2, !dbg !149
  %conv86 = sext i16 %69 to i64, !dbg !149
  %70 = load i16*, i16** %sp, align 8, !dbg !149
  %arrayidx87 = getelementptr inbounds i16, i16* %70, i64 -1, !dbg !149
  %71 = load i16, i16* %arrayidx87, align 2, !dbg !149
  %conv88 = sext i16 %71 to i64, !dbg !149
  %mul89 = mul nsw i64 %conv86, %conv88, !dbg !149
  %72 = load i64*, i64** %L_ACF.addr, align 8, !dbg !149
  %arrayidx90 = getelementptr inbounds i64, i64* %72, i64 1, !dbg !149
  %73 = load i64, i64* %arrayidx90, align 8, !dbg !149
  %add91 = add nsw i64 %73, %mul89, !dbg !149
  store i64 %add91, i64* %arrayidx90, align 8, !dbg !149
  %74 = load i16, i16* %sl, align 2, !dbg !150
  %conv92 = sext i16 %74 to i64, !dbg !150
  %75 = load i16*, i16** %sp, align 8, !dbg !150
  %arrayidx93 = getelementptr inbounds i16, i16* %75, i64 -2, !dbg !150
  %76 = load i16, i16* %arrayidx93, align 2, !dbg !150
  %conv94 = sext i16 %76 to i64, !dbg !150
  %mul95 = mul nsw i64 %conv92, %conv94, !dbg !150
  %77 = load i64*, i64** %L_ACF.addr, align 8, !dbg !150
  %arrayidx96 = getelementptr inbounds i64, i64* %77, i64 2, !dbg !150
  %78 = load i64, i64* %arrayidx96, align 8, !dbg !150
  %add97 = add nsw i64 %78, %mul95, !dbg !150
  store i64 %add97, i64* %arrayidx96, align 8, !dbg !150
  %79 = load i16, i16* %sl, align 2, !dbg !151
  %conv98 = sext i16 %79 to i64, !dbg !151
  %80 = load i16*, i16** %sp, align 8, !dbg !151
  %arrayidx99 = getelementptr inbounds i16, i16* %80, i64 -3, !dbg !151
  %81 = load i16, i16* %arrayidx99, align 2, !dbg !151
  %conv100 = sext i16 %81 to i64, !dbg !151
  %mul101 = mul nsw i64 %conv98, %conv100, !dbg !151
  %82 = load i64*, i64** %L_ACF.addr, align 8, !dbg !151
  %arrayidx102 = getelementptr inbounds i64, i64* %82, i64 3, !dbg !151
  %83 = load i64, i64* %arrayidx102, align 8, !dbg !151
  %add103 = add nsw i64 %83, %mul101, !dbg !151
  store i64 %add103, i64* %arrayidx102, align 8, !dbg !151
  %84 = load i16*, i16** %sp, align 8, !dbg !152
  %incdec.ptr104 = getelementptr inbounds i16, i16* %84, i32 1, !dbg !152
  store i16* %incdec.ptr104, i16** %sp, align 8, !dbg !152
  %85 = load i16, i16* %incdec.ptr104, align 2, !dbg !152
  store i16 %85, i16* %sl, align 2, !dbg !152
  %86 = load i16, i16* %sl, align 2, !dbg !153
  %conv105 = sext i16 %86 to i64, !dbg !153
  %87 = load i16*, i16** %sp, align 8, !dbg !153
  %arrayidx106 = getelementptr inbounds i16, i16* %87, i64 0, !dbg !153
  %88 = load i16, i16* %arrayidx106, align 2, !dbg !153
  %conv107 = sext i16 %88 to i64, !dbg !153
  %mul108 = mul nsw i64 %conv105, %conv107, !dbg !153
  %89 = load i64*, i64** %L_ACF.addr, align 8, !dbg !153
  %arrayidx109 = getelementptr inbounds i64, i64* %89, i64 0, !dbg !153
  %90 = load i64, i64* %arrayidx109, align 8, !dbg !153
  %add110 = add nsw i64 %90, %mul108, !dbg !153
  store i64 %add110, i64* %arrayidx109, align 8, !dbg !153
  %91 = load i16, i16* %sl, align 2, !dbg !154
  %conv111 = sext i16 %91 to i64, !dbg !154
  %92 = load i16*, i16** %sp, align 8, !dbg !154
  %arrayidx112 = getelementptr inbounds i16, i16* %92, i64 -1, !dbg !154
  %93 = load i16, i16* %arrayidx112, align 2, !dbg !154
  %conv113 = sext i16 %93 to i64, !dbg !154
  %mul114 = mul nsw i64 %conv111, %conv113, !dbg !154
  %94 = load i64*, i64** %L_ACF.addr, align 8, !dbg !154
  %arrayidx115 = getelementptr inbounds i64, i64* %94, i64 1, !dbg !154
  %95 = load i64, i64* %arrayidx115, align 8, !dbg !154
  %add116 = add nsw i64 %95, %mul114, !dbg !154
  store i64 %add116, i64* %arrayidx115, align 8, !dbg !154
  %96 = load i16, i16* %sl, align 2, !dbg !155
  %conv117 = sext i16 %96 to i64, !dbg !155
  %97 = load i16*, i16** %sp, align 8, !dbg !155
  %arrayidx118 = getelementptr inbounds i16, i16* %97, i64 -2, !dbg !155
  %98 = load i16, i16* %arrayidx118, align 2, !dbg !155
  %conv119 = sext i16 %98 to i64, !dbg !155
  %mul120 = mul nsw i64 %conv117, %conv119, !dbg !155
  %99 = load i64*, i64** %L_ACF.addr, align 8, !dbg !155
  %arrayidx121 = getelementptr inbounds i64, i64* %99, i64 2, !dbg !155
  %100 = load i64, i64* %arrayidx121, align 8, !dbg !155
  %add122 = add nsw i64 %100, %mul120, !dbg !155
  store i64 %add122, i64* %arrayidx121, align 8, !dbg !155
  %101 = load i16, i16* %sl, align 2, !dbg !156
  %conv123 = sext i16 %101 to i64, !dbg !156
  %102 = load i16*, i16** %sp, align 8, !dbg !156
  %arrayidx124 = getelementptr inbounds i16, i16* %102, i64 -3, !dbg !156
  %103 = load i16, i16* %arrayidx124, align 2, !dbg !156
  %conv125 = sext i16 %103 to i64, !dbg !156
  %mul126 = mul nsw i64 %conv123, %conv125, !dbg !156
  %104 = load i64*, i64** %L_ACF.addr, align 8, !dbg !156
  %arrayidx127 = getelementptr inbounds i64, i64* %104, i64 3, !dbg !156
  %105 = load i64, i64* %arrayidx127, align 8, !dbg !156
  %add128 = add nsw i64 %105, %mul126, !dbg !156
  store i64 %add128, i64* %arrayidx127, align 8, !dbg !156
  %106 = load i16, i16* %sl, align 2, !dbg !157
  %conv129 = sext i16 %106 to i64, !dbg !157
  %107 = load i16*, i16** %sp, align 8, !dbg !157
  %arrayidx130 = getelementptr inbounds i16, i16* %107, i64 -4, !dbg !157
  %108 = load i16, i16* %arrayidx130, align 2, !dbg !157
  %conv131 = sext i16 %108 to i64, !dbg !157
  %mul132 = mul nsw i64 %conv129, %conv131, !dbg !157
  %109 = load i64*, i64** %L_ACF.addr, align 8, !dbg !157
  %arrayidx133 = getelementptr inbounds i64, i64* %109, i64 4, !dbg !157
  %110 = load i64, i64* %arrayidx133, align 8, !dbg !157
  %add134 = add nsw i64 %110, %mul132, !dbg !157
  store i64 %add134, i64* %arrayidx133, align 8, !dbg !157
  %111 = load i16*, i16** %sp, align 8, !dbg !158
  %incdec.ptr135 = getelementptr inbounds i16, i16* %111, i32 1, !dbg !158
  store i16* %incdec.ptr135, i16** %sp, align 8, !dbg !158
  %112 = load i16, i16* %incdec.ptr135, align 2, !dbg !158
  store i16 %112, i16* %sl, align 2, !dbg !158
  %113 = load i16, i16* %sl, align 2, !dbg !159
  %conv136 = sext i16 %113 to i64, !dbg !159
  %114 = load i16*, i16** %sp, align 8, !dbg !159
  %arrayidx137 = getelementptr inbounds i16, i16* %114, i64 0, !dbg !159
  %115 = load i16, i16* %arrayidx137, align 2, !dbg !159
  %conv138 = sext i16 %115 to i64, !dbg !159
  %mul139 = mul nsw i64 %conv136, %conv138, !dbg !159
  %116 = load i64*, i64** %L_ACF.addr, align 8, !dbg !159
  %arrayidx140 = getelementptr inbounds i64, i64* %116, i64 0, !dbg !159
  %117 = load i64, i64* %arrayidx140, align 8, !dbg !159
  %add141 = add nsw i64 %117, %mul139, !dbg !159
  store i64 %add141, i64* %arrayidx140, align 8, !dbg !159
  %118 = load i16, i16* %sl, align 2, !dbg !160
  %conv142 = sext i16 %118 to i64, !dbg !160
  %119 = load i16*, i16** %sp, align 8, !dbg !160
  %arrayidx143 = getelementptr inbounds i16, i16* %119, i64 -1, !dbg !160
  %120 = load i16, i16* %arrayidx143, align 2, !dbg !160
  %conv144 = sext i16 %120 to i64, !dbg !160
  %mul145 = mul nsw i64 %conv142, %conv144, !dbg !160
  %121 = load i64*, i64** %L_ACF.addr, align 8, !dbg !160
  %arrayidx146 = getelementptr inbounds i64, i64* %121, i64 1, !dbg !160
  %122 = load i64, i64* %arrayidx146, align 8, !dbg !160
  %add147 = add nsw i64 %122, %mul145, !dbg !160
  store i64 %add147, i64* %arrayidx146, align 8, !dbg !160
  %123 = load i16, i16* %sl, align 2, !dbg !161
  %conv148 = sext i16 %123 to i64, !dbg !161
  %124 = load i16*, i16** %sp, align 8, !dbg !161
  %arrayidx149 = getelementptr inbounds i16, i16* %124, i64 -2, !dbg !161
  %125 = load i16, i16* %arrayidx149, align 2, !dbg !161
  %conv150 = sext i16 %125 to i64, !dbg !161
  %mul151 = mul nsw i64 %conv148, %conv150, !dbg !161
  %126 = load i64*, i64** %L_ACF.addr, align 8, !dbg !161
  %arrayidx152 = getelementptr inbounds i64, i64* %126, i64 2, !dbg !161
  %127 = load i64, i64* %arrayidx152, align 8, !dbg !161
  %add153 = add nsw i64 %127, %mul151, !dbg !161
  store i64 %add153, i64* %arrayidx152, align 8, !dbg !161
  %128 = load i16, i16* %sl, align 2, !dbg !162
  %conv154 = sext i16 %128 to i64, !dbg !162
  %129 = load i16*, i16** %sp, align 8, !dbg !162
  %arrayidx155 = getelementptr inbounds i16, i16* %129, i64 -3, !dbg !162
  %130 = load i16, i16* %arrayidx155, align 2, !dbg !162
  %conv156 = sext i16 %130 to i64, !dbg !162
  %mul157 = mul nsw i64 %conv154, %conv156, !dbg !162
  %131 = load i64*, i64** %L_ACF.addr, align 8, !dbg !162
  %arrayidx158 = getelementptr inbounds i64, i64* %131, i64 3, !dbg !162
  %132 = load i64, i64* %arrayidx158, align 8, !dbg !162
  %add159 = add nsw i64 %132, %mul157, !dbg !162
  store i64 %add159, i64* %arrayidx158, align 8, !dbg !162
  %133 = load i16, i16* %sl, align 2, !dbg !163
  %conv160 = sext i16 %133 to i64, !dbg !163
  %134 = load i16*, i16** %sp, align 8, !dbg !163
  %arrayidx161 = getelementptr inbounds i16, i16* %134, i64 -4, !dbg !163
  %135 = load i16, i16* %arrayidx161, align 2, !dbg !163
  %conv162 = sext i16 %135 to i64, !dbg !163
  %mul163 = mul nsw i64 %conv160, %conv162, !dbg !163
  %136 = load i64*, i64** %L_ACF.addr, align 8, !dbg !163
  %arrayidx164 = getelementptr inbounds i64, i64* %136, i64 4, !dbg !163
  %137 = load i64, i64* %arrayidx164, align 8, !dbg !163
  %add165 = add nsw i64 %137, %mul163, !dbg !163
  store i64 %add165, i64* %arrayidx164, align 8, !dbg !163
  %138 = load i16, i16* %sl, align 2, !dbg !164
  %conv166 = sext i16 %138 to i64, !dbg !164
  %139 = load i16*, i16** %sp, align 8, !dbg !164
  %arrayidx167 = getelementptr inbounds i16, i16* %139, i64 -5, !dbg !164
  %140 = load i16, i16* %arrayidx167, align 2, !dbg !164
  %conv168 = sext i16 %140 to i64, !dbg !164
  %mul169 = mul nsw i64 %conv166, %conv168, !dbg !164
  %141 = load i64*, i64** %L_ACF.addr, align 8, !dbg !164
  %arrayidx170 = getelementptr inbounds i64, i64* %141, i64 5, !dbg !164
  %142 = load i64, i64* %arrayidx170, align 8, !dbg !164
  %add171 = add nsw i64 %142, %mul169, !dbg !164
  store i64 %add171, i64* %arrayidx170, align 8, !dbg !164
  %143 = load i16*, i16** %sp, align 8, !dbg !165
  %incdec.ptr172 = getelementptr inbounds i16, i16* %143, i32 1, !dbg !165
  store i16* %incdec.ptr172, i16** %sp, align 8, !dbg !165
  %144 = load i16, i16* %incdec.ptr172, align 2, !dbg !165
  store i16 %144, i16* %sl, align 2, !dbg !165
  %145 = load i16, i16* %sl, align 2, !dbg !166
  %conv173 = sext i16 %145 to i64, !dbg !166
  %146 = load i16*, i16** %sp, align 8, !dbg !166
  %arrayidx174 = getelementptr inbounds i16, i16* %146, i64 0, !dbg !166
  %147 = load i16, i16* %arrayidx174, align 2, !dbg !166
  %conv175 = sext i16 %147 to i64, !dbg !166
  %mul176 = mul nsw i64 %conv173, %conv175, !dbg !166
  %148 = load i64*, i64** %L_ACF.addr, align 8, !dbg !166
  %arrayidx177 = getelementptr inbounds i64, i64* %148, i64 0, !dbg !166
  %149 = load i64, i64* %arrayidx177, align 8, !dbg !166
  %add178 = add nsw i64 %149, %mul176, !dbg !166
  store i64 %add178, i64* %arrayidx177, align 8, !dbg !166
  %150 = load i16, i16* %sl, align 2, !dbg !167
  %conv179 = sext i16 %150 to i64, !dbg !167
  %151 = load i16*, i16** %sp, align 8, !dbg !167
  %arrayidx180 = getelementptr inbounds i16, i16* %151, i64 -1, !dbg !167
  %152 = load i16, i16* %arrayidx180, align 2, !dbg !167
  %conv181 = sext i16 %152 to i64, !dbg !167
  %mul182 = mul nsw i64 %conv179, %conv181, !dbg !167
  %153 = load i64*, i64** %L_ACF.addr, align 8, !dbg !167
  %arrayidx183 = getelementptr inbounds i64, i64* %153, i64 1, !dbg !167
  %154 = load i64, i64* %arrayidx183, align 8, !dbg !167
  %add184 = add nsw i64 %154, %mul182, !dbg !167
  store i64 %add184, i64* %arrayidx183, align 8, !dbg !167
  %155 = load i16, i16* %sl, align 2, !dbg !168
  %conv185 = sext i16 %155 to i64, !dbg !168
  %156 = load i16*, i16** %sp, align 8, !dbg !168
  %arrayidx186 = getelementptr inbounds i16, i16* %156, i64 -2, !dbg !168
  %157 = load i16, i16* %arrayidx186, align 2, !dbg !168
  %conv187 = sext i16 %157 to i64, !dbg !168
  %mul188 = mul nsw i64 %conv185, %conv187, !dbg !168
  %158 = load i64*, i64** %L_ACF.addr, align 8, !dbg !168
  %arrayidx189 = getelementptr inbounds i64, i64* %158, i64 2, !dbg !168
  %159 = load i64, i64* %arrayidx189, align 8, !dbg !168
  %add190 = add nsw i64 %159, %mul188, !dbg !168
  store i64 %add190, i64* %arrayidx189, align 8, !dbg !168
  %160 = load i16, i16* %sl, align 2, !dbg !169
  %conv191 = sext i16 %160 to i64, !dbg !169
  %161 = load i16*, i16** %sp, align 8, !dbg !169
  %arrayidx192 = getelementptr inbounds i16, i16* %161, i64 -3, !dbg !169
  %162 = load i16, i16* %arrayidx192, align 2, !dbg !169
  %conv193 = sext i16 %162 to i64, !dbg !169
  %mul194 = mul nsw i64 %conv191, %conv193, !dbg !169
  %163 = load i64*, i64** %L_ACF.addr, align 8, !dbg !169
  %arrayidx195 = getelementptr inbounds i64, i64* %163, i64 3, !dbg !169
  %164 = load i64, i64* %arrayidx195, align 8, !dbg !169
  %add196 = add nsw i64 %164, %mul194, !dbg !169
  store i64 %add196, i64* %arrayidx195, align 8, !dbg !169
  %165 = load i16, i16* %sl, align 2, !dbg !170
  %conv197 = sext i16 %165 to i64, !dbg !170
  %166 = load i16*, i16** %sp, align 8, !dbg !170
  %arrayidx198 = getelementptr inbounds i16, i16* %166, i64 -4, !dbg !170
  %167 = load i16, i16* %arrayidx198, align 2, !dbg !170
  %conv199 = sext i16 %167 to i64, !dbg !170
  %mul200 = mul nsw i64 %conv197, %conv199, !dbg !170
  %168 = load i64*, i64** %L_ACF.addr, align 8, !dbg !170
  %arrayidx201 = getelementptr inbounds i64, i64* %168, i64 4, !dbg !170
  %169 = load i64, i64* %arrayidx201, align 8, !dbg !170
  %add202 = add nsw i64 %169, %mul200, !dbg !170
  store i64 %add202, i64* %arrayidx201, align 8, !dbg !170
  %170 = load i16, i16* %sl, align 2, !dbg !171
  %conv203 = sext i16 %170 to i64, !dbg !171
  %171 = load i16*, i16** %sp, align 8, !dbg !171
  %arrayidx204 = getelementptr inbounds i16, i16* %171, i64 -5, !dbg !171
  %172 = load i16, i16* %arrayidx204, align 2, !dbg !171
  %conv205 = sext i16 %172 to i64, !dbg !171
  %mul206 = mul nsw i64 %conv203, %conv205, !dbg !171
  %173 = load i64*, i64** %L_ACF.addr, align 8, !dbg !171
  %arrayidx207 = getelementptr inbounds i64, i64* %173, i64 5, !dbg !171
  %174 = load i64, i64* %arrayidx207, align 8, !dbg !171
  %add208 = add nsw i64 %174, %mul206, !dbg !171
  store i64 %add208, i64* %arrayidx207, align 8, !dbg !171
  %175 = load i16, i16* %sl, align 2, !dbg !172
  %conv209 = sext i16 %175 to i64, !dbg !172
  %176 = load i16*, i16** %sp, align 8, !dbg !172
  %arrayidx210 = getelementptr inbounds i16, i16* %176, i64 -6, !dbg !172
  %177 = load i16, i16* %arrayidx210, align 2, !dbg !172
  %conv211 = sext i16 %177 to i64, !dbg !172
  %mul212 = mul nsw i64 %conv209, %conv211, !dbg !172
  %178 = load i64*, i64** %L_ACF.addr, align 8, !dbg !172
  %arrayidx213 = getelementptr inbounds i64, i64* %178, i64 6, !dbg !172
  %179 = load i64, i64* %arrayidx213, align 8, !dbg !172
  %add214 = add nsw i64 %179, %mul212, !dbg !172
  store i64 %add214, i64* %arrayidx213, align 8, !dbg !172
  %180 = load i16*, i16** %sp, align 8, !dbg !173
  %incdec.ptr215 = getelementptr inbounds i16, i16* %180, i32 1, !dbg !173
  store i16* %incdec.ptr215, i16** %sp, align 8, !dbg !173
  %181 = load i16, i16* %incdec.ptr215, align 2, !dbg !173
  store i16 %181, i16* %sl, align 2, !dbg !173
  %182 = load i16, i16* %sl, align 2, !dbg !174
  %conv216 = sext i16 %182 to i64, !dbg !174
  %183 = load i16*, i16** %sp, align 8, !dbg !174
  %arrayidx217 = getelementptr inbounds i16, i16* %183, i64 0, !dbg !174
  %184 = load i16, i16* %arrayidx217, align 2, !dbg !174
  %conv218 = sext i16 %184 to i64, !dbg !174
  %mul219 = mul nsw i64 %conv216, %conv218, !dbg !174
  %185 = load i64*, i64** %L_ACF.addr, align 8, !dbg !174
  %arrayidx220 = getelementptr inbounds i64, i64* %185, i64 0, !dbg !174
  %186 = load i64, i64* %arrayidx220, align 8, !dbg !174
  %add221 = add nsw i64 %186, %mul219, !dbg !174
  store i64 %add221, i64* %arrayidx220, align 8, !dbg !174
  %187 = load i16, i16* %sl, align 2, !dbg !175
  %conv222 = sext i16 %187 to i64, !dbg !175
  %188 = load i16*, i16** %sp, align 8, !dbg !175
  %arrayidx223 = getelementptr inbounds i16, i16* %188, i64 -1, !dbg !175
  %189 = load i16, i16* %arrayidx223, align 2, !dbg !175
  %conv224 = sext i16 %189 to i64, !dbg !175
  %mul225 = mul nsw i64 %conv222, %conv224, !dbg !175
  %190 = load i64*, i64** %L_ACF.addr, align 8, !dbg !175
  %arrayidx226 = getelementptr inbounds i64, i64* %190, i64 1, !dbg !175
  %191 = load i64, i64* %arrayidx226, align 8, !dbg !175
  %add227 = add nsw i64 %191, %mul225, !dbg !175
  store i64 %add227, i64* %arrayidx226, align 8, !dbg !175
  %192 = load i16, i16* %sl, align 2, !dbg !176
  %conv228 = sext i16 %192 to i64, !dbg !176
  %193 = load i16*, i16** %sp, align 8, !dbg !176
  %arrayidx229 = getelementptr inbounds i16, i16* %193, i64 -2, !dbg !176
  %194 = load i16, i16* %arrayidx229, align 2, !dbg !176
  %conv230 = sext i16 %194 to i64, !dbg !176
  %mul231 = mul nsw i64 %conv228, %conv230, !dbg !176
  %195 = load i64*, i64** %L_ACF.addr, align 8, !dbg !176
  %arrayidx232 = getelementptr inbounds i64, i64* %195, i64 2, !dbg !176
  %196 = load i64, i64* %arrayidx232, align 8, !dbg !176
  %add233 = add nsw i64 %196, %mul231, !dbg !176
  store i64 %add233, i64* %arrayidx232, align 8, !dbg !176
  %197 = load i16, i16* %sl, align 2, !dbg !177
  %conv234 = sext i16 %197 to i64, !dbg !177
  %198 = load i16*, i16** %sp, align 8, !dbg !177
  %arrayidx235 = getelementptr inbounds i16, i16* %198, i64 -3, !dbg !177
  %199 = load i16, i16* %arrayidx235, align 2, !dbg !177
  %conv236 = sext i16 %199 to i64, !dbg !177
  %mul237 = mul nsw i64 %conv234, %conv236, !dbg !177
  %200 = load i64*, i64** %L_ACF.addr, align 8, !dbg !177
  %arrayidx238 = getelementptr inbounds i64, i64* %200, i64 3, !dbg !177
  %201 = load i64, i64* %arrayidx238, align 8, !dbg !177
  %add239 = add nsw i64 %201, %mul237, !dbg !177
  store i64 %add239, i64* %arrayidx238, align 8, !dbg !177
  %202 = load i16, i16* %sl, align 2, !dbg !178
  %conv240 = sext i16 %202 to i64, !dbg !178
  %203 = load i16*, i16** %sp, align 8, !dbg !178
  %arrayidx241 = getelementptr inbounds i16, i16* %203, i64 -4, !dbg !178
  %204 = load i16, i16* %arrayidx241, align 2, !dbg !178
  %conv242 = sext i16 %204 to i64, !dbg !178
  %mul243 = mul nsw i64 %conv240, %conv242, !dbg !178
  %205 = load i64*, i64** %L_ACF.addr, align 8, !dbg !178
  %arrayidx244 = getelementptr inbounds i64, i64* %205, i64 4, !dbg !178
  %206 = load i64, i64* %arrayidx244, align 8, !dbg !178
  %add245 = add nsw i64 %206, %mul243, !dbg !178
  store i64 %add245, i64* %arrayidx244, align 8, !dbg !178
  %207 = load i16, i16* %sl, align 2, !dbg !179
  %conv246 = sext i16 %207 to i64, !dbg !179
  %208 = load i16*, i16** %sp, align 8, !dbg !179
  %arrayidx247 = getelementptr inbounds i16, i16* %208, i64 -5, !dbg !179
  %209 = load i16, i16* %arrayidx247, align 2, !dbg !179
  %conv248 = sext i16 %209 to i64, !dbg !179
  %mul249 = mul nsw i64 %conv246, %conv248, !dbg !179
  %210 = load i64*, i64** %L_ACF.addr, align 8, !dbg !179
  %arrayidx250 = getelementptr inbounds i64, i64* %210, i64 5, !dbg !179
  %211 = load i64, i64* %arrayidx250, align 8, !dbg !179
  %add251 = add nsw i64 %211, %mul249, !dbg !179
  store i64 %add251, i64* %arrayidx250, align 8, !dbg !179
  %212 = load i16, i16* %sl, align 2, !dbg !180
  %conv252 = sext i16 %212 to i64, !dbg !180
  %213 = load i16*, i16** %sp, align 8, !dbg !180
  %arrayidx253 = getelementptr inbounds i16, i16* %213, i64 -6, !dbg !180
  %214 = load i16, i16* %arrayidx253, align 2, !dbg !180
  %conv254 = sext i16 %214 to i64, !dbg !180
  %mul255 = mul nsw i64 %conv252, %conv254, !dbg !180
  %215 = load i64*, i64** %L_ACF.addr, align 8, !dbg !180
  %arrayidx256 = getelementptr inbounds i64, i64* %215, i64 6, !dbg !180
  %216 = load i64, i64* %arrayidx256, align 8, !dbg !180
  %add257 = add nsw i64 %216, %mul255, !dbg !180
  store i64 %add257, i64* %arrayidx256, align 8, !dbg !180
  %217 = load i16, i16* %sl, align 2, !dbg !181
  %conv258 = sext i16 %217 to i64, !dbg !181
  %218 = load i16*, i16** %sp, align 8, !dbg !181
  %arrayidx259 = getelementptr inbounds i16, i16* %218, i64 -7, !dbg !181
  %219 = load i16, i16* %arrayidx259, align 2, !dbg !181
  %conv260 = sext i16 %219 to i64, !dbg !181
  %mul261 = mul nsw i64 %conv258, %conv260, !dbg !181
  %220 = load i64*, i64** %L_ACF.addr, align 8, !dbg !181
  %arrayidx262 = getelementptr inbounds i64, i64* %220, i64 7, !dbg !181
  %221 = load i64, i64* %arrayidx262, align 8, !dbg !181
  %add263 = add nsw i64 %221, %mul261, !dbg !181
  store i64 %add263, i64* %arrayidx262, align 8, !dbg !181
  br label %Autocorrelation_label3, !dbg !181

Autocorrelation_label3:                           ; preds = %for.end43
  call void @llvm.dbg.label(metadata !182), !dbg !183
  store i32 8, i32* %i, align 4, !dbg !184
  br label %for.cond264, !dbg !186

for.cond264:                                      ; preds = %for.inc323, %Autocorrelation_label3
  %222 = load i32, i32* %i, align 4, !dbg !187
  %cmp265 = icmp sle i32 %222, 159, !dbg !189
  br i1 %cmp265, label %for.body267, label %for.end325, !dbg !190

for.body267:                                      ; preds = %for.cond264
  %223 = load i16*, i16** %sp, align 8, !dbg !191
  %incdec.ptr268 = getelementptr inbounds i16, i16* %223, i32 1, !dbg !191
  store i16* %incdec.ptr268, i16** %sp, align 8, !dbg !191
  %224 = load i16, i16* %incdec.ptr268, align 2, !dbg !191
  store i16 %224, i16* %sl, align 2, !dbg !191
  %225 = load i16, i16* %sl, align 2, !dbg !193
  %conv269 = sext i16 %225 to i64, !dbg !193
  %226 = load i16*, i16** %sp, align 8, !dbg !193
  %arrayidx270 = getelementptr inbounds i16, i16* %226, i64 0, !dbg !193
  %227 = load i16, i16* %arrayidx270, align 2, !dbg !193
  %conv271 = sext i16 %227 to i64, !dbg !193
  %mul272 = mul nsw i64 %conv269, %conv271, !dbg !193
  %228 = load i64*, i64** %L_ACF.addr, align 8, !dbg !193
  %arrayidx273 = getelementptr inbounds i64, i64* %228, i64 0, !dbg !193
  %229 = load i64, i64* %arrayidx273, align 8, !dbg !193
  %add274 = add nsw i64 %229, %mul272, !dbg !193
  store i64 %add274, i64* %arrayidx273, align 8, !dbg !193
  %230 = load i16, i16* %sl, align 2, !dbg !194
  %conv275 = sext i16 %230 to i64, !dbg !194
  %231 = load i16*, i16** %sp, align 8, !dbg !194
  %arrayidx276 = getelementptr inbounds i16, i16* %231, i64 -1, !dbg !194
  %232 = load i16, i16* %arrayidx276, align 2, !dbg !194
  %conv277 = sext i16 %232 to i64, !dbg !194
  %mul278 = mul nsw i64 %conv275, %conv277, !dbg !194
  %233 = load i64*, i64** %L_ACF.addr, align 8, !dbg !194
  %arrayidx279 = getelementptr inbounds i64, i64* %233, i64 1, !dbg !194
  %234 = load i64, i64* %arrayidx279, align 8, !dbg !194
  %add280 = add nsw i64 %234, %mul278, !dbg !194
  store i64 %add280, i64* %arrayidx279, align 8, !dbg !194
  %235 = load i16, i16* %sl, align 2, !dbg !195
  %conv281 = sext i16 %235 to i64, !dbg !195
  %236 = load i16*, i16** %sp, align 8, !dbg !195
  %arrayidx282 = getelementptr inbounds i16, i16* %236, i64 -2, !dbg !195
  %237 = load i16, i16* %arrayidx282, align 2, !dbg !195
  %conv283 = sext i16 %237 to i64, !dbg !195
  %mul284 = mul nsw i64 %conv281, %conv283, !dbg !195
  %238 = load i64*, i64** %L_ACF.addr, align 8, !dbg !195
  %arrayidx285 = getelementptr inbounds i64, i64* %238, i64 2, !dbg !195
  %239 = load i64, i64* %arrayidx285, align 8, !dbg !195
  %add286 = add nsw i64 %239, %mul284, !dbg !195
  store i64 %add286, i64* %arrayidx285, align 8, !dbg !195
  %240 = load i16, i16* %sl, align 2, !dbg !196
  %conv287 = sext i16 %240 to i64, !dbg !196
  %241 = load i16*, i16** %sp, align 8, !dbg !196
  %arrayidx288 = getelementptr inbounds i16, i16* %241, i64 -3, !dbg !196
  %242 = load i16, i16* %arrayidx288, align 2, !dbg !196
  %conv289 = sext i16 %242 to i64, !dbg !196
  %mul290 = mul nsw i64 %conv287, %conv289, !dbg !196
  %243 = load i64*, i64** %L_ACF.addr, align 8, !dbg !196
  %arrayidx291 = getelementptr inbounds i64, i64* %243, i64 3, !dbg !196
  %244 = load i64, i64* %arrayidx291, align 8, !dbg !196
  %add292 = add nsw i64 %244, %mul290, !dbg !196
  store i64 %add292, i64* %arrayidx291, align 8, !dbg !196
  %245 = load i16, i16* %sl, align 2, !dbg !197
  %conv293 = sext i16 %245 to i64, !dbg !197
  %246 = load i16*, i16** %sp, align 8, !dbg !197
  %arrayidx294 = getelementptr inbounds i16, i16* %246, i64 -4, !dbg !197
  %247 = load i16, i16* %arrayidx294, align 2, !dbg !197
  %conv295 = sext i16 %247 to i64, !dbg !197
  %mul296 = mul nsw i64 %conv293, %conv295, !dbg !197
  %248 = load i64*, i64** %L_ACF.addr, align 8, !dbg !197
  %arrayidx297 = getelementptr inbounds i64, i64* %248, i64 4, !dbg !197
  %249 = load i64, i64* %arrayidx297, align 8, !dbg !197
  %add298 = add nsw i64 %249, %mul296, !dbg !197
  store i64 %add298, i64* %arrayidx297, align 8, !dbg !197
  %250 = load i16, i16* %sl, align 2, !dbg !198
  %conv299 = sext i16 %250 to i64, !dbg !198
  %251 = load i16*, i16** %sp, align 8, !dbg !198
  %arrayidx300 = getelementptr inbounds i16, i16* %251, i64 -5, !dbg !198
  %252 = load i16, i16* %arrayidx300, align 2, !dbg !198
  %conv301 = sext i16 %252 to i64, !dbg !198
  %mul302 = mul nsw i64 %conv299, %conv301, !dbg !198
  %253 = load i64*, i64** %L_ACF.addr, align 8, !dbg !198
  %arrayidx303 = getelementptr inbounds i64, i64* %253, i64 5, !dbg !198
  %254 = load i64, i64* %arrayidx303, align 8, !dbg !198
  %add304 = add nsw i64 %254, %mul302, !dbg !198
  store i64 %add304, i64* %arrayidx303, align 8, !dbg !198
  %255 = load i16, i16* %sl, align 2, !dbg !199
  %conv305 = sext i16 %255 to i64, !dbg !199
  %256 = load i16*, i16** %sp, align 8, !dbg !199
  %arrayidx306 = getelementptr inbounds i16, i16* %256, i64 -6, !dbg !199
  %257 = load i16, i16* %arrayidx306, align 2, !dbg !199
  %conv307 = sext i16 %257 to i64, !dbg !199
  %mul308 = mul nsw i64 %conv305, %conv307, !dbg !199
  %258 = load i64*, i64** %L_ACF.addr, align 8, !dbg !199
  %arrayidx309 = getelementptr inbounds i64, i64* %258, i64 6, !dbg !199
  %259 = load i64, i64* %arrayidx309, align 8, !dbg !199
  %add310 = add nsw i64 %259, %mul308, !dbg !199
  store i64 %add310, i64* %arrayidx309, align 8, !dbg !199
  %260 = load i16, i16* %sl, align 2, !dbg !200
  %conv311 = sext i16 %260 to i64, !dbg !200
  %261 = load i16*, i16** %sp, align 8, !dbg !200
  %arrayidx312 = getelementptr inbounds i16, i16* %261, i64 -7, !dbg !200
  %262 = load i16, i16* %arrayidx312, align 2, !dbg !200
  %conv313 = sext i16 %262 to i64, !dbg !200
  %mul314 = mul nsw i64 %conv311, %conv313, !dbg !200
  %263 = load i64*, i64** %L_ACF.addr, align 8, !dbg !200
  %arrayidx315 = getelementptr inbounds i64, i64* %263, i64 7, !dbg !200
  %264 = load i64, i64* %arrayidx315, align 8, !dbg !200
  %add316 = add nsw i64 %264, %mul314, !dbg !200
  store i64 %add316, i64* %arrayidx315, align 8, !dbg !200
  %265 = load i16, i16* %sl, align 2, !dbg !201
  %conv317 = sext i16 %265 to i64, !dbg !201
  %266 = load i16*, i16** %sp, align 8, !dbg !201
  %arrayidx318 = getelementptr inbounds i16, i16* %266, i64 -8, !dbg !201
  %267 = load i16, i16* %arrayidx318, align 2, !dbg !201
  %conv319 = sext i16 %267 to i64, !dbg !201
  %mul320 = mul nsw i64 %conv317, %conv319, !dbg !201
  %268 = load i64*, i64** %L_ACF.addr, align 8, !dbg !201
  %arrayidx321 = getelementptr inbounds i64, i64* %268, i64 8, !dbg !201
  %269 = load i64, i64* %arrayidx321, align 8, !dbg !201
  %add322 = add nsw i64 %269, %mul320, !dbg !201
  store i64 %add322, i64* %arrayidx321, align 8, !dbg !201
  br label %for.inc323, !dbg !202

for.inc323:                                       ; preds = %for.body267
  %270 = load i32, i32* %i, align 4, !dbg !203
  %inc324 = add nsw i32 %270, 1, !dbg !203
  store i32 %inc324, i32* %i, align 4, !dbg !203
  br label %for.cond264, !dbg !204, !llvm.loop !205

for.end325:                                       ; preds = %for.cond264
  br label %Autocorrelation_label4, !dbg !206

Autocorrelation_label4:                           ; preds = %for.end325
  call void @llvm.dbg.label(metadata !207), !dbg !208
  store i32 8, i32* %k, align 4, !dbg !209
  br label %for.cond326, !dbg !211

for.cond326:                                      ; preds = %for.inc333, %Autocorrelation_label4
  %271 = load i32, i32* %k, align 4, !dbg !212
  %cmp327 = icmp sge i32 %271, 0, !dbg !214
  br i1 %cmp327, label %for.body329, label %for.end335, !dbg !215

for.body329:                                      ; preds = %for.cond326
  %272 = load i64*, i64** %L_ACF.addr, align 8, !dbg !216
  %273 = load i32, i32* %k, align 4, !dbg !218
  %idxprom330 = sext i32 %273 to i64, !dbg !216
  %arrayidx331 = getelementptr inbounds i64, i64* %272, i64 %idxprom330, !dbg !216
  %274 = load i64, i64* %arrayidx331, align 8, !dbg !219
  %shl332 = shl i64 %274, 1, !dbg !219
  store i64 %shl332, i64* %arrayidx331, align 8, !dbg !219
  br label %for.inc333, !dbg !220

for.inc333:                                       ; preds = %for.body329
  %275 = load i32, i32* %k, align 4, !dbg !221
  %dec334 = add nsw i32 %275, -1, !dbg !221
  store i32 %dec334, i32* %k, align 4, !dbg !221
  br label %for.cond326, !dbg !222, !llvm.loop !223

for.end335:                                       ; preds = %for.cond326
  %276 = load i16, i16* %scalauto, align 2, !dbg !225
  %conv336 = sext i16 %276 to i32, !dbg !225
  %cmp337 = icmp sgt i32 %conv336, 0, !dbg !227
  br i1 %cmp337, label %if.then339, label %if.end352, !dbg !228

if.then339:                                       ; preds = %for.end335
  br label %Autocorrelation_label5, !dbg !229

Autocorrelation_label5:                           ; preds = %if.then339
  call void @llvm.dbg.label(metadata !230), !dbg !232
  store i32 159, i32* %k, align 4, !dbg !233
  br label %for.cond340, !dbg !235

for.cond340:                                      ; preds = %for.inc349, %Autocorrelation_label5
  %277 = load i32, i32* %k, align 4, !dbg !236
  %cmp341 = icmp sge i32 %277, 0, !dbg !238
  br i1 %cmp341, label %for.body343, label %for.end351, !dbg !239

for.body343:                                      ; preds = %for.cond340
  %278 = load i16, i16* %scalauto, align 2, !dbg !240
  %conv344 = sext i16 %278 to i32, !dbg !240
  %279 = load i16*, i16** %s.addr, align 8, !dbg !242
  %incdec.ptr345 = getelementptr inbounds i16, i16* %279, i32 1, !dbg !242
  store i16* %incdec.ptr345, i16** %s.addr, align 8, !dbg !242
  %280 = load i16, i16* %279, align 2, !dbg !243
  %conv346 = sext i16 %280 to i32, !dbg !243
  %shl347 = shl i32 %conv346, %conv344, !dbg !243
  %conv348 = trunc i32 %shl347 to i16, !dbg !243
  store i16 %conv348, i16* %279, align 2, !dbg !243
  br label %for.inc349, !dbg !244

for.inc349:                                       ; preds = %for.body343
  %281 = load i32, i32* %k, align 4, !dbg !245
  %dec350 = add nsw i32 %281, -1, !dbg !245
  store i32 %dec350, i32* %k, align 4, !dbg !245
  br label %for.cond340, !dbg !246, !llvm.loop !247

for.end351:                                       ; preds = %for.cond340
  br label %if.end352, !dbg !249

if.end352:                                        ; preds = %for.end351, %for.end335
  ret void, !dbg !250
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

declare signext i16 @gsm_abs(i16 noundef signext) #2

declare signext i16 @gsm_norm(i64 noundef) #2

declare signext i16 @gsm_mult_r(i16 noundef signext, i16 noundef signext) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Reflection_coefficients(i64* noundef %L_ACF, i16* noundef %r) #0 !dbg !251 {
entry:
  %L_ACF.addr = alloca i64*, align 8
  %r.addr = alloca i16*, align 8
  %i = alloca i32, align 4
  %m = alloca i32, align 4
  %n = alloca i32, align 4
  %temp = alloca i16, align 2
  %ACF = alloca [9 x i16], align 16
  %P = alloca [9 x i16], align 16
  %K = alloca [9 x i16], align 16
  store i64* %L_ACF, i64** %L_ACF.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %L_ACF.addr, metadata !254, metadata !DIExpression()), !dbg !255
  store i16* %r, i16** %r.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %r.addr, metadata !256, metadata !DIExpression()), !dbg !257
  call void @llvm.dbg.declare(metadata i32* %i, metadata !258, metadata !DIExpression()), !dbg !259
  call void @llvm.dbg.declare(metadata i32* %m, metadata !260, metadata !DIExpression()), !dbg !261
  call void @llvm.dbg.declare(metadata i32* %n, metadata !262, metadata !DIExpression()), !dbg !263
  call void @llvm.dbg.declare(metadata i16* %temp, metadata !264, metadata !DIExpression()), !dbg !265
  call void @llvm.dbg.declare(metadata [9 x i16]* %ACF, metadata !266, metadata !DIExpression()), !dbg !270
  call void @llvm.dbg.declare(metadata [9 x i16]* %P, metadata !271, metadata !DIExpression()), !dbg !272
  call void @llvm.dbg.declare(metadata [9 x i16]* %K, metadata !273, metadata !DIExpression()), !dbg !274
  %0 = load i64*, i64** %L_ACF.addr, align 8, !dbg !275
  %arrayidx = getelementptr inbounds i64, i64* %0, i64 0, !dbg !275
  %1 = load i64, i64* %arrayidx, align 8, !dbg !275
  %cmp = icmp eq i64 %1, 0, !dbg !277
  br i1 %cmp, label %if.then, label %if.end, !dbg !278

if.then:                                          ; preds = %entry
  br label %Reflection_coefficients_label0, !dbg !279

Reflection_coefficients_label0:                   ; preds = %if.then
  call void @llvm.dbg.label(metadata !280), !dbg !282
  store i32 8, i32* %i, align 4, !dbg !283
  br label %for.cond, !dbg !285

for.cond:                                         ; preds = %for.inc, %Reflection_coefficients_label0
  %2 = load i32, i32* %i, align 4, !dbg !286
  %cmp1 = icmp sgt i32 %2, 0, !dbg !288
  br i1 %cmp1, label %for.body, label %for.end, !dbg !289

for.body:                                         ; preds = %for.cond
  %3 = load i16*, i16** %r.addr, align 8, !dbg !290
  %incdec.ptr = getelementptr inbounds i16, i16* %3, i32 1, !dbg !290
  store i16* %incdec.ptr, i16** %r.addr, align 8, !dbg !290
  store i16 0, i16* %3, align 2, !dbg !292
  br label %for.inc, !dbg !293

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !dbg !294
  %dec = add nsw i32 %4, -1, !dbg !294
  store i32 %dec, i32* %i, align 4, !dbg !294
  br label %for.cond, !dbg !295, !llvm.loop !296

for.end:                                          ; preds = %for.cond
  br label %for.end102, !dbg !298

if.end:                                           ; preds = %entry
  %5 = load i64*, i64** %L_ACF.addr, align 8, !dbg !299
  %arrayidx2 = getelementptr inbounds i64, i64* %5, i64 0, !dbg !299
  %6 = load i64, i64* %arrayidx2, align 8, !dbg !299
  %call = call signext i16 @gsm_norm(i64 noundef %6), !dbg !300
  store i16 %call, i16* %temp, align 2, !dbg !301
  br label %Reflection_coefficients_label1, !dbg !302

Reflection_coefficients_label1:                   ; preds = %if.end
  call void @llvm.dbg.label(metadata !303), !dbg !304
  store i32 0, i32* %i, align 4, !dbg !305
  br label %for.cond3, !dbg !307

for.cond3:                                        ; preds = %for.inc10, %Reflection_coefficients_label1
  %7 = load i32, i32* %i, align 4, !dbg !308
  %cmp4 = icmp sle i32 %7, 8, !dbg !310
  br i1 %cmp4, label %for.body5, label %for.end11, !dbg !311

for.body5:                                        ; preds = %for.cond3
  %8 = load i64*, i64** %L_ACF.addr, align 8, !dbg !312
  %9 = load i32, i32* %i, align 4, !dbg !312
  %idxprom = sext i32 %9 to i64, !dbg !312
  %arrayidx6 = getelementptr inbounds i64, i64* %8, i64 %idxprom, !dbg !312
  %10 = load i64, i64* %arrayidx6, align 8, !dbg !312
  %11 = load i16, i16* %temp, align 2, !dbg !312
  %conv = sext i16 %11 to i32, !dbg !312
  %sh_prom = zext i32 %conv to i64, !dbg !312
  %shl = shl i64 %10, %sh_prom, !dbg !312
  %shr = ashr i64 %shl, 16, !dbg !312
  %conv7 = trunc i64 %shr to i16, !dbg !312
  %12 = load i32, i32* %i, align 4, !dbg !314
  %idxprom8 = sext i32 %12 to i64, !dbg !315
  %arrayidx9 = getelementptr inbounds [9 x i16], [9 x i16]* %ACF, i64 0, i64 %idxprom8, !dbg !315
  store i16 %conv7, i16* %arrayidx9, align 2, !dbg !316
  br label %for.inc10, !dbg !317

for.inc10:                                        ; preds = %for.body5
  %13 = load i32, i32* %i, align 4, !dbg !318
  %inc = add nsw i32 %13, 1, !dbg !318
  store i32 %inc, i32* %i, align 4, !dbg !318
  br label %for.cond3, !dbg !319, !llvm.loop !320

for.end11:                                        ; preds = %for.cond3
  br label %Reflection_coefficients_label2, !dbg !321

Reflection_coefficients_label2:                   ; preds = %for.end11
  call void @llvm.dbg.label(metadata !322), !dbg !323
  store i32 1, i32* %i, align 4, !dbg !324
  br label %for.cond12, !dbg !326

for.cond12:                                       ; preds = %for.inc20, %Reflection_coefficients_label2
  %14 = load i32, i32* %i, align 4, !dbg !327
  %cmp13 = icmp sle i32 %14, 7, !dbg !329
  br i1 %cmp13, label %for.body15, label %for.end22, !dbg !330

for.body15:                                       ; preds = %for.cond12
  %15 = load i32, i32* %i, align 4, !dbg !331
  %idxprom16 = sext i32 %15 to i64, !dbg !333
  %arrayidx17 = getelementptr inbounds [9 x i16], [9 x i16]* %ACF, i64 0, i64 %idxprom16, !dbg !333
  %16 = load i16, i16* %arrayidx17, align 2, !dbg !333
  %17 = load i32, i32* %i, align 4, !dbg !334
  %idxprom18 = sext i32 %17 to i64, !dbg !335
  %arrayidx19 = getelementptr inbounds [9 x i16], [9 x i16]* %K, i64 0, i64 %idxprom18, !dbg !335
  store i16 %16, i16* %arrayidx19, align 2, !dbg !336
  br label %for.inc20, !dbg !337

for.inc20:                                        ; preds = %for.body15
  %18 = load i32, i32* %i, align 4, !dbg !338
  %inc21 = add nsw i32 %18, 1, !dbg !338
  store i32 %inc21, i32* %i, align 4, !dbg !338
  br label %for.cond12, !dbg !339, !llvm.loop !340

for.end22:                                        ; preds = %for.cond12
  br label %Reflection_coefficients_label3, !dbg !341

Reflection_coefficients_label3:                   ; preds = %for.end22
  call void @llvm.dbg.label(metadata !342), !dbg !343
  store i32 0, i32* %i, align 4, !dbg !344
  br label %for.cond23, !dbg !346

for.cond23:                                       ; preds = %for.inc31, %Reflection_coefficients_label3
  %19 = load i32, i32* %i, align 4, !dbg !347
  %cmp24 = icmp sle i32 %19, 8, !dbg !349
  br i1 %cmp24, label %for.body26, label %for.end33, !dbg !350

for.body26:                                       ; preds = %for.cond23
  %20 = load i32, i32* %i, align 4, !dbg !351
  %idxprom27 = sext i32 %20 to i64, !dbg !353
  %arrayidx28 = getelementptr inbounds [9 x i16], [9 x i16]* %ACF, i64 0, i64 %idxprom27, !dbg !353
  %21 = load i16, i16* %arrayidx28, align 2, !dbg !353
  %22 = load i32, i32* %i, align 4, !dbg !354
  %idxprom29 = sext i32 %22 to i64, !dbg !355
  %arrayidx30 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 %idxprom29, !dbg !355
  store i16 %21, i16* %arrayidx30, align 2, !dbg !356
  br label %for.inc31, !dbg !357

for.inc31:                                        ; preds = %for.body26
  %23 = load i32, i32* %i, align 4, !dbg !358
  %inc32 = add nsw i32 %23, 1, !dbg !358
  store i32 %inc32, i32* %i, align 4, !dbg !358
  br label %for.cond23, !dbg !359, !llvm.loop !360

for.end33:                                        ; preds = %for.cond23
  br label %Reflection_coefficients_label4, !dbg !361

Reflection_coefficients_label4:                   ; preds = %for.end33
  call void @llvm.dbg.label(metadata !362), !dbg !363
  store i32 1, i32* %n, align 4, !dbg !364
  br label %for.cond34, !dbg !366

for.cond34:                                       ; preds = %for.inc99, %Reflection_coefficients_label4
  %24 = load i32, i32* %n, align 4, !dbg !367
  %cmp35 = icmp sle i32 %24, 8, !dbg !369
  br i1 %cmp35, label %for.body37, label %for.end102, !dbg !370

for.body37:                                       ; preds = %for.cond34
  %arrayidx38 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 1, !dbg !371
  %25 = load i16, i16* %arrayidx38, align 2, !dbg !371
  store i16 %25, i16* %temp, align 2, !dbg !373
  %26 = load i16, i16* %temp, align 2, !dbg !374
  %call39 = call signext i16 @gsm_abs(i16 noundef signext %26), !dbg !374
  store i16 %call39, i16* %temp, align 2, !dbg !375
  %arrayidx40 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 0, !dbg !376
  %27 = load i16, i16* %arrayidx40, align 16, !dbg !376
  %conv41 = sext i16 %27 to i32, !dbg !376
  %28 = load i16, i16* %temp, align 2, !dbg !378
  %conv42 = sext i16 %28 to i32, !dbg !378
  %cmp43 = icmp slt i32 %conv41, %conv42, !dbg !379
  br i1 %cmp43, label %if.then45, label %if.end54, !dbg !380

if.then45:                                        ; preds = %for.body37
  br label %Reflection_coefficients_label6, !dbg !381

Reflection_coefficients_label6:                   ; preds = %if.then45
  call void @llvm.dbg.label(metadata !382), !dbg !384
  %29 = load i32, i32* %n, align 4, !dbg !385
  store i32 %29, i32* %i, align 4, !dbg !387
  br label %for.cond46, !dbg !388

for.cond46:                                       ; preds = %for.inc51, %Reflection_coefficients_label6
  %30 = load i32, i32* %i, align 4, !dbg !389
  %cmp47 = icmp sle i32 %30, 8, !dbg !391
  br i1 %cmp47, label %for.body49, label %for.end53, !dbg !392

for.body49:                                       ; preds = %for.cond46
  %31 = load i16*, i16** %r.addr, align 8, !dbg !393
  %incdec.ptr50 = getelementptr inbounds i16, i16* %31, i32 1, !dbg !393
  store i16* %incdec.ptr50, i16** %r.addr, align 8, !dbg !393
  store i16 0, i16* %31, align 2, !dbg !395
  br label %for.inc51, !dbg !396

for.inc51:                                        ; preds = %for.body49
  %32 = load i32, i32* %i, align 4, !dbg !397
  %inc52 = add nsw i32 %32, 1, !dbg !397
  store i32 %inc52, i32* %i, align 4, !dbg !397
  br label %for.cond46, !dbg !398, !llvm.loop !399

for.end53:                                        ; preds = %for.cond46
  br label %for.end102, !dbg !401

if.end54:                                         ; preds = %for.body37
  %33 = load i16, i16* %temp, align 2, !dbg !402
  %arrayidx55 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 0, !dbg !403
  %34 = load i16, i16* %arrayidx55, align 16, !dbg !403
  %call56 = call signext i16 @gsm_div(i16 noundef signext %33, i16 noundef signext %34), !dbg !404
  %35 = load i16*, i16** %r.addr, align 8, !dbg !405
  store i16 %call56, i16* %35, align 2, !dbg !406
  %arrayidx57 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 1, !dbg !407
  %36 = load i16, i16* %arrayidx57, align 2, !dbg !407
  %conv58 = sext i16 %36 to i32, !dbg !407
  %cmp59 = icmp sgt i32 %conv58, 0, !dbg !409
  br i1 %cmp59, label %if.then61, label %if.end64, !dbg !410

if.then61:                                        ; preds = %if.end54
  %37 = load i16*, i16** %r.addr, align 8, !dbg !411
  %38 = load i16, i16* %37, align 2, !dbg !412
  %conv62 = sext i16 %38 to i32, !dbg !412
  %sub = sub nsw i32 0, %conv62, !dbg !413
  %conv63 = trunc i32 %sub to i16, !dbg !413
  %39 = load i16*, i16** %r.addr, align 8, !dbg !414
  store i16 %conv63, i16* %39, align 2, !dbg !415
  br label %if.end64, !dbg !416

if.end64:                                         ; preds = %if.then61, %if.end54
  %40 = load i32, i32* %n, align 4, !dbg !417
  %cmp65 = icmp eq i32 %40, 8, !dbg !419
  br i1 %cmp65, label %if.then67, label %if.end68, !dbg !420

if.then67:                                        ; preds = %if.end64
  br label %for.end102, !dbg !421

if.end68:                                         ; preds = %if.end64
  %arrayidx69 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 1, !dbg !422
  %41 = load i16, i16* %arrayidx69, align 2, !dbg !422
  %42 = load i16*, i16** %r.addr, align 8, !dbg !422
  %43 = load i16, i16* %42, align 2, !dbg !422
  %call70 = call signext i16 @gsm_mult_r(i16 noundef signext %41, i16 noundef signext %43), !dbg !422
  store i16 %call70, i16* %temp, align 2, !dbg !423
  %arrayidx71 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 0, !dbg !424
  %44 = load i16, i16* %arrayidx71, align 16, !dbg !424
  %45 = load i16, i16* %temp, align 2, !dbg !424
  %call72 = call signext i16 @gsm_add(i16 noundef signext %44, i16 noundef signext %45), !dbg !424
  %arrayidx73 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 0, !dbg !425
  store i16 %call72, i16* %arrayidx73, align 16, !dbg !426
  br label %Reflection_coefficients_label5, !dbg !425

Reflection_coefficients_label5:                   ; preds = %if.end68
  call void @llvm.dbg.label(metadata !427), !dbg !428
  store i32 1, i32* %m, align 4, !dbg !429
  br label %for.cond74, !dbg !431

for.cond74:                                       ; preds = %for.inc96, %Reflection_coefficients_label5
  %46 = load i32, i32* %m, align 4, !dbg !432
  %47 = load i32, i32* %n, align 4, !dbg !434
  %sub75 = sub nsw i32 8, %47, !dbg !435
  %cmp76 = icmp sle i32 %46, %sub75, !dbg !436
  br i1 %cmp76, label %for.body78, label %for.end98, !dbg !437

for.body78:                                       ; preds = %for.cond74
  %48 = load i32, i32* %m, align 4, !dbg !438
  %idxprom79 = sext i32 %48 to i64, !dbg !438
  %arrayidx80 = getelementptr inbounds [9 x i16], [9 x i16]* %K, i64 0, i64 %idxprom79, !dbg !438
  %49 = load i16, i16* %arrayidx80, align 2, !dbg !438
  %50 = load i16*, i16** %r.addr, align 8, !dbg !438
  %51 = load i16, i16* %50, align 2, !dbg !438
  %call81 = call signext i16 @gsm_mult_r(i16 noundef signext %49, i16 noundef signext %51), !dbg !438
  store i16 %call81, i16* %temp, align 2, !dbg !440
  %52 = load i32, i32* %m, align 4, !dbg !441
  %add = add nsw i32 %52, 1, !dbg !441
  %idxprom82 = sext i32 %add to i64, !dbg !441
  %arrayidx83 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 %idxprom82, !dbg !441
  %53 = load i16, i16* %arrayidx83, align 2, !dbg !441
  %54 = load i16, i16* %temp, align 2, !dbg !441
  %call84 = call signext i16 @gsm_add(i16 noundef signext %53, i16 noundef signext %54), !dbg !441
  %55 = load i32, i32* %m, align 4, !dbg !442
  %idxprom85 = sext i32 %55 to i64, !dbg !443
  %arrayidx86 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 %idxprom85, !dbg !443
  store i16 %call84, i16* %arrayidx86, align 2, !dbg !444
  %56 = load i32, i32* %m, align 4, !dbg !445
  %add87 = add nsw i32 %56, 1, !dbg !445
  %idxprom88 = sext i32 %add87 to i64, !dbg !445
  %arrayidx89 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 %idxprom88, !dbg !445
  %57 = load i16, i16* %arrayidx89, align 2, !dbg !445
  %58 = load i16*, i16** %r.addr, align 8, !dbg !445
  %59 = load i16, i16* %58, align 2, !dbg !445
  %call90 = call signext i16 @gsm_mult_r(i16 noundef signext %57, i16 noundef signext %59), !dbg !445
  store i16 %call90, i16* %temp, align 2, !dbg !446
  %60 = load i32, i32* %m, align 4, !dbg !447
  %idxprom91 = sext i32 %60 to i64, !dbg !447
  %arrayidx92 = getelementptr inbounds [9 x i16], [9 x i16]* %K, i64 0, i64 %idxprom91, !dbg !447
  %61 = load i16, i16* %arrayidx92, align 2, !dbg !447
  %62 = load i16, i16* %temp, align 2, !dbg !447
  %call93 = call signext i16 @gsm_add(i16 noundef signext %61, i16 noundef signext %62), !dbg !447
  %63 = load i32, i32* %m, align 4, !dbg !448
  %idxprom94 = sext i32 %63 to i64, !dbg !449
  %arrayidx95 = getelementptr inbounds [9 x i16], [9 x i16]* %K, i64 0, i64 %idxprom94, !dbg !449
  store i16 %call93, i16* %arrayidx95, align 2, !dbg !450
  br label %for.inc96, !dbg !451

for.inc96:                                        ; preds = %for.body78
  %64 = load i32, i32* %m, align 4, !dbg !452
  %inc97 = add nsw i32 %64, 1, !dbg !452
  store i32 %inc97, i32* %m, align 4, !dbg !452
  br label %for.cond74, !dbg !453, !llvm.loop !454

for.end98:                                        ; preds = %for.cond74
  br label %for.inc99, !dbg !456

for.inc99:                                        ; preds = %for.end98
  %65 = load i32, i32* %n, align 4, !dbg !457
  %inc100 = add nsw i32 %65, 1, !dbg !457
  store i32 %inc100, i32* %n, align 4, !dbg !457
  %66 = load i16*, i16** %r.addr, align 8, !dbg !458
  %incdec.ptr101 = getelementptr inbounds i16, i16* %66, i32 1, !dbg !458
  store i16* %incdec.ptr101, i16** %r.addr, align 8, !dbg !458
  br label %for.cond34, !dbg !459, !llvm.loop !460

for.end102:                                       ; preds = %for.end, %for.end53, %if.then67, %for.cond34
  ret void, !dbg !462
}

declare signext i16 @gsm_div(i16 noundef signext, i16 noundef signext) #2

declare signext i16 @gsm_add(i16 noundef signext, i16 noundef signext) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Transformation_to_Log_Area_Ratios(i16* noundef %r) #0 !dbg !463 {
entry:
  %r.addr = alloca i16*, align 8
  %temp = alloca i16, align 2
  %i = alloca i32, align 4
  store i16* %r, i16** %r.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %r.addr, metadata !466, metadata !DIExpression()), !dbg !467
  call void @llvm.dbg.declare(metadata i16* %temp, metadata !468, metadata !DIExpression()), !dbg !469
  call void @llvm.dbg.declare(metadata i32* %i, metadata !470, metadata !DIExpression()), !dbg !471
  br label %Transformation_to_Log_Area_Ratios_label0, !dbg !472

Transformation_to_Log_Area_Ratios_label0:         ; preds = %entry
  call void @llvm.dbg.label(metadata !473), !dbg !474
  store i32 1, i32* %i, align 4, !dbg !475
  br label %for.cond, !dbg !477

for.cond:                                         ; preds = %for.inc, %Transformation_to_Log_Area_Ratios_label0
  %0 = load i32, i32* %i, align 4, !dbg !478
  %cmp = icmp sle i32 %0, 8, !dbg !480
  br i1 %cmp, label %for.body, label %for.end, !dbg !481

for.body:                                         ; preds = %for.cond
  %1 = load i16*, i16** %r.addr, align 8, !dbg !482
  %2 = load i16, i16* %1, align 2, !dbg !484
  store i16 %2, i16* %temp, align 2, !dbg !485
  %3 = load i16, i16* %temp, align 2, !dbg !486
  %call = call signext i16 @gsm_abs(i16 noundef signext %3), !dbg !486
  store i16 %call, i16* %temp, align 2, !dbg !487
  %4 = load i16, i16* %temp, align 2, !dbg !488
  %conv = sext i16 %4 to i32, !dbg !488
  %cmp1 = icmp slt i32 %conv, 22118, !dbg !490
  br i1 %cmp1, label %if.then, label %if.else, !dbg !491

if.then:                                          ; preds = %for.body
  %5 = load i16, i16* %temp, align 2, !dbg !492
  %conv3 = sext i16 %5 to i32, !dbg !492
  %shr = ashr i32 %conv3, 1, !dbg !492
  %conv4 = trunc i32 %shr to i16, !dbg !492
  store i16 %conv4, i16* %temp, align 2, !dbg !492
  br label %if.end17, !dbg !494

if.else:                                          ; preds = %for.body
  %6 = load i16, i16* %temp, align 2, !dbg !495
  %conv5 = sext i16 %6 to i32, !dbg !495
  %cmp6 = icmp slt i32 %conv5, 31130, !dbg !497
  br i1 %cmp6, label %if.then8, label %if.else11, !dbg !498

if.then8:                                         ; preds = %if.else
  %7 = load i16, i16* %temp, align 2, !dbg !499
  %conv9 = sext i16 %7 to i32, !dbg !499
  %sub = sub nsw i32 %conv9, 11059, !dbg !499
  %conv10 = trunc i32 %sub to i16, !dbg !499
  store i16 %conv10, i16* %temp, align 2, !dbg !499
  br label %if.end, !dbg !501

if.else11:                                        ; preds = %if.else
  %8 = load i16, i16* %temp, align 2, !dbg !502
  %conv12 = sext i16 %8 to i32, !dbg !502
  %sub13 = sub nsw i32 %conv12, 26112, !dbg !502
  %conv14 = trunc i32 %sub13 to i16, !dbg !502
  store i16 %conv14, i16* %temp, align 2, !dbg !502
  %9 = load i16, i16* %temp, align 2, !dbg !504
  %conv15 = sext i16 %9 to i32, !dbg !504
  %shl = shl i32 %conv15, 2, !dbg !504
  %conv16 = trunc i32 %shl to i16, !dbg !504
  store i16 %conv16, i16* %temp, align 2, !dbg !504
  br label %if.end

if.end:                                           ; preds = %if.else11, %if.then8
  br label %if.end17

if.end17:                                         ; preds = %if.end, %if.then
  %10 = load i16*, i16** %r.addr, align 8, !dbg !505
  %11 = load i16, i16* %10, align 2, !dbg !506
  %conv18 = sext i16 %11 to i32, !dbg !506
  %cmp19 = icmp slt i32 %conv18, 0, !dbg !507
  br i1 %cmp19, label %cond.true, label %cond.false, !dbg !506

cond.true:                                        ; preds = %if.end17
  %12 = load i16, i16* %temp, align 2, !dbg !508
  %conv21 = sext i16 %12 to i32, !dbg !508
  %sub22 = sub nsw i32 0, %conv21, !dbg !509
  br label %cond.end, !dbg !506

cond.false:                                       ; preds = %if.end17
  %13 = load i16, i16* %temp, align 2, !dbg !510
  %conv23 = sext i16 %13 to i32, !dbg !510
  br label %cond.end, !dbg !506

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %sub22, %cond.true ], [ %conv23, %cond.false ], !dbg !506
  %conv24 = trunc i32 %cond to i16, !dbg !506
  %14 = load i16*, i16** %r.addr, align 8, !dbg !511
  store i16 %conv24, i16* %14, align 2, !dbg !512
  br label %for.inc, !dbg !513

for.inc:                                          ; preds = %cond.end
  %15 = load i32, i32* %i, align 4, !dbg !514
  %inc = add nsw i32 %15, 1, !dbg !514
  store i32 %inc, i32* %i, align 4, !dbg !514
  %16 = load i16*, i16** %r.addr, align 8, !dbg !515
  %incdec.ptr = getelementptr inbounds i16, i16* %16, i32 1, !dbg !515
  store i16* %incdec.ptr, i16** %r.addr, align 8, !dbg !515
  br label %for.cond, !dbg !516, !llvm.loop !517

for.end:                                          ; preds = %for.cond
  ret void, !dbg !519
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Quantization_and_coding(i16* noundef %LAR) #0 !dbg !520 {
entry:
  %LAR.addr = alloca i16*, align 8
  %temp = alloca i16, align 2
  store i16* %LAR, i16** %LAR.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %LAR.addr, metadata !521, metadata !DIExpression()), !dbg !522
  call void @llvm.dbg.declare(metadata i16* %temp, metadata !523, metadata !DIExpression()), !dbg !524
  %0 = load i16*, i16** %LAR.addr, align 8, !dbg !525
  %1 = load i16, i16* %0, align 2, !dbg !525
  %call = call signext i16 @gsm_mult(i16 noundef signext 20480, i16 noundef signext %1), !dbg !525
  store i16 %call, i16* %temp, align 2, !dbg !525
  %2 = load i16, i16* %temp, align 2, !dbg !525
  %call1 = call signext i16 @gsm_add(i16 noundef signext %2, i16 noundef signext 0), !dbg !525
  store i16 %call1, i16* %temp, align 2, !dbg !525
  %3 = load i16, i16* %temp, align 2, !dbg !525
  %call2 = call signext i16 @gsm_add(i16 noundef signext %3, i16 noundef signext 256), !dbg !525
  store i16 %call2, i16* %temp, align 2, !dbg !525
  %4 = load i16, i16* %temp, align 2, !dbg !525
  %conv = sext i16 %4 to i32, !dbg !525
  %shr = ashr i32 %conv, 9, !dbg !525
  %conv3 = trunc i32 %shr to i16, !dbg !525
  store i16 %conv3, i16* %temp, align 2, !dbg !525
  %5 = load i16, i16* %temp, align 2, !dbg !525
  %conv4 = sext i16 %5 to i32, !dbg !525
  %cmp = icmp sgt i32 %conv4, 31, !dbg !525
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !525

cond.true:                                        ; preds = %entry
  br label %cond.end12, !dbg !525

cond.false:                                       ; preds = %entry
  %6 = load i16, i16* %temp, align 2, !dbg !525
  %conv6 = sext i16 %6 to i32, !dbg !525
  %cmp7 = icmp slt i32 %conv6, -32, !dbg !525
  br i1 %cmp7, label %cond.true9, label %cond.false10, !dbg !525

cond.true9:                                       ; preds = %cond.false
  br label %cond.end, !dbg !525

cond.false10:                                     ; preds = %cond.false
  %7 = load i16, i16* %temp, align 2, !dbg !525
  %conv11 = sext i16 %7 to i32, !dbg !525
  %sub = sub nsw i32 %conv11, -32, !dbg !525
  br label %cond.end, !dbg !525

cond.end:                                         ; preds = %cond.false10, %cond.true9
  %cond = phi i32 [ 0, %cond.true9 ], [ %sub, %cond.false10 ], !dbg !525
  br label %cond.end12, !dbg !525

cond.end12:                                       ; preds = %cond.end, %cond.true
  %cond13 = phi i32 [ 63, %cond.true ], [ %cond, %cond.end ], !dbg !525
  %conv14 = trunc i32 %cond13 to i16, !dbg !525
  %8 = load i16*, i16** %LAR.addr, align 8, !dbg !525
  store i16 %conv14, i16* %8, align 2, !dbg !525
  %9 = load i16*, i16** %LAR.addr, align 8, !dbg !525
  %incdec.ptr = getelementptr inbounds i16, i16* %9, i32 1, !dbg !525
  store i16* %incdec.ptr, i16** %LAR.addr, align 8, !dbg !525
  %10 = load i16*, i16** %LAR.addr, align 8, !dbg !526
  %11 = load i16, i16* %10, align 2, !dbg !526
  %call15 = call signext i16 @gsm_mult(i16 noundef signext 20480, i16 noundef signext %11), !dbg !526
  store i16 %call15, i16* %temp, align 2, !dbg !526
  %12 = load i16, i16* %temp, align 2, !dbg !526
  %call16 = call signext i16 @gsm_add(i16 noundef signext %12, i16 noundef signext 0), !dbg !526
  store i16 %call16, i16* %temp, align 2, !dbg !526
  %13 = load i16, i16* %temp, align 2, !dbg !526
  %call17 = call signext i16 @gsm_add(i16 noundef signext %13, i16 noundef signext 256), !dbg !526
  store i16 %call17, i16* %temp, align 2, !dbg !526
  %14 = load i16, i16* %temp, align 2, !dbg !526
  %conv18 = sext i16 %14 to i32, !dbg !526
  %shr19 = ashr i32 %conv18, 9, !dbg !526
  %conv20 = trunc i32 %shr19 to i16, !dbg !526
  store i16 %conv20, i16* %temp, align 2, !dbg !526
  %15 = load i16, i16* %temp, align 2, !dbg !526
  %conv21 = sext i16 %15 to i32, !dbg !526
  %cmp22 = icmp sgt i32 %conv21, 31, !dbg !526
  br i1 %cmp22, label %cond.true24, label %cond.false25, !dbg !526

cond.true24:                                      ; preds = %cond.end12
  br label %cond.end35, !dbg !526

cond.false25:                                     ; preds = %cond.end12
  %16 = load i16, i16* %temp, align 2, !dbg !526
  %conv26 = sext i16 %16 to i32, !dbg !526
  %cmp27 = icmp slt i32 %conv26, -32, !dbg !526
  br i1 %cmp27, label %cond.true29, label %cond.false30, !dbg !526

cond.true29:                                      ; preds = %cond.false25
  br label %cond.end33, !dbg !526

cond.false30:                                     ; preds = %cond.false25
  %17 = load i16, i16* %temp, align 2, !dbg !526
  %conv31 = sext i16 %17 to i32, !dbg !526
  %sub32 = sub nsw i32 %conv31, -32, !dbg !526
  br label %cond.end33, !dbg !526

cond.end33:                                       ; preds = %cond.false30, %cond.true29
  %cond34 = phi i32 [ 0, %cond.true29 ], [ %sub32, %cond.false30 ], !dbg !526
  br label %cond.end35, !dbg !526

cond.end35:                                       ; preds = %cond.end33, %cond.true24
  %cond36 = phi i32 [ 63, %cond.true24 ], [ %cond34, %cond.end33 ], !dbg !526
  %conv37 = trunc i32 %cond36 to i16, !dbg !526
  %18 = load i16*, i16** %LAR.addr, align 8, !dbg !526
  store i16 %conv37, i16* %18, align 2, !dbg !526
  %19 = load i16*, i16** %LAR.addr, align 8, !dbg !526
  %incdec.ptr38 = getelementptr inbounds i16, i16* %19, i32 1, !dbg !526
  store i16* %incdec.ptr38, i16** %LAR.addr, align 8, !dbg !526
  %20 = load i16*, i16** %LAR.addr, align 8, !dbg !527
  %21 = load i16, i16* %20, align 2, !dbg !527
  %call39 = call signext i16 @gsm_mult(i16 noundef signext 20480, i16 noundef signext %21), !dbg !527
  store i16 %call39, i16* %temp, align 2, !dbg !527
  %22 = load i16, i16* %temp, align 2, !dbg !527
  %call40 = call signext i16 @gsm_add(i16 noundef signext %22, i16 noundef signext 2048), !dbg !527
  store i16 %call40, i16* %temp, align 2, !dbg !527
  %23 = load i16, i16* %temp, align 2, !dbg !527
  %call41 = call signext i16 @gsm_add(i16 noundef signext %23, i16 noundef signext 256), !dbg !527
  store i16 %call41, i16* %temp, align 2, !dbg !527
  %24 = load i16, i16* %temp, align 2, !dbg !527
  %conv42 = sext i16 %24 to i32, !dbg !527
  %shr43 = ashr i32 %conv42, 9, !dbg !527
  %conv44 = trunc i32 %shr43 to i16, !dbg !527
  store i16 %conv44, i16* %temp, align 2, !dbg !527
  %25 = load i16, i16* %temp, align 2, !dbg !527
  %conv45 = sext i16 %25 to i32, !dbg !527
  %cmp46 = icmp sgt i32 %conv45, 15, !dbg !527
  br i1 %cmp46, label %cond.true48, label %cond.false49, !dbg !527

cond.true48:                                      ; preds = %cond.end35
  br label %cond.end59, !dbg !527

cond.false49:                                     ; preds = %cond.end35
  %26 = load i16, i16* %temp, align 2, !dbg !527
  %conv50 = sext i16 %26 to i32, !dbg !527
  %cmp51 = icmp slt i32 %conv50, -16, !dbg !527
  br i1 %cmp51, label %cond.true53, label %cond.false54, !dbg !527

cond.true53:                                      ; preds = %cond.false49
  br label %cond.end57, !dbg !527

cond.false54:                                     ; preds = %cond.false49
  %27 = load i16, i16* %temp, align 2, !dbg !527
  %conv55 = sext i16 %27 to i32, !dbg !527
  %sub56 = sub nsw i32 %conv55, -16, !dbg !527
  br label %cond.end57, !dbg !527

cond.end57:                                       ; preds = %cond.false54, %cond.true53
  %cond58 = phi i32 [ 0, %cond.true53 ], [ %sub56, %cond.false54 ], !dbg !527
  br label %cond.end59, !dbg !527

cond.end59:                                       ; preds = %cond.end57, %cond.true48
  %cond60 = phi i32 [ 31, %cond.true48 ], [ %cond58, %cond.end57 ], !dbg !527
  %conv61 = trunc i32 %cond60 to i16, !dbg !527
  %28 = load i16*, i16** %LAR.addr, align 8, !dbg !527
  store i16 %conv61, i16* %28, align 2, !dbg !527
  %29 = load i16*, i16** %LAR.addr, align 8, !dbg !527
  %incdec.ptr62 = getelementptr inbounds i16, i16* %29, i32 1, !dbg !527
  store i16* %incdec.ptr62, i16** %LAR.addr, align 8, !dbg !527
  %30 = load i16*, i16** %LAR.addr, align 8, !dbg !528
  %31 = load i16, i16* %30, align 2, !dbg !528
  %call63 = call signext i16 @gsm_mult(i16 noundef signext 20480, i16 noundef signext %31), !dbg !528
  store i16 %call63, i16* %temp, align 2, !dbg !528
  %32 = load i16, i16* %temp, align 2, !dbg !528
  %call64 = call signext i16 @gsm_add(i16 noundef signext %32, i16 noundef signext -2560), !dbg !528
  store i16 %call64, i16* %temp, align 2, !dbg !528
  %33 = load i16, i16* %temp, align 2, !dbg !528
  %call65 = call signext i16 @gsm_add(i16 noundef signext %33, i16 noundef signext 256), !dbg !528
  store i16 %call65, i16* %temp, align 2, !dbg !528
  %34 = load i16, i16* %temp, align 2, !dbg !528
  %conv66 = sext i16 %34 to i32, !dbg !528
  %shr67 = ashr i32 %conv66, 9, !dbg !528
  %conv68 = trunc i32 %shr67 to i16, !dbg !528
  store i16 %conv68, i16* %temp, align 2, !dbg !528
  %35 = load i16, i16* %temp, align 2, !dbg !528
  %conv69 = sext i16 %35 to i32, !dbg !528
  %cmp70 = icmp sgt i32 %conv69, 15, !dbg !528
  br i1 %cmp70, label %cond.true72, label %cond.false73, !dbg !528

cond.true72:                                      ; preds = %cond.end59
  br label %cond.end83, !dbg !528

cond.false73:                                     ; preds = %cond.end59
  %36 = load i16, i16* %temp, align 2, !dbg !528
  %conv74 = sext i16 %36 to i32, !dbg !528
  %cmp75 = icmp slt i32 %conv74, -16, !dbg !528
  br i1 %cmp75, label %cond.true77, label %cond.false78, !dbg !528

cond.true77:                                      ; preds = %cond.false73
  br label %cond.end81, !dbg !528

cond.false78:                                     ; preds = %cond.false73
  %37 = load i16, i16* %temp, align 2, !dbg !528
  %conv79 = sext i16 %37 to i32, !dbg !528
  %sub80 = sub nsw i32 %conv79, -16, !dbg !528
  br label %cond.end81, !dbg !528

cond.end81:                                       ; preds = %cond.false78, %cond.true77
  %cond82 = phi i32 [ 0, %cond.true77 ], [ %sub80, %cond.false78 ], !dbg !528
  br label %cond.end83, !dbg !528

cond.end83:                                       ; preds = %cond.end81, %cond.true72
  %cond84 = phi i32 [ 31, %cond.true72 ], [ %cond82, %cond.end81 ], !dbg !528
  %conv85 = trunc i32 %cond84 to i16, !dbg !528
  %38 = load i16*, i16** %LAR.addr, align 8, !dbg !528
  store i16 %conv85, i16* %38, align 2, !dbg !528
  %39 = load i16*, i16** %LAR.addr, align 8, !dbg !528
  %incdec.ptr86 = getelementptr inbounds i16, i16* %39, i32 1, !dbg !528
  store i16* %incdec.ptr86, i16** %LAR.addr, align 8, !dbg !528
  %40 = load i16*, i16** %LAR.addr, align 8, !dbg !529
  %41 = load i16, i16* %40, align 2, !dbg !529
  %call87 = call signext i16 @gsm_mult(i16 noundef signext 13964, i16 noundef signext %41), !dbg !529
  store i16 %call87, i16* %temp, align 2, !dbg !529
  %42 = load i16, i16* %temp, align 2, !dbg !529
  %call88 = call signext i16 @gsm_add(i16 noundef signext %42, i16 noundef signext 94), !dbg !529
  store i16 %call88, i16* %temp, align 2, !dbg !529
  %43 = load i16, i16* %temp, align 2, !dbg !529
  %call89 = call signext i16 @gsm_add(i16 noundef signext %43, i16 noundef signext 256), !dbg !529
  store i16 %call89, i16* %temp, align 2, !dbg !529
  %44 = load i16, i16* %temp, align 2, !dbg !529
  %conv90 = sext i16 %44 to i32, !dbg !529
  %shr91 = ashr i32 %conv90, 9, !dbg !529
  %conv92 = trunc i32 %shr91 to i16, !dbg !529
  store i16 %conv92, i16* %temp, align 2, !dbg !529
  %45 = load i16, i16* %temp, align 2, !dbg !529
  %conv93 = sext i16 %45 to i32, !dbg !529
  %cmp94 = icmp sgt i32 %conv93, 7, !dbg !529
  br i1 %cmp94, label %cond.true96, label %cond.false97, !dbg !529

cond.true96:                                      ; preds = %cond.end83
  br label %cond.end107, !dbg !529

cond.false97:                                     ; preds = %cond.end83
  %46 = load i16, i16* %temp, align 2, !dbg !529
  %conv98 = sext i16 %46 to i32, !dbg !529
  %cmp99 = icmp slt i32 %conv98, -8, !dbg !529
  br i1 %cmp99, label %cond.true101, label %cond.false102, !dbg !529

cond.true101:                                     ; preds = %cond.false97
  br label %cond.end105, !dbg !529

cond.false102:                                    ; preds = %cond.false97
  %47 = load i16, i16* %temp, align 2, !dbg !529
  %conv103 = sext i16 %47 to i32, !dbg !529
  %sub104 = sub nsw i32 %conv103, -8, !dbg !529
  br label %cond.end105, !dbg !529

cond.end105:                                      ; preds = %cond.false102, %cond.true101
  %cond106 = phi i32 [ 0, %cond.true101 ], [ %sub104, %cond.false102 ], !dbg !529
  br label %cond.end107, !dbg !529

cond.end107:                                      ; preds = %cond.end105, %cond.true96
  %cond108 = phi i32 [ 15, %cond.true96 ], [ %cond106, %cond.end105 ], !dbg !529
  %conv109 = trunc i32 %cond108 to i16, !dbg !529
  %48 = load i16*, i16** %LAR.addr, align 8, !dbg !529
  store i16 %conv109, i16* %48, align 2, !dbg !529
  %49 = load i16*, i16** %LAR.addr, align 8, !dbg !529
  %incdec.ptr110 = getelementptr inbounds i16, i16* %49, i32 1, !dbg !529
  store i16* %incdec.ptr110, i16** %LAR.addr, align 8, !dbg !529
  %50 = load i16*, i16** %LAR.addr, align 8, !dbg !530
  %51 = load i16, i16* %50, align 2, !dbg !530
  %call111 = call signext i16 @gsm_mult(i16 noundef signext 15360, i16 noundef signext %51), !dbg !530
  store i16 %call111, i16* %temp, align 2, !dbg !530
  %52 = load i16, i16* %temp, align 2, !dbg !530
  %call112 = call signext i16 @gsm_add(i16 noundef signext %52, i16 noundef signext -1792), !dbg !530
  store i16 %call112, i16* %temp, align 2, !dbg !530
  %53 = load i16, i16* %temp, align 2, !dbg !530
  %call113 = call signext i16 @gsm_add(i16 noundef signext %53, i16 noundef signext 256), !dbg !530
  store i16 %call113, i16* %temp, align 2, !dbg !530
  %54 = load i16, i16* %temp, align 2, !dbg !530
  %conv114 = sext i16 %54 to i32, !dbg !530
  %shr115 = ashr i32 %conv114, 9, !dbg !530
  %conv116 = trunc i32 %shr115 to i16, !dbg !530
  store i16 %conv116, i16* %temp, align 2, !dbg !530
  %55 = load i16, i16* %temp, align 2, !dbg !530
  %conv117 = sext i16 %55 to i32, !dbg !530
  %cmp118 = icmp sgt i32 %conv117, 7, !dbg !530
  br i1 %cmp118, label %cond.true120, label %cond.false121, !dbg !530

cond.true120:                                     ; preds = %cond.end107
  br label %cond.end131, !dbg !530

cond.false121:                                    ; preds = %cond.end107
  %56 = load i16, i16* %temp, align 2, !dbg !530
  %conv122 = sext i16 %56 to i32, !dbg !530
  %cmp123 = icmp slt i32 %conv122, -8, !dbg !530
  br i1 %cmp123, label %cond.true125, label %cond.false126, !dbg !530

cond.true125:                                     ; preds = %cond.false121
  br label %cond.end129, !dbg !530

cond.false126:                                    ; preds = %cond.false121
  %57 = load i16, i16* %temp, align 2, !dbg !530
  %conv127 = sext i16 %57 to i32, !dbg !530
  %sub128 = sub nsw i32 %conv127, -8, !dbg !530
  br label %cond.end129, !dbg !530

cond.end129:                                      ; preds = %cond.false126, %cond.true125
  %cond130 = phi i32 [ 0, %cond.true125 ], [ %sub128, %cond.false126 ], !dbg !530
  br label %cond.end131, !dbg !530

cond.end131:                                      ; preds = %cond.end129, %cond.true120
  %cond132 = phi i32 [ 15, %cond.true120 ], [ %cond130, %cond.end129 ], !dbg !530
  %conv133 = trunc i32 %cond132 to i16, !dbg !530
  %58 = load i16*, i16** %LAR.addr, align 8, !dbg !530
  store i16 %conv133, i16* %58, align 2, !dbg !530
  %59 = load i16*, i16** %LAR.addr, align 8, !dbg !530
  %incdec.ptr134 = getelementptr inbounds i16, i16* %59, i32 1, !dbg !530
  store i16* %incdec.ptr134, i16** %LAR.addr, align 8, !dbg !530
  %60 = load i16*, i16** %LAR.addr, align 8, !dbg !531
  %61 = load i16, i16* %60, align 2, !dbg !531
  %call135 = call signext i16 @gsm_mult(i16 noundef signext 8534, i16 noundef signext %61), !dbg !531
  store i16 %call135, i16* %temp, align 2, !dbg !531
  %62 = load i16, i16* %temp, align 2, !dbg !531
  %call136 = call signext i16 @gsm_add(i16 noundef signext %62, i16 noundef signext -341), !dbg !531
  store i16 %call136, i16* %temp, align 2, !dbg !531
  %63 = load i16, i16* %temp, align 2, !dbg !531
  %call137 = call signext i16 @gsm_add(i16 noundef signext %63, i16 noundef signext 256), !dbg !531
  store i16 %call137, i16* %temp, align 2, !dbg !531
  %64 = load i16, i16* %temp, align 2, !dbg !531
  %conv138 = sext i16 %64 to i32, !dbg !531
  %shr139 = ashr i32 %conv138, 9, !dbg !531
  %conv140 = trunc i32 %shr139 to i16, !dbg !531
  store i16 %conv140, i16* %temp, align 2, !dbg !531
  %65 = load i16, i16* %temp, align 2, !dbg !531
  %conv141 = sext i16 %65 to i32, !dbg !531
  %cmp142 = icmp sgt i32 %conv141, 3, !dbg !531
  br i1 %cmp142, label %cond.true144, label %cond.false145, !dbg !531

cond.true144:                                     ; preds = %cond.end131
  br label %cond.end155, !dbg !531

cond.false145:                                    ; preds = %cond.end131
  %66 = load i16, i16* %temp, align 2, !dbg !531
  %conv146 = sext i16 %66 to i32, !dbg !531
  %cmp147 = icmp slt i32 %conv146, -4, !dbg !531
  br i1 %cmp147, label %cond.true149, label %cond.false150, !dbg !531

cond.true149:                                     ; preds = %cond.false145
  br label %cond.end153, !dbg !531

cond.false150:                                    ; preds = %cond.false145
  %67 = load i16, i16* %temp, align 2, !dbg !531
  %conv151 = sext i16 %67 to i32, !dbg !531
  %sub152 = sub nsw i32 %conv151, -4, !dbg !531
  br label %cond.end153, !dbg !531

cond.end153:                                      ; preds = %cond.false150, %cond.true149
  %cond154 = phi i32 [ 0, %cond.true149 ], [ %sub152, %cond.false150 ], !dbg !531
  br label %cond.end155, !dbg !531

cond.end155:                                      ; preds = %cond.end153, %cond.true144
  %cond156 = phi i32 [ 7, %cond.true144 ], [ %cond154, %cond.end153 ], !dbg !531
  %conv157 = trunc i32 %cond156 to i16, !dbg !531
  %68 = load i16*, i16** %LAR.addr, align 8, !dbg !531
  store i16 %conv157, i16* %68, align 2, !dbg !531
  %69 = load i16*, i16** %LAR.addr, align 8, !dbg !531
  %incdec.ptr158 = getelementptr inbounds i16, i16* %69, i32 1, !dbg !531
  store i16* %incdec.ptr158, i16** %LAR.addr, align 8, !dbg !531
  %70 = load i16*, i16** %LAR.addr, align 8, !dbg !532
  %71 = load i16, i16* %70, align 2, !dbg !532
  %call159 = call signext i16 @gsm_mult(i16 noundef signext 9036, i16 noundef signext %71), !dbg !532
  store i16 %call159, i16* %temp, align 2, !dbg !532
  %72 = load i16, i16* %temp, align 2, !dbg !532
  %call160 = call signext i16 @gsm_add(i16 noundef signext %72, i16 noundef signext -1144), !dbg !532
  store i16 %call160, i16* %temp, align 2, !dbg !532
  %73 = load i16, i16* %temp, align 2, !dbg !532
  %call161 = call signext i16 @gsm_add(i16 noundef signext %73, i16 noundef signext 256), !dbg !532
  store i16 %call161, i16* %temp, align 2, !dbg !532
  %74 = load i16, i16* %temp, align 2, !dbg !532
  %conv162 = sext i16 %74 to i32, !dbg !532
  %shr163 = ashr i32 %conv162, 9, !dbg !532
  %conv164 = trunc i32 %shr163 to i16, !dbg !532
  store i16 %conv164, i16* %temp, align 2, !dbg !532
  %75 = load i16, i16* %temp, align 2, !dbg !532
  %conv165 = sext i16 %75 to i32, !dbg !532
  %cmp166 = icmp sgt i32 %conv165, 3, !dbg !532
  br i1 %cmp166, label %cond.true168, label %cond.false169, !dbg !532

cond.true168:                                     ; preds = %cond.end155
  br label %cond.end179, !dbg !532

cond.false169:                                    ; preds = %cond.end155
  %76 = load i16, i16* %temp, align 2, !dbg !532
  %conv170 = sext i16 %76 to i32, !dbg !532
  %cmp171 = icmp slt i32 %conv170, -4, !dbg !532
  br i1 %cmp171, label %cond.true173, label %cond.false174, !dbg !532

cond.true173:                                     ; preds = %cond.false169
  br label %cond.end177, !dbg !532

cond.false174:                                    ; preds = %cond.false169
  %77 = load i16, i16* %temp, align 2, !dbg !532
  %conv175 = sext i16 %77 to i32, !dbg !532
  %sub176 = sub nsw i32 %conv175, -4, !dbg !532
  br label %cond.end177, !dbg !532

cond.end177:                                      ; preds = %cond.false174, %cond.true173
  %cond178 = phi i32 [ 0, %cond.true173 ], [ %sub176, %cond.false174 ], !dbg !532
  br label %cond.end179, !dbg !532

cond.end179:                                      ; preds = %cond.end177, %cond.true168
  %cond180 = phi i32 [ 7, %cond.true168 ], [ %cond178, %cond.end177 ], !dbg !532
  %conv181 = trunc i32 %cond180 to i16, !dbg !532
  %78 = load i16*, i16** %LAR.addr, align 8, !dbg !532
  store i16 %conv181, i16* %78, align 2, !dbg !532
  %79 = load i16*, i16** %LAR.addr, align 8, !dbg !532
  %incdec.ptr182 = getelementptr inbounds i16, i16* %79, i32 1, !dbg !532
  store i16* %incdec.ptr182, i16** %LAR.addr, align 8, !dbg !532
  ret void, !dbg !533
}

declare signext i16 @gsm_mult(i16 noundef signext, i16 noundef signext) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8, !9, !10, !11, !12}
!llvm.ident = !{!13}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "data/benchmarks/real/gsm/gsm_lpc.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "32feb5ddaaa24ea713c6883a90957f9d")
!2 = !{!3}
!3 = !DIDerivedType(tag: DW_TAG_typedef, name: "longword", file: !4, line: 31, baseType: !5)
!4 = !DIFile(filename: "data/benchmarks/real/gsm/gsm_private.h", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "4f2b4f8362ef72e1c64723ce45f8c494")
!5 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!6 = !{i32 7, !"Dwarf Version", i32 5}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{i32 7, !"PIC Level", i32 2}
!10 = !{i32 7, !"PIE Level", i32 2}
!11 = !{i32 7, !"uwtable", i32 1}
!12 = !{i32 7, !"frame-pointer", i32 2}
!13 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!14 = distinct !DISubprogram(name: "Autocorrelation", scope: !1, file: !1, line: 34, type: !15, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17, !20}
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "word", file: !4, line: 30, baseType: !19)
!19 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3, size: 64)
!21 = !{}
!22 = !DILocalVariable(name: "s", arg: 1, scope: !14, file: !1, line: 35, type: !17)
!23 = !DILocation(line: 35, column: 11, scope: !14)
!24 = !DILocalVariable(name: "L_ACF", arg: 2, scope: !14, file: !1, line: 36, type: !20)
!25 = !DILocation(line: 36, column: 15, scope: !14)
!26 = !DILocalVariable(name: "k", scope: !14, file: !1, line: 39, type: !27)
!27 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!28 = !DILocation(line: 39, column: 18, scope: !14)
!29 = !DILocalVariable(name: "i", scope: !14, file: !1, line: 39, type: !27)
!30 = !DILocation(line: 39, column: 21, scope: !14)
!31 = !DILocalVariable(name: "temp", scope: !14, file: !1, line: 40, type: !18)
!32 = !DILocation(line: 40, column: 10, scope: !14)
!33 = !DILocalVariable(name: "smax", scope: !14, file: !1, line: 41, type: !18)
!34 = !DILocation(line: 41, column: 10, scope: !14)
!35 = !DILocalVariable(name: "scalauto", scope: !14, file: !1, line: 42, type: !18)
!36 = !DILocation(line: 42, column: 10, scope: !14)
!37 = !DILocalVariable(name: "n", scope: !14, file: !1, line: 42, type: !18)
!38 = !DILocation(line: 42, column: 20, scope: !14)
!39 = !DILocalVariable(name: "sp", scope: !14, file: !1, line: 43, type: !17)
!40 = !DILocation(line: 43, column: 11, scope: !14)
!41 = !DILocalVariable(name: "sl", scope: !14, file: !1, line: 44, type: !18)
!42 = !DILocation(line: 44, column: 10, scope: !14)
!43 = !DILocation(line: 47, column: 10, scope: !14)
!44 = !DILocation(line: 47, column: 5, scope: !14)
!45 = !DILabel(scope: !14, name: "Autocorrelation_label0", file: !1, line: 48)
!46 = !DILocation(line: 48, column: 5, scope: !14)
!47 = !DILocation(line: 49, column: 12, scope: !48)
!48 = distinct !DILexicalBlock(scope: !14, file: !1, line: 49, column: 5)
!49 = !DILocation(line: 49, column: 10, scope: !48)
!50 = !DILocation(line: 49, column: 17, scope: !51)
!51 = distinct !DILexicalBlock(scope: !48, file: !1, line: 49, column: 5)
!52 = !DILocation(line: 49, column: 19, scope: !51)
!53 = !DILocation(line: 49, column: 5, scope: !48)
!54 = !DILocation(line: 51, column: 16, scope: !55)
!55 = distinct !DILexicalBlock(scope: !51, file: !1, line: 49, column: 32)
!56 = !DILocation(line: 51, column: 14, scope: !55)
!57 = !DILocation(line: 52, column: 13, scope: !58)
!58 = distinct !DILexicalBlock(scope: !55, file: !1, line: 52, column: 13)
!59 = !DILocation(line: 52, column: 20, scope: !58)
!60 = !DILocation(line: 52, column: 18, scope: !58)
!61 = !DILocation(line: 52, column: 13, scope: !55)
!62 = !DILocation(line: 53, column: 20, scope: !58)
!63 = !DILocation(line: 53, column: 18, scope: !58)
!64 = !DILocation(line: 53, column: 13, scope: !58)
!65 = !DILocation(line: 54, column: 5, scope: !55)
!66 = !DILocation(line: 49, column: 28, scope: !51)
!67 = !DILocation(line: 49, column: 5, scope: !51)
!68 = distinct !{!68, !53, !69, !70}
!69 = !DILocation(line: 54, column: 5, scope: !48)
!70 = !{!"llvm.loop.mustprogress"}
!71 = !DILocation(line: 57, column: 9, scope: !72)
!72 = distinct !DILexicalBlock(scope: !14, file: !1, line: 57, column: 9)
!73 = !DILocation(line: 57, column: 14, scope: !72)
!74 = !DILocation(line: 57, column: 9, scope: !14)
!75 = !DILocation(line: 58, column: 18, scope: !72)
!76 = !DILocation(line: 58, column: 9, scope: !72)
!77 = !DILocation(line: 60, column: 43, scope: !72)
!78 = !DILocation(line: 60, column: 33, scope: !72)
!79 = !DILocation(line: 60, column: 48, scope: !72)
!80 = !DILocation(line: 60, column: 24, scope: !72)
!81 = !DILocation(line: 60, column: 22, scope: !72)
!82 = !DILocation(line: 60, column: 20, scope: !72)
!83 = !DILocation(line: 60, column: 18, scope: !72)
!84 = !DILocation(line: 62, column: 9, scope: !85)
!85 = distinct !DILexicalBlock(scope: !14, file: !1, line: 62, column: 9)
!86 = !DILocation(line: 62, column: 18, scope: !85)
!87 = !DILocation(line: 62, column: 22, scope: !85)
!88 = !DILocation(line: 62, column: 25, scope: !85)
!89 = !DILocation(line: 62, column: 34, scope: !85)
!90 = !DILocation(line: 62, column: 9, scope: !14)
!91 = !DILocation(line: 63, column: 13, scope: !92)
!92 = distinct !DILexicalBlock(scope: !85, file: !1, line: 62, column: 40)
!93 = !DILocation(line: 63, column: 11, scope: !92)
!94 = !DILocation(line: 63, column: 9, scope: !92)
!95 = !DILabel(scope: !92, name: "Autocorrelation_label1", file: !1, line: 64)
!96 = !DILocation(line: 64, column: 9, scope: !92)
!97 = !DILocation(line: 65, column: 16, scope: !98)
!98 = distinct !DILexicalBlock(scope: !92, file: !1, line: 65, column: 9)
!99 = !DILocation(line: 65, column: 14, scope: !98)
!100 = !DILocation(line: 65, column: 21, scope: !101)
!101 = distinct !DILexicalBlock(scope: !98, file: !1, line: 65, column: 9)
!102 = !DILocation(line: 65, column: 23, scope: !101)
!103 = !DILocation(line: 65, column: 9, scope: !98)
!104 = !DILocation(line: 67, column: 20, scope: !105)
!105 = distinct !DILexicalBlock(scope: !101, file: !1, line: 65, column: 36)
!106 = !DILocation(line: 67, column: 13, scope: !105)
!107 = !DILocation(line: 67, column: 15, scope: !105)
!108 = !DILocation(line: 67, column: 18, scope: !105)
!109 = !DILocation(line: 68, column: 9, scope: !105)
!110 = !DILocation(line: 65, column: 32, scope: !101)
!111 = !DILocation(line: 65, column: 9, scope: !101)
!112 = distinct !{!112, !103, !113, !70}
!113 = !DILocation(line: 68, column: 9, scope: !98)
!114 = !DILocation(line: 69, column: 5, scope: !92)
!115 = !DILocation(line: 72, column: 10, scope: !14)
!116 = !DILocation(line: 72, column: 8, scope: !14)
!117 = !DILocation(line: 73, column: 11, scope: !14)
!118 = !DILocation(line: 73, column: 10, scope: !14)
!119 = !DILocation(line: 73, column: 8, scope: !14)
!120 = !DILocation(line: 73, column: 5, scope: !14)
!121 = !DILabel(scope: !14, name: "Autocorrelation_label2", file: !1, line: 78)
!122 = !DILocation(line: 78, column: 5, scope: !14)
!123 = !DILocation(line: 79, column: 12, scope: !124)
!124 = distinct !DILexicalBlock(scope: !14, file: !1, line: 79, column: 5)
!125 = !DILocation(line: 79, column: 10, scope: !124)
!126 = !DILocation(line: 79, column: 17, scope: !127)
!127 = distinct !DILexicalBlock(scope: !124, file: !1, line: 79, column: 5)
!128 = !DILocation(line: 79, column: 19, scope: !127)
!129 = !DILocation(line: 79, column: 5, scope: !124)
!130 = !DILocation(line: 81, column: 9, scope: !131)
!131 = distinct !DILexicalBlock(scope: !127, file: !1, line: 79, column: 30)
!132 = !DILocation(line: 81, column: 15, scope: !131)
!133 = !DILocation(line: 81, column: 18, scope: !131)
!134 = !DILocation(line: 82, column: 5, scope: !131)
!135 = !DILocation(line: 79, column: 26, scope: !127)
!136 = !DILocation(line: 79, column: 5, scope: !127)
!137 = distinct !{!137, !129, !138, !70}
!138 = !DILocation(line: 82, column: 5, scope: !124)
!139 = !DILocation(line: 84, column: 5, scope: !14)
!140 = !DILocation(line: 85, column: 5, scope: !14)
!141 = !DILocation(line: 86, column: 5, scope: !14)
!142 = !DILocation(line: 87, column: 5, scope: !14)
!143 = !DILocation(line: 88, column: 5, scope: !14)
!144 = !DILocation(line: 89, column: 5, scope: !14)
!145 = !DILocation(line: 90, column: 5, scope: !14)
!146 = !DILocation(line: 91, column: 5, scope: !14)
!147 = !DILocation(line: 92, column: 5, scope: !14)
!148 = !DILocation(line: 93, column: 5, scope: !14)
!149 = !DILocation(line: 94, column: 5, scope: !14)
!150 = !DILocation(line: 95, column: 5, scope: !14)
!151 = !DILocation(line: 96, column: 5, scope: !14)
!152 = !DILocation(line: 97, column: 5, scope: !14)
!153 = !DILocation(line: 98, column: 5, scope: !14)
!154 = !DILocation(line: 99, column: 5, scope: !14)
!155 = !DILocation(line: 100, column: 5, scope: !14)
!156 = !DILocation(line: 101, column: 5, scope: !14)
!157 = !DILocation(line: 102, column: 5, scope: !14)
!158 = !DILocation(line: 103, column: 5, scope: !14)
!159 = !DILocation(line: 104, column: 5, scope: !14)
!160 = !DILocation(line: 105, column: 5, scope: !14)
!161 = !DILocation(line: 106, column: 5, scope: !14)
!162 = !DILocation(line: 107, column: 5, scope: !14)
!163 = !DILocation(line: 108, column: 5, scope: !14)
!164 = !DILocation(line: 109, column: 5, scope: !14)
!165 = !DILocation(line: 110, column: 5, scope: !14)
!166 = !DILocation(line: 111, column: 5, scope: !14)
!167 = !DILocation(line: 112, column: 5, scope: !14)
!168 = !DILocation(line: 113, column: 5, scope: !14)
!169 = !DILocation(line: 114, column: 5, scope: !14)
!170 = !DILocation(line: 115, column: 5, scope: !14)
!171 = !DILocation(line: 116, column: 5, scope: !14)
!172 = !DILocation(line: 117, column: 5, scope: !14)
!173 = !DILocation(line: 118, column: 5, scope: !14)
!174 = !DILocation(line: 119, column: 5, scope: !14)
!175 = !DILocation(line: 120, column: 5, scope: !14)
!176 = !DILocation(line: 121, column: 5, scope: !14)
!177 = !DILocation(line: 122, column: 5, scope: !14)
!178 = !DILocation(line: 123, column: 5, scope: !14)
!179 = !DILocation(line: 124, column: 5, scope: !14)
!180 = !DILocation(line: 125, column: 5, scope: !14)
!181 = !DILocation(line: 126, column: 5, scope: !14)
!182 = !DILabel(scope: !14, name: "Autocorrelation_label3", file: !1, line: 128)
!183 = !DILocation(line: 128, column: 5, scope: !14)
!184 = !DILocation(line: 129, column: 12, scope: !185)
!185 = distinct !DILexicalBlock(scope: !14, file: !1, line: 129, column: 5)
!186 = !DILocation(line: 129, column: 10, scope: !185)
!187 = !DILocation(line: 129, column: 17, scope: !188)
!188 = distinct !DILexicalBlock(scope: !185, file: !1, line: 129, column: 5)
!189 = !DILocation(line: 129, column: 19, scope: !188)
!190 = !DILocation(line: 129, column: 5, scope: !185)
!191 = !DILocation(line: 131, column: 9, scope: !192)
!192 = distinct !DILexicalBlock(scope: !188, file: !1, line: 129, column: 32)
!193 = !DILocation(line: 132, column: 9, scope: !192)
!194 = !DILocation(line: 133, column: 9, scope: !192)
!195 = !DILocation(line: 134, column: 9, scope: !192)
!196 = !DILocation(line: 135, column: 9, scope: !192)
!197 = !DILocation(line: 136, column: 9, scope: !192)
!198 = !DILocation(line: 137, column: 9, scope: !192)
!199 = !DILocation(line: 138, column: 9, scope: !192)
!200 = !DILocation(line: 139, column: 9, scope: !192)
!201 = !DILocation(line: 140, column: 9, scope: !192)
!202 = !DILocation(line: 141, column: 5, scope: !192)
!203 = !DILocation(line: 129, column: 28, scope: !188)
!204 = !DILocation(line: 129, column: 5, scope: !188)
!205 = distinct !{!205, !190, !206, !70}
!206 = !DILocation(line: 141, column: 5, scope: !185)
!207 = !DILabel(scope: !14, name: "Autocorrelation_label4", file: !1, line: 143)
!208 = !DILocation(line: 143, column: 5, scope: !14)
!209 = !DILocation(line: 144, column: 12, scope: !210)
!210 = distinct !DILexicalBlock(scope: !14, file: !1, line: 144, column: 5)
!211 = !DILocation(line: 144, column: 10, scope: !210)
!212 = !DILocation(line: 144, column: 17, scope: !213)
!213 = distinct !DILexicalBlock(scope: !210, file: !1, line: 144, column: 5)
!214 = !DILocation(line: 144, column: 19, scope: !213)
!215 = !DILocation(line: 144, column: 5, scope: !210)
!216 = !DILocation(line: 146, column: 9, scope: !217)
!217 = distinct !DILexicalBlock(scope: !213, file: !1, line: 144, column: 30)
!218 = !DILocation(line: 146, column: 15, scope: !217)
!219 = !DILocation(line: 146, column: 18, scope: !217)
!220 = !DILocation(line: 147, column: 5, scope: !217)
!221 = !DILocation(line: 144, column: 26, scope: !213)
!222 = !DILocation(line: 144, column: 5, scope: !213)
!223 = distinct !{!223, !215, !224, !70}
!224 = !DILocation(line: 147, column: 5, scope: !210)
!225 = !DILocation(line: 150, column: 9, scope: !226)
!226 = distinct !DILexicalBlock(scope: !14, file: !1, line: 150, column: 9)
!227 = !DILocation(line: 150, column: 18, scope: !226)
!228 = !DILocation(line: 150, column: 9, scope: !14)
!229 = !DILocation(line: 150, column: 23, scope: !226)
!230 = !DILabel(scope: !231, name: "Autocorrelation_label5", file: !1, line: 151)
!231 = distinct !DILexicalBlock(scope: !226, file: !1, line: 150, column: 23)
!232 = !DILocation(line: 151, column: 9, scope: !231)
!233 = !DILocation(line: 152, column: 16, scope: !234)
!234 = distinct !DILexicalBlock(scope: !231, file: !1, line: 152, column: 9)
!235 = !DILocation(line: 152, column: 14, scope: !234)
!236 = !DILocation(line: 152, column: 23, scope: !237)
!237 = distinct !DILexicalBlock(scope: !234, file: !1, line: 152, column: 9)
!238 = !DILocation(line: 152, column: 25, scope: !237)
!239 = !DILocation(line: 152, column: 9, scope: !234)
!240 = !DILocation(line: 154, column: 22, scope: !241)
!241 = distinct !DILexicalBlock(scope: !237, file: !1, line: 152, column: 36)
!242 = !DILocation(line: 154, column: 15, scope: !241)
!243 = !DILocation(line: 154, column: 18, scope: !241)
!244 = !DILocation(line: 155, column: 9, scope: !241)
!245 = !DILocation(line: 152, column: 32, scope: !237)
!246 = !DILocation(line: 152, column: 9, scope: !237)
!247 = distinct !{!247, !239, !248, !70}
!248 = !DILocation(line: 155, column: 9, scope: !234)
!249 = !DILocation(line: 156, column: 5, scope: !231)
!250 = !DILocation(line: 157, column: 1, scope: !14)
!251 = distinct !DISubprogram(name: "Reflection_coefficients", scope: !1, file: !1, line: 160, type: !252, scopeLine: 164, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!252 = !DISubroutineType(types: !253)
!253 = !{null, !20, !17}
!254 = !DILocalVariable(name: "L_ACF", arg: 1, scope: !251, file: !1, line: 161, type: !20)
!255 = !DILocation(line: 161, column: 15, scope: !251)
!256 = !DILocalVariable(name: "r", arg: 2, scope: !251, file: !1, line: 162, type: !17)
!257 = !DILocation(line: 162, column: 20, scope: !251)
!258 = !DILocalVariable(name: "i", scope: !251, file: !1, line: 165, type: !27)
!259 = !DILocation(line: 165, column: 18, scope: !251)
!260 = !DILocalVariable(name: "m", scope: !251, file: !1, line: 165, type: !27)
!261 = !DILocation(line: 165, column: 21, scope: !251)
!262 = !DILocalVariable(name: "n", scope: !251, file: !1, line: 165, type: !27)
!263 = !DILocation(line: 165, column: 24, scope: !251)
!264 = !DILocalVariable(name: "temp", scope: !251, file: !1, line: 166, type: !18)
!265 = !DILocation(line: 166, column: 19, scope: !251)
!266 = !DILocalVariable(name: "ACF", scope: !251, file: !1, line: 167, type: !267)
!267 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 144, elements: !268)
!268 = !{!269}
!269 = !DISubrange(count: 9)
!270 = !DILocation(line: 167, column: 10, scope: !251)
!271 = !DILocalVariable(name: "P", scope: !251, file: !1, line: 168, type: !267)
!272 = !DILocation(line: 168, column: 10, scope: !251)
!273 = !DILocalVariable(name: "K", scope: !251, file: !1, line: 169, type: !267)
!274 = !DILocation(line: 169, column: 10, scope: !251)
!275 = !DILocation(line: 172, column: 9, scope: !276)
!276 = distinct !DILexicalBlock(scope: !251, file: !1, line: 172, column: 9)
!277 = !DILocation(line: 172, column: 18, scope: !276)
!278 = !DILocation(line: 172, column: 9, scope: !251)
!279 = !DILocation(line: 172, column: 24, scope: !276)
!280 = !DILabel(scope: !281, name: "Reflection_coefficients_label0", file: !1, line: 173)
!281 = distinct !DILexicalBlock(scope: !276, file: !1, line: 172, column: 24)
!282 = !DILocation(line: 173, column: 9, scope: !281)
!283 = !DILocation(line: 174, column: 16, scope: !284)
!284 = distinct !DILexicalBlock(scope: !281, file: !1, line: 174, column: 9)
!285 = !DILocation(line: 174, column: 14, scope: !284)
!286 = !DILocation(line: 174, column: 21, scope: !287)
!287 = distinct !DILexicalBlock(scope: !284, file: !1, line: 174, column: 9)
!288 = !DILocation(line: 174, column: 23, scope: !287)
!289 = !DILocation(line: 174, column: 9, scope: !284)
!290 = !DILocation(line: 176, column: 15, scope: !291)
!291 = distinct !DILexicalBlock(scope: !287, file: !1, line: 174, column: 33)
!292 = !DILocation(line: 176, column: 18, scope: !291)
!293 = !DILocation(line: 177, column: 9, scope: !291)
!294 = !DILocation(line: 174, column: 29, scope: !287)
!295 = !DILocation(line: 174, column: 9, scope: !287)
!296 = distinct !{!296, !289, !297, !70}
!297 = !DILocation(line: 177, column: 9, scope: !284)
!298 = !DILocation(line: 178, column: 9, scope: !281)
!299 = !DILocation(line: 181, column: 21, scope: !251)
!300 = !DILocation(line: 181, column: 12, scope: !251)
!301 = !DILocation(line: 181, column: 10, scope: !251)
!302 = !DILocation(line: 181, column: 5, scope: !251)
!303 = !DILabel(scope: !251, name: "Reflection_coefficients_label1", file: !1, line: 183)
!304 = !DILocation(line: 183, column: 5, scope: !251)
!305 = !DILocation(line: 184, column: 12, scope: !306)
!306 = distinct !DILexicalBlock(scope: !251, file: !1, line: 184, column: 5)
!307 = !DILocation(line: 184, column: 10, scope: !306)
!308 = !DILocation(line: 184, column: 17, scope: !309)
!309 = distinct !DILexicalBlock(scope: !306, file: !1, line: 184, column: 5)
!310 = !DILocation(line: 184, column: 19, scope: !309)
!311 = !DILocation(line: 184, column: 5, scope: !306)
!312 = !DILocation(line: 186, column: 18, scope: !313)
!313 = distinct !DILexicalBlock(scope: !309, file: !1, line: 184, column: 30)
!314 = !DILocation(line: 186, column: 13, scope: !313)
!315 = !DILocation(line: 186, column: 9, scope: !313)
!316 = !DILocation(line: 186, column: 16, scope: !313)
!317 = !DILocation(line: 187, column: 5, scope: !313)
!318 = !DILocation(line: 184, column: 26, scope: !309)
!319 = !DILocation(line: 184, column: 5, scope: !309)
!320 = distinct !{!320, !311, !321, !70}
!321 = !DILocation(line: 187, column: 5, scope: !306)
!322 = !DILabel(scope: !251, name: "Reflection_coefficients_label2", file: !1, line: 190)
!323 = !DILocation(line: 190, column: 5, scope: !251)
!324 = !DILocation(line: 191, column: 12, scope: !325)
!325 = distinct !DILexicalBlock(scope: !251, file: !1, line: 191, column: 5)
!326 = !DILocation(line: 191, column: 10, scope: !325)
!327 = !DILocation(line: 191, column: 17, scope: !328)
!328 = distinct !DILexicalBlock(scope: !325, file: !1, line: 191, column: 5)
!329 = !DILocation(line: 191, column: 19, scope: !328)
!330 = !DILocation(line: 191, column: 5, scope: !325)
!331 = !DILocation(line: 193, column: 20, scope: !332)
!332 = distinct !DILexicalBlock(scope: !328, file: !1, line: 191, column: 30)
!333 = !DILocation(line: 193, column: 16, scope: !332)
!334 = !DILocation(line: 193, column: 11, scope: !332)
!335 = !DILocation(line: 193, column: 9, scope: !332)
!336 = !DILocation(line: 193, column: 14, scope: !332)
!337 = !DILocation(line: 194, column: 5, scope: !332)
!338 = !DILocation(line: 191, column: 26, scope: !328)
!339 = !DILocation(line: 191, column: 5, scope: !328)
!340 = distinct !{!340, !330, !341, !70}
!341 = !DILocation(line: 194, column: 5, scope: !325)
!342 = !DILabel(scope: !251, name: "Reflection_coefficients_label3", file: !1, line: 196)
!343 = !DILocation(line: 196, column: 5, scope: !251)
!344 = !DILocation(line: 197, column: 12, scope: !345)
!345 = distinct !DILexicalBlock(scope: !251, file: !1, line: 197, column: 5)
!346 = !DILocation(line: 197, column: 10, scope: !345)
!347 = !DILocation(line: 197, column: 17, scope: !348)
!348 = distinct !DILexicalBlock(scope: !345, file: !1, line: 197, column: 5)
!349 = !DILocation(line: 197, column: 19, scope: !348)
!350 = !DILocation(line: 197, column: 5, scope: !345)
!351 = !DILocation(line: 199, column: 20, scope: !352)
!352 = distinct !DILexicalBlock(scope: !348, file: !1, line: 197, column: 30)
!353 = !DILocation(line: 199, column: 16, scope: !352)
!354 = !DILocation(line: 199, column: 11, scope: !352)
!355 = !DILocation(line: 199, column: 9, scope: !352)
!356 = !DILocation(line: 199, column: 14, scope: !352)
!357 = !DILocation(line: 200, column: 5, scope: !352)
!358 = !DILocation(line: 197, column: 26, scope: !348)
!359 = !DILocation(line: 197, column: 5, scope: !348)
!360 = distinct !{!360, !350, !361, !70}
!361 = !DILocation(line: 200, column: 5, scope: !345)
!362 = !DILabel(scope: !251, name: "Reflection_coefficients_label4", file: !1, line: 203)
!363 = !DILocation(line: 203, column: 5, scope: !251)
!364 = !DILocation(line: 204, column: 12, scope: !365)
!365 = distinct !DILexicalBlock(scope: !251, file: !1, line: 204, column: 5)
!366 = !DILocation(line: 204, column: 10, scope: !365)
!367 = !DILocation(line: 204, column: 17, scope: !368)
!368 = distinct !DILexicalBlock(scope: !365, file: !1, line: 204, column: 5)
!369 = !DILocation(line: 204, column: 19, scope: !368)
!370 = !DILocation(line: 204, column: 5, scope: !365)
!371 = !DILocation(line: 206, column: 16, scope: !372)
!372 = distinct !DILexicalBlock(scope: !368, file: !1, line: 204, column: 35)
!373 = !DILocation(line: 206, column: 14, scope: !372)
!374 = !DILocation(line: 207, column: 16, scope: !372)
!375 = !DILocation(line: 207, column: 14, scope: !372)
!376 = !DILocation(line: 208, column: 13, scope: !377)
!377 = distinct !DILexicalBlock(scope: !372, file: !1, line: 208, column: 13)
!378 = !DILocation(line: 208, column: 20, scope: !377)
!379 = !DILocation(line: 208, column: 18, scope: !377)
!380 = !DILocation(line: 208, column: 13, scope: !372)
!381 = !DILocation(line: 208, column: 26, scope: !377)
!382 = !DILabel(scope: !383, name: "Reflection_coefficients_label6", file: !1, line: 209)
!383 = distinct !DILexicalBlock(scope: !377, file: !1, line: 208, column: 26)
!384 = !DILocation(line: 209, column: 13, scope: !383)
!385 = !DILocation(line: 210, column: 22, scope: !386)
!386 = distinct !DILexicalBlock(scope: !383, file: !1, line: 210, column: 13)
!387 = !DILocation(line: 210, column: 20, scope: !386)
!388 = !DILocation(line: 210, column: 18, scope: !386)
!389 = !DILocation(line: 210, column: 25, scope: !390)
!390 = distinct !DILexicalBlock(scope: !386, file: !1, line: 210, column: 13)
!391 = !DILocation(line: 210, column: 27, scope: !390)
!392 = !DILocation(line: 210, column: 13, scope: !386)
!393 = !DILocation(line: 212, column: 19, scope: !394)
!394 = distinct !DILexicalBlock(scope: !390, file: !1, line: 210, column: 38)
!395 = !DILocation(line: 212, column: 22, scope: !394)
!396 = !DILocation(line: 213, column: 13, scope: !394)
!397 = !DILocation(line: 210, column: 34, scope: !390)
!398 = !DILocation(line: 210, column: 13, scope: !390)
!399 = distinct !{!399, !392, !400, !70}
!400 = !DILocation(line: 213, column: 13, scope: !386)
!401 = !DILocation(line: 214, column: 13, scope: !383)
!402 = !DILocation(line: 217, column: 22, scope: !372)
!403 = !DILocation(line: 217, column: 28, scope: !372)
!404 = !DILocation(line: 217, column: 14, scope: !372)
!405 = !DILocation(line: 217, column: 10, scope: !372)
!406 = !DILocation(line: 217, column: 12, scope: !372)
!407 = !DILocation(line: 219, column: 13, scope: !408)
!408 = distinct !DILexicalBlock(scope: !372, file: !1, line: 219, column: 13)
!409 = !DILocation(line: 219, column: 18, scope: !408)
!410 = !DILocation(line: 219, column: 13, scope: !372)
!411 = !DILocation(line: 220, column: 20, scope: !408)
!412 = !DILocation(line: 220, column: 19, scope: !408)
!413 = !DILocation(line: 220, column: 18, scope: !408)
!414 = !DILocation(line: 220, column: 14, scope: !408)
!415 = !DILocation(line: 220, column: 16, scope: !408)
!416 = !DILocation(line: 220, column: 13, scope: !408)
!417 = !DILocation(line: 221, column: 13, scope: !418)
!418 = distinct !DILexicalBlock(scope: !372, file: !1, line: 221, column: 13)
!419 = !DILocation(line: 221, column: 15, scope: !418)
!420 = !DILocation(line: 221, column: 13, scope: !372)
!421 = !DILocation(line: 222, column: 13, scope: !418)
!422 = !DILocation(line: 225, column: 16, scope: !372)
!423 = !DILocation(line: 225, column: 14, scope: !372)
!424 = !DILocation(line: 226, column: 16, scope: !372)
!425 = !DILocation(line: 226, column: 9, scope: !372)
!426 = !DILocation(line: 226, column: 14, scope: !372)
!427 = !DILabel(scope: !372, name: "Reflection_coefficients_label5", file: !1, line: 228)
!428 = !DILocation(line: 228, column: 9, scope: !372)
!429 = !DILocation(line: 229, column: 16, scope: !430)
!430 = distinct !DILexicalBlock(scope: !372, file: !1, line: 229, column: 9)
!431 = !DILocation(line: 229, column: 14, scope: !430)
!432 = !DILocation(line: 229, column: 21, scope: !433)
!433 = distinct !DILexicalBlock(scope: !430, file: !1, line: 229, column: 9)
!434 = !DILocation(line: 229, column: 30, scope: !433)
!435 = !DILocation(line: 229, column: 28, scope: !433)
!436 = !DILocation(line: 229, column: 23, scope: !433)
!437 = !DILocation(line: 229, column: 9, scope: !430)
!438 = !DILocation(line: 231, column: 20, scope: !439)
!439 = distinct !DILexicalBlock(scope: !433, file: !1, line: 229, column: 38)
!440 = !DILocation(line: 231, column: 18, scope: !439)
!441 = !DILocation(line: 232, column: 20, scope: !439)
!442 = !DILocation(line: 232, column: 15, scope: !439)
!443 = !DILocation(line: 232, column: 13, scope: !439)
!444 = !DILocation(line: 232, column: 18, scope: !439)
!445 = !DILocation(line: 234, column: 20, scope: !439)
!446 = !DILocation(line: 234, column: 18, scope: !439)
!447 = !DILocation(line: 235, column: 20, scope: !439)
!448 = !DILocation(line: 235, column: 15, scope: !439)
!449 = !DILocation(line: 235, column: 13, scope: !439)
!450 = !DILocation(line: 235, column: 18, scope: !439)
!451 = !DILocation(line: 236, column: 9, scope: !439)
!452 = !DILocation(line: 229, column: 34, scope: !433)
!453 = !DILocation(line: 229, column: 9, scope: !433)
!454 = distinct !{!454, !437, !455, !70}
!455 = !DILocation(line: 236, column: 9, scope: !430)
!456 = !DILocation(line: 237, column: 5, scope: !372)
!457 = !DILocation(line: 204, column: 26, scope: !368)
!458 = !DILocation(line: 204, column: 31, scope: !368)
!459 = !DILocation(line: 204, column: 5, scope: !368)
!460 = distinct !{!460, !370, !461, !70}
!461 = !DILocation(line: 237, column: 5, scope: !365)
!462 = !DILocation(line: 238, column: 1, scope: !251)
!463 = distinct !DISubprogram(name: "Transformation_to_Log_Area_Ratios", scope: !1, file: !1, line: 241, type: !464, scopeLine: 242, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!464 = !DISubroutineType(types: !465)
!465 = !{null, !17}
!466 = !DILocalVariable(name: "r", arg: 1, scope: !463, file: !1, line: 241, type: !17)
!467 = !DILocation(line: 241, column: 55, scope: !463)
!468 = !DILocalVariable(name: "temp", scope: !463, file: !1, line: 243, type: !18)
!469 = !DILocation(line: 243, column: 19, scope: !463)
!470 = !DILocalVariable(name: "i", scope: !463, file: !1, line: 244, type: !27)
!471 = !DILocation(line: 244, column: 18, scope: !463)
!472 = !DILocation(line: 244, column: 5, scope: !463)
!473 = !DILabel(scope: !463, name: "Transformation_to_Log_Area_Ratios_label0", file: !1, line: 247)
!474 = !DILocation(line: 247, column: 5, scope: !463)
!475 = !DILocation(line: 248, column: 12, scope: !476)
!476 = distinct !DILexicalBlock(scope: !463, file: !1, line: 248, column: 5)
!477 = !DILocation(line: 248, column: 10, scope: !476)
!478 = !DILocation(line: 248, column: 17, scope: !479)
!479 = distinct !DILexicalBlock(scope: !476, file: !1, line: 248, column: 5)
!480 = !DILocation(line: 248, column: 19, scope: !479)
!481 = !DILocation(line: 248, column: 5, scope: !476)
!482 = !DILocation(line: 250, column: 17, scope: !483)
!483 = distinct !DILexicalBlock(scope: !479, file: !1, line: 248, column: 35)
!484 = !DILocation(line: 250, column: 16, scope: !483)
!485 = !DILocation(line: 250, column: 14, scope: !483)
!486 = !DILocation(line: 251, column: 16, scope: !483)
!487 = !DILocation(line: 251, column: 14, scope: !483)
!488 = !DILocation(line: 253, column: 13, scope: !489)
!489 = distinct !DILexicalBlock(scope: !483, file: !1, line: 253, column: 13)
!490 = !DILocation(line: 253, column: 18, scope: !489)
!491 = !DILocation(line: 253, column: 13, scope: !483)
!492 = !DILocation(line: 254, column: 18, scope: !493)
!493 = distinct !DILexicalBlock(scope: !489, file: !1, line: 253, column: 27)
!494 = !DILocation(line: 255, column: 9, scope: !493)
!495 = !DILocation(line: 255, column: 20, scope: !496)
!496 = distinct !DILexicalBlock(scope: !489, file: !1, line: 255, column: 20)
!497 = !DILocation(line: 255, column: 25, scope: !496)
!498 = !DILocation(line: 255, column: 20, scope: !489)
!499 = !DILocation(line: 256, column: 18, scope: !500)
!500 = distinct !DILexicalBlock(scope: !496, file: !1, line: 255, column: 34)
!501 = !DILocation(line: 257, column: 9, scope: !500)
!502 = !DILocation(line: 258, column: 18, scope: !503)
!503 = distinct !DILexicalBlock(scope: !496, file: !1, line: 257, column: 16)
!504 = !DILocation(line: 259, column: 18, scope: !503)
!505 = !DILocation(line: 262, column: 15, scope: !483)
!506 = !DILocation(line: 262, column: 14, scope: !483)
!507 = !DILocation(line: 262, column: 17, scope: !483)
!508 = !DILocation(line: 262, column: 24, scope: !483)
!509 = !DILocation(line: 262, column: 23, scope: !483)
!510 = !DILocation(line: 262, column: 31, scope: !483)
!511 = !DILocation(line: 262, column: 10, scope: !483)
!512 = !DILocation(line: 262, column: 12, scope: !483)
!513 = !DILocation(line: 263, column: 5, scope: !483)
!514 = !DILocation(line: 248, column: 26, scope: !479)
!515 = !DILocation(line: 248, column: 31, scope: !479)
!516 = !DILocation(line: 248, column: 5, scope: !479)
!517 = distinct !{!517, !481, !518, !70}
!518 = !DILocation(line: 263, column: 5, scope: !476)
!519 = !DILocation(line: 264, column: 1, scope: !463)
!520 = distinct !DISubprogram(name: "Quantization_and_coding", scope: !1, file: !1, line: 267, type: !464, scopeLine: 268, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!521 = !DILocalVariable(name: "LAR", arg: 1, scope: !520, file: !1, line: 267, type: !17)
!522 = !DILocation(line: 267, column: 45, scope: !520)
!523 = !DILocalVariable(name: "temp", scope: !520, file: !1, line: 269, type: !18)
!524 = !DILocation(line: 269, column: 19, scope: !520)
!525 = !DILocation(line: 289, column: 5, scope: !520)
!526 = !DILocation(line: 290, column: 5, scope: !520)
!527 = !DILocation(line: 291, column: 5, scope: !520)
!528 = !DILocation(line: 292, column: 5, scope: !520)
!529 = !DILocation(line: 294, column: 5, scope: !520)
!530 = !DILocation(line: 295, column: 5, scope: !520)
!531 = !DILocation(line: 296, column: 5, scope: !520)
!532 = !DILocation(line: 297, column: 5, scope: !520)
!533 = !DILocation(line: 300, column: 1, scope: !520)
