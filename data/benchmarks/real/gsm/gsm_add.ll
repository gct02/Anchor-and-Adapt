; ModuleID = 'data/benchmarks/real/gsm/gsm_add.c'
source_filename = "data/benchmarks/real/gsm/gsm_add.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@__const.gsm_norm.bitoff = private unnamed_addr constant <{ [128 x i8], [128 x i8] }> <{ [128 x i8] c"\08\07\06\06\05\05\05\05\04\04\04\04\04\04\04\04\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01", [128 x i8] zeroinitializer }>, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_add(i16 noundef signext %a, i16 noundef signext %b) #0 !dbg !14 {
entry:
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  %sum = alloca i64, align 8
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !22, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i64* %sum, metadata !24, metadata !DIExpression()), !dbg !25
  %0 = load i16, i16* %a.addr, align 2, !dbg !26
  %conv = sext i16 %0 to i64, !dbg !27
  %1 = load i16, i16* %b.addr, align 2, !dbg !28
  %conv1 = sext i16 %1 to i64, !dbg !29
  %add = add nsw i64 %conv, %conv1, !dbg !30
  store i64 %add, i64* %sum, align 8, !dbg !31
  %2 = load i64, i64* %sum, align 8, !dbg !32
  %cmp = icmp slt i64 %2, -32768, !dbg !32
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !32

cond.true:                                        ; preds = %entry
  br label %cond.end7, !dbg !32

cond.false:                                       ; preds = %entry
  %3 = load i64, i64* %sum, align 8, !dbg !32
  %cmp3 = icmp sgt i64 %3, 32767, !dbg !32
  br i1 %cmp3, label %cond.true5, label %cond.false6, !dbg !32

cond.true5:                                       ; preds = %cond.false
  br label %cond.end, !dbg !32

cond.false6:                                      ; preds = %cond.false
  %4 = load i64, i64* %sum, align 8, !dbg !32
  br label %cond.end, !dbg !32

cond.end:                                         ; preds = %cond.false6, %cond.true5
  %cond = phi i64 [ 32767, %cond.true5 ], [ %4, %cond.false6 ], !dbg !32
  br label %cond.end7, !dbg !32

cond.end7:                                        ; preds = %cond.end, %cond.true
  %cond8 = phi i64 [ -32768, %cond.true ], [ %cond, %cond.end ], !dbg !32
  %conv9 = trunc i64 %cond8 to i16, !dbg !32
  ret i16 %conv9, !dbg !33
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_mult(i16 noundef signext %a, i16 noundef signext %b) #0 !dbg !34 {
entry:
  %retval = alloca i16, align 2
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !35, metadata !DIExpression()), !dbg !36
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !37, metadata !DIExpression()), !dbg !38
  %0 = load i16, i16* %a.addr, align 2, !dbg !39
  %conv = sext i16 %0 to i32, !dbg !39
  %cmp = icmp eq i32 %conv, -32768, !dbg !41
  br i1 %cmp, label %land.lhs.true, label %if.else, !dbg !42

land.lhs.true:                                    ; preds = %entry
  %1 = load i16, i16* %b.addr, align 2, !dbg !43
  %conv2 = sext i16 %1 to i32, !dbg !43
  %cmp3 = icmp eq i32 %conv2, -32768, !dbg !44
  br i1 %cmp3, label %if.then, label %if.else, !dbg !45

if.then:                                          ; preds = %land.lhs.true
  store i16 32767, i16* %retval, align 2, !dbg !46
  br label %return, !dbg !46

if.else:                                          ; preds = %land.lhs.true, %entry
  %2 = load i16, i16* %a.addr, align 2, !dbg !47
  %conv5 = sext i16 %2 to i64, !dbg !47
  %3 = load i16, i16* %b.addr, align 2, !dbg !47
  %conv6 = sext i16 %3 to i64, !dbg !47
  %mul = mul nsw i64 %conv5, %conv6, !dbg !47
  %shr = ashr i64 %mul, 15, !dbg !47
  %conv7 = trunc i64 %shr to i16, !dbg !47
  store i16 %conv7, i16* %retval, align 2, !dbg !48
  br label %return, !dbg !48

