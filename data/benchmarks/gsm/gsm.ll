; ModuleID = 'data/benchmarks/real/gsm/gsm.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@__const.gsm_norm.bitoff = private unnamed_addr constant <{ [128 x i8], [128 x i8] }> <{ [128 x i8] c"\08\07\06\06\05\05\05\05\04\04\04\04\04\04\04\04\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01", [128 x i8] zeroinitializer }>, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_add(i16 noundef signext %a, i16 noundef signext %b) #0 !dbg !18 {
entry:
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  %sum = alloca i64, align 8
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !26, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.declare(metadata i64* %sum, metadata !28, metadata !DIExpression()), !dbg !29
  %0 = load i16, i16* %a.addr, align 2, !dbg !30
  %conv = sext i16 %0 to i64, !dbg !31
  %1 = load i16, i16* %b.addr, align 2, !dbg !32
  %conv1 = sext i16 %1 to i64, !dbg !33
  %add = add nsw i64 %conv, %conv1, !dbg !34
  store i64 %add, i64* %sum, align 8, !dbg !35
  %2 = load i64, i64* %sum, align 8, !dbg !36
  %cmp = icmp slt i64 %2, -32768, !dbg !36
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !36

cond.true:                                        ; preds = %entry
  br label %cond.end7, !dbg !36

cond.false:                                       ; preds = %entry
  %3 = load i64, i64* %sum, align 8, !dbg !36
  %cmp3 = icmp sgt i64 %3, 32767, !dbg !36
  br i1 %cmp3, label %cond.true5, label %cond.false6, !dbg !36

cond.true5:                                       ; preds = %cond.false
  br label %cond.end, !dbg !36

cond.false6:                                      ; preds = %cond.false
  %4 = load i64, i64* %sum, align 8, !dbg !36
  br label %cond.end, !dbg !36

cond.end:                                         ; preds = %cond.false6, %cond.true5
  %cond = phi i64 [ 32767, %cond.true5 ], [ %4, %cond.false6 ], !dbg !36
  br label %cond.end7, !dbg !36

cond.end7:                                        ; preds = %cond.end, %cond.true
  %cond8 = phi i64 [ -32768, %cond.true ], [ %cond, %cond.end ], !dbg !36
  %conv9 = trunc i64 %cond8 to i16, !dbg !36
  ret i16 %conv9, !dbg !37
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_mult(i16 noundef signext %a, i16 noundef signext %b) #0 !dbg !38 {
entry:
  %retval = alloca i16, align 2
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !39, metadata !DIExpression()), !dbg !40
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !41, metadata !DIExpression()), !dbg !42
  %0 = load i16, i16* %a.addr, align 2, !dbg !43
  %conv = sext i16 %0 to i32, !dbg !43
  %cmp = icmp eq i32 %conv, -32768, !dbg !45
  br i1 %cmp, label %land.lhs.true, label %if.else, !dbg !46

land.lhs.true:                                    ; preds = %entry
  %1 = load i16, i16* %b.addr, align 2, !dbg !47
  %conv2 = sext i16 %1 to i32, !dbg !47
  %cmp3 = icmp eq i32 %conv2, -32768, !dbg !48
  br i1 %cmp3, label %if.then, label %if.else, !dbg !49

if.then:                                          ; preds = %land.lhs.true
  store i16 32767, i16* %retval, align 2, !dbg !50
  br label %return, !dbg !50

if.else:                                          ; preds = %land.lhs.true, %entry
  %2 = load i16, i16* %a.addr, align 2, !dbg !51
  %conv5 = sext i16 %2 to i64, !dbg !51
  %3 = load i16, i16* %b.addr, align 2, !dbg !51
  %conv6 = sext i16 %3 to i64, !dbg !51
  %mul = mul nsw i64 %conv5, %conv6, !dbg !51
  %shr = ashr i64 %mul, 15, !dbg !51
  %conv7 = trunc i64 %shr to i16, !dbg !51
  store i16 %conv7, i16* %retval, align 2, !dbg !52
  br label %return, !dbg !52

return:                                           ; preds = %if.else, %if.then
  %4 = load i16, i16* %retval, align 2, !dbg !53
  ret i16 %4, !dbg !53
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_mult_r(i16 noundef signext %a, i16 noundef signext %b) #0 !dbg !54 {
entry:
  %retval = alloca i16, align 2
  %a.addr = alloca i16, align 2
  %b.addr = alloca i16, align 2
  %prod = alloca i64, align 8
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !55, metadata !DIExpression()), !dbg !56
  store i16 %b, i16* %b.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %b.addr, metadata !57, metadata !DIExpression()), !dbg !58
  call void @llvm.dbg.declare(metadata i64* %prod, metadata !59, metadata !DIExpression()), !dbg !60
  %0 = load i16, i16* %b.addr, align 2, !dbg !61
  %conv = sext i16 %0 to i32, !dbg !61
  %cmp = icmp eq i32 %conv, -32768, !dbg !63
  br i1 %cmp, label %land.lhs.true, label %if.else, !dbg !64

land.lhs.true:                                    ; preds = %entry
  %1 = load i16, i16* %a.addr, align 2, !dbg !65
  %conv2 = sext i16 %1 to i32, !dbg !65
  %cmp3 = icmp eq i32 %conv2, -32768, !dbg !66
  br i1 %cmp3, label %if.then, label %if.else, !dbg !67

if.then:                                          ; preds = %land.lhs.true
  store i16 32767, i16* %retval, align 2, !dbg !68
  br label %return, !dbg !68

if.else:                                          ; preds = %land.lhs.true, %entry
  %2 = load i16, i16* %a.addr, align 2, !dbg !69
  %conv5 = sext i16 %2 to i64, !dbg !71
  %3 = load i16, i16* %b.addr, align 2, !dbg !72
  %conv6 = sext i16 %3 to i64, !dbg !73
  %mul = mul nsw i64 %conv5, %conv6, !dbg !74
  %add = add nsw i64 %mul, 16384, !dbg !75
  store i64 %add, i64* %prod, align 8, !dbg !76
  %4 = load i64, i64* %prod, align 8, !dbg !77
  %shr = ashr i64 %4, 15, !dbg !77
  store i64 %shr, i64* %prod, align 8, !dbg !77
  %5 = load i64, i64* %prod, align 8, !dbg !78
  %and = and i64 %5, 65535, !dbg !79
  %conv7 = trunc i64 %and to i16, !dbg !78
  store i16 %conv7, i16* %retval, align 2, !dbg !80
  br label %return, !dbg !80

return:                                           ; preds = %if.else, %if.then
  %6 = load i16, i16* %retval, align 2, !dbg !81
  ret i16 %6, !dbg !81
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_abs(i16 noundef signext %a) #0 !dbg !82 {
entry:
  %a.addr = alloca i16, align 2
  store i16 %a, i16* %a.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %a.addr, metadata !85, metadata !DIExpression()), !dbg !86
  %0 = load i16, i16* %a.addr, align 2, !dbg !87
  %conv = sext i16 %0 to i32, !dbg !87
  %cmp = icmp slt i32 %conv, 0, !dbg !88
  br i1 %cmp, label %cond.true, label %cond.false7, !dbg !87

cond.true:                                        ; preds = %entry
  %1 = load i16, i16* %a.addr, align 2, !dbg !89
  %conv2 = sext i16 %1 to i32, !dbg !89
  %cmp3 = icmp eq i32 %conv2, -32768, !dbg !90
  br i1 %cmp3, label %cond.true5, label %cond.false, !dbg !89

cond.true5:                                       ; preds = %cond.true
  br label %cond.end, !dbg !89

cond.false:                                       ; preds = %cond.true
  %2 = load i16, i16* %a.addr, align 2, !dbg !91
  %conv6 = sext i16 %2 to i32, !dbg !91
  %sub = sub nsw i32 0, %conv6, !dbg !92
  br label %cond.end, !dbg !89

cond.end:                                         ; preds = %cond.false, %cond.true5
  %cond = phi i32 [ 32767, %cond.true5 ], [ %sub, %cond.false ], !dbg !89
  br label %cond.end9, !dbg !87

cond.false7:                                      ; preds = %entry
  %3 = load i16, i16* %a.addr, align 2, !dbg !93
  %conv8 = sext i16 %3 to i32, !dbg !93
  br label %cond.end9, !dbg !87

cond.end9:                                        ; preds = %cond.false7, %cond.end
  %cond10 = phi i32 [ %cond, %cond.end ], [ %conv8, %cond.false7 ], !dbg !87
  %conv11 = trunc i32 %cond10 to i16, !dbg !87
  ret i16 %conv11, !dbg !94
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_norm(i64 noundef %a) #0 !dbg !95 {
entry:
  %retval = alloca i16, align 2
  %a.addr = alloca i64, align 8
  %bitoff = alloca [256 x i8], align 16
  store i64 %a, i64* %a.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %a.addr, metadata !98, metadata !DIExpression()), !dbg !99
  call void @llvm.dbg.declare(metadata [256 x i8]* %bitoff, metadata !100, metadata !DIExpression()), !dbg !106
  %0 = bitcast [256 x i8]* %bitoff to i8*, !dbg !106
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 getelementptr inbounds (<{ [128 x i8], [128 x i8] }>, <{ [128 x i8], [128 x i8] }>* @__const.gsm_norm.bitoff, i32 0, i32 0, i32 0), i64 256, i1 false), !dbg !106
  %1 = load i64, i64* %a.addr, align 8, !dbg !107
  %cmp = icmp slt i64 %1, 0, !dbg !109
  br i1 %cmp, label %if.then, label %if.end3, !dbg !110

if.then:                                          ; preds = %entry
  %2 = load i64, i64* %a.addr, align 8, !dbg !111
  %cmp1 = icmp sle i64 %2, -1073741824, !dbg !114
  br i1 %cmp1, label %if.then2, label %if.end, !dbg !115

if.then2:                                         ; preds = %if.then
  store i16 0, i16* %retval, align 2, !dbg !116
  br label %return, !dbg !116

if.end:                                           ; preds = %if.then
  %3 = load i64, i64* %a.addr, align 8, !dbg !117
  %neg = xor i64 %3, -1, !dbg !118
  store i64 %neg, i64* %a.addr, align 8, !dbg !119
  br label %if.end3, !dbg !120

if.end3:                                          ; preds = %if.end, %entry
  %4 = load i64, i64* %a.addr, align 8, !dbg !121
  %and = and i64 %4, 4294901760, !dbg !122
  %tobool = icmp ne i64 %and, 0, !dbg !122
  br i1 %tobool, label %cond.true, label %cond.false13, !dbg !121

cond.true:                                        ; preds = %if.end3
  %5 = load i64, i64* %a.addr, align 8, !dbg !123
  %and4 = and i64 %5, 4278190080, !dbg !124
  %tobool5 = icmp ne i64 %and4, 0, !dbg !124
  br i1 %tobool5, label %cond.true6, label %cond.false, !dbg !123

cond.true6:                                       ; preds = %cond.true
  %6 = load i64, i64* %a.addr, align 8, !dbg !125
  %shr = ashr i64 %6, 24, !dbg !126
  %and7 = and i64 255, %shr, !dbg !127
  %arrayidx = getelementptr inbounds [256 x i8], [256 x i8]* %bitoff, i64 0, i64 %and7, !dbg !128
  %7 = load i8, i8* %arrayidx, align 1, !dbg !128
  %conv = zext i8 %7 to i32, !dbg !128
  %add = add nsw i32 -1, %conv, !dbg !129
  br label %cond.end, !dbg !123

cond.false:                                       ; preds = %cond.true
  %8 = load i64, i64* %a.addr, align 8, !dbg !130
  %shr8 = ashr i64 %8, 16, !dbg !131
  %and9 = and i64 255, %shr8, !dbg !132
  %arrayidx10 = getelementptr inbounds [256 x i8], [256 x i8]* %bitoff, i64 0, i64 %and9, !dbg !133
  %9 = load i8, i8* %arrayidx10, align 1, !dbg !133
  %conv11 = zext i8 %9 to i32, !dbg !133
  %add12 = add nsw i32 7, %conv11, !dbg !134
  br label %cond.end, !dbg !123

cond.end:                                         ; preds = %cond.false, %cond.true6
  %cond = phi i32 [ %add, %cond.true6 ], [ %add12, %cond.false ], !dbg !123
  br label %cond.end29, !dbg !121

cond.false13:                                     ; preds = %if.end3
  %10 = load i64, i64* %a.addr, align 8, !dbg !135
  %and14 = and i64 %10, 65280, !dbg !136
  %tobool15 = icmp ne i64 %and14, 0, !dbg !136
  br i1 %tobool15, label %cond.true16, label %cond.false22, !dbg !135

cond.true16:                                      ; preds = %cond.false13
  %11 = load i64, i64* %a.addr, align 8, !dbg !137
  %shr17 = ashr i64 %11, 8, !dbg !138
  %and18 = and i64 255, %shr17, !dbg !139
  %arrayidx19 = getelementptr inbounds [256 x i8], [256 x i8]* %bitoff, i64 0, i64 %and18, !dbg !140
  %12 = load i8, i8* %arrayidx19, align 1, !dbg !140
  %conv20 = zext i8 %12 to i32, !dbg !140
  %add21 = add nsw i32 15, %conv20, !dbg !141
  br label %cond.end27, !dbg !135

cond.false22:                                     ; preds = %cond.false13
  %13 = load i64, i64* %a.addr, align 8, !dbg !142
  %and23 = and i64 255, %13, !dbg !143
  %arrayidx24 = getelementptr inbounds [256 x i8], [256 x i8]* %bitoff, i64 0, i64 %and23, !dbg !144
  %14 = load i8, i8* %arrayidx24, align 1, !dbg !144
  %conv25 = zext i8 %14 to i32, !dbg !144
  %add26 = add nsw i32 23, %conv25, !dbg !145
  br label %cond.end27, !dbg !135

cond.end27:                                       ; preds = %cond.false22, %cond.true16
  %cond28 = phi i32 [ %add21, %cond.true16 ], [ %add26, %cond.false22 ], !dbg !135
  br label %cond.end29, !dbg !121

cond.end29:                                       ; preds = %cond.end27, %cond.end
  %cond30 = phi i32 [ %cond, %cond.end ], [ %cond28, %cond.end27 ], !dbg !121
  %conv31 = trunc i32 %cond30 to i16, !dbg !121
  store i16 %conv31, i16* %retval, align 2, !dbg !146
  br label %return, !dbg !146