return:                                           ; preds = %if.else, %if.then
  %4 = load i16, i16* %retval, align 2, !dbg !49
  ret i16 %4, !dbg !49
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_mult_r(i16 noundef signext %a, i16 noundef signext %b) #0 !dbg !50 {
entry:
  %retval = alloca i16, align 2
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  %prod = alloca i64, align 8
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !51, metadata !DIExpression()), !dbg !52
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !53, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.declare(metadata i64* %prod, metadata !55, metadata !DIExpression()), !dbg !56
  %0 = load i16, i16* %b.addr, align 2, !dbg !57
  %conv = sext i16 %0 to i32, !dbg !57
  %cmp = icmp eq i32 %conv, -32768, !dbg !59
  br i1 %cmp, label %land.lhs.true, label %if.else, !dbg !60

land.lhs.true:                                    ; preds = %entry
  %1 = load i16, i16* %a.addr, align 2, !dbg !61
  %conv2 = sext i16 %1 to i32, !dbg !61
  %cmp3 = icmp eq i32 %conv2, -32768, !dbg !62
  br i1 %cmp3, label %if.then, label %if.else, !dbg !63

if.then:                                          ; preds = %land.lhs.true
  store i16 32767, i16* %retval, align 2, !dbg !64
  br label %return, !dbg !64

if.else:                                          ; preds = %land.lhs.true, %entry
  %2 = load i16, i16* %a.addr, align 2, !dbg !65
  %conv5 = sext i16 %2 to i64, !dbg !67
  %3 = load i16, i16* %b.addr, align 2, !dbg !68
  %conv6 = sext i16 %3 to i64, !dbg !69
  %mul = mul nsw i64 %conv5, %conv6, !dbg !70
  %add = add nsw i64 %mul, 16384, !dbg !71
  store i64 %add, i64* %prod, align 8, !dbg !72
  %4 = load i64, i64* %prod, align 8, !dbg !73
  %shr = ashr i64 %4, 15, !dbg !73
  store i64 %shr, i64* %prod, align 8, !dbg !73
  %5 = load i64, i64* %prod, align 8, !dbg !74
  %and = and i64 %5, 65535, !dbg !75
  %conv7 = trunc i64 %and to i16, !dbg !74
  store i16 %conv7, i16* %retval, align 2, !dbg !76
  br label %return, !dbg !76

return:                                           ; preds = %if.else, %if.then
  %6 = load i16, i16* %retval, align 2, !dbg !77
  ret i16 %6, !dbg !77
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_abs(i16 noundef signext %a) #0 !dbg !78 {
entry:
  %a.addr = alloca i16, align 2
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !81, metadata !DIExpression()), !dbg !82
  %0 = load i16, i16* %a.addr, align 2, !dbg !83
  %conv = sext i16 %0 to i32, !dbg !83
  %cmp = icmp slt i32 %conv, 0, !dbg !84
  br i1 %cmp, label %cond.true, label %cond.false7, !dbg !83

cond.true:                                        ; preds = %entry
  %1 = load i16, i16* %a.addr, align 2, !dbg !85
  %conv2 = sext i16 %1 to i32, !dbg !85
  %cmp3 = icmp eq i32 %conv2, -32768, !dbg !86
  br i1 %cmp3, label %cond.true5, label %cond.false, !dbg !85

cond.true5:                                       ; preds = %cond.true
  br label %cond.end, !dbg !85

cond.false:                                       ; preds = %cond.true
  %2 = load i16, i16* %a.addr, align 2, !dbg !87
  %conv6 = sext i16 %2 to i32, !dbg !87
  %sub = sub nsw i32 0, %conv6, !dbg !88
  br label %cond.end, !dbg !85

cond.end:                                         ; preds = %cond.false, %cond.true5
  %cond = phi i32 [ 32767, %cond.true5 ], [ %sub, %cond.false ], !dbg !85
  br label %cond.end9, !dbg !83

cond.false7:                                      ; preds = %entry
  %3 = load i16, i16* %a.addr, align 2, !dbg !89
  %conv8 = sext i16 %3 to i32, !dbg !89
  br label %cond.end9, !dbg !83

cond.end9:                                        ; preds = %cond.false7, %cond.end
  %cond10 = phi i32 [ %cond, %cond.end ], [ %conv8, %cond.false7 ], !dbg !83
  %conv11 = trunc i32 %cond10 to i16, !dbg !83
  ret i16 %conv11, !dbg !90
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_norm(i64 noundef %a) #0 !dbg !91 {
entry:
  %retval = alloca i16, align 2
  %a.addr = alloca i64, align 8
  %bitoff = alloca [256 x i8], align 16
  store i64 %a, i64* %a.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %a.addr, metadata !94, metadata !DIExpression()), !dbg !95
  call void @llvm.dbg.declare(metadata [256 x i8]* %bitoff, metadata !96, metadata !DIExpression()), !dbg !102
  %0 = bitcast [256 x i8]* %bitoff to i8*, !dbg !102
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 getelementptr inbounds (<{ [128 x i8], [128 x i8] }>, <{ [128 x i8], [128 x i8] }>* @__const.gsm_norm.bitoff, i32 0, i32 0, i32 0), i64 256, i1 false), !dbg !102
  %1 = load i64, i64* %a.addr, align 8, !dbg !103
  %cmp = icmp slt i64 %1, 0, !dbg !105
  br i1 %cmp, label %if.then, label %if.end3, !dbg !106

if.then:                                          ; preds = %entry
  %2 = load i64, i64* %a.addr, align 8, !dbg !107
  %cmp1 = icmp sle i64 %2, -1073741824, !dbg !110
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !111

if.then2:                                         ; preds = %if.then
  store i16 0, i16* %retval, align 2, !dbg !112
  br label %return, !dbg !112

if.end:                                           ; preds = %if.then
  %3 = load i64, i64* %a.addr, align 8, !dbg !113
  %neg = xor i64 %3, -1, !dbg !114
  store i64 %neg, i64* %a.addr, align 8, !dbg !115
  br label %if.end3, !dbg !116

if.end3:                                          ; preds = %if.end, %entry
  %4 = load i64, i64* %a.addr, align 8, !dbg !117
  %and = and i64 %4, 4294901760, !dbg !118
  %tobool = icmp ne i64 %and, 0, !dbg !118
  br i1 %tobool, label %cond.true, label %cond.false13, !dbg !117

cond.true:                                        ; preds = %if.end3
  %5 = load i64, i64* %a.addr, align 8, !dbg !119
  %and4 = and i64 %5, 4278190080, !dbg !120
  %tobool5 = icmp ne i64 %and4, 0, !dbg !120
  br i1 %tobool5, label %cond.true6, label %cond.false, !dbg !119

cond.true6:                                       ; preds = %cond.true
  %6 = load i64, i64* %a.addr, align 8, !dbg !121
  %shr = ashr i64 %6, 24, !dbg !122
  %and7 = and i64 255, %shr, !dbg !123
  %arrayidx = getelementptr inbounds [256 x i8], [256 x i8]* %bitoff, i64 0, i64 %and7, !dbg !124
  %7 = load i8, i8* %arrayidx, align 1, !dbg !124
  %conv = zext i8 %7 to i32, !dbg !124
  %add = add nsw i32 -1, %conv, !dbg !125
  br label %cond.end, !dbg !119

cond.false:                                       ; preds = %cond.true
  %8 = load i64, i64* %a.addr, align 8, !dbg !126
  %shr8 = ashr i64 %8, 16, !dbg !127
  %and9 = and i64 255, %shr8, !dbg !128
  %arrayidx10 = getelementptr inbounds [256 x i8], [256 x i8]* %bitoff, i64 0, i64 %and9, !dbg !129
  %9 = load i8, i8* %arrayidx10, align 1, !dbg !129
  %conv11 = zext i8 %9 to i32, !dbg !129
  %add12 = add nsw i32 7, %conv11, !dbg !130
  br label %cond.end, !dbg !119