return:                                           ; preds = %cond.end29, %if.then2
  %15 = load i16, i16* %retval, align 2, !dbg !147
  ret i16 %15, !dbg !147
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local signext i16 @gsm_div(i16 noundef signext %num, i16 noundef signext %denum) #0 !dbg !148 {
entry:
  %retval = alloca i16, align 2
  %num.addr = alloca i16, align 2
  %denum.addr = alloca i16, align 2
  %L_num = alloca i64, align 8
  %L_denum = alloca i64, align 8
  %div = alloca i16, align 2
  %k = alloca i32, align 4
  store i16 %num, i16* %num.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %num.addr, metadata !149, metadata !DIExpression()), !dbg !150
  store i16 %denum, i16* %denum.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %denum.addr, metadata !151, metadata !DIExpression()), !dbg !152
  call void @llvm.dbg.declare(metadata i64* %L_num, metadata !153, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.declare(metadata i64* %L_denum, metadata !155, metadata !DIExpression()), !dbg !156
  call void @llvm.dbg.declare(metadata i16* %div, metadata !157, metadata !DIExpression()), !dbg !158
  call void @llvm.dbg.declare(metadata i32* %k, metadata !159, metadata !DIExpression()), !dbg !161
  %0 = load i16, i16* %num.addr, align 2, !dbg !162
  %conv = sext i16 %0 to i64, !dbg !162
  store i64 %conv, i64* %L_num, align 8, !dbg !163
  %1 = load i16, i16* %denum.addr, align 2, !dbg !164
  %conv1 = sext i16 %1 to i64, !dbg !164
  store i64 %conv1, i64* %L_denum, align 8, !dbg !165
  store i16 0, i16* %div, align 2, !dbg !166
  store i32 15, i32* %k, align 4, !dbg !167
  %2 = load i16, i16* %num.addr, align 2, !dbg !168
  %conv2 = sext i16 %2 to i32, !dbg !168
  %cmp = icmp eq i32 %conv2, 0, !dbg !170
  br i1 %cmp, label %if.then, label %if.end, !dbg !171

if.then:                                          ; preds = %entry
  store i16 0, i16* %retval, align 2, !dbg !172
  br label %return, !dbg !172

if.end:                                           ; preds = %entry
  br label %gsm_div_label0, !dbg !173

gsm_div_label0:                                   ; preds = %if.end
  call void @llvm.dbg.label(metadata !174), !dbg !175
  br label %while.cond, !dbg !176

while.cond:                                       ; preds = %if.end10, %gsm_div_label0
  %3 = load i32, i32* %k, align 4, !dbg !177
  %dec = add nsw i32 %3, -1, !dbg !177
  store i32 %dec, i32* %k, align 4, !dbg !177
  %tobool = icmp ne i32 %3, 0, !dbg !176
  br i1 %tobool, label %while.body, label %while.end, !dbg !176

while.body:                                       ; preds = %while.cond
  %4 = load i16, i16* %div, align 2, !dbg !178
  %conv4 = sext i16 %4 to i32, !dbg !178
  %shl = shl i32 %conv4, 1, !dbg !178
  %conv5 = trunc i32 %shl to i16, !dbg !178
  store i16 %conv5, i16* %div, align 2, !dbg !178
  %5 = load i64, i64* %L_num, align 8, !dbg !180
  %shl6 = shl i64 %5, 1, !dbg !180
  store i64 %shl6, i64* %L_num, align 8, !dbg !180
  %6 = load i64, i64* %L_num, align 8, !dbg !181
  %7 = load i64, i64* %L_denum, align 8, !dbg !183
  %cmp7 = icmp sge i64 %6, %7, !dbg !184
  br i1 %cmp7, label %if.then9, label %if.end10, !dbg !185

if.then9:                                         ; preds = %while.body
  %8 = load i64, i64* %L_denum, align 8, !dbg !186
  %9 = load i64, i64* %L_num, align 8, !dbg !188
  %sub = sub nsw i64 %9, %8, !dbg !188
  store i64 %sub, i64* %L_num, align 8, !dbg !188
  %10 = load i16, i16* %div, align 2, !dbg !189
  %inc = add i16 %10, 1, !dbg !189
  store i16 %inc, i16* %div, align 2, !dbg !189
  br label %if.end10, !dbg !190

if.end10:                                         ; preds = %if.then9, %while.body
  br label %while.cond, !dbg !176, !llvm.loop !191

while.end:                                        ; preds = %while.cond
  %11 = load i16, i16* %div, align 2, !dbg !194
  store i16 %11, i16* %retval, align 2, !dbg !195
  br label %return, !dbg !195

return:                                           ; preds = %while.end, %if.then
  %12 = load i16, i16* %retval, align 2, !dbg !196
  ret i16 %12, !dbg !196
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Autocorrelation(i16* noundef %s, i64* noundef %L_ACF) #0 !dbg !197 {
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
  call void @llvm.dbg.declare(metadata i16** %s.addr, metadata !202, metadata !DIExpression()), !dbg !203
  store i64* %L_ACF, i64** %L_ACF.addr, align 8
  call void @llvm.dbg.declare(metadata i64** %L_ACF.addr, metadata !204, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.declare(metadata i32* %k, metadata !206, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.declare(metadata i32* %i, metadata !208, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.declare(metadata i16* %temp, metadata !210, metadata !DIExpression()), !dbg !211
  call void @llvm.dbg.declare(metadata i16* %smax, metadata !212, metadata !DIExpression()), !dbg !213
  call void @llvm.dbg.declare(metadata i16* %scalauto, metadata !214, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.declare(metadata i16* %n, metadata !216, metadata !DIExpression()), !dbg !217
  call void @llvm.dbg.declare(metadata i16** %sp, metadata !218, metadata !DIExpression()), !dbg !219
  call void @llvm.dbg.declare(metadata i16* %sl, metadata !220, metadata !DIExpression()), !dbg !221
  store i16 0, i16* %smax, align 2, !dbg !222
  br label %Autocorrelation_label0, !dbg !223

Autocorrelation_label0:                           ; preds = %entry
  call void @llvm.dbg.label(metadata !224), !dbg !225
  store i32 0, i32* %k, align 4, !dbg !226
  br label %for.cond, !dbg !228

for.cond:                                         ; preds = %for.inc, %Autocorrelation_label0
  %0 = load i32, i32* %k, align 4, !dbg !229
  %cmp = icmp sle i32 %0, 159, !dbg !231
  br i1 %cmp, label %for.body, label %for.end, !dbg !232

for.body:                                         ; preds = %for.cond
  %1 = load i16*, i16** %s.addr, align 8, !dbg !233
  %2 = load i32, i32* %k, align 4, !dbg !233
  %idxprom = sext i32 %2 to i64, !dbg !233
  %arrayidx = getelementptr inbounds i16, i16* %1, i64 %idxprom, !dbg !233
  %3 = load i16, i16* %arrayidx, align 2, !dbg !233
  %call = call signext i16 @gsm_abs(i16 noundef signext %3), !dbg !233
  store i16 %call, i16* %temp, align 2, !dbg !235
  %4 = load i16, i16* %temp, align 2, !dbg !236
  %conv = sext i16 %4 to i32, !dbg !236
  %5 = load i16, i16* %smax, align 2, !dbg !238
  %conv1 = sext i16 %5 to i32, !dbg !238
  %cmp2 = icmp sgt i32 %conv, %conv1, !dbg !239
  br i1 %cmp2, label %if.then, label %if.end, !dbg !240

if.then:                                          ; preds = %for.body
  %6 = load i16, i16* %temp, align 2, !dbg !241
  store i16 %6, i16* %smax, align 2, !dbg !242
  br label %if.end, !dbg !243

if.end:                                           ; preds = %if.then, %for.body
  br label %for.inc, !dbg !244

for.inc:                                          ; preds = %if.end
  %7 = load i32, i32* %k, align 4, !dbg !245
  %inc = add nsw i32 %7, 1, !dbg !245
  store i32 %inc, i32* %k, align 4, !dbg !245
  br label %for.cond, !dbg !246, !llvm.loop !247

for.end:                                          ; preds = %for.cond
  %8 = load i16, i16* %smax, align 2, !dbg !249
  %conv4 = sext i16 %8 to i32, !dbg !249
  %cmp5 = icmp eq i32 %conv4, 0, !dbg !251
  br i1 %cmp5, label %if.then7, label %if.else, !dbg !252

if.then7:                                         ; preds = %for.end
  store i16 0, i16* %scalauto, align 2, !dbg !253
  br label %if.end12, !dbg !254

if.else:                                          ; preds = %for.end
  %9 = load i16, i16* %smax, align 2, !dbg !255
  %conv8 = sext i16 %9 to i64, !dbg !256
  %shl = shl i64 %conv8, 16, !dbg !257
  %call9 = call signext i16 @gsm_norm(i64 noundef %shl), !dbg !258
  %conv10 = sext i16 %call9 to i32, !dbg !258
  %sub = sub nsw i32 4, %conv10, !dbg !259
  %conv11 = trunc i32 %sub to i16, !dbg !260
  store i16 %conv11, i16* %scalauto, align 2, !dbg !261
  br label %if.end12

if.end12:                                         ; preds = %if.else, %if.then7
  %10 = load i16, i16* %scalauto, align 2, !dbg !262
  %conv13 = sext i16 %10 to i32, !dbg !262
  %cmp14 = icmp sgt i32 %conv13, 0, !dbg !264
  br i1 %cmp14, label %land.lhs.true, label %if.end35, !dbg !265

land.lhs.true:                                    ; preds = %if.end12
  %11 = load i16, i16* %scalauto, align 2, !dbg !266
  %conv16 = sext i16 %11 to i32, !dbg !266
  %cmp17 = icmp sle i32 %conv16, 4, !dbg !267
  br i1 %cmp17, label %if.then19, label %if.end35, !dbg !268

if.then19:                                        ; preds = %land.lhs.true
  %12 = load i16, i16* %scalauto, align 2, !dbg !269
  store i16 %12, i16* %n, align 2, !dbg !271
  br label %Autocorrelation_label1, !dbg !272

Autocorrelation_label1:                           ; preds = %if.then19
  call void @llvm.dbg.label(metadata !273), !dbg !274
  store i32 0, i32* %k, align 4, !dbg !275
  br label %for.cond20, !dbg !277

for.cond20:                                       ; preds = %for.inc32, %Autocorrelation_label1
  %13 = load i32, i32* %k, align 4, !dbg !278
  %cmp21 = icmp sle i32 %13, 159, !dbg !280
  br i1 %cmp21, label %for.body23, label %for.end34, !dbg !281

for.body23:                                       ; preds = %for.cond20
  %14 = load i16*, i16** %s.addr, align 8, !dbg !282
  %15 = load i32, i32* %k, align 4, !dbg !282
  %idxprom24 = sext i32 %15 to i64, !dbg !282
  %arrayidx25 = getelementptr inbounds i16, i16* %14, i64 %idxprom24, !dbg !282
  %16 = load i16, i16* %arrayidx25, align 2, !dbg !282
  %17 = load i16, i16* %n, align 2, !dbg !282
  %conv26 = sext i16 %17 to i32, !dbg !282
  %sub27 = sub nsw i32 %conv26, 1, !dbg !282
  %shr = ashr i32 16384, %sub27, !dbg !282
  %conv28 = trunc i32 %shr to i16, !dbg !282
  %call29 = call signext i16 @gsm_mult_r(i16 noundef signext %16, i16 noundef signext %conv28), !dbg !282
  %18 = load i16*, i16** %s.addr, align 8, !dbg !284
  %19 = load i32, i32* %k, align 4, !dbg !285
  %idxprom30 = sext i32 %19 to i64, !dbg !284
  %arrayidx31 = getelementptr inbounds i16, i16* %18, i64 %idxprom30, !dbg !284
  store i16 %call29, i16* %arrayidx31, align 2, !dbg !286
  br label %for.inc32, !dbg !287

for.inc32:                                        ; preds = %for.body23
  %20 = load i32, i32* %k, align 4, !dbg !288
  %inc33 = add nsw i32 %20, 1, !dbg !288
  store i32 %inc33, i32* %k, align 4, !dbg !288
  br label %for.cond20, !dbg !289, !llvm.loop !290

for.end34:                                        ; preds = %for.cond20
  br label %if.end35, !dbg !292

if.end35:                                         ; preds = %for.end34, %land.lhs.true, %if.end12
  %21 = load i16*, i16** %s.addr, align 8, !dbg !293
  store i16* %21, i16** %sp, align 8, !dbg !294
  %22 = load i16*, i16** %sp, align 8, !dbg !295
  %23 = load i16, i16* %22, align 2, !dbg !296
  store i16 %23, i16* %sl, align 2, !dbg !297
  br label %Autocorrelation_label2, !dbg !298

Autocorrelation_label2:                           ; preds = %if.end35
  call void @llvm.dbg.label(metadata !299), !dbg !300
  store i32 8, i32* %k, align 4, !dbg !301
  br label %for.cond36, !dbg !303

for.cond36:                                       ; preds = %for.inc42, %Autocorrelation_label2
  %24 = load i32, i32* %k, align 4, !dbg !304
  %cmp37 = icmp sge i32 %24, 0, !dbg !306
  br i1 %cmp37, label %for.body39, label %for.end43, !dbg !307

for.body39:                                       ; preds = %for.cond36
  %25 = load i64*, i64** %L_ACF.addr, align 8, !dbg !308
  %26 = load i32, i32* %k, align 4, !dbg !310
  %idxprom40 = sext i32 %26 to i64, !dbg !308
  %arrayidx41 = getelementptr inbounds i64, i64* %25, i64 %idxprom40, !dbg !308
  store i64 0, i64* %arrayidx41, align 8, !dbg !311
  br label %for.inc42, !dbg !312

for.inc42:                                        ; preds = %for.body39
  %27 = load i32, i32* %k, align 4, !dbg !313
  %dec = add nsw i32 %27, -1, !dbg !313
  store i32 %dec, i32* %k, align 4, !dbg !313
  br label %for.cond36, !dbg !314, !llvm.loop !315

for.end43:                                        ; preds = %for.cond36
  %28 = load i16, i16* %sl, align 2, !dbg !317
  %conv44 = sext i16 %28 to i64, !dbg !317
  %29 = load i16*, i16** %sp, align 8, !dbg !317
  %arrayidx45 = getelementptr inbounds i16, i16* %29, i64 0, !dbg !317
  %30 = load i16, i16* %arrayidx45, align 2, !dbg !317
  %conv46 = sext i16 %30 to i64, !dbg !317
  %mul = mul nsw i64 %conv44, %conv46, !dbg !317
  %31 = load i64*, i64** %L_ACF.addr, align 8, !dbg !317
  %arrayidx47 = getelementptr inbounds i64, i64* %31, i64 0, !dbg !317
  %32 = load i64, i64* %arrayidx47, align 8, !dbg !317
  %add = add nsw i64 %32, %mul, !dbg !317
  store i64 %add, i64* %arrayidx47, align 8, !dbg !317
  %33 = load i16*, i16** %sp, align 8, !dbg !318
  %incdec.ptr = getelementptr inbounds i16, i16* %33, i32 1, !dbg !318
  store i16* %incdec.ptr, i16** %sp, align 8, !dbg !318
  %34 = load i16, i16* %incdec.ptr, align 2, !dbg !318
  store i16 %34, i16* %sl, align 2, !dbg !318
  %35 = load i16, i16* %sl, align 2, !dbg !319
  %conv48 = sext i16 %35 to i64, !dbg !319
  %36 = load i16*, i16** %sp, align 8, !dbg !319
  %arrayidx49 = getelementptr inbounds i16, i16* %36, i64 0, !dbg !319
  %37 = load i16, i16* %arrayidx49, align 2, !dbg !319
  %conv50 = sext i16 %37 to i64, !dbg !319
  %mul51 = mul nsw i64 %conv48, %conv50, !dbg !319
  %38 = load i64*, i64** %L_ACF.addr, align 8, !dbg !319
  %arrayidx52 = getelementptr inbounds i64, i64* %38, i64 0, !dbg !319
  %39 = load i64, i64* %arrayidx52, align 8, !dbg !319
  %add53 = add nsw i64 %39, %mul51, !dbg !319
  store i64 %add53, i64* %arrayidx52, align 8, !dbg !319
  %40 = load i16, i16* %sl, align 2, !dbg !320
  %conv54 = sext i16 %40 to i64, !dbg !320
  %41 = load i16*, i16** %sp, align 8, !dbg !320
  %arrayidx55 = getelementptr inbounds i16, i16* %41, i64 -1, !dbg !320
  %42 = load i16, i16* %arrayidx55, align 2, !dbg !320
  %conv56 = sext i16 %42 to i64, !dbg !320
  %mul57 = mul nsw i64 %conv54, %conv56, !dbg !320
  %43 = load i64*, i64** %L_ACF.addr, align 8, !dbg !320
  %arrayidx58 = getelementptr inbounds i64, i64* %43, i64 1, !dbg !320
  %44 = load i64, i64* %arrayidx58, align 8, !dbg !320
  %add59 = add nsw i64 %44, %mul57, !dbg !320
  store i64 %add59, i64* %arrayidx58, align 8, !dbg !320
  %45 = load i16*, i16** %sp, align 8, !dbg !321
  %incdec.ptr60 = getelementptr inbounds i16, i16* %45, i32 1, !dbg !321
  store i16* %incdec.ptr60, i16** %sp, align 8, !dbg !321
  %46 = load i16, i16* %incdec.ptr60, align 2, !dbg !321
  store i16 %46, i16* %sl, align 2, !dbg !321
  %47 = load i16, i16* %sl, align 2, !dbg !322
  %conv61 = sext i16 %47 to i64, !dbg !322
  %48 = load i16*, i16** %sp, align 8, !dbg !322
  %arrayidx62 = getelementptr inbounds i16, i16* %48, i64 0, !dbg !322
  %49 = load i16, i16* %arrayidx62, align 2, !dbg !322
  %conv63 = sext i16 %49 to i64, !dbg !322
  %mul64 = mul nsw i64 %conv61, %conv63, !dbg !322
  %50 = load i64*, i64** %L_ACF.addr, align 8, !dbg !322
  %arrayidx65 = getelementptr inbounds i64, i64* %50, i64 0, !dbg !322
  %51 = load i64, i64* %arrayidx65, align 8, !dbg !322
  %add66 = add nsw i64 %51, %mul64, !dbg !322
  store i64 %add66, i64* %arrayidx65, align 8, !dbg !322
  %52 = load i16, i16* %sl, align 2, !dbg !323
  %conv67 = sext i16 %52 to i64, !dbg !323
  %53 = load i16*, i16** %sp, align 8, !dbg !323
  %arrayidx68 = getelementptr inbounds i16, i16* %53, i64 -1, !dbg !323
  %54 = load i16, i16* %arrayidx68, align 2, !dbg !323
  %conv69 = sext i16 %54 to i64, !dbg !323
  %mul70 = mul nsw i64 %conv67, %conv69, !dbg !323
  %55 = load i64*, i64** %L_ACF.addr, align 8, !dbg !323
  %arrayidx71 = getelementptr inbounds i64, i64* %55, i64 1, !dbg !323
  %56 = load i64, i64* %arrayidx71, align 8, !dbg !323
  %add72 = add nsw i64 %56, %mul70, !dbg !323
  store i64 %add72, i64* %arrayidx71, align 8, !dbg !323
  %57 = load i16, i16* %sl, align 2, !dbg !324
  %conv73 = sext i16 %57 to i64, !dbg !324
  %58 = load i16*, i16** %sp, align 8, !dbg !324
  %arrayidx74 = getelementptr inbounds i16, i16* %58, i64 -2, !dbg !324
  %59 = load i16, i16* %arrayidx74, align 2, !dbg !324
  %conv75 = sext i16 %59 to i64, !dbg !324
  %mul76 = mul nsw i64 %conv73, %conv75, !dbg !324
  %60 = load i64*, i64** %L_ACF.addr, align 8, !dbg !324
  %arrayidx77 = getelementptr inbounds i64, i64* %60, i64 2, !dbg !324
  %61 = load i64, i64* %arrayidx77, align 8, !dbg !324
  %add78 = add nsw i64 %61, %mul76, !dbg !324
  store i64 %add78, i64* %arrayidx77, align 8, !dbg !324
  %62 = load i16*, i16** %sp, align 8, !dbg !325
  %incdec.ptr79 = getelementptr inbounds i16, i16* %62, i32 1, !dbg !325
  store i16* %incdec.ptr79, i16** %sp, align 8, !dbg !325
  %63 = load i16, i16* %incdec.ptr79, align 2, !dbg !325
  store i16 %63, i16* %sl, align 2, !dbg !325
  %64 = load i16, i16* %sl, align 2, !dbg !326
  %conv80 = sext i16 %64 to i64, !dbg !326
  %65 = load i16*, i16** %sp, align 8, !dbg !326
  %arrayidx81 = getelementptr inbounds i16, i16* %65, i64 0, !dbg !326
  %66 = load i16, i16* %arrayidx81, align 2, !dbg !326
  %conv82 = sext i16 %66 to i64, !dbg !326
  %mul83 = mul nsw i64 %conv80, %conv82, !dbg !326
  %67 = load i64*, i64** %L_ACF.addr, align 8, !dbg !326
  %arrayidx84 = getelementptr inbounds i64, i64* %67, i64 0, !dbg !326
  %68 = load i64, i64* %arrayidx84, align 8, !dbg !326
  %add85 = add nsw i64 %68, %mul83, !dbg !326
  store i64 %add85, i64* %arrayidx84, align 8, !dbg !326
  %69 = load i16, i16* %sl, align 2, !dbg !327
  %conv86 = sext i16 %69 to i64, !dbg !327
  %70 = load i16*, i16** %sp, align 8, !dbg !327
  %arrayidx87 = getelementptr inbounds i16, i16* %70, i64 -1, !dbg !327
  %71 = load i16, i16* %arrayidx87, align 2, !dbg !327
  %conv88 = sext i16 %71 to i64, !dbg !327
  %mul89 = mul nsw i64 %conv86, %conv88, !dbg !327
  %72 = load i64*, i64** %L_ACF.addr, align 8, !dbg !327
  %arrayidx90 = getelementptr inbounds i64, i64* %72, i64 1, !dbg !327
  %73 = load i64, i64* %arrayidx90, align 8, !dbg !327
  %add91 = add nsw i64 %73, %mul89, !dbg !327
  store i64 %add91, i64* %arrayidx90, align 8, !dbg !327
  %74 = load i16, i16* %sl, align 2, !dbg !328
  %conv92 = sext i16 %74 to i64, !dbg !328
  %75 = load i16*, i16** %sp, align 8, !dbg !328
  %arrayidx93 = getelementptr inbounds i16, i16* %75, i64 -2, !dbg !328
  %76 = load i16, i16* %arrayidx93, align 2, !dbg !328
  %conv94 = sext i16 %76 to i64, !dbg !328
  %mul95 = mul nsw i64 %conv92, %conv94, !dbg !328
  %77 = load i64*, i64** %L_ACF.addr, align 8, !dbg !328
  %arrayidx96 = getelementptr inbounds i64, i64* %77, i64 2, !dbg !328
  %78 = load i64, i64* %arrayidx96, align 8, !dbg !328
  %add97 = add nsw i64 %78, %mul95, !dbg !328
  store i64 %add97, i64* %arrayidx96, align 8, !dbg !328
  %79 = load i16, i16* %sl, align 2, !dbg !329
  %conv98 = sext i16 %79 to i64, !dbg !329
  %80 = load i16*, i16** %sp, align 8, !dbg !329
  %arrayidx99 = getelementptr inbounds i16, i16* %80, i64 -3, !dbg !329
  %81 = load i16, i16* %arrayidx99, align 2, !dbg !329
  %conv100 = sext i16 %81 to i64, !dbg !329
  %mul101 = mul nsw i64 %conv98, %conv100, !dbg !329
  %82 = load i64*, i64** %L_ACF.addr, align 8, !dbg !329
  %arrayidx102 = getelementptr inbounds i64, i64* %82, i64 3, !dbg !329
  %83 = load i64, i64* %arrayidx102, align 8, !dbg !329
  %add103 = add nsw i64 %83, %mul101, !dbg !329
  store i64 %add103, i64* %arrayidx102, align 8, !dbg !329
  %84 = load i16*, i16** %sp, align 8, !dbg !330
  %incdec.ptr104 = getelementptr inbounds i16, i16* %84, i32 1, !dbg !330
  store i16* %incdec.ptr104, i16** %sp, align 8, !dbg !330
  %85 = load i16, i16* %incdec.ptr104, align 2, !dbg !330
  store i16 %85, i16* %sl, align 2, !dbg !330
  %86 = load i16, i16* %sl, align 2, !dbg !331
  %conv105 = sext i16 %86 to i64, !dbg !331
  %87 = load i16*, i16** %sp, align 8, !dbg !331
  %arrayidx106 = getelementptr inbounds i16, i16* %87, i64 0, !dbg !331
  %88 = load i16, i16* %arrayidx106, align 2, !dbg !331
  %conv107 = sext i16 %88 to i64, !dbg !331
  %mul108 = mul nsw i64 %conv105, %conv107, !dbg !331
  %89 = load i64*, i64** %L_ACF.addr, align 8, !dbg !331
  %arrayidx109 = getelementptr inbounds i64, i64* %89, i64 0, !dbg !331
  %90 = load i64, i64* %arrayidx109, align 8, !dbg !331
  %add110 = add nsw i64 %90, %mul108, !dbg !331
  store i64 %add110, i64* %arrayidx109, align 8, !dbg !331
  %91 = load i16, i16* %sl, align 2, !dbg !332
  %conv111 = sext i16 %91 to i64, !dbg !332
  %92 = load i16*, i16** %sp, align 8, !dbg !332
  %arrayidx112 = getelementptr inbounds i16, i16* %92, i64 -1, !dbg !332
  %93 = load i16, i16* %arrayidx112, align 2, !dbg !332
  %conv113 = sext i16 %93 to i64, !dbg !332
  %mul114 = mul nsw i64 %conv111, %conv113, !dbg !332
  %94 = load i64*, i64** %L_ACF.addr, align 8, !dbg !332
  %arrayidx115 = getelementptr inbounds i64, i64* %94, i64 1, !dbg !332
  %95 = load i64, i64* %arrayidx115, align 8, !dbg !332
  %add116 = add nsw i64 %95, %mul114, !dbg !332
  store i64 %add116, i64* %arrayidx115, align 8, !dbg !332
  %96 = load i16, i16* %sl, align 2, !dbg !333
  %conv117 = sext i16 %96 to i64, !dbg !333
  %97 = load i16*, i16** %sp, align 8, !dbg !333
  %arrayidx118 = getelementptr inbounds i16, i16* %97, i64 -2, !dbg !333
  %98 = load i16, i16* %arrayidx118, align 2, !dbg !333
  %conv119 = sext i16 %98 to i64, !dbg !333
  %mul120 = mul nsw i64 %conv117, %conv119, !dbg !333
  %99 = load i64*, i64** %L_ACF.addr, align 8, !dbg !333
  %arrayidx121 = getelementptr inbounds i64, i64* %99, i64 2, !dbg !333
  %100 = load i64, i64* %arrayidx121, align 8, !dbg !333
  %add122 = add nsw i64 %100, %mul120, !dbg !333
  store i64 %add122, i64* %arrayidx121, align 8, !dbg !333
  %101 = load i16, i16* %sl, align 2, !dbg !334
  %conv123 = sext i16 %101 to i64, !dbg !334
  %102 = load i16*, i16** %sp, align 8, !dbg !334
  %arrayidx124 = getelementptr inbounds i16, i16* %102, i64 -3, !dbg !334
  %103 = load i16, i16* %arrayidx124, align 2, !dbg !334
  %conv125 = sext i16 %103 to i64, !dbg !334
  %mul126 = mul nsw i64 %conv123, %conv125, !dbg !334
  %104 = load i64*, i64** %L_ACF.addr, align 8, !dbg !334
  %arrayidx127 = getelementptr inbounds i64, i64* %104, i64 3, !dbg !334
  %105 = load i64, i64* %arrayidx127, align 8, !dbg !334
  %add128 = add nsw i64 %105, %mul126, !dbg !334
  store i64 %add128, i64* %arrayidx127, align 8, !dbg !334
  %106 = load i16, i16* %sl, align 2, !dbg !335
  %conv129 = sext i16 %106 to i64, !dbg !335
  %107 = load i16*, i16** %sp, align 8, !dbg !335
  %arrayidx130 = getelementptr inbounds i16, i16* %107, i64 -4, !dbg !335
  %108 = load i16, i16* %arrayidx130, align 2, !dbg !335
  %conv131 = sext i16 %108 to i64, !dbg !335
  %mul132 = mul nsw i64 %conv129, %conv131, !dbg !335
  %109 = load i64*, i64** %L_ACF.addr, align 8, !dbg !335
  %arrayidx133 = getelementptr inbounds i64, i64* %109, i64 4, !dbg !335
  %110 = load i64, i64* %arrayidx133, align 8, !dbg !335
  %add134 = add nsw i64 %110, %mul132, !dbg !335
  store i64 %add134, i64* %arrayidx133, align 8, !dbg !335
  %111 = load i16*, i16** %sp, align 8, !dbg !336
  %incdec.ptr135 = getelementptr inbounds i16, i16* %111, i32 1, !dbg !336
  store i16* %incdec.ptr135, i16** %sp, align 8, !dbg !336
  %112 = load i16, i16* %incdec.ptr135, align 2, !dbg !336
  store i16 %112, i16* %sl, align 2, !dbg !336
  %113 = load i16, i16* %sl, align 2, !dbg !337
  %conv136 = sext i16 %113 to i64, !dbg !337
  %114 = load i16*, i16** %sp, align 8, !dbg !337
  %arrayidx137 = getelementptr inbounds i16, i16* %114, i64 0, !dbg !337
  %115 = load i16, i16* %arrayidx137, align 2, !dbg !337
  %conv138 = sext i16 %115 to i64, !dbg !337
  %mul139 = mul nsw i64 %conv136, %conv138, !dbg !337
  %116 = load i64*, i64** %L_ACF.addr, align 8, !dbg !337
  %arrayidx140 = getelementptr inbounds i64, i64* %116, i64 0, !dbg !337
  %117 = load i64, i64* %arrayidx140, align 8, !dbg !337
  %add141 = add nsw i64 %117, %mul139, !dbg !337
  store i64 %add141, i64* %arrayidx140, align 8, !dbg !337
  %118 = load i16, i16* %sl, align 2, !dbg !338
  %conv142 = sext i16 %118 to i64, !dbg !338
  %119 = load i16*, i16** %sp, align 8, !dbg !338
  %arrayidx143 = getelementptr inbounds i16, i16* %119, i64 -1, !dbg !338
  %120 = load i16, i16* %arrayidx143, align 2, !dbg !338
  %conv144 = sext i16 %120 to i64, !dbg !338
  %mul145 = mul nsw i64 %conv142, %conv144, !dbg !338
  %121 = load i64*, i64** %L_ACF.addr, align 8, !dbg !338
  %arrayidx146 = getelementptr inbounds i64, i64* %121, i64 1, !dbg !338
  %122 = load i64, i64* %arrayidx146, align 8, !dbg !338
  %add147 = add nsw i64 %122, %mul145, !dbg !338
  store i64 %add147, i64* %arrayidx146, align 8, !dbg !338
  %123 = load i16, i16* %sl, align 2, !dbg !339
  %conv148 = sext i16 %123 to i64, !dbg !339
  %124 = load i16*, i16** %sp, align 8, !dbg !339
  %arrayidx149 = getelementptr inbounds i16, i16* %124, i64 -2, !dbg !339
  %125 = load i16, i16* %arrayidx149, align 2, !dbg !339
  %conv150 = sext i16 %125 to i64, !dbg !339
  %mul151 = mul nsw i64 %conv148, %conv150, !dbg !339
  %126 = load i64*, i64** %L_ACF.addr, align 8, !dbg !339
  %arrayidx152 = getelementptr inbounds i64, i64* %126, i64 2, !dbg !339
  %127 = load i64, i64* %arrayidx152, align 8, !dbg !339
  %add153 = add nsw i64 %127, %mul151, !dbg !339
  store i64 %add153, i64* %arrayidx152, align 8, !dbg !339
  %128 = load i16, i16* %sl, align 2, !dbg !340
  %conv154 = sext i16 %128 to i64, !dbg !340
  %129 = load i16*, i16** %sp, align 8, !dbg !340
  %arrayidx155 = getelementptr inbounds i16, i16* %129, i64 -3, !dbg !340
  %130 = load i16, i16* %arrayidx155, align 2, !dbg !340
  %conv156 = sext i16 %130 to i64, !dbg !340
  %mul157 = mul nsw i64 %conv154, %conv156, !dbg !340
  %131 = load i64*, i64** %L_ACF.addr, align 8, !dbg !340
  %arrayidx158 = getelementptr inbounds i64, i64* %131, i64 3, !dbg !340
  %132 = load i64, i64* %arrayidx158, align 8, !dbg !340
  %add159 = add nsw i64 %132, %mul157, !dbg !340
  store i64 %add159, i64* %arrayidx158, align 8, !dbg !340
  %133 = load i16, i16* %sl, align 2, !dbg !341
  %conv160 = sext i16 %133 to i64, !dbg !341
  %134 = load i16*, i16** %sp, align 8, !dbg !341
  %arrayidx161 = getelementptr inbounds i16, i16* %134, i64 -4, !dbg !341
  %135 = load i16, i16* %arrayidx161, align 2, !dbg !341
  %conv162 = sext i16 %135 to i64, !dbg !341
  %mul163 = mul nsw i64 %conv160, %conv162, !dbg !341
  %136 = load i64*, i64** %L_ACF.addr, align 8, !dbg !341
  %arrayidx164 = getelementptr inbounds i64, i64* %136, i64 4, !dbg !341
  %137 = load i64, i64* %arrayidx164, align 8, !dbg !341
  %add165 = add nsw i64 %137, %mul163, !dbg !341
  store i64 %add165, i64* %arrayidx164, align 8, !dbg !341
  %138 = load i16, i16* %sl, align 2, !dbg !342
  %conv166 = sext i16 %138 to i64, !dbg !342
  %139 = load i16*, i16** %sp, align 8, !dbg !342
  %arrayidx167 = getelementptr inbounds i16, i16* %139, i64 -5, !dbg !342
  %140 = load i16, i16* %arrayidx167, align 2, !dbg !342
  %conv168 = sext i16 %140 to i64, !dbg !342
  %mul169 = mul nsw i64 %conv166, %conv168, !dbg !342
  %141 = load i64*, i64** %L_ACF.addr, align 8, !dbg !342
  %arrayidx170 = getelementptr inbounds i64, i64* %141, i64 5, !dbg !342
  %142 = load i64, i64* %arrayidx170, align 8, !dbg !342
  %add171 = add nsw i64 %142, %mul169, !dbg !342
  store i64 %add171, i64* %arrayidx170, align 8, !dbg !342
  %143 = load i16*, i16** %sp, align 8, !dbg !343
  %incdec.ptr172 = getelementptr inbounds i16, i16* %143, i32 1, !dbg !343
  store i16* %incdec.ptr172, i16** %sp, align 8, !dbg !343
  %144 = load i16, i16* %incdec.ptr172, align 2, !dbg !343
  store i16 %144, i16* %sl, align 2, !dbg !343
  %145 = load i16, i16* %sl, align 2, !dbg !344
  %conv173 = sext i16 %145 to i64, !dbg !344
  %146 = load i16*, i16** %sp, align 8, !dbg !344
  %arrayidx174 = getelementptr inbounds i16, i16* %146, i64 0, !dbg !344
  %147 = load i16, i16* %arrayidx174, align 2, !dbg !344
  %conv175 = sext i16 %147 to i64, !dbg !344
  %mul176 = mul nsw i64 %conv173, %conv175, !dbg !344
  %148 = load i64*, i64** %L_ACF.addr, align 8, !dbg !344
  %arrayidx177 = getelementptr inbounds i64, i64* %148, i64 0, !dbg !344
  %149 = load i64, i64* %arrayidx177, align 8, !dbg !344
  %add178 = add nsw i64 %149, %mul176, !dbg !344
  store i64 %add178, i64* %arrayidx177, align 8, !dbg !344
  %150 = load i16, i16* %sl, align 2, !dbg !345
  %conv179 = sext i16 %150 to i64, !dbg !345
  %151 = load i16*, i16** %sp, align 8, !dbg !345
  %arrayidx180 = getelementptr inbounds i16, i16* %151, i64 -1, !dbg !345
  %152 = load i16, i16* %arrayidx180, align 2, !dbg !345
  %conv181 = sext i16 %152 to i64, !dbg !345
  %mul182 = mul nsw i64 %conv179, %conv181, !dbg !345
  %153 = load i64*, i64** %L_ACF.addr, align 8, !dbg !345
  %arrayidx183 = getelementptr inbounds i64, i64* %153, i64 1, !dbg !345
  %154 = load i64, i64* %arrayidx183, align 8, !dbg !345
  %add184 = add nsw i64 %154, %mul182, !dbg !345
  store i64 %add184, i64* %arrayidx183, align 8, !dbg !345
  %155 = load i16, i16* %sl, align 2, !dbg !346
  %conv185 = sext i16 %155 to i64, !dbg !346
  %156 = load i16*, i16** %sp, align 8, !dbg !346
  %arrayidx186 = getelementptr inbounds i16, i16* %156, i64 -2, !dbg !346
  %157 = load i16, i16* %arrayidx186, align 2, !dbg !346
  %conv187 = sext i16 %157 to i64, !dbg !346
  %mul188 = mul nsw i64 %conv185, %conv187, !dbg !346
  %158 = load i64*, i64** %L_ACF.addr, align 8, !dbg !346
  %arrayidx189 = getelementptr inbounds i64, i64* %158, i64 2, !dbg !346
  %159 = load i64, i64* %arrayidx189, align 8, !dbg !346
  %add190 = add nsw i64 %159, %mul188, !dbg !346
  store i64 %add190, i64* %arrayidx189, align 8, !dbg !346
  %160 = load i16, i16* %sl, align 2, !dbg !347
  %conv191 = sext i16 %160 to i64, !dbg !347
  %161 = load i16*, i16** %sp, align 8, !dbg !347
  %arrayidx192 = getelementptr inbounds i16, i16* %161, i64 -3, !dbg !347
  %162 = load i16, i16* %arrayidx192, align 2, !dbg !347
  %conv193 = sext i16 %162 to i64, !dbg !347
  %mul194 = mul nsw i64 %conv191, %conv193, !dbg !347
  %163 = load i64*, i64** %L_ACF.addr, align 8, !dbg !347
  %arrayidx195 = getelementptr inbounds i64, i64* %163, i64 3, !dbg !347
  %164 = load i64, i64* %arrayidx195, align 8, !dbg !347
  %add196 = add nsw i64 %164, %mul194, !dbg !347
  store i64 %add196, i64* %arrayidx195, align 8, !dbg !347
  %165 = load i16, i16* %sl, align 2, !dbg !348
  %conv197 = sext i16 %165 to i64, !dbg !348
  %166 = load i16*, i16** %sp, align 8, !dbg !348
  %arrayidx198 = getelementptr inbounds i16, i16* %166, i64 -4, !dbg !348
  %167 = load i16, i16* %arrayidx198, align 2, !dbg !348
  %conv199 = sext i16 %167 to i64, !dbg !348
  %mul200 = mul nsw i64 %conv197, %conv199, !dbg !348
  %168 = load i64*, i64** %L_ACF.addr, align 8, !dbg !348
  %arrayidx201 = getelementptr inbounds i64, i64* %168, i64 4, !dbg !348
  %169 = load i64, i64* %arrayidx201, align 8, !dbg !348
  %add202 = add nsw i64 %169, %mul200, !dbg !348
  store i64 %add202, i64* %arrayidx201, align 8, !dbg !348
  %170 = load i16, i16* %sl, align 2, !dbg !349
  %conv203 = sext i16 %170 to i64, !dbg !349
  %171 = load i16*, i16** %sp, align 8, !dbg !349
  %arrayidx204 = getelementptr inbounds i16, i16* %171, i64 -5, !dbg !349
  %172 = load i16, i16* %arrayidx204, align 2, !dbg !349
  %conv205 = sext i16 %172 to i64, !dbg !349
  %mul206 = mul nsw i64 %conv203, %conv205, !dbg !349
  %173 = load i64*, i64** %L_ACF.addr, align 8, !dbg !349
  %arrayidx207 = getelementptr inbounds i64, i64* %173, i64 5, !dbg !349
  %174 = load i64, i64* %arrayidx207, align 8, !dbg !349
  %add208 = add nsw i64 %174, %mul206, !dbg !349
  store i64 %add208, i64* %arrayidx207, align 8, !dbg !349
  %175 = load i16, i16* %sl, align 2, !dbg !350
  %conv209 = sext i16 %175 to i64, !dbg !350
  %176 = load i16*, i16** %sp, align 8, !dbg !350
  %arrayidx210 = getelementptr inbounds i16, i16* %176, i64 -6, !dbg !350
  %177 = load i16, i16* %arrayidx210, align 2, !dbg !350
  %conv211 = sext i16 %177 to i64, !dbg !350
  %mul212 = mul nsw i64 %conv209, %conv211, !dbg !350
  %178 = load i64*, i64** %L_ACF.addr, align 8, !dbg !350
  %arrayidx213 = getelementptr inbounds i64, i64* %178, i64 6, !dbg !350
  %179 = load i64, i64* %arrayidx213, align 8, !dbg !350
  %add214 = add nsw i64 %179, %mul212, !dbg !350
  store i64 %add214, i64* %arrayidx213, align 8, !dbg !350
  %180 = load i16*, i16** %sp, align 8, !dbg !351
  %incdec.ptr215 = getelementptr inbounds i16, i16* %180, i32 1, !dbg !351
  store i16* %incdec.ptr215, i16** %sp, align 8, !dbg !351
  %181 = load i16, i16* %incdec.ptr215, align 2, !dbg !351
  store i16 %181, i16* %sl, align 2, !dbg !351
  %182 = load i16, i16* %sl, align 2, !dbg !352
  %conv216 = sext i16 %182 to i64, !dbg !352
  %183 = load i16*, i16** %sp, align 8, !dbg !352
  %arrayidx217 = getelementptr inbounds i16, i16* %183, i64 0, !dbg !352
  %184 = load i16, i16* %arrayidx217, align 2, !dbg !352
  %conv218 = sext i16 %184 to i64, !dbg !352
  %mul219 = mul nsw i64 %conv216, %conv218, !dbg !352
  %185 = load i64*, i64** %L_ACF.addr, align 8, !dbg !352
  %arrayidx220 = getelementptr inbounds i64, i64* %185, i64 0, !dbg !352
  %186 = load i64, i64* %arrayidx220, align 8, !dbg !352
  %add221 = add nsw i64 %186, %mul219, !dbg !352
  store i64 %add221, i64* %arrayidx220, align 8, !dbg !352
  %187 = load i16, i16* %sl, align 2, !dbg !353
  %conv222 = sext i16 %187 to i64, !dbg !353
  %188 = load i16*, i16** %sp, align 8, !dbg !353
  %arrayidx223 = getelementptr inbounds i16, i16* %188, i64 -1, !dbg !353
  %189 = load i16, i16* %arrayidx223, align 2, !dbg !353
  %conv224 = sext i16 %189 to i64, !dbg !353
  %mul225 = mul nsw i64 %conv222, %conv224, !dbg !353
  %190 = load i64*, i64** %L_ACF.addr, align 8, !dbg !353
  %arrayidx226 = getelementptr inbounds i64, i64* %190, i64 1, !dbg !353
  %191 = load i64, i64* %arrayidx226, align 8, !dbg !353
  %add227 = add nsw i64 %191, %mul225, !dbg !353
  store i64 %add227, i64* %arrayidx226, align 8, !dbg !353
  %192 = load i16, i16* %sl, align 2, !dbg !354
  %conv228 = sext i16 %192 to i64, !dbg !354
  %193 = load i16*, i16** %sp, align 8, !dbg !354
  %arrayidx229 = getelementptr inbounds i16, i16* %193, i64 -2, !dbg !354
  %194 = load i16, i16* %arrayidx229, align 2, !dbg !354
  %conv230 = sext i16 %194 to i64, !dbg !354
  %mul231 = mul nsw i64 %conv228, %conv230, !dbg !354
  %195 = load i64*, i64** %L_ACF.addr, align 8, !dbg !354
  %arrayidx232 = getelementptr inbounds i64, i64* %195, i64 2, !dbg !354
  %196 = load i64, i64* %arrayidx232, align 8, !dbg !354
  %add233 = add nsw i64 %196, %mul231, !dbg !354
  store i64 %add233, i64* %arrayidx232, align 8, !dbg !354
  %197 = load i16, i16* %sl, align 2, !dbg !355
  %conv234 = sext i16 %197 to i64, !dbg !355
  %198 = load i16*, i16** %sp, align 8, !dbg !355
  %arrayidx235 = getelementptr inbounds i16, i16* %198, i64 -3, !dbg !355
  %199 = load i16, i16* %arrayidx235, align 2, !dbg !355
  %conv236 = sext i16 %199 to i64, !dbg !355
  %mul237 = mul nsw i64 %conv234, %conv236, !dbg !355
  %200 = load i64*, i64** %L_ACF.addr, align 8, !dbg !355
  %arrayidx238 = getelementptr inbounds i64, i64* %200, i64 3, !dbg !355
  %201 = load i64, i64* %arrayidx238, align 8, !dbg !355
  %add239 = add nsw i64 %201, %mul237, !dbg !355
  store i64 %add239, i64* %arrayidx238, align 8, !dbg !355
  %202 = load i16, i16* %sl, align 2, !dbg !356
  %conv240 = sext i16 %202 to i64, !dbg !356
  %203 = load i16*, i16** %sp, align 8, !dbg !356
  %arrayidx241 = getelementptr inbounds i16, i16* %203, i64 -4, !dbg !356
  %204 = load i16, i16* %arrayidx241, align 2, !dbg !356
  %conv242 = sext i16 %204 to i64, !dbg !356
  %mul243 = mul nsw i64 %conv240, %conv242, !dbg !356
  %205 = load i64*, i64** %L_ACF.addr, align 8, !dbg !356
  %arrayidx244 = getelementptr inbounds i64, i64* %205, i64 4, !dbg !356
  %206 = load i64, i64* %arrayidx244, align 8, !dbg !356
  %add245 = add nsw i64 %206, %mul243, !dbg !356
  store i64 %add245, i64* %arrayidx244, align 8, !dbg !356
  %207 = load i16, i16* %sl, align 2, !dbg !357
  %conv246 = sext i16 %207 to i64, !dbg !357
  %208 = load i16*, i16** %sp, align 8, !dbg !357
  %arrayidx247 = getelementptr inbounds i16, i16* %208, i64 -5, !dbg !357
  %209 = load i16, i16* %arrayidx247, align 2, !dbg !357
  %conv248 = sext i16 %209 to i64, !dbg !357
  %mul249 = mul nsw i64 %conv246, %conv248, !dbg !357
  %210 = load i64*, i64** %L_ACF.addr, align 8, !dbg !357
  %arrayidx250 = getelementptr inbounds i64, i64* %210, i64 5, !dbg !357
  %211 = load i64, i64* %arrayidx250, align 8, !dbg !357
  %add251 = add nsw i64 %211, %mul249, !dbg !357
  store i64 %add251, i64* %arrayidx250, align 8, !dbg !357
  %212 = load i16, i16* %sl, align 2, !dbg !358
  %conv252 = sext i16 %212 to i64, !dbg !358
  %213 = load i16*, i16** %sp, align 8, !dbg !358
  %arrayidx253 = getelementptr inbounds i16, i16* %213, i64 -6, !dbg !358
  %214 = load i16, i16* %arrayidx253, align 2, !dbg !358
  %conv254 = sext i16 %214 to i64, !dbg !358
  %mul255 = mul nsw i64 %conv252, %conv254, !dbg !358
  %215 = load i64*, i64** %L_ACF.addr, align 8, !dbg !358
  %arrayidx256 = getelementptr inbounds i64, i64* %215, i64 6, !dbg !358
  %216 = load i64, i64* %arrayidx256, align 8, !dbg !358
  %add257 = add nsw i64 %216, %mul255, !dbg !358
  store i64 %add257, i64* %arrayidx256, align 8, !dbg !358
  %217 = load i16, i16* %sl, align 2, !dbg !359
  %conv258 = sext i16 %217 to i64, !dbg !359
  %218 = load i16*, i16** %sp, align 8, !dbg !359
  %arrayidx259 = getelementptr inbounds i16, i16* %218, i64 -7, !dbg !359
  %219 = load i16, i16* %arrayidx259, align 2, !dbg !359
  %conv260 = sext i16 %219 to i64, !dbg !359
  %mul261 = mul nsw i64 %conv258, %conv260, !dbg !359
  %220 = load i64*, i64** %L_ACF.addr, align 8, !dbg !359
  %arrayidx262 = getelementptr inbounds i64, i64* %220, i64 7, !dbg !359
  %221 = load i64, i64* %arrayidx262, align 8, !dbg !359
  %add263 = add nsw i64 %221, %mul261, !dbg !359
  store i64 %add263, i64* %arrayidx262, align 8, !dbg !359
  br label %Autocorrelation_label3, !dbg !359

Autocorrelation_label3:                           ; preds = %for.end43
  call void @llvm.dbg.label(metadata !360), !dbg !361
  store i32 8, i32* %i, align 4, !dbg !362
  br label %for.cond264, !dbg !364

for.cond264:                                      ; preds = %for.inc323, %Autocorrelation_label3
  %222 = load i32, i32* %i, align 4, !dbg !365
  %cmp265 = icmp sle i32 %222, 159, !dbg !367
  br i1 %cmp265, label %for.body267, label %for.end325, !dbg !368

for.body267:                                      ; preds = %for.cond264
  %223 = load i16*, i16** %sp, align 8, !dbg !369
  %incdec.ptr268 = getelementptr inbounds i16, i16* %223, i32 1, !dbg !369
  store i16* %incdec.ptr268, i16** %sp, align 8, !dbg !369
  %224 = load i16, i16* %incdec.ptr268, align 2, !dbg !369
  store i16 %224, i16* %sl, align 2, !dbg !369
  %225 = load i16, i16* %sl, align 2, !dbg !371
  %conv269 = sext i16 %225 to i64, !dbg !371
  %226 = load i16*, i16** %sp, align 8, !dbg !371
  %arrayidx270 = getelementptr inbounds i16, i16* %226, i64 0, !dbg !371
  %227 = load i16, i16* %arrayidx270, align 2, !dbg !371
  %conv271 = sext i16 %227 to i64, !dbg !371
  %mul272 = mul nsw i64 %conv269, %conv271, !dbg !371
  %228 = load i64*, i64** %L_ACF.addr, align 8, !dbg !371
  %arrayidx273 = getelementptr inbounds i64, i64* %228, i64 0, !dbg !371
  %229 = load i64, i64* %arrayidx273, align 8, !dbg !371
  %add274 = add nsw i64 %229, %mul272, !dbg !371
  store i64 %add274, i64* %arrayidx273, align 8, !dbg !371
  %230 = load i16, i16* %sl, align 2, !dbg !372
  %conv275 = sext i16 %230 to i64, !dbg !372
  %231 = load i16*, i16** %sp, align 8, !dbg !372
  %arrayidx276 = getelementptr inbounds i16, i16* %231, i64 -1, !dbg !372
  %232 = load i16, i16* %arrayidx276, align 2, !dbg !372
  %conv277 = sext i16 %232 to i64, !dbg !372
  %mul278 = mul nsw i64 %conv275, %conv277, !dbg !372
  %233 = load i64*, i64** %L_ACF.addr, align 8, !dbg !372
  %arrayidx279 = getelementptr inbounds i64, i64* %233, i64 1, !dbg !372
  %234 = load i64, i64* %arrayidx279, align 8, !dbg !372
  %add280 = add nsw i64 %234, %mul278, !dbg !372
  store i64 %add280, i64* %arrayidx279, align 8, !dbg !372
  %235 = load i16, i16* %sl, align 2, !dbg !373
  %conv281 = sext i16 %235 to i64, !dbg !373
  %236 = load i16*, i16** %sp, align 8, !dbg !373
  %arrayidx282 = getelementptr inbounds i16, i16* %236, i64 -2, !dbg !373
  %237 = load i16, i16* %arrayidx282, align 2, !dbg !373
  %conv283 = sext i16 %237 to i64, !dbg !373
  %mul284 = mul nsw i64 %conv281, %conv283, !dbg !373
  %238 = load i64*, i64** %L_ACF.addr, align 8, !dbg !373
  %arrayidx285 = getelementptr inbounds i64, i64* %238, i64 2, !dbg !373
  %239 = load i64, i64* %arrayidx285, align 8, !dbg !373
  %add286 = add nsw i64 %239, %mul284, !dbg !373
  store i64 %add286, i64* %arrayidx285, align 8, !dbg !373
  %240 = load i16, i16* %sl, align 2, !dbg !374
  %conv287 = sext i16 %240 to i64, !dbg !374
  %241 = load i16*, i16** %sp, align 8, !dbg !374
  %arrayidx288 = getelementptr inbounds i16, i16* %241, i64 -3, !dbg !374
  %242 = load i16, i16* %arrayidx288, align 2, !dbg !374
  %conv289 = sext i16 %242 to i64, !dbg !374
  %mul290 = mul nsw i64 %conv287, %conv289, !dbg !374
  %243 = load i64*, i64** %L_ACF.addr, align 8, !dbg !374
  %arrayidx291 = getelementptr inbounds i64, i64* %243, i64 3, !dbg !374
  %244 = load i64, i64* %arrayidx291, align 8, !dbg !374
  %add292 = add nsw i64 %244, %mul290, !dbg !374
  store i64 %add292, i64* %arrayidx291, align 8, !dbg !374
  %245 = load i16, i16* %sl, align 2, !dbg !375
  %conv293 = sext i16 %245 to i64, !dbg !375
  %246 = load i16*, i16** %sp, align 8, !dbg !375
  %arrayidx294 = getelementptr inbounds i16, i16* %246, i64 -4, !dbg !375
  %247 = load i16, i16* %arrayidx294, align 2, !dbg !375
  %conv295 = sext i16 %247 to i64, !dbg !375
  %mul296 = mul nsw i64 %conv293, %conv295, !dbg !375
  %248 = load i64*, i64** %L_ACF.addr, align 8, !dbg !375
  %arrayidx297 = getelementptr inbounds i64, i64* %248, i64 4, !dbg !375
  %249 = load i64, i64* %arrayidx297, align 8, !dbg !375
  %add298 = add nsw i64 %249, %mul296, !dbg !375
  store i64 %add298, i64* %arrayidx297, align 8, !dbg !375
  %250 = load i16, i16* %sl, align 2, !dbg !376
  %conv299 = sext i16 %250 to i64, !dbg !376
  %251 = load i16*, i16** %sp, align 8, !dbg !376
  %arrayidx300 = getelementptr inbounds i16, i16* %251, i64 -5, !dbg !376
  %252 = load i16, i16* %arrayidx300, align 2, !dbg !376
  %conv301 = sext i16 %252 to i64, !dbg !376
  %mul302 = mul nsw i64 %conv299, %conv301, !dbg !376
  %253 = load i64*, i64** %L_ACF.addr, align 8, !dbg !376
  %arrayidx303 = getelementptr inbounds i64, i64* %253, i64 5, !dbg !376
  %254 = load i64, i64* %arrayidx303, align 8, !dbg !376
  %add304 = add nsw i64 %254, %mul302, !dbg !376
  store i64 %add304, i64* %arrayidx303, align 8, !dbg !376
  %255 = load i16, i16* %sl, align 2, !dbg !377
  %conv305 = sext i16 %255 to i64, !dbg !377
  %256 = load i16*, i16** %sp, align 8, !dbg !377
  %arrayidx306 = getelementptr inbounds i16, i16* %256, i64 -6, !dbg !377
  %257 = load i16, i16* %arrayidx306, align 2, !dbg !377
  %conv307 = sext i16 %257 to i64, !dbg !377
  %mul308 = mul nsw i64 %conv305, %conv307, !dbg !377
  %258 = load i64*, i64** %L_ACF.addr, align 8, !dbg !377
  %arrayidx309 = getelementptr inbounds i64, i64* %258, i64 6, !dbg !377
  %259 = load i64, i64* %arrayidx309, align 8, !dbg !377
  %add310 = add nsw i64 %259, %mul308, !dbg !377
  store i64 %add310, i64* %arrayidx309, align 8, !dbg !377
  %260 = load i16, i16* %sl, align 2, !dbg !378
  %conv311 = sext i16 %260 to i64, !dbg !378
  %261 = load i16*, i16** %sp, align 8, !dbg !378
  %arrayidx312 = getelementptr inbounds i16, i16* %261, i64 -7, !dbg !378
  %262 = load i16, i16* %arrayidx312, align 2, !dbg !378
  %conv313 = sext i16 %262 to i64, !dbg !378
  %mul314 = mul nsw i64 %conv311, %conv313, !dbg !378
  %263 = load i64*, i64** %L_ACF.addr, align 8, !dbg !378
  %arrayidx315 = getelementptr inbounds i64, i64* %263, i64 7, !dbg !378
  %264 = load i64, i64* %arrayidx315, align 8, !dbg !378
  %add316 = add nsw i64 %264, %mul314, !dbg !378
  store i64 %add316, i64* %arrayidx315, align 8, !dbg !378
  %265 = load i16, i16* %sl, align 2, !dbg !379
  %conv317 = sext i16 %265 to i64, !dbg !379
  %266 = load i16*, i16** %sp, align 8, !dbg !379
  %arrayidx318 = getelementptr inbounds i16, i16* %266, i64 -8, !dbg !379
  %267 = load i16, i16* %arrayidx318, align 2, !dbg !379
  %conv319 = sext i16 %267 to i64, !dbg !379
  %mul320 = mul nsw i64 %conv317, %conv319, !dbg !379
  %268 = load i64*, i64** %L_ACF.addr, align 8, !dbg !379
  %arrayidx321 = getelementptr inbounds i64, i64* %268, i64 8, !dbg !379
  %269 = load i64, i64* %arrayidx321, align 8, !dbg !379
  %add322 = add nsw i64 %269, %mul320, !dbg !379
  store i64 %add322, i64* %arrayidx321, align 8, !dbg !379
  br label %for.inc323, !dbg !380

for.inc323:                                       ; preds = %for.body267
  %270 = load i32, i32* %i, align 4, !dbg !381
  %inc324 = add nsw i32 %270, 1, !dbg !381
  store i32 %inc324, i32* %i, align 4, !dbg !381
  br label %for.cond264, !dbg !382, !llvm.loop !383

for.end325:                                       ; preds = %for.cond264
  br label %Autocorrelation_label4, !dbg !384

Autocorrelation_label4:                           ; preds = %for.end325
  call void @llvm.dbg.label(metadata !385), !dbg !386
  store i32 8, i32* %k, align 4, !dbg !387
  br label %for.cond326, !dbg !389

for.cond326:                                      ; preds = %for.inc333, %Autocorrelation_label4
  %271 = load i32, i32* %k, align 4, !dbg !390
  %cmp327 = icmp sge i32 %271, 0, !dbg !392
  br i1 %cmp327, label %for.body329, label %for.end335, !dbg !393

for.body329:                                      ; preds = %for.cond326
  %272 = load i64*, i64** %L_ACF.addr, align 8, !dbg !394
  %273 = load i32, i32* %k, align 4, !dbg !396
  %idxprom330 = sext i32 %273 to i64, !dbg !394
  %arrayidx331 = getelementptr inbounds i64, i64* %272, i64 %idxprom330, !dbg !394
  %274 = load i64, i64* %arrayidx331, align 8, !dbg !397
  %shl332 = shl i64 %274, 1, !dbg !397
  store i64 %shl332, i64* %arrayidx331, align 8, !dbg !397
  br label %for.inc333, !dbg !398

for.inc333:                                       ; preds = %for.body329
  %275 = load i32, i32* %k, align 4, !dbg !399
  %dec334 = add nsw i32 %275, -1, !dbg !399
  store i32 %dec334, i32* %k, align 4, !dbg !399
  br label %for.cond326, !dbg !400, !llvm.loop !401

for.end335:                                       ; preds = %for.cond326
  %276 = load i16, i16* %scalauto, align 2, !dbg !403
  %conv336 = sext i16 %276 to i32, !dbg !403
  %cmp337 = icmp sgt i32 %conv336, 0, !dbg !405
  br i1 %cmp337, label %if.then339, label %if.end352, !dbg !406

if.then339:                                       ; preds = %for.end335
  br label %Autocorrelation_label5, !dbg !407

Autocorrelation_label5:                           ; preds = %if.then339
  call void @llvm.dbg.label(metadata !408), !dbg !410
  store i32 159, i32* %k, align 4, !dbg !411
  br label %for.cond340, !dbg !413

for.cond340:                                      ; preds = %for.inc349, %Autocorrelation_label5
  %277 = load i32, i32* %k, align 4, !dbg !414
  %cmp341 = icmp sge i32 %277, 0, !dbg !416
  br i1 %cmp341, label %for.body343, label %for.end351, !dbg !417

for.body343:                                      ; preds = %for.cond340
  %278 = load i16, i16* %scalauto, align 2, !dbg !418
  %conv344 = sext i16 %278 to i32, !dbg !418
  %279 = load i16*, i16** %s.addr, align 8, !dbg !420
  %incdec.ptr345 = getelementptr inbounds i16, i16* %279, i32 1, !dbg !420
  store i16* %incdec.ptr345, i16** %s.addr, align 8, !dbg !420
  %280 = load i16, i16* %279, align 2, !dbg !421
  %conv346 = sext i16 %280 to i32, !dbg !421
  %shl347 = shl i32 %conv346, %conv344, !dbg !421
  %conv348 = trunc i32 %shl347 to i16, !dbg !421
  store i16 %conv348, i16* %279, align 2, !dbg !421
  br label %for.inc349, !dbg !422

for.inc349:                                       ; preds = %for.body343
  %281 = load i32, i32* %k, align 4, !dbg !423
  %dec350 = add nsw i32 %281, -1, !dbg !423
  store i32 %dec350, i32* %k, align 4, !dbg !423
  br label %for.cond340, !dbg !424, !llvm.loop !425

for.end351:                                       ; preds = %for.cond340
  br label %if.end352, !dbg !427

if.end352:                                        ; preds = %for.end351, %for.end335
  ret void, !dbg !428
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Reflection_coefficients(i64* noundef %L_ACF, i16* noundef %r) #0 !dbg !429 {
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
  call void @llvm.dbg.declare(metadata i64** %L_ACF.addr, metadata !432, metadata !DIExpression()), !dbg !433
  store i16* %r, i16** %r.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %r.addr, metadata !434, metadata !DIExpression()), !dbg !435
  call void @llvm.dbg.declare(metadata i32* %i, metadata !436, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.declare(metadata i32* %m, metadata !438, metadata !DIExpression()), !dbg !439
  call void @llvm.dbg.declare(metadata i32* %n, metadata !440, metadata !DIExpression()), !dbg !441
  call void @llvm.dbg.declare(metadata i16* %temp, metadata !442, metadata !DIExpression()), !dbg !443
  call void @llvm.dbg.declare(metadata [9 x i16]* %ACF, metadata !444, metadata !DIExpression()), !dbg !448
  call void @llvm.dbg.declare(metadata [9 x i16]* %P, metadata !449, metadata !DIExpression()), !dbg !450
  call void @llvm.dbg.declare(metadata [9 x i16]* %K, metadata !451, metadata !DIExpression()), !dbg !452
  %0 = load i64*, i64** %L_ACF.addr, align 8, !dbg !453
  %arrayidx = getelementptr inbounds i64, i64* %0, i64 0, !dbg !453
  %1 = load i64, i64* %arrayidx, align 8, !dbg !453
  %cmp = icmp eq i64 %1, 0, !dbg !455
  br i1 %cmp, label %if.then, label %if.end, !dbg !456

if.then:                                          ; preds = %entry
  br label %Reflection_coefficients_label0, !dbg !457

Reflection_coefficients_label0:                   ; preds = %if.then
  call void @llvm.dbg.label(metadata !458), !dbg !460
  store i32 8, i32* %i, align 4, !dbg !461
  br label %for.cond, !dbg !463

for.cond:                                         ; preds = %for.inc, %Reflection_coefficients_label0
  %2 = load i32, i32* %i, align 4, !dbg !464
  %cmp1 = icmp sgt i32 %2, 0, !dbg !466
  br i1 %cmp1, label %for.body, label %for.end, !dbg !467

for.body:                                         ; preds = %for.cond
  %3 = load i16*, i16** %r.addr, align 8, !dbg !468
  %incdec.ptr = getelementptr inbounds i16, i16* %3, i32 1, !dbg !468
  store i16* %incdec.ptr, i16** %r.addr, align 8, !dbg !468
  store i16 0, i16* %3, align 2, !dbg !470
  br label %for.inc, !dbg !471

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !dbg !472
  %dec = add nsw i32 %4, -1, !dbg !472
  store i32 %dec, i32* %i, align 4, !dbg !472
  br label %for.cond, !dbg !473, !llvm.loop !474

for.end:                                          ; preds = %for.cond
  br label %for.end102, !dbg !476

if.end:                                           ; preds = %entry
  %5 = load i64*, i64** %L_ACF.addr, align 8, !dbg !477
  %arrayidx2 = getelementptr inbounds i64, i64* %5, i64 0, !dbg !477
  %6 = load i64, i64* %arrayidx2, align 8, !dbg !477
  %call = call signext i16 @gsm_norm(i64 noundef %6), !dbg !478
  store i16 %call, i16* %temp, align 2, !dbg !479
  br label %Reflection_coefficients_label1, !dbg !480

Reflection_coefficients_label1:                   ; preds = %if.end
  call void @llvm.dbg.label(metadata !481), !dbg !482
  store i32 0, i32* %i, align 4, !dbg !483
  br label %for.cond3, !dbg !485

for.cond3:                                        ; preds = %for.inc10, %Reflection_coefficients_label1
  %7 = load i32, i32* %i, align 4, !dbg !486
  %cmp4 = icmp sle i32 %7, 8, !dbg !488
  br i1 %cmp4, label %for.body5, label %for.end11, !dbg !489

for.body5:                                        ; preds = %for.cond3
  %8 = load i64*, i64** %L_ACF.addr, align 8, !dbg !490
  %9 = load i32, i32* %i, align 4, !dbg !490
  %idxprom = sext i32 %9 to i64, !dbg !490
  %arrayidx6 = getelementptr inbounds i64, i64* %8, i64 %idxprom, !dbg !490
  %10 = load i64, i64* %arrayidx6, align 8, !dbg !490
  %11 = load i16, i16* %temp, align 2, !dbg !490
  %conv = sext i16 %11 to i32, !dbg !490
  %sh_prom = zext i32 %conv to i64, !dbg !490
  %shl = shl i64 %10, %sh_prom, !dbg !490
  %shr = ashr i64 %shl, 16, !dbg !490
  %conv7 = trunc i64 %shr to i16, !dbg !490
  %12 = load i32, i32* %i, align 4, !dbg !492
  %idxprom8 = sext i32 %12 to i64, !dbg !493
  %arrayidx9 = getelementptr inbounds [9 x i16], [9 x i16]* %ACF, i64 0, i64 %idxprom8, !dbg !493
  store i16 %conv7, i16* %arrayidx9, align 2, !dbg !494
  br label %for.inc10, !dbg !495

for.inc10:                                        ; preds = %for.body5
  %13 = load i32, i32* %i, align 4, !dbg !496
  %inc = add nsw i32 %13, 1, !dbg !496
  store i32 %inc, i32* %i, align 4, !dbg !496
  br label %for.cond3, !dbg !497, !llvm.loop !498

for.end11:                                        ; preds = %for.cond3
  br label %Reflection_coefficients_label2, !dbg !499

Reflection_coefficients_label2:                   ; preds = %for.end11
  call void @llvm.dbg.label(metadata !500), !dbg !501
  store i32 1, i32* %i, align 4, !dbg !502
  br label %for.cond12, !dbg !504

for.cond12:                                       ; preds = %for.inc20, %Reflection_coefficients_label2
  %14 = load i32, i32* %i, align 4, !dbg !505
  %cmp13 = icmp sle i32 %14, 7, !dbg !507
  br i1 %cmp13, label %for.body15, label %for.end22, !dbg !508

for.body15:                                       ; preds = %for.cond12
  %15 = load i32, i32* %i, align 4, !dbg !509
  %idxprom16 = sext i32 %15 to i64, !dbg !511
  %arrayidx17 = getelementptr inbounds [9 x i16], [9 x i16]* %ACF, i64 0, i64 %idxprom16, !dbg !511
  %16 = load i16, i16* %arrayidx17, align 2, !dbg !511
  %17 = load i32, i32* %i, align 4, !dbg !512
  %idxprom18 = sext i32 %17 to i64, !dbg !513
  %arrayidx19 = getelementptr inbounds [9 x i16], [9 x i16]* %K, i64 0, i64 %idxprom18, !dbg !513
  store i16 %16, i16* %arrayidx19, align 2, !dbg !514
  br label %for.inc20, !dbg !515

for.inc20:                                        ; preds = %for.body15
  %18 = load i32, i32* %i, align 4, !dbg !516
  %inc21 = add nsw i32 %18, 1, !dbg !516
  store i32 %inc21, i32* %i, align 4, !dbg !516
  br label %for.cond12, !dbg !517, !llvm.loop !518

for.end22:                                        ; preds = %for.cond12
  br label %Reflection_coefficients_label3, !dbg !519

Reflection_coefficients_label3:                   ; preds = %for.end22
  call void @llvm.dbg.label(metadata !520), !dbg !521
  store i32 0, i32* %i, align 4, !dbg !522
  br label %for.cond23, !dbg !524

for.cond23:                                       ; preds = %for.inc31, %Reflection_coefficients_label3
  %19 = load i32, i32* %i, align 4, !dbg !525
  %cmp24 = icmp sle i32 %19, 8, !dbg !527
  br i1 %cmp24, label %for.body26, label %for.end33, !dbg !528

for.body26:                                       ; preds = %for.cond23
  %20 = load i32, i32* %i, align 4, !dbg !529
  %idxprom27 = sext i32 %20 to i64, !dbg !531
  %arrayidx28 = getelementptr inbounds [9 x i16], [9 x i16]* %ACF, i64 0, i64 %idxprom27, !dbg !531
  %21 = load i16, i16* %arrayidx28, align 2, !dbg !531
  %22 = load i32, i32* %i, align 4, !dbg !532
  %idxprom29 = sext i32 %22 to i64, !dbg !533
  %arrayidx30 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 %idxprom29, !dbg !533
  store i16 %21, i16* %arrayidx30, align 2, !dbg !534
  br label %for.inc31, !dbg !535

for.inc31:                                        ; preds = %for.body26
  %23 = load i32, i32* %i, align 4, !dbg !536
  %inc32 = add nsw i32 %23, 1, !dbg !536
  store i32 %inc32, i32* %i, align 4, !dbg !536
  br label %for.cond23, !dbg !537, !llvm.loop !538

for.end33:                                        ; preds = %for.cond23
  br label %Reflection_coefficients_label4, !dbg !539

Reflection_coefficients_label4:                   ; preds = %for.end33
  call void @llvm.dbg.label(metadata !540), !dbg !541
  store i32 1, i32* %n, align 4, !dbg !542
  br label %for.cond34, !dbg !544

for.cond34:                                       ; preds = %for.inc99, %Reflection_coefficients_label4
  %24 = load i32, i32* %n, align 4, !dbg !545
  %cmp35 = icmp sle i32 %24, 8, !dbg !547
  br i1 %cmp35, label %for.body37, label %for.end102, !dbg !548

for.body37:                                       ; preds = %for.cond34
  %arrayidx38 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 1, !dbg !549
  %25 = load i16, i16* %arrayidx38, align 2, !dbg !549
  store i16 %25, i16* %temp, align 2, !dbg !551
  %26 = load i16, i16* %temp, align 2, !dbg !552
  %call39 = call signext i16 @gsm_abs(i16 noundef signext %26), !dbg !552
  store i16 %call39, i16* %temp, align 2, !dbg !553
  %arrayidx40 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 0, !dbg !554
  %27 = load i16, i16* %arrayidx40, align 16, !dbg !554
  %conv41 = sext i16 %27 to i32, !dbg !554
  %28 = load i16, i16* %temp, align 2, !dbg !556
  %conv42 = sext i16 %28 to i32, !dbg !556
  %cmp43 = icmp slt i32 %conv41, %conv42, !dbg !557
  br i1 %cmp43, label %if.then45, label %if.end54, !dbg !558

if.then45:                                        ; preds = %for.body37
  br label %Reflection_coefficients_label6, !dbg !559

Reflection_coefficients_label6:                   ; preds = %if.then45
  call void @llvm.dbg.label(metadata !560), !dbg !562
  %29 = load i32, i32* %n, align 4, !dbg !563
  store i32 %29, i32* %i, align 4, !dbg !565
  br label %for.cond46, !dbg !566

for.cond46:                                       ; preds = %for.inc51, %Reflection_coefficients_label6
  %30 = load i32, i32* %i, align 4, !dbg !567
  %cmp47 = icmp sle i32 %30, 8, !dbg !569
  br i1 %cmp47, label %for.body49, label %for.end53, !dbg !570

for.body49:                                       ; preds = %for.cond46
  %31 = load i16*, i16** %r.addr, align 8, !dbg !571
  %incdec.ptr50 = getelementptr inbounds i16, i16* %31, i32 1, !dbg !571
  store i16* %incdec.ptr50, i16** %r.addr, align 8, !dbg !571
  store i16 0, i16* %31, align 2, !dbg !573
  br label %for.inc51, !dbg !574

for.inc51:                                        ; preds = %for.body49
  %32 = load i32, i32* %i, align 4, !dbg !575
  %inc52 = add nsw i32 %32, 1, !dbg !575
  store i32 %inc52, i32* %i, align 4, !dbg !575
  br label %for.cond46, !dbg !576, !llvm.loop !577

for.end53:                                        ; preds = %for.cond46
  br label %for.end102, !dbg !579

if.end54:                                         ; preds = %for.body37
  %33 = load i16, i16* %temp, align 2, !dbg !580
  %arrayidx55 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 0, !dbg !581
  %34 = load i16, i16* %arrayidx55, align 16, !dbg !581
  %call56 = call signext i16 @gsm_div(i16 noundef signext %33, i16 noundef signext %34), !dbg !582
  %35 = load i16*, i16** %r.addr, align 8, !dbg !583
  store i16 %call56, i16* %35, align 2, !dbg !584
  %arrayidx57 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 1, !dbg !585
  %36 = load i16, i16* %arrayidx57, align 2, !dbg !585
  %conv58 = sext i16 %36 to i32, !dbg !585
  %cmp59 = icmp sgt i32 %conv58, 0, !dbg !587
  br i1 %cmp59, label %if.then61, label %if.end64, !dbg !588

if.then61:                                        ; preds = %if.end54
  %37 = load i16*, i16** %r.addr, align 8, !dbg !589
  %38 = load i16, i16* %37, align 2, !dbg !590
  %conv62 = sext i16 %38 to i32, !dbg !590
  %sub = sub nsw i32 0, %conv62, !dbg !591
  %conv63 = trunc i32 %sub to i16, !dbg !591
  %39 = load i16*, i16** %r.addr, align 8, !dbg !592
  store i16 %conv63, i16* %39, align 2, !dbg !593
  br label %if.end64, !dbg !594

if.end64:                                         ; preds = %if.then61, %if.end54
  %40 = load i32, i32* %n, align 4, !dbg !595
  %cmp65 = icmp eq i32 %40, 8, !dbg !597
  br i1 %cmp65, label %if.then67, label %if.end68, !dbg !598

if.then67:                                        ; preds = %if.end64
  br label %for.end102, !dbg !599

if.end68:                                         ; preds = %if.end64
  %arrayidx69 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 1, !dbg !600
  %41 = load i16, i16* %arrayidx69, align 2, !dbg !600
  %42 = load i16*, i16** %r.addr, align 8, !dbg !600
  %43 = load i16, i16* %42, align 2, !dbg !600
  %call70 = call signext i16 @gsm_mult_r(i16 noundef signext %41, i16 noundef signext %43), !dbg !600
  store i16 %call70, i16* %temp, align 2, !dbg !601
  %arrayidx71 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 0, !dbg !602
  %44 = load i16, i16* %arrayidx71, align 16, !dbg !602
  %45 = load i16, i16* %temp, align 2, !dbg !602
  %call72 = call signext i16 @gsm_add(i16 noundef signext %44, i16 noundef signext %45), !dbg !602
  %arrayidx73 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 0, !dbg !603
  store i16 %call72, i16* %arrayidx73, align 16, !dbg !604
  br label %Reflection_coefficients_label5, !dbg !603

Reflection_coefficients_label5:                   ; preds = %if.end68
  call void @llvm.dbg.label(metadata !605), !dbg !606
  store i32 1, i32* %m, align 4, !dbg !607
  br label %for.cond74, !dbg !609

for.cond74:                                       ; preds = %for.inc96, %Reflection_coefficients_label5
  %46 = load i32, i32* %m, align 4, !dbg !610
  %47 = load i32, i32* %n, align 4, !dbg !612
  %sub75 = sub nsw i32 8, %47, !dbg !613
  %cmp76 = icmp sle i32 %46, %sub75, !dbg !614
  br i1 %cmp76, label %for.body78, label %for.end98, !dbg !615

for.body78:                                       ; preds = %for.cond74
  %48 = load i32, i32* %m, align 4, !dbg !616
  %idxprom79 = sext i32 %48 to i64, !dbg !616
  %arrayidx80 = getelementptr inbounds [9 x i16], [9 x i16]* %K, i64 0, i64 %idxprom79, !dbg !616
  %49 = load i16, i16* %arrayidx80, align 2, !dbg !616
  %50 = load i16*, i16** %r.addr, align 8, !dbg !616
  %51 = load i16, i16* %50, align 2, !dbg !616
  %call81 = call signext i16 @gsm_mult_r(i16 noundef signext %49, i16 noundef signext %51), !dbg !616
  store i16 %call81, i16* %temp, align 2, !dbg !618
  %52 = load i32, i32* %m, align 4, !dbg !619
  %add = add nsw i32 %52, 1, !dbg !619
  %idxprom82 = sext i32 %add to i64, !dbg !619
  %arrayidx83 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 %idxprom82, !dbg !619
  %53 = load i16, i16* %arrayidx83, align 2, !dbg !619
  %54 = load i16, i16* %temp, align 2, !dbg !619
  %call84 = call signext i16 @gsm_add(i16 noundef signext %53, i16 noundef signext %54), !dbg !619
  %55 = load i32, i32* %m, align 4, !dbg !620
  %idxprom85 = sext i32 %55 to i64, !dbg !621
  %arrayidx86 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 %idxprom85, !dbg !621
  store i16 %call84, i16* %arrayidx86, align 2, !dbg !622
  %56 = load i32, i32* %m, align 4, !dbg !623
  %add87 = add nsw i32 %56, 1, !dbg !623
  %idxprom88 = sext i32 %add87 to i64, !dbg !623
  %arrayidx89 = getelementptr inbounds [9 x i16], [9 x i16]* %P, i64 0, i64 %idxprom88, !dbg !623
  %57 = load i16, i16* %arrayidx89, align 2, !dbg !623
  %58 = load i16*, i16** %r.addr, align 8, !dbg !623
  %59 = load i16, i16* %58, align 2, !dbg !623
  %call90 = call signext i16 @gsm_mult_r(i16 noundef signext %57, i16 noundef signext %59), !dbg !623
  store i16 %call90, i16* %temp, align 2, !dbg !624
  %60 = load i32, i32* %m, align 4, !dbg !625
  %idxprom91 = sext i32 %60 to i64, !dbg !625
  %arrayidx92 = getelementptr inbounds [9 x i16], [9 x i16]* %K, i64 0, i64 %idxprom91, !dbg !625
  %61 = load i16, i16* %arrayidx92, align 2, !dbg !625
  %62 = load i16, i16* %temp, align 2, !dbg !625
  %call93 = call signext i16 @gsm_add(i16 noundef signext %61, i16 noundef signext %62), !dbg !625
  %63 = load i32, i32* %m, align 4, !dbg !626
  %idxprom94 = sext i32 %63 to i64, !dbg !627
  %arrayidx95 = getelementptr inbounds [9 x i16], [9 x i16]* %K, i64 0, i64 %idxprom94, !dbg !627
  store i16 %call93, i16* %arrayidx95, align 2, !dbg !628
  br label %for.inc96, !dbg !629

for.inc96:                                        ; preds = %for.body78
  %64 = load i32, i32* %m, align 4, !dbg !630
  %inc97 = add nsw i32 %64, 1, !dbg !630
  store i32 %inc97, i32* %m, align 4, !dbg !630
  br label %for.cond74, !dbg !631, !llvm.loop !632

for.end98:                                        ; preds = %for.cond74
  br label %for.inc99, !dbg !634

for.inc99:                                        ; preds = %for.end98
  %65 = load i32, i32* %n, align 4, !dbg !635
  %inc100 = add nsw i32 %65, 1, !dbg !635
  store i32 %inc100, i32* %n, align 4, !dbg !635
  %66 = load i16*, i16** %r.addr, align 8, !dbg !636
  %incdec.ptr101 = getelementptr inbounds i16, i16* %66, i32 1, !dbg !636
  store i16* %incdec.ptr101, i16** %r.addr, align 8, !dbg !636
  br label %for.cond34, !dbg !637, !llvm.loop !638

for.end102:                                       ; preds = %if.then67, %for.end53, %for.cond34, %for.end
  ret void, !dbg !640
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Transformation_to_Log_Area_Ratios(i16* noundef %r) #0 !dbg !641 {
entry:
  %r.addr = alloca i16*, align 8
  %temp = alloca i16, align 2
  %i = alloca i32, align 4
  store i16* %r, i16** %r.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %r.addr, metadata !644, metadata !DIExpression()), !dbg !645
  call void @llvm.dbg.declare(metadata i16* %temp, metadata !646, metadata !DIExpression()), !dbg !647
  call void @llvm.dbg.declare(metadata i32* %i, metadata !648, metadata !DIExpression()), !dbg !649
  br label %Transformation_to_Log_Area_Ratios_label0, !dbg !650

Transformation_to_Log_Area_Ratios_label0:         ; preds = %entry
  call void @llvm.dbg.label(metadata !651), !dbg !652
  store i32 1, i32* %i, align 4, !dbg !653
  br label %for.cond, !dbg !655

for.cond:                                         ; preds = %for.inc, %Transformation_to_Log_Area_Ratios_label0
  %0 = load i32, i32* %i, align 4, !dbg !656
  %cmp = icmp sle i32 %0, 8, !dbg !658
  br i1 %cmp, label %for.body, label %for.end, !dbg !659

for.body:                                         ; preds = %for.cond
  %1 = load i16*, i16** %r.addr, align 8, !dbg !660
  %2 = load i16, i16* %1, align 2, !dbg !662
  store i16 %2, i16* %temp, align 2, !dbg !663
  %3 = load i16, i16* %temp, align 2, !dbg !664
  %call = call signext i16 @gsm_abs(i16 noundef signext %3), !dbg !664
  store i16 %call, i16* %temp, align 2, !dbg !665
  %4 = load i16, i16* %temp, align 2, !dbg !666
  %conv = sext i16 %4 to i32, !dbg !666
  %cmp1 = icmp slt i32 %conv, 22118, !dbg !668
  br i1 %cmp1, label %if.then, label %if.else, !dbg !669

if.then:                                          ; preds = %for.body
  %5 = load i16, i16* %temp, align 2, !dbg !670
  %conv3 = sext i16 %5 to i32, !dbg !670
  %shr = ashr i32 %conv3, 1, !dbg !670
  %conv4 = trunc i32 %shr to i16, !dbg !670
  store i16 %conv4, i16* %temp, align 2, !dbg !670
  br label %if.end17, !dbg !672

if.else:                                          ; preds = %for.body
  %6 = load i16, i16* %temp, align 2, !dbg !673
  %conv5 = sext i16 %6 to i32, !dbg !673
  %cmp6 = icmp slt i32 %conv5, 31130, !dbg !675
  br i1 %cmp6, label %if.then8, label %if.else11, !dbg !676

if.then8:                                         ; preds = %if.else
  %7 = load i16, i16* %temp, align 2, !dbg !677
  %conv9 = sext i16 %7 to i32, !dbg !677
  %sub = sub nsw i32 %conv9, 11059, !dbg !677
  %conv10 = trunc i32 %sub to i16, !dbg !677
  store i16 %conv10, i16* %temp, align 2, !dbg !677
  br label %if.end, !dbg !679

if.else11:                                        ; preds = %if.else
  %8 = load i16, i16* %temp, align 2, !dbg !680
  %conv12 = sext i16 %8 to i32, !dbg !680
  %sub13 = sub nsw i32 %conv12, 26112, !dbg !680
  %conv14 = trunc i32 %sub13 to i16, !dbg !680
  store i16 %conv14, i16* %temp, align 2, !dbg !680
  %9 = load i16, i16* %temp, align 2, !dbg !682
  %conv15 = sext i16 %9 to i32, !dbg !682
  %shl = shl i32 %conv15, 2, !dbg !682
  %conv16 = trunc i32 %shl to i16, !dbg !682
  store i16 %conv16, i16* %temp, align 2, !dbg !682
  br label %if.end

if.end:                                           ; preds = %if.else11, %if.then8
  br label %if.end17

if.end17:                                         ; preds = %if.end, %if.then
  %10 = load i16*, i16** %r.addr, align 8, !dbg !683
  %11 = load i16, i16* %10, align 2, !dbg !684
  %conv18 = sext i16 %11 to i32, !dbg !684
  %cmp19 = icmp slt i32 %conv18, 0, !dbg !685
  br i1 %cmp19, label %cond.true, label %cond.false, !dbg !684

cond.true:                                        ; preds = %if.end17
  %12 = load i16, i16* %temp, align 2, !dbg !686
  %conv21 = sext i16 %12 to i32, !dbg !686
  %sub22 = sub nsw i32 0, %conv21, !dbg !687
  br label %cond.end, !dbg !684

cond.false:                                       ; preds = %if.end17
  %13 = load i16, i16* %temp, align 2, !dbg !688
  %conv23 = sext i16 %13 to i32, !dbg !688
  br label %cond.end, !dbg !684

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %sub22, %cond.true ], [ %conv23, %cond.false ], !dbg !684
  %conv24 = trunc i32 %cond to i16, !dbg !684
  %14 = load i16*, i16** %r.addr, align 8, !dbg !689
  store i16 %conv24, i16* %14, align 2, !dbg !690
  br label %for.inc, !dbg !691

for.inc:                                          ; preds = %cond.end
  %15 = load i32, i32* %i, align 4, !dbg !692
  %inc = add nsw i32 %15, 1, !dbg !692
  store i32 %inc, i32* %i, align 4, !dbg !692
  %16 = load i16*, i16** %r.addr, align 8, !dbg !693
  %incdec.ptr = getelementptr inbounds i16, i16* %16, i32 1, !dbg !693
  store i16* %incdec.ptr, i16** %r.addr, align 8, !dbg !693
  br label %for.cond, !dbg !694, !llvm.loop !695

for.end:                                          ; preds = %for.cond
  ret void, !dbg !697
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Quantization_and_coding(i16* noundef %LAR) #0 !dbg !698 {
entry:
  %LAR.addr = alloca i16*, align 8
  %temp = alloca i16, align 2
  store i16* %LAR, i16** %LAR.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %LAR.addr, metadata !699, metadata !DIExpression()), !dbg !700
  call void @llvm.dbg.declare(metadata i16* %temp, metadata !701, metadata !DIExpression()), !dbg !702
  %0 = load i16*, i16** %LAR.addr, align 8, !dbg !703
  %1 = load i16, i16* %0, align 2, !dbg !703
  %call = call signext i16 @gsm_mult(i16 noundef signext 20480, i16 noundef signext %1), !dbg !703
  store i16 %call, i16* %temp, align 2, !dbg !703
  %2 = load i16, i16* %temp, align 2, !dbg !703
  %call1 = call signext i16 @gsm_add(i16 noundef signext %2, i16 noundef signext 0), !dbg !703
  store i16 %call1, i16* %temp, align 2, !dbg !703
  %3 = load i16, i16* %temp, align 2, !dbg !703
  %call2 = call signext i16 @gsm_add(i16 noundef signext %3, i16 noundef signext 256), !dbg !703
  store i16 %call2, i16* %temp, align 2, !dbg !703
  %4 = load i16, i16* %temp, align 2, !dbg !703
  %conv = sext i16 %4 to i32, !dbg !703
  %shr = ashr i32 %conv, 9, !dbg !703
  %conv3 = trunc i32 %shr to i16, !dbg !703
  store i16 %conv3, i16* %temp, align 2, !dbg !703
  %5 = load i16, i16* %temp, align 2, !dbg !703
  %conv4 = sext i16 %5 to i32, !dbg !703
  %cmp = icmp sgt i32 %conv4, 31, !dbg !703
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !703

cond.true:                                        ; preds = %entry
  br label %cond.end12, !dbg !703

cond.false:                                       ; preds = %entry
  %6 = load i16, i16* %temp, align 2, !dbg !703
  %conv6 = sext i16 %6 to i32, !dbg !703
  %cmp7 = icmp slt i32 %conv6, -32, !dbg !703
  br i1 %cmp7, label %cond.true9, label %cond.false10, !dbg !703

cond.true9:                                       ; preds = %cond.false
  br label %cond.end, !dbg !703

cond.false10:                                     ; preds = %cond.false
  %7 = load i16, i16* %temp, align 2, !dbg !703
  %conv11 = sext i16 %7 to i32, !dbg !703
  %sub = sub nsw i32 %conv11, -32, !dbg !703
  br label %cond.end, !dbg !703

cond.end:                                         ; preds = %cond.false10, %cond.true9
  %cond = phi i32 [ 0, %cond.true9 ], [ %sub, %cond.false10 ], !dbg !703
  br label %cond.end12, !dbg !703

cond.end12:                                       ; preds = %cond.end, %cond.true
  %cond13 = phi i32 [ 63, %cond.true ], [ %cond, %cond.end ], !dbg !703
  %conv14 = trunc i32 %cond13 to i16, !dbg !703
  %8 = load i16*, i16** %LAR.addr, align 8, !dbg !703
  store i16 %conv14, i16* %8, align 2, !dbg !703
  %9 = load i16*, i16** %LAR.addr, align 8, !dbg !703
  %incdec.ptr = getelementptr inbounds i16, i16* %9, i32 1, !dbg !703
  store i16* %incdec.ptr, i16** %LAR.addr, align 8, !dbg !703
  %10 = load i16*, i16** %LAR.addr, align 8, !dbg !704
  %11 = load i16, i16* %10, align 2, !dbg !704
  %call15 = call signext i16 @gsm_mult(i16 noundef signext 20480, i16 noundef signext %11), !dbg !704
  store i16 %call15, i16* %temp, align 2, !dbg !704
  %12 = load i16, i16* %temp, align 2, !dbg !704
  %call16 = call signext i16 @gsm_add(i16 noundef signext %12, i16 noundef signext 0), !dbg !704
  store i16 %call16, i16* %temp, align 2, !dbg !704
  %13 = load i16, i16* %temp, align 2, !dbg !704
  %call17 = call signext i16 @gsm_add(i16 noundef signext %13, i16 noundef signext 256), !dbg !704
  store i16 %call17, i16* %temp, align 2, !dbg !704
  %14 = load i16, i16* %temp, align 2, !dbg !704
  %conv18 = sext i16 %14 to i32, !dbg !704
  %shr19 = ashr i32 %conv18, 9, !dbg !704
  %conv20 = trunc i32 %shr19 to i16, !dbg !704
  store i16 %conv20, i16* %temp, align 2, !dbg !704
  %15 = load i16, i16* %temp, align 2, !dbg !704
  %conv21 = sext i16 %15 to i32, !dbg !704
  %cmp22 = icmp sgt i32 %conv21, 31, !dbg !704
  br i1 %cmp22, label %cond.true24, label %cond.false25, !dbg !704

cond.true24:                                      ; preds = %cond.end12
  br label %cond.end35, !dbg !704

cond.false25:                                     ; preds = %cond.end12
  %16 = load i16, i16* %temp, align 2, !dbg !704
  %conv26 = sext i16 %16 to i32, !dbg !704
  %cmp27 = icmp slt i32 %conv26, -32, !dbg !704
  br i1 %cmp27, label %cond.true29, label %cond.false30, !dbg !704

cond.true29:                                      ; preds = %cond.false25
  br label %cond.end33, !dbg !704

cond.false30:                                     ; preds = %cond.false25
  %17 = load i16, i16* %temp, align 2, !dbg !704
  %conv31 = sext i16 %17 to i32, !dbg !704
  %sub32 = sub nsw i32 %conv31, -32, !dbg !704
  br label %cond.end33, !dbg !704

cond.end33:                                       ; preds = %cond.false30, %cond.true29
  %cond34 = phi i32 [ 0, %cond.true29 ], [ %sub32, %cond.false30 ], !dbg !704
  br label %cond.end35, !dbg !704

cond.end35:                                       ; preds = %cond.end33, %cond.true24
  %cond36 = phi i32 [ 63, %cond.true24 ], [ %cond34, %cond.end33 ], !dbg !704
  %conv37 = trunc i32 %cond36 to i16, !dbg !704
  %18 = load i16*, i16** %LAR.addr, align 8, !dbg !704
  store i16 %conv37, i16* %18, align 2, !dbg !704
  %19 = load i16*, i16** %LAR.addr, align 8, !dbg !704
  %incdec.ptr38 = getelementptr inbounds i16, i16* %19, i32 1, !dbg !704
  store i16* %incdec.ptr38, i16** %LAR.addr, align 8, !dbg !704
  %20 = load i16*, i16** %LAR.addr, align 8, !dbg !705
  %21 = load i16, i16* %20, align 2, !dbg !705
  %call39 = call signext i16 @gsm_mult(i16 noundef signext 20480, i16 noundef signext %21), !dbg !705
  store i16 %call39, i16* %temp, align 2, !dbg !705
  %22 = load i16, i16* %temp, align 2, !dbg !705
  %call40 = call signext i16 @gsm_add(i16 noundef signext %22, i16 noundef signext 2048), !dbg !705
  store i16 %call40, i16* %temp, align 2, !dbg !705
  %23 = load i16, i16* %temp, align 2, !dbg !705
  %call41 = call signext i16 @gsm_add(i16 noundef signext %23, i16 noundef signext 256), !dbg !705
  store i16 %call41, i16* %temp, align 2, !dbg !705
  %24 = load i16, i16* %temp, align 2, !dbg !705
  %conv42 = sext i16 %24 to i32, !dbg !705
  %shr43 = ashr i32 %conv42, 9, !dbg !705
  %conv44 = trunc i32 %shr43 to i16, !dbg !705
  store i16 %conv44, i16* %temp, align 2, !dbg !705
  %25 = load i16, i16* %temp, align 2, !dbg !705
  %conv45 = sext i16 %25 to i32, !dbg !705
  %cmp46 = icmp sgt i32 %conv45, 15, !dbg !705
  br i1 %cmp46, label %cond.true48, label %cond.false49, !dbg !705

cond.true48:                                      ; preds = %cond.end35
  br label %cond.end59, !dbg !705

cond.false49:                                     ; preds = %cond.end35
  %26 = load i16, i16* %temp, align 2, !dbg !705
  %conv50 = sext i16 %26 to i32, !dbg !705
  %cmp51 = icmp slt i32 %conv50, -16, !dbg !705
  br i1 %cmp51, label %cond.true53, label %cond.false54, !dbg !705

cond.true53:                                      ; preds = %cond.false49
  br label %cond.end57, !dbg !705

cond.false54:                                     ; preds = %cond.false49
  %27 = load i16, i16* %temp, align 2, !dbg !705
  %conv55 = sext i16 %27 to i32, !dbg !705
  %sub56 = sub nsw i32 %conv55, -16, !dbg !705
  br label %cond.end57, !dbg !705

cond.end57:                                       ; preds = %cond.false54, %cond.true53
  %cond58 = phi i32 [ 0, %cond.true53 ], [ %sub56, %cond.false54 ], !dbg !705
  br label %cond.end59, !dbg !705

cond.end59:                                       ; preds = %cond.end57, %cond.true48
  %cond60 = phi i32 [ 31, %cond.true48 ], [ %cond58, %cond.end57 ], !dbg !705
  %conv61 = trunc i32 %cond60 to i16, !dbg !705
  %28 = load i16*, i16** %LAR.addr, align 8, !dbg !705
  store i16 %conv61, i16* %28, align 2, !dbg !705
  %29 = load i16*, i16** %LAR.addr, align 8, !dbg !705
  %incdec.ptr62 = getelementptr inbounds i16, i16* %29, i32 1, !dbg !705
  store i16* %incdec.ptr62, i16** %LAR.addr, align 8, !dbg !705
  %30 = load i16*, i16** %LAR.addr, align 8, !dbg !706
  %31 = load i16, i16* %30, align 2, !dbg !706
  %call63 = call signext i16 @gsm_mult(i16 noundef signext 20480, i16 noundef signext %31), !dbg !706
  store i16 %call63, i16* %temp, align 2, !dbg !706
  %32 = load i16, i16* %temp, align 2, !dbg !706
  %call64 = call signext i16 @gsm_add(i16 noundef signext %32, i16 noundef signext -2560), !dbg !706
  store i16 %call64, i16* %temp, align 2, !dbg !706
  %33 = load i16, i16* %temp, align 2, !dbg !706
  %call65 = call signext i16 @gsm_add(i16 noundef signext %33, i16 noundef signext 256), !dbg !706
  store i16 %call65, i16* %temp, align 2, !dbg !706
  %34 = load i16, i16* %temp, align 2, !dbg !706
  %conv66 = sext i16 %34 to i32, !dbg !706
  %shr67 = ashr i32 %conv66, 9, !dbg !706
  %conv68 = trunc i32 %shr67 to i16, !dbg !706
  store i16 %conv68, i16* %temp, align 2, !dbg !706
  %35 = load i16, i16* %temp, align 2, !dbg !706
  %conv69 = sext i16 %35 to i32, !dbg !706
  %cmp70 = icmp sgt i32 %conv69, 15, !dbg !706
  br i1 %cmp70, label %cond.true72, label %cond.false73, !dbg !706

cond.true72:                                      ; preds = %cond.end59
  br label %cond.end83, !dbg !706

cond.false73:                                     ; preds = %cond.end59
  %36 = load i16, i16* %temp, align 2, !dbg !706
  %conv74 = sext i16 %36 to i32, !dbg !706
  %cmp75 = icmp slt i32 %conv74, -16, !dbg !706
  br i1 %cmp75, label %cond.true77, label %cond.false78, !dbg !706

cond.true77:                                      ; preds = %cond.false73
  br label %cond.end81, !dbg !706

cond.false78:                                     ; preds = %cond.false73
  %37 = load i16, i16* %temp, align 2, !dbg !706
  %conv79 = sext i16 %37 to i32, !dbg !706
  %sub80 = sub nsw i32 %conv79, -16, !dbg !706
  br label %cond.end81, !dbg !706

cond.end81:                                       ; preds = %cond.false78, %cond.true77
  %cond82 = phi i32 [ 0, %cond.true77 ], [ %sub80, %cond.false78 ], !dbg !706
  br label %cond.end83, !dbg !706

cond.end83:                                       ; preds = %cond.end81, %cond.true72
  %cond84 = phi i32 [ 31, %cond.true72 ], [ %cond82, %cond.end81 ], !dbg !706
  %conv85 = trunc i32 %cond84 to i16, !dbg !706
  %38 = load i16*, i16** %LAR.addr, align 8, !dbg !706
  store i16 %conv85, i16* %38, align 2, !dbg !706
  %39 = load i16*, i16** %LAR.addr, align 8, !dbg !706
  %incdec.ptr86 = getelementptr inbounds i16, i16* %39, i32 1, !dbg !706
  store i16* %incdec.ptr86, i16** %LAR.addr, align 8, !dbg !706
  %40 = load i16*, i16** %LAR.addr, align 8, !dbg !707
  %41 = load i16, i16* %40, align 2, !dbg !707
  %call87 = call signext i16 @gsm_mult(i16 noundef signext 13964, i16 noundef signext %41), !dbg !707
  store i16 %call87, i16* %temp, align 2, !dbg !707
  %42 = load i16, i16* %temp, align 2, !dbg !707
  %call88 = call signext i16 @gsm_add(i16 noundef signext %42, i16 noundef signext 94), !dbg !707
  store i16 %call88, i16* %temp, align 2, !dbg !707
  %43 = load i16, i16* %temp, align 2, !dbg !707
  %call89 = call signext i16 @gsm_add(i16 noundef signext %43, i16 noundef signext 256), !dbg !707
  store i16 %call89, i16* %temp, align 2, !dbg !707
  %44 = load i16, i16* %temp, align 2, !dbg !707
  %conv90 = sext i16 %44 to i32, !dbg !707
  %shr91 = ashr i32 %conv90, 9, !dbg !707
  %conv92 = trunc i32 %shr91 to i16, !dbg !707
  store i16 %conv92, i16* %temp, align 2, !dbg !707
  %45 = load i16, i16* %temp, align 2, !dbg !707
  %conv93 = sext i16 %45 to i32, !dbg !707
  %cmp94 = icmp sgt i32 %conv93, 7, !dbg !707
  br i1 %cmp94, label %cond.true96, label %cond.false97, !dbg !707

cond.true96:                                      ; preds = %cond.end83
  br label %cond.end107, !dbg !707

cond.false97:                                     ; preds = %cond.end83
  %46 = load i16, i16* %temp, align 2, !dbg !707
  %conv98 = sext i16 %46 to i32, !dbg !707
  %cmp99 = icmp slt i32 %conv98, -8, !dbg !707
  br i1 %cmp99, label %cond.true101, label %cond.false102, !dbg !707

cond.true101:                                     ; preds = %cond.false97
  br label %cond.end105, !dbg !707

cond.false102:                                    ; preds = %cond.false97
  %47 = load i16, i16* %temp, align 2, !dbg !707
  %conv103 = sext i16 %47 to i32, !dbg !707
  %sub104 = sub nsw i32 %conv103, -8, !dbg !707
  br label %cond.end105, !dbg !707

cond.end105:                                      ; preds = %cond.false102, %cond.true101
  %cond106 = phi i32 [ 0, %cond.true101 ], [ %sub104, %cond.false102 ], !dbg !707
  br label %cond.end107, !dbg !707

cond.end107:                                      ; preds = %cond.end105, %cond.true96
  %cond108 = phi i32 [ 15, %cond.true96 ], [ %cond106, %cond.end105 ], !dbg !707
  %conv109 = trunc i32 %cond108 to i16, !dbg !707
  %48 = load i16*, i16** %LAR.addr, align 8, !dbg !707
  store i16 %conv109, i16* %48, align 2, !dbg !707
  %49 = load i16*, i16** %LAR.addr, align 8, !dbg !707
  %incdec.ptr110 = getelementptr inbounds i16, i16* %49, i32 1, !dbg !707
  store i16* %incdec.ptr110, i16** %LAR.addr, align 8, !dbg !707
  %50 = load i16*, i16** %LAR.addr, align 8, !dbg !708
  %51 = load i16, i16* %50, align 2, !dbg !708
  %call111 = call signext i16 @gsm_mult(i16 noundef signext 15360, i16 noundef signext %51), !dbg !708
  store i16 %call111, i16* %temp, align 2, !dbg !708
  %52 = load i16, i16* %temp, align 2, !dbg !708
  %call112 = call signext i16 @gsm_add(i16 noundef signext %52, i16 noundef signext -1792), !dbg !708
  store i16 %call112, i16* %temp, align 2, !dbg !708
  %53 = load i16, i16* %temp, align 2, !dbg !708
  %call113 = call signext i16 @gsm_add(i16 noundef signext %53, i16 noundef signext 256), !dbg !708
  store i16 %call113, i16* %temp, align 2, !dbg !708
  %54 = load i16, i16* %temp, align 2, !dbg !708
  %conv114 = sext i16 %54 to i32, !dbg !708
  %shr115 = ashr i32 %conv114, 9, !dbg !708
  %conv116 = trunc i32 %shr115 to i16, !dbg !708
  store i16 %conv116, i16* %temp, align 2, !dbg !708
  %55 = load i16, i16* %temp, align 2, !dbg !708
  %conv117 = sext i16 %55 to i32, !dbg !708
  %cmp118 = icmp sgt i32 %conv117, 7, !dbg !708
  br i1 %cmp118, label %cond.true120, label %cond.false121, !dbg !708

cond.true120:                                     ; preds = %cond.end107
  br label %cond.end131, !dbg !708

cond.false121:                                    ; preds = %cond.end107
  %56 = load i16, i16* %temp, align 2, !dbg !708
  %conv122 = sext i16 %56 to i32, !dbg !708
  %cmp123 = icmp slt i32 %conv122, -8, !dbg !708
  br i1 %cmp123, label %cond.true125, label %cond.false126, !dbg !708

cond.true125:                                     ; preds = %cond.false121
  br label %cond.end129, !dbg !708

cond.false126:                                    ; preds = %cond.false121
  %57 = load i16, i16* %temp, align 2, !dbg !708
  %conv127 = sext i16 %57 to i32, !dbg !708
  %sub128 = sub nsw i32 %conv127, -8, !dbg !708
  br label %cond.end129, !dbg !708

cond.end129:                                      ; preds = %cond.false126, %cond.true125
  %cond130 = phi i32 [ 0, %cond.true125 ], [ %sub128, %cond.false126 ], !dbg !708
  br label %cond.end131, !dbg !708

cond.end131:                                      ; preds = %cond.end129, %cond.true120
  %cond132 = phi i32 [ 15, %cond.true120 ], [ %cond130, %cond.end129 ], !dbg !708
  %conv133 = trunc i32 %cond132 to i16, !dbg !708
  %58 = load i16*, i16** %LAR.addr, align 8, !dbg !708
  store i16 %conv133, i16* %58, align 2, !dbg !708
  %59 = load i16*, i16** %LAR.addr, align 8, !dbg !708
  %incdec.ptr134 = getelementptr inbounds i16, i16* %59, i32 1, !dbg !708
  store i16* %incdec.ptr134, i16** %LAR.addr, align 8, !dbg !708
  %60 = load i16*, i16** %LAR.addr, align 8, !dbg !709
  %61 = load i16, i16* %60, align 2, !dbg !709
  %call135 = call signext i16 @gsm_mult(i16 noundef signext 8534, i16 noundef signext %61), !dbg !709
  store i16 %call135, i16* %temp, align 2, !dbg !709
  %62 = load i16, i16* %temp, align 2, !dbg !709
  %call136 = call signext i16 @gsm_add(i16 noundef signext %62, i16 noundef signext -341), !dbg !709
  store i16 %call136, i16* %temp, align 2, !dbg !709
  %63 = load i16, i16* %temp, align 2, !dbg !709
  %call137 = call signext i16 @gsm_add(i16 noundef signext %63, i16 noundef signext 256), !dbg !709
  store i16 %call137, i16* %temp, align 2, !dbg !709
  %64 = load i16, i16* %temp, align 2, !dbg !709
  %conv138 = sext i16 %64 to i32, !dbg !709
  %shr139 = ashr i32 %conv138, 9, !dbg !709
  %conv140 = trunc i32 %shr139 to i16, !dbg !709
  store i16 %conv140, i16* %temp, align 2, !dbg !709
  %65 = load i16, i16* %temp, align 2, !dbg !709
  %conv141 = sext i16 %65 to i32, !dbg !709
  %cmp142 = icmp sgt i32 %conv141, 3, !dbg !709
  br i1 %cmp142, label %cond.true144, label %cond.false145, !dbg !709

cond.true144:                                     ; preds = %cond.end131
  br label %cond.end155, !dbg !709

cond.false145:                                    ; preds = %cond.end131
  %66 = load i16, i16* %temp, align 2, !dbg !709
  %conv146 = sext i16 %66 to i32, !dbg !709
  %cmp147 = icmp slt i32 %conv146, -4, !dbg !709
  br i1 %cmp147, label %cond.true149, label %cond.false150, !dbg !709

cond.true149:                                     ; preds = %cond.false145
  br label %cond.end153, !dbg !709

cond.false150:                                    ; preds = %cond.false145
  %67 = load i16, i16* %temp, align 2, !dbg !709
  %conv151 = sext i16 %67 to i32, !dbg !709
  %sub152 = sub nsw i32 %conv151, -4, !dbg !709
  br label %cond.end153, !dbg !709

cond.end153:                                      ; preds = %cond.false150, %cond.true149
  %cond154 = phi i32 [ 0, %cond.true149 ], [ %sub152, %cond.false150 ], !dbg !709
  br label %cond.end155, !dbg !709

cond.end155:                                      ; preds = %cond.end153, %cond.true144
  %cond156 = phi i32 [ 7, %cond.true144 ], [ %cond154, %cond.end153 ], !dbg !709
  %conv157 = trunc i32 %cond156 to i16, !dbg !709
  %68 = load i16*, i16** %LAR.addr, align 8, !dbg !709
  store i16 %conv157, i16* %68, align 2, !dbg !709
  %69 = load i16*, i16** %LAR.addr, align 8, !dbg !709
  %incdec.ptr158 = getelementptr inbounds i16, i16* %69, i32 1, !dbg !709
  store i16* %incdec.ptr158, i16** %LAR.addr, align 8, !dbg !709
  %70 = load i16*, i16** %LAR.addr, align 8, !dbg !710
  %71 = load i16, i16* %70, align 2, !dbg !710
  %call159 = call signext i16 @gsm_mult(i16 noundef signext 9036, i16 noundef signext %71), !dbg !710
  store i16 %call159, i16* %temp, align 2, !dbg !710
  %72 = load i16, i16* %temp, align 2, !dbg !710
  %call160 = call signext i16 @gsm_add(i16 noundef signext %72, i16 noundef signext -1144), !dbg !710
  store i16 %call160, i16* %temp, align 2, !dbg !710
  %73 = load i16, i16* %temp, align 2, !dbg !710
  %call161 = call signext i16 @gsm_add(i16 noundef signext %73, i16 noundef signext 256), !dbg !710
  store i16 %call161, i16* %temp, align 2, !dbg !710
  %74 = load i16, i16* %temp, align 2, !dbg !710
  %conv162 = sext i16 %74 to i32, !dbg !710
  %shr163 = ashr i32 %conv162, 9, !dbg !710
  %conv164 = trunc i32 %shr163 to i16, !dbg !710
  store i16 %conv164, i16* %temp, align 2, !dbg !710
  %75 = load i16, i16* %temp, align 2, !dbg !710
  %conv165 = sext i16 %75 to i32, !dbg !710
  %cmp166 = icmp sgt i32 %conv165, 3, !dbg !710
  br i1 %cmp166, label %cond.true168, label %cond.false169, !dbg !710

cond.true168:                                     ; preds = %cond.end155
  br label %cond.end179, !dbg !710

cond.false169:                                    ; preds = %cond.end155
  %76 = load i16, i16* %temp, align 2, !dbg !710
  %conv170 = sext i16 %76 to i32, !dbg !710
  %cmp171 = icmp slt i32 %conv170, -4, !dbg !710
  br i1 %cmp171, label %cond.true173, label %cond.false174, !dbg !710

cond.true173:                                     ; preds = %cond.false169
  br label %cond.end177, !dbg !710

cond.false174:                                    ; preds = %cond.false169
  %77 = load i16, i16* %temp, align 2, !dbg !710
  %conv175 = sext i16 %77 to i32, !dbg !710
  %sub176 = sub nsw i32 %conv175, -4, !dbg !710
  br label %cond.end177, !dbg !710

cond.end177:                                      ; preds = %cond.false174, %cond.true173
  %cond178 = phi i32 [ 0, %cond.true173 ], [ %sub176, %cond.false174 ], !dbg !710
  br label %cond.end179, !dbg !710

cond.end179:                                      ; preds = %cond.end177, %cond.true168
  %cond180 = phi i32 [ 7, %cond.true168 ], [ %cond178, %cond.end177 ], !dbg !710
  %conv181 = trunc i32 %cond180 to i16, !dbg !710
  %78 = load i16*, i16** %LAR.addr, align 8, !dbg !710
  store i16 %conv181, i16* %78, align 2, !dbg !710
  %79 = load i16*, i16** %LAR.addr, align 8, !dbg !710
  %incdec.ptr182 = getelementptr inbounds i16, i16* %79, i32 1, !dbg !710
  store i16* %incdec.ptr182, i16** %LAR.addr, align 8, !dbg !710
  ret void, !dbg !711
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @Gsm_LPC_Analysis(i16* noundef %indata, i16* noundef %LARc) #0 !dbg !712 {
entry:
  %indata.addr = alloca i16*, align 8
  %LARc.addr = alloca i16*, align 8
  %L_ACF = alloca [9 x i64], align 16
  store i16* %indata, i16** %indata.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %indata.addr, metadata !715, metadata !DIExpression()), !dbg !716
  store i16* %LARc, i16** %LARc.addr, align 8
  call void @llvm.dbg.declare(metadata i16** %LARc.addr, metadata !717, metadata !DIExpression()), !dbg !718
  call void @llvm.dbg.declare(metadata [9 x i64]* %L_ACF, metadata !719, metadata !DIExpression()), !dbg !721
  %0 = load i16*, i16** %indata.addr, align 8, !dbg !722
  %arraydecay = getelementptr inbounds [9 x i64], [9 x i64]* %L_ACF, i64 0, i64 0, !dbg !723
  call void @Autocorrelation(i16* noundef %0, i64* noundef %arraydecay), !dbg !724
  %arraydecay1 = getelementptr inbounds [9 x i64], [9 x i64]* %L_ACF, i64 0, i64 0, !dbg !725
  %1 = load i16*, i16** %LARc.addr, align 8, !dbg !726
  call void @Reflection_coefficients(i64* noundef %arraydecay1, i16* noundef %1), !dbg !727
  %2 = load i16*, i16** %LARc.addr, align 8, !dbg !728
  call void @Transformation_to_Log_Area_Ratios(i16* noundef %2), !dbg !729
  %3 = load i16*, i16** %LARc.addr, align 8, !dbg !730
  call void @Quantization_and_coding(i16* noundef %3), !dbg !731
  ret void, !dbg !732
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nofree nounwind willreturn }