cond.end:                                         ; preds = %cond.false, %cond.true6
  %cond = phi i32 [ %add, %cond.true6 ], [ %add12, %cond.false ], !dbg !119
  br label %cond.end29, !dbg !117

cond.false13:                                     ; preds = %if.end3
  %10 = load i64, i64* %a.addr, align 8, !dbg !131
  %and14 = and i64 %10, 65280, !dbg !132
  %tobool15 = icmp ne i64 %and14, 0, !dbg !132
  br i1 %tobool15, label %cond.true16, label %cond.false22, !dbg !131

cond.true16:                                      ; preds = %cond.false13
  %11 = load i64, i64* %a.addr, align 8, !dbg !133
  %shr17 = ashr i64 %11, 8, !dbg !134
  %and18 = and i64 255, %shr17, !dbg !135
  %arrayidx19 = getelementptr inbounds [256 x i8], [256 x i8]* %bitoff, i64 0, i64 %and18, !dbg !136
  %12 = load i8, i8* %arrayidx19, align 1, !dbg !136
  %conv20 = zext i8 %12 to i32, !dbg !136
  %add21 = add nsw i32 15, %conv20, !dbg !137
  br label %cond.end27, !dbg !131

cond.false22:                                     ; preds = %cond.false13
  %13 = load i64, i64* %a.addr, align 8, !dbg !138
  %and23 = and i64 255, %13, !dbg !139
  %arrayidx24 = getelementptr inbounds [256 x i8], [256 x i8]* %bitoff, i64 0, i64 %and23, !dbg !140
  %14 = load i8, i8* %arrayidx24, align 1, !dbg !140
  %conv25 = zext i8 %14 to i32, !dbg !140
  %add26 = add nsw i32 23, %conv25, !dbg !141
  br label %cond.end27, !dbg !131

cond.end27:                                       ; preds = %cond.false22, %cond.true16
  %cond28 = phi i32 [ %add21, %cond.true16 ], [ %add26, %cond.false22 ], !dbg !131
  br label %cond.end29, !dbg !117

cond.end29:                                       ; preds = %cond.end27, %cond.end
  %cond30 = phi i32 [ %cond, %cond.end ], [ %cond28, %cond.end27 ], !dbg !117
  %conv31 = trunc i32 %cond30 to i16, !dbg !117
  store i16 %conv31, i16* %retval, align 2, !dbg !142
  br label %return, !dbg !142

return:                                           ; preds = %cond.end29, %if.then2
  %15 = load i16, i16* %retval, align 2, !dbg !143
  ret i16 %15, !dbg !143
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_div(i16 noundef signext %num, i16 noundef signext %denum) #0 !dbg !144 {
entry:
  %retval = alloca i16, align 2
  %num.addr = alloca i16, align 2
  %denum.addr = alloca i16, align 2
  %L_num = alloca i64, align 8
  %L_denum = alloca i64, align 8
  %div = alloca i16, align 2
  %k = alloca i32, align 4
  store i16 %num, i16* %num.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %num.addr, metadata !145, metadata !DIExpression()), !dbg !146
  store i16 %denum, i16* %denum.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %denum.addr, metadata !147, metadata !DIExpression()), !dbg !148
  call void @llvm.dbg.declare(metadata i64* %L_num, metadata !149, metadata !DIExpression()), !dbg !150
  call void @llvm.dbg.declare(metadata i64* %L_denum, metadata !151, metadata !DIExpression()), !dbg !152
  call void @llvm.dbg.declare(metadata i16* %div, metadata !153, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.declare(metadata i32* %k, metadata !155, metadata !DIExpression()), !dbg !157
  %0 = load i16, i16* %num.addr, align 2, !dbg !158
  %conv = sext i16 %0 to i64, !dbg !158
  store i64 %conv, i64* %L_num, align 8, !dbg !159
  %1 = load i16, i16* %denum.addr, align 2, !dbg !160
  %conv1 = sext i16 %1 to i64, !dbg !160
  store i64 %conv1, i64* %L_denum, align 8, !dbg !161
  store i16 0, i16* %div, align 2, !dbg !162
  store i32 15, i32* %k, align 4, !dbg !163
  %2 = load i16, i16* %num.addr, align 2, !dbg !164
  %conv2 = sext i16 %2 to i32, !dbg !164
  %cmp = icmp eq i32 %conv2, 0, !dbg !166
  br i1 %cmp, label %if.then, label %if.end, !dbg !167

if.then:                                          ; preds = %entry
  store i16 0, i16* %retval, align 2, !dbg !168
  br label %return, !dbg !168

if.end:                                           ; preds = %entry
  br label %gsm_div_label0, !dbg !169

gsm_div_label0:                                   ; preds = %if.end
  call void @llvm.dbg.label(metadata !170), !dbg !171
  br label %while.cond, !dbg !172

while.cond:                                       ; preds = %if.end10, %gsm_div_label0
  %3 = load i32, i32* %k, align 4, !dbg !173
  %dec = add nsw i32 %3, -1, !dbg !173
  store i32 %dec, i32* %k, align 4, !dbg !173
  %tobool = icmp ne i32 %3, 0, !dbg !172
  br i1 %tobool, label %while.body, label %while.end, !dbg !172

while.body:                                       ; preds = %while.cond
  %4 = load i16, i16* %div, align 2, !dbg !174
  %conv4 = sext i16 %4 to i32, !dbg !174
  %shl = shl i32 %conv4, 1, !dbg !174
  %conv5 = trunc i32 %shl to i16, !dbg !174
  store i16 %conv5, i16* %div, align 2, !dbg !174
  %5 = load i64, i64* %L_num, align 8, !dbg !176
  %shl6 = shl i64 %5, 1, !dbg !176
  store i64 %shl6, i64* %L_num, align 8, !dbg !176
  %6 = load i64, i64* %L_num, align 8, !dbg !177
  %7 = load i64, i64* %L_denum, align 8, !dbg !179
  %cmp7 = icmp sge i64 %6, %7, !dbg !180
  br i1 %cmp7, label %if.then9, label %if.end10, !dbg !181

if.then9:                                         ; preds = %while.body
  %8 = load i64, i64* %L_denum, align 8, !dbg !182
  %9 = load i64, i64* %L_num, align 8, !dbg !184
  %sub = sub nsw i64 %9, %8, !dbg !184
  store i64 %sub, i64* %L_num, align 8, !dbg !184
  %10 = load i16, i16* %div, align 2, !dbg !185
  %inc = add i16 %10, 1, !dbg !185
  store i16 %inc, i16* %div, align 2, !dbg !185
  br label %if.end10, !dbg !186

if.end10:                                         ; preds = %if.then9, %while.body
  br label %while.cond, !dbg !172, !llvm.loop !187

while.end:                                        ; preds = %while.cond
  %11 = load i16, i16* %div, align 2, !dbg !190
  store i16 %11, i16* %retval, align 2, !dbg !191
  br label %return, !dbg !191

return:                                           ; preds = %while.end, %if.then
  %12 = load i16, i16* %retval, align 2, !dbg !192
  ret i16 %12, !dbg !192
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nofree nounwind willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8, !9, !10, !11, !12}
!llvm.ident = !{!13}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "data/benchmarks/real/gsm/gsm_add.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "203474295b4ff57c36bb810505beeb6a")
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
!14 = distinct !DISubprogram(name: "gsm_add", scope: !1, file: !1, line: 36, type: !15, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !19)
!15 = !DISubroutineType(types: !16)
!16 = !{!17, !17, !17}
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "word", file: !4, line: 30, baseType: !18)
!18 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!19 = !{}
!20 = !DILocalVariable(name: "a", arg: 1, scope: !14, file: !1, line: 36, type: !17)
!21 = !DILocation(line: 36, column: 19, scope: !14)
!22 = !DILocalVariable(name: "b", arg: 2, scope: !14, file: !1, line: 36, type: !17)
!23 = !DILocation(line: 36, column: 27, scope: !14)
!24 = !DILocalVariable(name: "sum", scope: !14, file: !1, line: 38, type: !3)
!25 = !DILocation(line: 38, column: 14, scope: !14)
!26 = !DILocation(line: 39, column: 22, scope: !14)
!27 = !DILocation(line: 39, column: 11, scope: !14)
!28 = !DILocation(line: 39, column: 37, scope: !14)
!29 = !DILocation(line: 39, column: 26, scope: !14)
!30 = !DILocation(line: 39, column: 24, scope: !14)
!31 = !DILocation(line: 39, column: 9, scope: !14)
!32 = !DILocation(line: 40, column: 12, scope: !14)
!33 = !DILocation(line: 40, column: 5, scope: !14)
!34 = distinct !DISubprogram(name: "gsm_mult", scope: !1, file: !1, line: 43, type: !15, scopeLine: 44, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !19)
!35 = !DILocalVariable(name: "a", arg: 1, scope: !34, file: !1, line: 43, type: !17)
!36 = !DILocation(line: 43, column: 20, scope: !34)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !34, file: !1, line: 43, type: !17)
!38 = !DILocation(line: 43, column: 28, scope: !34)
!39 = !DILocation(line: 45, column: 9, scope: !40)
!40 = distinct !DILexicalBlock(scope: !34, file: !1, line: 45, column: 9)
!41 = !DILocation(line: 45, column: 11, scope: !40)
!42 = !DILocation(line: 45, column: 23, scope: !40)
!43 = !DILocation(line: 45, column: 26, scope: !40)
!44 = !DILocation(line: 45, column: 28, scope: !40)
!45 = !DILocation(line: 45, column: 9, scope: !34)
!46 = !DILocation(line: 46, column: 9, scope: !40)
!47 = !DILocation(line: 48, column: 16, scope: !40)
!48 = !DILocation(line: 48, column: 9, scope: !40)
!49 = !DILocation(line: 49, column: 1, scope: !34)
!50 = distinct !DISubprogram(name: "gsm_mult_r", scope: !1, file: !1, line: 51, type: !15, scopeLine: 52, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !19)
!51 = !DILocalVariable(name: "a", arg: 1, scope: !50, file: !1, line: 51, type: !17)
!52 = !DILocation(line: 51, column: 22, scope: !50)
!53 = !DILocalVariable(name: "b", arg: 2, scope: !50, file: !1, line: 51, type: !17)
!54 = !DILocation(line: 51, column: 30, scope: !50)
!55 = !DILocalVariable(name: "prod", scope: !50, file: !1, line: 53, type: !3)
!56 = !DILocation(line: 53, column: 14, scope: !50)
!57 = !DILocation(line: 55, column: 9, scope: !58)
!58 = distinct !DILexicalBlock(scope: !50, file: !1, line: 55, column: 9)
!59 = !DILocation(line: 55, column: 11, scope: !58)
!60 = !DILocation(line: 55, column: 23, scope: !58)
!61 = !DILocation(line: 55, column: 26, scope: !58)
!62 = !DILocation(line: 55, column: 28, scope: !58)
!63 = !DILocation(line: 55, column: 9, scope: !50)
!64 = !DILocation(line: 56, column: 9, scope: !58)
!65 = !DILocation(line: 59, column: 27, scope: !66)
!66 = distinct !DILexicalBlock(scope: !58, file: !1, line: 58, column: 5)
!67 = !DILocation(line: 59, column: 16, scope: !66)
!68 = !DILocation(line: 59, column: 42, scope: !66)
!69 = !DILocation(line: 59, column: 31, scope: !66)
!70 = !DILocation(line: 59, column: 29, scope: !66)
!71 = !DILocation(line: 59, column: 44, scope: !66)
!72 = !DILocation(line: 59, column: 14, scope: !66)
!73 = !DILocation(line: 60, column: 14, scope: !66)
!74 = !DILocation(line: 61, column: 16, scope: !66)
!75 = !DILocation(line: 61, column: 21, scope: !66)
!76 = !DILocation(line: 61, column: 9, scope: !66)
!77 = !DILocation(line: 63, column: 1, scope: !50)
!78 = distinct !DISubprogram(name: "gsm_abs", scope: !1, file: !1, line: 65, type: !79, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !19)
!79 = !DISubroutineType(types: !80)
!80 = !{!17, !17}
!81 = !DILocalVariable(name: "a", arg: 1, scope: !78, file: !1, line: 65, type: !17)
!82 = !DILocation(line: 65, column: 19, scope: !78)
!83 = !DILocation(line: 67, column: 12, scope: !78)
!84 = !DILocation(line: 67, column: 14, scope: !78)
!85 = !DILocation(line: 67, column: 21, scope: !78)
!86 = !DILocation(line: 67, column: 23, scope: !78)
!87 = !DILocation(line: 67, column: 49, scope: !78)
!88 = !DILocation(line: 67, column: 48, scope: !78)
!89 = !DILocation(line: 67, column: 54, scope: !78)
!90 = !DILocation(line: 67, column: 5, scope: !78)
!91 = distinct !DISubprogram(name: "gsm_norm", scope: !1, file: !1, line: 70, type: !92, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !19)
!92 = !DISubroutineType(types: !93)
!93 = !{!17, !3}
!94 = !DILocalVariable(name: "a", arg: 1, scope: !91, file: !1, line: 70, type: !3)
!95 = !DILocation(line: 70, column: 24, scope: !91)
!96 = !DILocalVariable(name: "bitoff", scope: !91, file: !1, line: 72, type: !97)
!97 = !DICompositeType(tag: DW_TAG_array_type, baseType: !98, size: 2048, elements: !100)
!98 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !99)
!99 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!100 = !{!101}
!101 = !DISubrange(count: 256)
!102 = !DILocation(line: 72, column: 25, scope: !91)
!103 = !DILocation(line: 105, column: 9, scope: !104)
!104 = distinct !DILexicalBlock(scope: !91, file: !1, line: 105, column: 9)
!105 = !DILocation(line: 105, column: 11, scope: !104)
!106 = !DILocation(line: 105, column: 9, scope: !91)
!107 = !DILocation(line: 107, column: 13, scope: !108)
!108 = distinct !DILexicalBlock(scope: !109, file: !1, line: 107, column: 13)
!109 = distinct !DILexicalBlock(scope: !104, file: !1, line: 106, column: 5)
!110 = !DILocation(line: 107, column: 15, scope: !108)
!111 = !DILocation(line: 107, column: 13, scope: !109)
!112 = !DILocation(line: 108, column: 13, scope: !108)
!113 = !DILocation(line: 109, column: 14, scope: !109)
!114 = !DILocation(line: 109, column: 13, scope: !109)
!115 = !DILocation(line: 109, column: 11, scope: !109)
!116 = !DILocation(line: 110, column: 5, scope: !109)
!117 = !DILocation(line: 112, column: 12, scope: !91)
!118 = !DILocation(line: 112, column: 14, scope: !91)
!119 = !DILocation(line: 113, column: 10, scope: !91)
!120 = !DILocation(line: 113, column: 12, scope: !91)
!121 = !DILocation(line: 113, column: 47, scope: !91)
!122 = !DILocation(line: 113, column: 49, scope: !91)
!123 = !DILocation(line: 113, column: 44, scope: !91)
!124 = !DILocation(line: 113, column: 32, scope: !91)
!125 = !DILocation(line: 113, column: 30, scope: !91)
!126 = !DILocation(line: 114, column: 29, scope: !91)
!127 = !DILocation(line: 114, column: 31, scope: !91)
!128 = !DILocation(line: 114, column: 26, scope: !91)
!129 = !DILocation(line: 114, column: 14, scope: !91)
!130 = !DILocation(line: 114, column: 12, scope: !91)
!131 = !DILocation(line: 115, column: 12, scope: !91)
!132 = !DILocation(line: 115, column: 14, scope: !91)
!133 = !DILocation(line: 115, column: 45, scope: !91)
!134 = !DILocation(line: 115, column: 47, scope: !91)
!135 = !DILocation(line: 115, column: 42, scope: !91)
!136 = !DILocation(line: 115, column: 30, scope: !91)
!137 = !DILocation(line: 115, column: 28, scope: !91)
!138 = !DILocation(line: 115, column: 75, scope: !91)
!139 = !DILocation(line: 115, column: 73, scope: !91)
!140 = !DILocation(line: 115, column: 61, scope: !91)
!141 = !DILocation(line: 115, column: 59, scope: !91)
!142 = !DILocation(line: 112, column: 5, scope: !91)
!143 = !DILocation(line: 116, column: 1, scope: !91)
!144 = distinct !DISubprogram(name: "gsm_div", scope: !1, file: !1, line: 118, type: !15, scopeLine: 119, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !19)
!145 = !DILocalVariable(name: "num", arg: 1, scope: !144, file: !1, line: 118, type: !17)
!146 = !DILocation(line: 118, column: 19, scope: !144)
!147 = !DILocalVariable(name: "denum", arg: 2, scope: !144, file: !1, line: 118, type: !17)
!148 = !DILocation(line: 118, column: 29, scope: !144)
!149 = !DILocalVariable(name: "L_num", scope: !144, file: !1, line: 120, type: !3)
!150 = !DILocation(line: 120, column: 14, scope: !144)
!151 = !DILocalVariable(name: "L_denum", scope: !144, file: !1, line: 121, type: !3)
!152 = !DILocation(line: 121, column: 14, scope: !144)
!153 = !DILocalVariable(name: "div", scope: !144, file: !1, line: 122, type: !17)
!154 = !DILocation(line: 122, column: 10, scope: !144)
!155 = !DILocalVariable(name: "k", scope: !144, file: !1, line: 123, type: !156)
!156 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!157 = !DILocation(line: 123, column: 9, scope: !144)
!158 = !DILocation(line: 125, column: 13, scope: !144)
!159 = !DILocation(line: 125, column: 11, scope: !144)
!160 = !DILocation(line: 126, column: 15, scope: !144)
!161 = !DILocation(line: 126, column: 13, scope: !144)
!162 = !DILocation(line: 127, column: 9, scope: !144)
!163 = !DILocation(line: 128, column: 7, scope: !144)
!164 = !DILocation(line: 134, column: 9, scope: !165)
!165 = distinct !DILexicalBlock(scope: !144, file: !1, line: 134, column: 9)
!166 = !DILocation(line: 134, column: 13, scope: !165)
!167 = !DILocation(line: 134, column: 9, scope: !144)
!168 = !DILocation(line: 135, column: 9, scope: !165)
!169 = !DILocation(line: 134, column: 16, scope: !165)
!170 = !DILabel(scope: !144, name: "gsm_div_label0", file: !1, line: 137)
!171 = !DILocation(line: 137, column: 5, scope: !144)
!172 = !DILocation(line: 138, column: 5, scope: !144)
!173 = !DILocation(line: 138, column: 13, scope: !144)
!174 = !DILocation(line: 141, column: 13, scope: !175)
!175 = distinct !DILexicalBlock(scope: !144, file: !1, line: 139, column: 5)
!176 = !DILocation(line: 142, column: 15, scope: !175)
!177 = !DILocation(line: 144, column: 13, scope: !178)
!178 = distinct !DILexicalBlock(scope: !175, file: !1, line: 144, column: 13)
!179 = !DILocation(line: 144, column: 22, scope: !178)
!180 = !DILocation(line: 144, column: 19, scope: !178)
!181 = !DILocation(line: 144, column: 13, scope: !175)
!182 = !DILocation(line: 146, column: 22, scope: !183)
!183 = distinct !DILexicalBlock(scope: !178, file: !1, line: 145, column: 9)
!184 = !DILocation(line: 146, column: 19, scope: !183)
!185 = !DILocation(line: 147, column: 16, scope: !183)
!186 = !DILocation(line: 148, column: 9, scope: !183)
!187 = distinct !{!187, !172, !188, !189}
!188 = !DILocation(line: 149, column: 5, scope: !144)
!189 = !{!"llvm.loop.mustprogress"}
!190 = !DILocation(line: 151, column: 12, scope: !144)
!191 = !DILocation(line: 151, column: 5, scope: !144)
!192 = !DILocation(line: 152, column: 1, scope: !144)