!llvm.dbg.cu = !{!0, !6, !8}
!llvm.ident = !{!10, !10, !10}
!llvm.module.flags = !{!11, !12, !13, !14, !15, !16, !17}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "data/benchmarks/real/gsm/gsm_add.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "203474295b4ff57c36bb810505beeb6a")
!2 = !{!3}
!3 = !DIDerivedType(tag: DW_TAG_typedef, name: "longword", file: !4, line: 31, baseType: !5)
!4 = !DIFile(filename: "data/benchmarks/real/gsm/gsm_private.h", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "4f2b4f8362ef72e1c64723ce45f8c494")
!5 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!6 = distinct !DICompileUnit(language: DW_LANG_C99, file: !7, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!7 = !DIFile(filename: "data/benchmarks/real/gsm/gsm_lpc.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "32feb5ddaaa24ea713c6883a90957f9d")
!8 = distinct !DICompileUnit(language: DW_LANG_C99, file: !9, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!9 = !DIFile(filename: "data/benchmarks/real/gsm/gsm.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "d3722921f9a4500b1c124a0080ea33be")
!10 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!11 = !{i32 7, !"Dwarf Version", i32 5}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = !{i32 7, !"PIC Level", i32 2}
!15 = !{i32 7, !"PIE Level", i32 2}
!16 = !{i32 7, !"uwtable", i32 1}
!17 = !{i32 7, !"frame-pointer", i32 2}
!18 = distinct !DISubprogram(name: "gsm_add", scope: !1, file: !1, line: 36, type: !19, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!19 = !DISubroutineType(types: !20)
!20 = !{!21, !21, !21}
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "word", file: !4, line: 30, baseType: !22)
!22 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!23 = !{}
!24 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 36, type: !21)
!25 = !DILocation(line: 36, column: 19, scope: !18)
!26 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 36, type: !21)
!27 = !DILocation(line: 36, column: 27, scope: !18)
!28 = !DILocalVariable(name: "sum", scope: !18, file: !1, line: 38, type: !3)
!29 = !DILocation(line: 38, column: 14, scope: !18)
!30 = !DILocation(line: 39, column: 22, scope: !18)
!31 = !DILocation(line: 39, column: 11, scope: !18)
!32 = !DILocation(line: 39, column: 37, scope: !18)
!33 = !DILocation(line: 39, column: 26, scope: !18)
!34 = !DILocation(line: 39, column: 24, scope: !18)
!35 = !DILocation(line: 39, column: 9, scope: !18)
!36 = !DILocation(line: 40, column: 12, scope: !18)
!37 = !DILocation(line: 40, column: 5, scope: !18)
!38 = distinct !DISubprogram(name: "gsm_mult", scope: !1, file: !1, line: 43, type: !19, scopeLine: 44, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!39 = !DILocalVariable(name: "a", arg: 1, scope: !38, file: !1, line: 43, type: !21)
!40 = !DILocation(line: 43, column: 20, scope: !38)
!41 = !DILocalVariable(name: "b", arg: 2, scope: !38, file: !1, line: 43, type: !21)
!42 = !DILocation(line: 43, column: 28, scope: !38)
!43 = !DILocation(line: 45, column: 9, scope: !44)
!44 = distinct !DILexicalBlock(scope: !38, file: !1, line: 45, column: 9)
!45 = !DILocation(line: 45, column: 11, scope: !44)
!46 = !DILocation(line: 45, column: 23, scope: !44)
!47 = !DILocation(line: 45, column: 26, scope: !44)
!48 = !DILocation(line: 45, column: 28, scope: !44)
!49 = !DILocation(line: 45, column: 9, scope: !38)
!50 = !DILocation(line: 46, column: 9, scope: !44)
!51 = !DILocation(line: 48, column: 16, scope: !44)
!52 = !DILocation(line: 48, column: 9, scope: !44)
!53 = !DILocation(line: 49, column: 1, scope: !38)
!54 = distinct !DISubprogram(name: "gsm_mult_r", scope: !1, file: !1, line: 51, type: !19, scopeLine: 52, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!55 = !DILocalVariable(name: "a", arg: 1, scope: !54, file: !1, line: 51, type: !21)
!56 = !DILocation(line: 51, column: 22, scope: !54)
!57 = !DILocalVariable(name: "b", arg: 2, scope: !54, file: !1, line: 51, type: !21)
!58 = !DILocation(line: 51, column: 30, scope: !54)
!59 = !DILocalVariable(name: "prod", scope: !54, file: !1, line: 53, type: !3)
!60 = !DILocation(line: 53, column: 14, scope: !54)
!61 = !DILocation(line: 55, column: 9, scope: !62)
!62 = distinct !DILexicalBlock(scope: !54, file: !1, line: 55, column: 9)
!63 = !DILocation(line: 55, column: 11, scope: !62)
!64 = !DILocation(line: 55, column: 23, scope: !62)
!65 = !DILocation(line: 55, column: 26, scope: !62)
!66 = !DILocation(line: 55, column: 28, scope: !62)
!67 = !DILocation(line: 55, column: 9, scope: !54)
!68 = !DILocation(line: 56, column: 9, scope: !62)
!69 = !DILocation(line: 59, column: 27, scope: !70)
!70 = distinct !DILexicalBlock(scope: !62, file: !1, line: 58, column: 5)
!71 = !DILocation(line: 59, column: 16, scope: !70)
!72 = !DILocation(line: 59, column: 42, scope: !70)
!73 = !DILocation(line: 59, column: 31, scope: !70)
!74 = !DILocation(line: 59, column: 29, scope: !70)
!75 = !DILocation(line: 59, column: 44, scope: !70)
!76 = !DILocation(line: 59, column: 14, scope: !70)
!77 = !DILocation(line: 60, column: 14, scope: !70)
!78 = !DILocation(line: 61, column: 16, scope: !70)
!79 = !DILocation(line: 61, column: 21, scope: !70)
!80 = !DILocation(line: 61, column: 9, scope: !70)
!81 = !DILocation(line: 63, column: 1, scope: !54)
!82 = distinct !DISubprogram(name: "gsm_abs", scope: !1, file: !1, line: 65, type: !83, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!83 = !DISubroutineType(types: !84)
!84 = !{!21, !21}
!85 = !DILocalVariable(name: "a", arg: 1, scope: !82, file: !1, line: 65, type: !21)
!86 = !DILocation(line: 65, column: 19, scope: !82)
!87 = !DILocation(line: 67, column: 12, scope: !82)
!88 = !DILocation(line: 67, column: 14, scope: !82)
!89 = !DILocation(line: 67, column: 21, scope: !82)
!90 = !DILocation(line: 67, column: 23, scope: !82)
!91 = !DILocation(line: 67, column: 49, scope: !82)
!92 = !DILocation(line: 67, column: 48, scope: !82)
!93 = !DILocation(line: 67, column: 54, scope: !82)
!94 = !DILocation(line: 67, column: 5, scope: !82)
!95 = distinct !DISubprogram(name: "gsm_norm", scope: !1, file: !1, line: 70, type: !96, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!96 = !DISubroutineType(types: !97)
!97 = !{!21, !3}
!98 = !DILocalVariable(name: "a", arg: 1, scope: !95, file: !1, line: 70, type: !3)
!99 = !DILocation(line: 70, column: 24, scope: !95)
!100 = !DILocalVariable(name: "bitoff", scope: !95, file: !1, line: 72, type: !101)
!101 = !DICompositeType(tag: DW_TAG_array_type, baseType: !102, size: 2048, elements: !104)
!102 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !103)
!103 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!104 = !{!105}
!105 = !DISubrange(count: 256)
!106 = !DILocation(line: 72, column: 25, scope: !95)
!107 = !DILocation(line: 105, column: 9, scope: !108)
!108 = distinct !DILexicalBlock(scope: !95, file: !1, line: 105, column: 9)
!109 = !DILocation(line: 105, column: 11, scope: !108)
!110 = !DILocation(line: 105, column: 9, scope: !95)
!111 = !DILocation(line: 107, column: 13, scope: !112)
!112 = distinct !DILexicalBlock(scope: !113, file: !1, line: 107, column: 13)
!113 = distinct !DILexicalBlock(scope: !108, file: !1, line: 106, column: 5)
!114 = !DILocation(line: 107, column: 15, scope: !112)
!115 = !DILocation(line: 107, column: 13, scope: !113)
!116 = !DILocation(line: 108, column: 13, scope: !112)
!117 = !DILocation(line: 109, column: 14, scope: !113)
!118 = !DILocation(line: 109, column: 13, scope: !113)
!119 = !DILocation(line: 109, column: 11, scope: !113)
!120 = !DILocation(line: 110, column: 5, scope: !113)
!121 = !DILocation(line: 112, column: 12, scope: !95)
!122 = !DILocation(line: 112, column: 14, scope: !95)
!123 = !DILocation(line: 113, column: 10, scope: !95)
!124 = !DILocation(line: 113, column: 12, scope: !95)
!125 = !DILocation(line: 113, column: 47, scope: !95)
!126 = !DILocation(line: 113, column: 49, scope: !95)
!127 = !DILocation(line: 113, column: 44, scope: !95)
!128 = !DILocation(line: 113, column: 32, scope: !95)
!129 = !DILocation(line: 113, column: 30, scope: !95)
!130 = !DILocation(line: 114, column: 29, scope: !95)
!131 = !DILocation(line: 114, column: 31, scope: !95)
!132 = !DILocation(line: 114, column: 26, scope: !95)
!133 = !DILocation(line: 114, column: 14, scope: !95)
!134 = !DILocation(line: 114, column: 12, scope: !95)
!135 = !DILocation(line: 115, column: 12, scope: !95)
!136 = !DILocation(line: 115, column: 14, scope: !95)
!137 = !DILocation(line: 115, column: 45, scope: !95)
!138 = !DILocation(line: 115, column: 47, scope: !95)
!139 = !DILocation(line: 115, column: 42, scope: !95)
!140 = !DILocation(line: 115, column: 30, scope: !95)
!141 = !DILocation(line: 115, column: 28, scope: !95)
!142 = !DILocation(line: 115, column: 75, scope: !95)
!143 = !DILocation(line: 115, column: 73, scope: !95)
!144 = !DILocation(line: 115, column: 61, scope: !95)
!145 = !DILocation(line: 115, column: 59, scope: !95)
!146 = !DILocation(line: 112, column: 5, scope: !95)
!147 = !DILocation(line: 116, column: 1, scope: !95)
!148 = distinct !DISubprogram(name: "gsm_div", scope: !1, file: !1, line: 118, type: !19, scopeLine: 119, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!149 = !DILocalVariable(name: "num", arg: 1, scope: !148, file: !1, line: 118, type: !21)
!150 = !DILocation(line: 118, column: 19, scope: !148)
!151 = !DILocalVariable(name: "denum", arg: 2, scope: !148, file: !1, line: 118, type: !21)
!152 = !DILocation(line: 118, column: 29, scope: !148)
!153 = !DILocalVariable(name: "L_num", scope: !148, file: !1, line: 120, type: !3)
!154 = !DILocation(line: 120, column: 14, scope: !148)
!155 = !DILocalVariable(name: "L_denum", scope: !148, file: !1, line: 121, type: !3)
!156 = !DILocation(line: 121, column: 14, scope: !148)
!157 = !DILocalVariable(name: "div", scope: !148, file: !1, line: 122, type: !21)
!158 = !DILocation(line: 122, column: 10, scope: !148)
!159 = !DILocalVariable(name: "k", scope: !148, file: !1, line: 123, type: !160)
!160 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!161 = !DILocation(line: 123, column: 9, scope: !148)
!162 = !DILocation(line: 125, column: 13, scope: !148)
!163 = !DILocation(line: 125, column: 11, scope: !148)
!164 = !DILocation(line: 126, column: 15, scope: !148)
!165 = !DILocation(line: 126, column: 13, scope: !148)
!166 = !DILocation(line: 127, column: 9, scope: !148)
!167 = !DILocation(line: 128, column: 7, scope: !148)
!168 = !DILocation(line: 134, column: 9, scope: !169)
!169 = distinct !DILexicalBlock(scope: !148, file: !1, line: 134, column: 9)
!170 = !DILocation(line: 134, column: 13, scope: !169)
!171 = !DILocation(line: 134, column: 9, scope: !148)
!172 = !DILocation(line: 135, column: 9, scope: !169)
!173 = !DILocation(line: 134, column: 16, scope: !169)
!174 = !DILabel(scope: !148, name: "gsm_div_label0", file: !1, line: 137)
!175 = !DILocation(line: 137, column: 5, scope: !148)
!176 = !DILocation(line: 138, column: 5, scope: !148)
!177 = !DILocation(line: 138, column: 13, scope: !148)
!178 = !DILocation(line: 141, column: 13, scope: !179)
!179 = distinct !DILexicalBlock(scope: !148, file: !1, line: 139, column: 5)
!180 = !DILocation(line: 142, column: 15, scope: !179)
!181 = !DILocation(line: 144, column: 13, scope: !182)
!182 = distinct !DILexicalBlock(scope: !179, file: !1, line: 144, column: 13)
!183 = !DILocation(line: 144, column: 22, scope: !182)
!184 = !DILocation(line: 144, column: 19, scope: !182)
!185 = !DILocation(line: 144, column: 13, scope: !179)
!186 = !DILocation(line: 146, column: 22, scope: !187)
!187 = distinct !DILexicalBlock(scope: !182, file: !1, line: 145, column: 9)
!188 = !DILocation(line: 146, column: 19, scope: !187)
!189 = !DILocation(line: 147, column: 16, scope: !187)
!190 = !DILocation(line: 148, column: 9, scope: !187)
!191 = distinct !{!191, !176, !192, !193}
!192 = !DILocation(line: 149, column: 5, scope: !148)
!193 = !{!"llvm.loop.mustprogress"}
!194 = !DILocation(line: 151, column: 12, scope: !148)
!195 = !DILocation(line: 151, column: 5, scope: !148)
!196 = !DILocation(line: 152, column: 1, scope: !148)
!197 = distinct !DISubprogram(name: "Autocorrelation", scope: !7, file: !7, line: 34, type: !198, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6, retainedNodes: !23)
!198 = !DISubroutineType(types: !199)
!199 = !{null, !200, !201}
!200 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!201 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3, size: 64)
!202 = !DILocalVariable(name: "s", arg: 1, scope: !197, file: !7, line: 35, type: !200)
!203 = !DILocation(line: 35, column: 11, scope: !197)
!204 = !DILocalVariable(name: "L_ACF", arg: 2, scope: !197, file: !7, line: 36, type: !201)
!205 = !DILocation(line: 36, column: 15, scope: !197)
!206 = !DILocalVariable(name: "k", scope: !197, file: !7, line: 39, type: !160)
!207 = !DILocation(line: 39, column: 18, scope: !197)
!208 = !DILocalVariable(name: "i", scope: !197, file: !7, line: 39, type: !160)
!209 = !DILocation(line: 39, column: 21, scope: !197)
!210 = !DILocalVariable(name: "temp", scope: !197, file: !7, line: 40, type: !21)
!211 = !DILocation(line: 40, column: 10, scope: !197)
!212 = !DILocalVariable(name: "smax", scope: !197, file: !7, line: 41, type: !21)
!213 = !DILocation(line: 41, column: 10, scope: !197)
!214 = !DILocalVariable(name: "scalauto", scope: !197, file: !7, line: 42, type: !21)
!215 = !DILocation(line: 42, column: 10, scope: !197)
!216 = !DILocalVariable(name: "n", scope: !197, file: !7, line: 42, type: !21)
!217 = !DILocation(line: 42, column: 20, scope: !197)
!218 = !DILocalVariable(name: "sp", scope: !197, file: !7, line: 43, type: !200)
!219 = !DILocation(line: 43, column: 11, scope: !197)
!220 = !DILocalVariable(name: "sl", scope: !197, file: !7, line: 44, type: !21)
!221 = !DILocation(line: 44, column: 10, scope: !197)
!222 = !DILocation(line: 47, column: 10, scope: !197)
!223 = !DILocation(line: 47, column: 5, scope: !197)
!224 = !DILabel(scope: !197, name: "Autocorrelation_label0", file: !7, line: 48)
!225 = !DILocation(line: 48, column: 5, scope: !197)
!226 = !DILocation(line: 49, column: 12, scope: !227)
!227 = distinct !DILexicalBlock(scope: !197, file: !7, line: 49, column: 5)
!228 = !DILocation(line: 49, column: 10, scope: !227)
!229 = !DILocation(line: 49, column: 17, scope: !230)
!230 = distinct !DILexicalBlock(scope: !227, file: !7, line: 49, column: 5)
!231 = !DILocation(line: 49, column: 19, scope: !230)
!232 = !DILocation(line: 49, column: 5, scope: !227)
!233 = !DILocation(line: 51, column: 16, scope: !234)
!234 = distinct !DILexicalBlock(scope: !230, file: !7, line: 49, column: 32)
!235 = !DILocation(line: 51, column: 14, scope: !234)
!236 = !DILocation(line: 52, column: 13, scope: !237)
!237 = distinct !DILexicalBlock(scope: !234, file: !7, line: 52, column: 13)
!238 = !DILocation(line: 52, column: 20, scope: !237)
!239 = !DILocation(line: 52, column: 18, scope: !237)
!240 = !DILocation(line: 52, column: 13, scope: !234)
!241 = !DILocation(line: 53, column: 20, scope: !237)
!242 = !DILocation(line: 53, column: 18, scope: !237)
!243 = !DILocation(line: 53, column: 13, scope: !237)
!244 = !DILocation(line: 54, column: 5, scope: !234)
!245 = !DILocation(line: 49, column: 28, scope: !230)
!246 = !DILocation(line: 49, column: 5, scope: !230)
!247 = distinct !{!247, !232, !248, !193}
!248 = !DILocation(line: 54, column: 5, scope: !227)
!249 = !DILocation(line: 57, column: 9, scope: !250)
!250 = distinct !DILexicalBlock(scope: !197, file: !7, line: 57, column: 9)
!251 = !DILocation(line: 57, column: 14, scope: !250)
!252 = !DILocation(line: 57, column: 9, scope: !197)
!253 = !DILocation(line: 58, column: 18, scope: !250)
!254 = !DILocation(line: 58, column: 9, scope: !250)
!255 = !DILocation(line: 60, column: 43, scope: !250)
!256 = !DILocation(line: 60, column: 33, scope: !250)
!257 = !DILocation(line: 60, column: 48, scope: !250)
!258 = !DILocation(line: 60, column: 24, scope: !250)
!259 = !DILocation(line: 60, column: 22, scope: !250)
!260 = !DILocation(line: 60, column: 20, scope: !250)
!261 = !DILocation(line: 60, column: 18, scope: !250)
!262 = !DILocation(line: 62, column: 9, scope: !263)
!263 = distinct !DILexicalBlock(scope: !197, file: !7, line: 62, column: 9)
!264 = !DILocation(line: 62, column: 18, scope: !263)
!265 = !DILocation(line: 62, column: 22, scope: !263)
!266 = !DILocation(line: 62, column: 25, scope: !263)
!267 = !DILocation(line: 62, column: 34, scope: !263)
!268 = !DILocation(line: 62, column: 9, scope: !197)
!269 = !DILocation(line: 63, column: 13, scope: !270)
!270 = distinct !DILexicalBlock(scope: !263, file: !7, line: 62, column: 40)
!271 = !DILocation(line: 63, column: 11, scope: !270)
!272 = !DILocation(line: 63, column: 9, scope: !270)
!273 = !DILabel(scope: !270, name: "Autocorrelation_label1", file: !7, line: 64)
!274 = !DILocation(line: 64, column: 9, scope: !270)
!275 = !DILocation(line: 65, column: 16, scope: !276)
!276 = distinct !DILexicalBlock(scope: !270, file: !7, line: 65, column: 9)
!277 = !DILocation(line: 65, column: 14, scope: !276)
!278 = !DILocation(line: 65, column: 21, scope: !279)
!279 = distinct !DILexicalBlock(scope: !276, file: !7, line: 65, column: 9)
!280 = !DILocation(line: 65, column: 23, scope: !279)
!281 = !DILocation(line: 65, column: 9, scope: !276)
!282 = !DILocation(line: 67, column: 20, scope: !283)
!283 = distinct !DILexicalBlock(scope: !279, file: !7, line: 65, column: 36)
!284 = !DILocation(line: 67, column: 13, scope: !283)
!285 = !DILocation(line: 67, column: 15, scope: !283)
!286 = !DILocation(line: 67, column: 18, scope: !283)
!287 = !DILocation(line: 68, column: 9, scope: !283)
!288 = !DILocation(line: 65, column: 32, scope: !279)
!289 = !DILocation(line: 65, column: 9, scope: !279)
!290 = distinct !{!290, !281, !291, !193}
!291 = !DILocation(line: 68, column: 9, scope: !276)
!292 = !DILocation(line: 69, column: 5, scope: !270)
!293 = !DILocation(line: 72, column: 10, scope: !197)
!294 = !DILocation(line: 72, column: 8, scope: !197)
!295 = !DILocation(line: 73, column: 11, scope: !197)
!296 = !DILocation(line: 73, column: 10, scope: !197)
!297 = !DILocation(line: 73, column: 8, scope: !197)
!298 = !DILocation(line: 73, column: 5, scope: !197)
!299 = !DILabel(scope: !197, name: "Autocorrelation_label2", file: !7, line: 78)
!300 = !DILocation(line: 78, column: 5, scope: !197)
!301 = !DILocation(line: 79, column: 12, scope: !302)
!302 = distinct !DILexicalBlock(scope: !197, file: !7, line: 79, column: 5)
!303 = !DILocation(line: 79, column: 10, scope: !302)
!304 = !DILocation(line: 79, column: 17, scope: !305)
!305 = distinct !DILexicalBlock(scope: !302, file: !7, line: 79, column: 5)
!306 = !DILocation(line: 79, column: 19, scope: !305)
!307 = !DILocation(line: 79, column: 5, scope: !302)
!308 = !DILocation(line: 81, column: 9, scope: !309)
!309 = distinct !DILexicalBlock(scope: !305, file: !7, line: 79, column: 30)
!310 = !DILocation(line: 81, column: 15, scope: !309)
!311 = !DILocation(line: 81, column: 18, scope: !309)
!312 = !DILocation(line: 82, column: 5, scope: !309)
!313 = !DILocation(line: 79, column: 26, scope: !305)
!314 = !DILocation(line: 79, column: 5, scope: !305)
!315 = distinct !{!315, !307, !316, !193}
!316 = !DILocation(line: 82, column: 5, scope: !302)
!317 = !DILocation(line: 84, column: 5, scope: !197)
!318 = !DILocation(line: 85, column: 5, scope: !197)
!319 = !DILocation(line: 86, column: 5, scope: !197)
!320 = !DILocation(line: 87, column: 5, scope: !197)
!321 = !DILocation(line: 88, column: 5, scope: !197)
!322 = !DILocation(line: 89, column: 5, scope: !197)
!323 = !DILocation(line: 90, column: 5, scope: !197)
!324 = !DILocation(line: 91, column: 5, scope: !197)
!325 = !DILocation(line: 92, column: 5, scope: !197)
!326 = !DILocation(line: 93, column: 5, scope: !197)
!327 = !DILocation(line: 94, column: 5, scope: !197)
!328 = !DILocation(line: 95, column: 5, scope: !197)
!329 = !DILocation(line: 96, column: 5, scope: !197)
!330 = !DILocation(line: 97, column: 5, scope: !197)
!331 = !DILocation(line: 98, column: 5, scope: !197)
!332 = !DILocation(line: 99, column: 5, scope: !197)
!333 = !DILocation(line: 100, column: 5, scope: !197)
!334 = !DILocation(line: 101, column: 5, scope: !197)
!335 = !DILocation(line: 102, column: 5, scope: !197)
!336 = !DILocation(line: 103, column: 5, scope: !197)
!337 = !DILocation(line: 104, column: 5, scope: !197)
!338 = !DILocation(line: 105, column: 5, scope: !197)
!339 = !DILocation(line: 106, column: 5, scope: !197)
!340 = !DILocation(line: 107, column: 5, scope: !197)
!341 = !DILocation(line: 108, column: 5, scope: !197)
!342 = !DILocation(line: 109, column: 5, scope: !197)
!343 = !DILocation(line: 110, column: 5, scope: !197)
!344 = !DILocation(line: 111, column: 5, scope: !197)
!345 = !DILocation(line: 112, column: 5, scope: !197)
!346 = !DILocation(line: 113, column: 5, scope: !197)
!347 = !DILocation(line: 114, column: 5, scope: !197)
!348 = !DILocation(line: 115, column: 5, scope: !197)
!349 = !DILocation(line: 116, column: 5, scope: !197)
!350 = !DILocation(line: 117, column: 5, scope: !197)
!351 = !DILocation(line: 118, column: 5, scope: !197)
!352 = !DILocation(line: 119, column: 5, scope: !197)
!353 = !DILocation(line: 120, column: 5, scope: !197)
!354 = !DILocation(line: 121, column: 5, scope: !197)
!355 = !DILocation(line: 122, column: 5, scope: !197)
!356 = !DILocation(line: 123, column: 5, scope: !197)
!357 = !DILocation(line: 124, column: 5, scope: !197)
!358 = !DILocation(line: 125, column: 5, scope: !197)
!359 = !DILocation(line: 126, column: 5, scope: !197)
!360 = !DILabel(scope: !197, name: "Autocorrelation_label3", file: !7, line: 128)
!361 = !DILocation(line: 128, column: 5, scope: !197)
!362 = !DILocation(line: 129, column: 12, scope: !363)
!363 = distinct !DILexicalBlock(scope: !197, file: !7, line: 129, column: 5)
!364 = !DILocation(line: 129, column: 10, scope: !363)
!365 = !DILocation(line: 129, column: 17, scope: !366)
!366 = distinct !DILexicalBlock(scope: !363, file: !7, line: 129, column: 5)
!367 = !DILocation(line: 129, column: 19, scope: !366)
!368 = !DILocation(line: 129, column: 5, scope: !363)
!369 = !DILocation(line: 131, column: 9, scope: !370)
!370 = distinct !DILexicalBlock(scope: !366, file: !7, line: 129, column: 32)
!371 = !DILocation(line: 132, column: 9, scope: !370)
!372 = !DILocation(line: 133, column: 9, scope: !370)
!373 = !DILocation(line: 134, column: 9, scope: !370)
!374 = !DILocation(line: 135, column: 9, scope: !370)
!375 = !DILocation(line: 136, column: 9, scope: !370)
!376 = !DILocation(line: 137, column: 9, scope: !370)
!377 = !DILocation(line: 138, column: 9, scope: !370)
!378 = !DILocation(line: 139, column: 9, scope: !370)
!379 = !DILocation(line: 140, column: 9, scope: !370)
!380 = !DILocation(line: 141, column: 5, scope: !370)
!381 = !DILocation(line: 129, column: 28, scope: !366)
!382 = !DILocation(line: 129, column: 5, scope: !366)
!383 = distinct !{!383, !368, !384, !193}
!384 = !DILocation(line: 141, column: 5, scope: !363)
!385 = !DILabel(scope: !197, name: "Autocorrelation_label4", file: !7, line: 143)
!386 = !DILocation(line: 143, column: 5, scope: !197)
!387 = !DILocation(line: 144, column: 12, scope: !388)
!388 = distinct !DILexicalBlock(scope: !197, file: !7, line: 144, column: 5)
!389 = !DILocation(line: 144, column: 10, scope: !388)
!390 = !DILocation(line: 144, column: 17, scope: !391)
!391 = distinct !DILexicalBlock(scope: !388, file: !7, line: 144, column: 5)
!392 = !DILocation(line: 144, column: 19, scope: !391)
!393 = !DILocation(line: 144, column: 5, scope: !388)
!394 = !DILocation(line: 146, column: 9, scope: !395)
!395 = distinct !DILexicalBlock(scope: !391, file: !7, line: 144, column: 30)
!396 = !DILocation(line: 146, column: 15, scope: !395)
!397 = !DILocation(line: 146, column: 18, scope: !395)
!398 = !DILocation(line: 147, column: 5, scope: !395)
!399 = !DILocation(line: 144, column: 26, scope: !391)
!400 = !DILocation(line: 144, column: 5, scope: !391)
!401 = distinct !{!401, !393, !402, !193}
!402 = !DILocation(line: 147, column: 5, scope: !388)
!403 = !DILocation(line: 150, column: 9, scope: !404)
!404 = distinct !DILexicalBlock(scope: !197, file: !7, line: 150, column: 9)
!405 = !DILocation(line: 150, column: 18, scope: !404)
!406 = !DILocation(line: 150, column: 9, scope: !197)
!407 = !DILocation(line: 150, column: 23, scope: !404)
!408 = !DILabel(scope: !409, name: "Autocorrelation_label5", file: !7, line: 151)
!409 = distinct !DILexicalBlock(scope: !404, file: !7, line: 150, column: 23)
!410 = !DILocation(line: 151, column: 9, scope: !409)
!411 = !DILocation(line: 152, column: 16, scope: !412)
!412 = distinct !DILexicalBlock(scope: !409, file: !7, line: 152, column: 9)
!413 = !DILocation(line: 152, column: 14, scope: !412)
!414 = !DILocation(line: 152, column: 23, scope: !415)
!415 = distinct !DILexicalBlock(scope: !412, file: !7, line: 152, column: 9)
!416 = !DILocation(line: 152, column: 25, scope: !415)
!417 = !DILocation(line: 152, column: 9, scope: !412)
!418 = !DILocation(line: 154, column: 22, scope: !419)
!419 = distinct !DILexicalBlock(scope: !415, file: !7, line: 152, column: 36)
!420 = !DILocation(line: 154, column: 15, scope: !419)
!421 = !DILocation(line: 154, column: 18, scope: !419)
!422 = !DILocation(line: 155, column: 9, scope: !419)
!423 = !DILocation(line: 152, column: 32, scope: !415)
!424 = !DILocation(line: 152, column: 9, scope: !415)
!425 = distinct !{!425, !417, !426, !193}
!426 = !DILocation(line: 155, column: 9, scope: !412)
!427 = !DILocation(line: 156, column: 5, scope: !409)
!428 = !DILocation(line: 157, column: 1, scope: !197)
!429 = distinct !DISubprogram(name: "Reflection_coefficients", scope: !7, file: !7, line: 160, type: !430, scopeLine: 164, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6, retainedNodes: !23)
!430 = !DISubroutineType(types: !431)
!431 = !{null, !201, !200}
!432 = !DILocalVariable(name: "L_ACF", arg: 1, scope: !429, file: !7, line: 161, type: !201)
!433 = !DILocation(line: 161, column: 15, scope: !429)
!434 = !DILocalVariable(name: "r", arg: 2, scope: !429, file: !7, line: 162, type: !200)
!435 = !DILocation(line: 162, column: 20, scope: !429)
!436 = !DILocalVariable(name: "i", scope: !429, file: !7, line: 165, type: !160)
!437 = !DILocation(line: 165, column: 18, scope: !429)
!438 = !DILocalVariable(name: "m", scope: !429, file: !7, line: 165, type: !160)
!439 = !DILocation(line: 165, column: 21, scope: !429)
!440 = !DILocalVariable(name: "n", scope: !429, file: !7, line: 165, type: !160)
!441 = !DILocation(line: 165, column: 24, scope: !429)
!442 = !DILocalVariable(name: "temp", scope: !429, file: !7, line: 166, type: !21)
!443 = !DILocation(line: 166, column: 19, scope: !429)
!444 = !DILocalVariable(name: "ACF", scope: !429, file: !7, line: 167, type: !445)
!445 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 144, elements: !446)
!446 = !{!447}
!447 = !DISubrange(count: 9)
!448 = !DILocation(line: 167, column: 10, scope: !429)
!449 = !DILocalVariable(name: "P", scope: !429, file: !7, line: 168, type: !445)
!450 = !DILocation(line: 168, column: 10, scope: !429)
!451 = !DILocalVariable(name: "K", scope: !429, file: !7, line: 169, type: !445)
!452 = !DILocation(line: 169, column: 10, scope: !429)
!453 = !DILocation(line: 172, column: 9, scope: !454)
!454 = distinct !DILexicalBlock(scope: !429, file: !7, line: 172, column: 9)
!455 = !DILocation(line: 172, column: 18, scope: !454)
!456 = !DILocation(line: 172, column: 9, scope: !429)
!457 = !DILocation(line: 172, column: 24, scope: !454)
!458 = !DILabel(scope: !459, name: "Reflection_coefficients_label0", file: !7, line: 173)
!459 = distinct !DILexicalBlock(scope: !454, file: !7, line: 172, column: 24)
!460 = !DILocation(line: 173, column: 9, scope: !459)
!461 = !DILocation(line: 174, column: 16, scope: !462)
!462 = distinct !DILexicalBlock(scope: !459, file: !7, line: 174, column: 9)
!463 = !DILocation(line: 174, column: 14, scope: !462)
!464 = !DILocation(line: 174, column: 21, scope: !465)
!465 = distinct !DILexicalBlock(scope: !462, file: !7, line: 174, column: 9)
!466 = !DILocation(line: 174, column: 23, scope: !465)
!467 = !DILocation(line: 174, column: 9, scope: !462)
!468 = !DILocation(line: 176, column: 15, scope: !469)
!469 = distinct !DILexicalBlock(scope: !465, file: !7, line: 174, column: 33)
!470 = !DILocation(line: 176, column: 18, scope: !469)
!471 = !DILocation(line: 177, column: 9, scope: !469)
!472 = !DILocation(line: 174, column: 29, scope: !465)
!473 = !DILocation(line: 174, column: 9, scope: !465)
!474 = distinct !{!474, !467, !475, !193}
!475 = !DILocation(line: 177, column: 9, scope: !462)
!476 = !DILocation(line: 178, column: 9, scope: !459)
!477 = !DILocation(line: 181, column: 21, scope: !429)
!478 = !DILocation(line: 181, column: 12, scope: !429)
!479 = !DILocation(line: 181, column: 10, scope: !429)
!480 = !DILocation(line: 181, column: 5, scope: !429)
!481 = !DILabel(scope: !429, name: "Reflection_coefficients_label1", file: !7, line: 183)
!482 = !DILocation(line: 183, column: 5, scope: !429)
!483 = !DILocation(line: 184, column: 12, scope: !484)
!484 = distinct !DILexicalBlock(scope: !429, file: !7, line: 184, column: 5)
!485 = !DILocation(line: 184, column: 10, scope: !484)
!486 = !DILocation(line: 184, column: 17, scope: !487)
!487 = distinct !DILexicalBlock(scope: !484, file: !7, line: 184, column: 5)
!488 = !DILocation(line: 184, column: 19, scope: !487)
!489 = !DILocation(line: 184, column: 5, scope: !484)
!490 = !DILocation(line: 186, column: 18, scope: !491)
!491 = distinct !DILexicalBlock(scope: !487, file: !7, line: 184, column: 30)
!492 = !DILocation(line: 186, column: 13, scope: !491)
!493 = !DILocation(line: 186, column: 9, scope: !491)
!494 = !DILocation(line: 186, column: 16, scope: !491)
!495 = !DILocation(line: 187, column: 5, scope: !491)
!496 = !DILocation(line: 184, column: 26, scope: !487)
!497 = !DILocation(line: 184, column: 5, scope: !487)
!498 = distinct !{!498, !489, !499, !193}
!499 = !DILocation(line: 187, column: 5, scope: !484)
!500 = !DILabel(scope: !429, name: "Reflection_coefficients_label2", file: !7, line: 190)
!501 = !DILocation(line: 190, column: 5, scope: !429)
!502 = !DILocation(line: 191, column: 12, scope: !503)
!503 = distinct !DILexicalBlock(scope: !429, file: !7, line: 191, column: 5)
!504 = !DILocation(line: 191, column: 10, scope: !503)
!505 = !DILocation(line: 191, column: 17, scope: !506)
!506 = distinct !DILexicalBlock(scope: !503, file: !7, line: 191, column: 5)
!507 = !DILocation(line: 191, column: 19, scope: !506)
!508 = !DILocation(line: 191, column: 5, scope: !503)
!509 = !DILocation(line: 193, column: 20, scope: !510)
!510 = distinct !DILexicalBlock(scope: !506, file: !7, line: 191, column: 30)
!511 = !DILocation(line: 193, column: 16, scope: !510)
!512 = !DILocation(line: 193, column: 11, scope: !510)
!513 = !DILocation(line: 193, column: 9, scope: !510)
!514 = !DILocation(line: 193, column: 14, scope: !510)
!515 = !DILocation(line: 194, column: 5, scope: !510)
!516 = !DILocation(line: 191, column: 26, scope: !506)
!517 = !DILocation(line: 191, column: 5, scope: !506)
!518 = distinct !{!518, !508, !519, !193}
!519 = !DILocation(line: 194, column: 5, scope: !503)
!520 = !DILabel(scope: !429, name: "Reflection_coefficients_label3", file: !7, line: 196)
!521 = !DILocation(line: 196, column: 5, scope: !429)
!522 = !DILocation(line: 197, column: 12, scope: !523)
!523 = distinct !DILexicalBlock(scope: !429, file: !7, line: 197, column: 5)
!524 = !DILocation(line: 197, column: 10, scope: !523)
!525 = !DILocation(line: 197, column: 17, scope: !526)
!526 = distinct !DILexicalBlock(scope: !523, file: !7, line: 197, column: 5)
!527 = !DILocation(line: 197, column: 19, scope: !526)
!528 = !DILocation(line: 197, column: 5, scope: !523)
!529 = !DILocation(line: 199, column: 20, scope: !530)
!530 = distinct !DILexicalBlock(scope: !526, file: !7, line: 197, column: 30)
!531 = !DILocation(line: 199, column: 16, scope: !530)
!532 = !DILocation(line: 199, column: 11, scope: !530)
!533 = !DILocation(line: 199, column: 9, scope: !530)
!534 = !DILocation(line: 199, column: 14, scope: !530)
!535 = !DILocation(line: 200, column: 5, scope: !530)
!536 = !DILocation(line: 197, column: 26, scope: !526)
!537 = !DILocation(line: 197, column: 5, scope: !526)
!538 = distinct !{!538, !528, !539, !193}
!539 = !DILocation(line: 200, column: 5, scope: !523)
!540 = !DILabel(scope: !429, name: "Reflection_coefficients_label4", file: !7, line: 203)
!541 = !DILocation(line: 203, column: 5, scope: !429)
!542 = !DILocation(line: 204, column: 12, scope: !543)
!543 = distinct !DILexicalBlock(scope: !429, file: !7, line: 204, column: 5)
!544 = !DILocation(line: 204, column: 10, scope: !543)
!545 = !DILocation(line: 204, column: 17, scope: !546)
!546 = distinct !DILexicalBlock(scope: !543, file: !7, line: 204, column: 5)
!547 = !DILocation(line: 204, column: 19, scope: !546)
!548 = !DILocation(line: 204, column: 5, scope: !543)
!549 = !DILocation(line: 206, column: 16, scope: !550)
!550 = distinct !DILexicalBlock(scope: !546, file: !7, line: 204, column: 35)
!551 = !DILocation(line: 206, column: 14, scope: !550)
!552 = !DILocation(line: 207, column: 16, scope: !550)
!553 = !DILocation(line: 207, column: 14, scope: !550)
!554 = !DILocation(line: 208, column: 13, scope: !555)
!555 = distinct !DILexicalBlock(scope: !550, file: !7, line: 208, column: 13)
!556 = !DILocation(line: 208, column: 20, scope: !555)
!557 = !DILocation(line: 208, column: 18, scope: !555)
!558 = !DILocation(line: 208, column: 13, scope: !550)
!559 = !DILocation(line: 208, column: 26, scope: !555)
!560 = !DILabel(scope: !561, name: "Reflection_coefficients_label6", file: !7, line: 209)
!561 = distinct !DILexicalBlock(scope: !555, file: !7, line: 208, column: 26)
!562 = !DILocation(line: 209, column: 13, scope: !561)
!563 = !DILocation(line: 210, column: 22, scope: !564)
!564 = distinct !DILexicalBlock(scope: !561, file: !7, line: 210, column: 13)
!565 = !DILocation(line: 210, column: 20, scope: !564)
!566 = !DILocation(line: 210, column: 18, scope: !564)
!567 = !DILocation(line: 210, column: 25, scope: !568)
!568 = distinct !DILexicalBlock(scope: !564, file: !7, line: 210, column: 13)
!569 = !DILocation(line: 210, column: 27, scope: !568)
!570 = !DILocation(line: 210, column: 13, scope: !564)
!571 = !DILocation(line: 212, column: 19, scope: !572)
!572 = distinct !DILexicalBlock(scope: !568, file: !7, line: 210, column: 38)
!573 = !DILocation(line: 212, column: 22, scope: !572)
!574 = !DILocation(line: 213, column: 13, scope: !572)
!575 = !DILocation(line: 210, column: 34, scope: !568)
!576 = !DILocation(line: 210, column: 13, scope: !568)
!577 = distinct !{!577, !570, !578, !193}
!578 = !DILocation(line: 213, column: 13, scope: !564)
!579 = !DILocation(line: 214, column: 13, scope: !561)
!580 = !DILocation(line: 217, column: 22, scope: !550)
!581 = !DILocation(line: 217, column: 28, scope: !550)
!582 = !DILocation(line: 217, column: 14, scope: !550)
!583 = !DILocation(line: 217, column: 10, scope: !550)
!584 = !DILocation(line: 217, column: 12, scope: !550)
!585 = !DILocation(line: 219, column: 13, scope: !586)
!586 = distinct !DILexicalBlock(scope: !550, file: !7, line: 219, column: 13)
!587 = !DILocation(line: 219, column: 18, scope: !586)
!588 = !DILocation(line: 219, column: 13, scope: !550)
!589 = !DILocation(line: 220, column: 20, scope: !586)
!590 = !DILocation(line: 220, column: 19, scope: !586)
!591 = !DILocation(line: 220, column: 18, scope: !586)
!592 = !DILocation(line: 220, column: 14, scope: !586)
!593 = !DILocation(line: 220, column: 16, scope: !586)
!594 = !DILocation(line: 220, column: 13, scope: !586)
!595 = !DILocation(line: 221, column: 13, scope: !596)
!596 = distinct !DILexicalBlock(scope: !550, file: !7, line: 221, column: 13)
!597 = !DILocation(line: 221, column: 15, scope: !596)
!598 = !DILocation(line: 221, column: 13, scope: !550)
!599 = !DILocation(line: 222, column: 13, scope: !596)
!600 = !DILocation(line: 225, column: 16, scope: !550)
!601 = !DILocation(line: 225, column: 14, scope: !550)
!602 = !DILocation(line: 226, column: 16, scope: !550)
!603 = !DILocation(line: 226, column: 9, scope: !550)
!604 = !DILocation(line: 226, column: 14, scope: !550)
!605 = !DILabel(scope: !550, name: "Reflection_coefficients_label5", file: !7, line: 228)
!606 = !DILocation(line: 228, column: 9, scope: !550)
!607 = !DILocation(line: 229, column: 16, scope: !608)
!608 = distinct !DILexicalBlock(scope: !550, file: !7, line: 229, column: 9)
!609 = !DILocation(line: 229, column: 14, scope: !608)
!610 = !DILocation(line: 229, column: 21, scope: !611)
!611 = distinct !DILexicalBlock(scope: !608, file: !7, line: 229, column: 9)
!612 = !DILocation(line: 229, column: 30, scope: !611)
!613 = !DILocation(line: 229, column: 28, scope: !611)
!614 = !DILocation(line: 229, column: 23, scope: !611)
!615 = !DILocation(line: 229, column: 9, scope: !608)
!616 = !DILocation(line: 231, column: 20, scope: !617)
!617 = distinct !DILexicalBlock(scope: !611, file: !7, line: 229, column: 38)
!618 = !DILocation(line: 231, column: 18, scope: !617)
!619 = !DILocation(line: 232, column: 20, scope: !617)
!620 = !DILocation(line: 232, column: 15, scope: !617)
!621 = !DILocation(line: 232, column: 13, scope: !617)
!622 = !DILocation(line: 232, column: 18, scope: !617)
!623 = !DILocation(line: 234, column: 20, scope: !617)
!624 = !DILocation(line: 234, column: 18, scope: !617)
!625 = !DILocation(line: 235, column: 20, scope: !617)
!626 = !DILocation(line: 235, column: 15, scope: !617)
!627 = !DILocation(line: 235, column: 13, scope: !617)
!628 = !DILocation(line: 235, column: 18, scope: !617)
!629 = !DILocation(line: 236, column: 9, scope: !617)
!630 = !DILocation(line: 229, column: 34, scope: !611)
!631 = !DILocation(line: 229, column: 9, scope: !611)
!632 = distinct !{!632, !615, !633, !193}
!633 = !DILocation(line: 236, column: 9, scope: !608)
!634 = !DILocation(line: 237, column: 5, scope: !550)
!635 = !DILocation(line: 204, column: 26, scope: !546)
!636 = !DILocation(line: 204, column: 31, scope: !546)
!637 = !DILocation(line: 204, column: 5, scope: !546)
!638 = distinct !{!638, !548, !639, !193}
!639 = !DILocation(line: 237, column: 5, scope: !543)
!640 = !DILocation(line: 238, column: 1, scope: !429)
!641 = distinct !DISubprogram(name: "Transformation_to_Log_Area_Ratios", scope: !7, file: !7, line: 241, type: !642, scopeLine: 242, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6, retainedNodes: !23)
!642 = !DISubroutineType(types: !643)
!643 = !{null, !200}
!644 = !DILocalVariable(name: "r", arg: 1, scope: !641, file: !7, line: 241, type: !200)
!645 = !DILocation(line: 241, column: 55, scope: !641)
!646 = !DILocalVariable(name: "temp", scope: !641, file: !7, line: 243, type: !21)
!647 = !DILocation(line: 243, column: 19, scope: !641)
!648 = !DILocalVariable(name: "i", scope: !641, file: !7, line: 244, type: !160)
!649 = !DILocation(line: 244, column: 18, scope: !641)
!650 = !DILocation(line: 244, column: 5, scope: !641)
!651 = !DILabel(scope: !641, name: "Transformation_to_Log_Area_Ratios_label0", file: !7, line: 247)
!652 = !DILocation(line: 247, column: 5, scope: !641)
!653 = !DILocation(line: 248, column: 12, scope: !654)
!654 = distinct !DILexicalBlock(scope: !641, file: !7, line: 248, column: 5)
!655 = !DILocation(line: 248, column: 10, scope: !654)
!656 = !DILocation(line: 248, column: 17, scope: !657)
!657 = distinct !DILexicalBlock(scope: !654, file: !7, line: 248, column: 5)
!658 = !DILocation(line: 248, column: 19, scope: !657)
!659 = !DILocation(line: 248, column: 5, scope: !654)
!660 = !DILocation(line: 250, column: 17, scope: !661)
!661 = distinct !DILexicalBlock(scope: !657, file: !7, line: 248, column: 35)
!662 = !DILocation(line: 250, column: 16, scope: !661)
!663 = !DILocation(line: 250, column: 14, scope: !661)
!664 = !DILocation(line: 251, column: 16, scope: !661)
!665 = !DILocation(line: 251, column: 14, scope: !661)
!666 = !DILocation(line: 253, column: 13, scope: !667)
!667 = distinct !DILexicalBlock(scope: !661, file: !7, line: 253, column: 13)
!668 = !DILocation(line: 253, column: 18, scope: !667)
!669 = !DILocation(line: 253, column: 13, scope: !661)
!670 = !DILocation(line: 254, column: 18, scope: !671)
!671 = distinct !DILexicalBlock(scope: !667, file: !7, line: 253, column: 27)
!672 = !DILocation(line: 255, column: 9, scope: !671)
!673 = !DILocation(line: 255, column: 20, scope: !674)
!674 = distinct !DILexicalBlock(scope: !667, file: !7, line: 255, column: 20)
!675 = !DILocation(line: 255, column: 25, scope: !674)
!676 = !DILocation(line: 255, column: 20, scope: !667)
!677 = !DILocation(line: 256, column: 18, scope: !678)
!678 = distinct !DILexicalBlock(scope: !674, file: !7, line: 255, column: 34)
!679 = !DILocation(line: 257, column: 9, scope: !678)
!680 = !DILocation(line: 258, column: 18, scope: !681)
!681 = distinct !DILexicalBlock(scope: !674, file: !7, line: 257, column: 16)
!682 = !DILocation(line: 259, column: 18, scope: !681)
!683 = !DILocation(line: 262, column: 15, scope: !661)
!684 = !DILocation(line: 262, column: 14, scope: !661)
!685 = !DILocation(line: 262, column: 17, scope: !661)
!686 = !DILocation(line: 262, column: 24, scope: !661)
!687 = !DILocation(line: 262, column: 23, scope: !661)
!688 = !DILocation(line: 262, column: 31, scope: !661)
!689 = !DILocation(line: 262, column: 10, scope: !661)
!690 = !DILocation(line: 262, column: 12, scope: !661)
!691 = !DILocation(line: 263, column: 5, scope: !661)
!692 = !DILocation(line: 248, column: 26, scope: !657)
!693 = !DILocation(line: 248, column: 31, scope: !657)
!694 = !DILocation(line: 248, column: 5, scope: !657)
!695 = distinct !{!695, !659, !696, !193}
!696 = !DILocation(line: 263, column: 5, scope: !654)
!697 = !DILocation(line: 264, column: 1, scope: !641)
!698 = distinct !DISubprogram(name: "Quantization_and_coding", scope: !7, file: !7, line: 267, type: !642, scopeLine: 268, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !6, retainedNodes: !23)
!699 = !DILocalVariable(name: "LAR", arg: 1, scope: !698, file: !7, line: 267, type: !200)
!700 = !DILocation(line: 267, column: 45, scope: !698)
!701 = !DILocalVariable(name: "temp", scope: !698, file: !7, line: 269, type: !21)
!702 = !DILocation(line: 269, column: 19, scope: !698)
!703 = !DILocation(line: 289, column: 5, scope: !698)
!704 = !DILocation(line: 290, column: 5, scope: !698)
!705 = !DILocation(line: 291, column: 5, scope: !698)
!706 = !DILocation(line: 292, column: 5, scope: !698)
!707 = !DILocation(line: 294, column: 5, scope: !698)
!708 = !DILocation(line: 295, column: 5, scope: !698)
!709 = !DILocation(line: 296, column: 5, scope: !698)
!710 = !DILocation(line: 297, column: 5, scope: !698)
!711 = !DILocation(line: 300, column: 1, scope: !698)
!712 = distinct !DISubprogram(name: "Gsm_LPC_Analysis", scope: !9, file: !9, line: 7, type: !713, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !23)
!713 = !DISubroutineType(types: !714)
!714 = !{null, !200, !200}
!715 = !DILocalVariable(name: "indata", arg: 1, scope: !712, file: !9, line: 7, type: !200)
!716 = !DILocation(line: 7, column: 28, scope: !712)
!717 = !DILocalVariable(name: "LARc", arg: 2, scope: !712, file: !9, line: 7, type: !200)
!718 = !DILocation(line: 7, column: 44, scope: !712)
!719 = !DILocalVariable(name: "L_ACF", scope: !712, file: !9, line: 9, type: !720)
!720 = !DICompositeType(tag: DW_TAG_array_type, baseType: !3, size: 576, elements: !446)
!721 = !DILocation(line: 9, column: 14, scope: !712)
!722 = !DILocation(line: 11, column: 21, scope: !712)
!723 = !DILocation(line: 11, column: 29, scope: !712)
!724 = !DILocation(line: 11, column: 5, scope: !712)
!725 = !DILocation(line: 12, column: 29, scope: !712)
!726 = !DILocation(line: 12, column: 36, scope: !712)
!727 = !DILocation(line: 12, column: 5, scope: !712)
!728 = !DILocation(line: 13, column: 39, scope: !712)
!729 = !DILocation(line: 13, column: 5, scope: !712)
!730 = !DILocation(line: 14, column: 29, scope: !712)
!731 = !DILocation(line: 14, column: 5, scope: !712)
!732 = !DILocation(line: 15, column: 1, scope: !712)
