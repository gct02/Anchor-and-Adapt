; ModuleID = 'data/benchmarks/real/sha/sha.c'
source_filename = "data/benchmarks/real/sha/sha.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@sha_info_data = dso_local global [16 x i32] zeroinitializer, align 16, !dbg !0
@sha_info_digest = dso_local global [5 x i32] zeroinitializer, align 16, !dbg !15
@sha_info_count_lo = dso_local global i32 0, align 4, !dbg !11
@sha_info_count_hi = dso_local global i32 0, align 4, !dbg !13
@local_indata = dso_local global [2 x [8192 x i8]] zeroinitializer, align 16, !dbg !20

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @local_memset(i32* noundef %s, i32 noundef %c, i32 noundef %n, i32 noundef %e) #0 !dbg !37 {
entry:
  %s.addr = alloca i32*, align 8
  %c.addr = alloca i32, align 4
  %n.addr = alloca i32, align 4
  %e.addr = alloca i32, align 4
  %uc = alloca i32, align 4
  %p = alloca i32*, align 8
  %m = alloca i32, align 4
  store i32* %s, i32** %s.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %s.addr, metadata !41, metadata !DIExpression()), !dbg !42
  store i32 %c, i32* %c.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %c.addr, metadata !43, metadata !DIExpression()), !dbg !44
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !45, metadata !DIExpression()), !dbg !46
  store i32 %e, i32* %e.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %e.addr, metadata !47, metadata !DIExpression()), !dbg !48
  call void @llvm.dbg.declare(metadata i32* %uc, metadata !49, metadata !DIExpression()), !dbg !50
  %0 = load i32, i32* %c.addr, align 4, !dbg !51
  store i32 %0, i32* %uc, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata i32** %p, metadata !52, metadata !DIExpression()), !dbg !53
  %1 = load i32*, i32** %s.addr, align 8, !dbg !54
  store i32* %1, i32** %p, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i32* %m, metadata !55, metadata !DIExpression()), !dbg !56
  %2 = load i32, i32* %n.addr, align 4, !dbg !57
  %div = sdiv i32 %2, 4, !dbg !58
  store i32 %div, i32* %m, align 4, !dbg !56
  br label %local_memset_label0, !dbg !59

local_memset_label0:                              ; preds = %entry
  call void @llvm.dbg.label(metadata !60), !dbg !61
  br label %while.cond, !dbg !62

while.cond:                                       ; preds = %while.body, %local_memset_label0
  %3 = load i32, i32* %e.addr, align 4, !dbg !63
  %dec = add nsw i32 %3, -1, !dbg !63
  store i32 %dec, i32* %e.addr, align 4, !dbg !63
  %cmp = icmp sgt i32 %3, 0, !dbg !64
  br i1 %cmp, label %while.body, label %while.end, !dbg !62

while.body:                                       ; preds = %while.cond
  %4 = load i32*, i32** %p, align 8, !dbg !65
  %incdec.ptr = getelementptr inbounds i32, i32* %4, i32 1, !dbg !65
  store i32* %incdec.ptr, i32** %p, align 8, !dbg !65
  br label %while.cond, !dbg !62, !llvm.loop !67

while.end:                                        ; preds = %while.cond
  br label %local_memset_label1, !dbg !62

local_memset_label1:                              ; preds = %while.end
  call void @llvm.dbg.label(metadata !70), !dbg !71
  br label %while.cond1, !dbg !72

while.cond1:                                      ; preds = %while.body4, %local_memset_label1
  %5 = load i32, i32* %m, align 4, !dbg !73
  %dec2 = add nsw i32 %5, -1, !dbg !73
  store i32 %dec2, i32* %m, align 4, !dbg !73
  %cmp3 = icmp sgt i32 %5, 0, !dbg !74
  br i1 %cmp3, label %while.body4, label %while.end6, !dbg !72

while.body4:                                      ; preds = %while.cond1
  %6 = load i32, i32* %uc, align 4, !dbg !75
  %7 = load i32*, i32** %p, align 8, !dbg !77
  %incdec.ptr5 = getelementptr inbounds i32, i32* %7, i32 1, !dbg !77
  store i32* %incdec.ptr5, i32** %p, align 8, !dbg !77
  store i32 %6, i32* %7, align 4, !dbg !78
  br label %while.cond1, !dbg !72, !llvm.loop !79

while.end6:                                       ; preds = %while.cond1
  ret void, !dbg !81
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @local_memcpy(i32* noundef %s1, i8* noundef %s2, i32 noundef %n) #0 !dbg !82 {
entry:
  %s1.addr = alloca i32*, align 8
  %s2.addr = alloca i8*, align 8
  %n.addr = alloca i32, align 4
  %p1 = alloca i32*, align 8
  %p2 = alloca i8*, align 8
  %tmp = alloca i32, align 4
  %m = alloca i32, align 4
  store i32* %s1, i32** %s1.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %s1.addr, metadata !87, metadata !DIExpression()), !dbg !88
  store i8* %s2, i8** %s2.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %s2.addr, metadata !89, metadata !DIExpression()), !dbg !90
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !91, metadata !DIExpression()), !dbg !92
  call void @llvm.dbg.declare(metadata i32** %p1, metadata !93, metadata !DIExpression()), !dbg !94
  %0 = load i32*, i32** %s1.addr, align 8, !dbg !95
  store i32* %0, i32** %p1, align 8, !dbg !94
  call void @llvm.dbg.declare(metadata i8** %p2, metadata !96, metadata !DIExpression()), !dbg !97
  %1 = load i8*, i8** %s2.addr, align 8, !dbg !98
  store i8* %1, i8** %p2, align 8, !dbg !97
  call void @llvm.dbg.declare(metadata i32* %tmp, metadata !99, metadata !DIExpression()), !dbg !100
  call void @llvm.dbg.declare(metadata i32* %m, metadata !101, metadata !DIExpression()), !dbg !102
  %2 = load i32, i32* %n.addr, align 4, !dbg !103
  %div = sdiv i32 %2, 4, !dbg !104
  store i32 %div, i32* %m, align 4, !dbg !102
  br label %local_memcpy_label3, !dbg !105

local_memcpy_label3:                              ; preds = %entry
  call void @llvm.dbg.label(metadata !106), !dbg !107
  br label %while.cond, !dbg !108

while.cond:                                       ; preds = %while.body, %local_memcpy_label3
  %3 = load i32, i32* %m, align 4, !dbg !109
  %dec = add nsw i32 %3, -1, !dbg !109
  store i32 %dec, i32* %m, align 4, !dbg !109
  %cmp = icmp sgt i32 %3, 0, !dbg !110
  br i1 %cmp, label %while.body, label %while.end, !dbg !108

while.body:                                       ; preds = %while.cond
  store i32 0, i32* %tmp, align 4, !dbg !111
  %4 = load i8*, i8** %p2, align 8, !dbg !113
  %incdec.ptr = getelementptr inbounds i8, i8* %4, i32 1, !dbg !113
  store i8* %incdec.ptr, i8** %p2, align 8, !dbg !113
  %5 = load i8, i8* %4, align 1, !dbg !114
  %conv = zext i8 %5 to i32, !dbg !114
  %and = and i32 255, %conv, !dbg !115
  %6 = load i32, i32* %tmp, align 4, !dbg !116
  %or = or i32 %6, %and, !dbg !116
  store i32 %or, i32* %tmp, align 4, !dbg !116
  %7 = load i8*, i8** %p2, align 8, !dbg !117
  %incdec.ptr1 = getelementptr inbounds i8, i8* %7, i32 1, !dbg !117
  store i8* %incdec.ptr1, i8** %p2, align 8, !dbg !117
  %8 = load i8, i8* %7, align 1, !dbg !118
  %conv2 = zext i8 %8 to i32, !dbg !118
  %and3 = and i32 255, %conv2, !dbg !119
  %shl = shl i32 %and3, 8, !dbg !120
  %9 = load i32, i32* %tmp, align 4, !dbg !121
  %or4 = or i32 %9, %shl, !dbg !121
  store i32 %or4, i32* %tmp, align 4, !dbg !121
  %10 = load i8*, i8** %p2, align 8, !dbg !122
  %incdec.ptr5 = getelementptr inbounds i8, i8* %10, i32 1, !dbg !122
  store i8* %incdec.ptr5, i8** %p2, align 8, !dbg !122
  %11 = load i8, i8* %10, align 1, !dbg !123
  %conv6 = zext i8 %11 to i32, !dbg !123
  %and7 = and i32 255, %conv6, !dbg !124
  %shl8 = shl i32 %and7, 16, !dbg !125
  %12 = load i32, i32* %tmp, align 4, !dbg !126
  %or9 = or i32 %12, %shl8, !dbg !126
  store i32 %or9, i32* %tmp, align 4, !dbg !126
  %13 = load i8*, i8** %p2, align 8, !dbg !127
  %incdec.ptr10 = getelementptr inbounds i8, i8* %13, i32 1, !dbg !127
  store i8* %incdec.ptr10, i8** %p2, align 8, !dbg !127
  %14 = load i8, i8* %13, align 1, !dbg !128
  %conv11 = zext i8 %14 to i32, !dbg !128
  %and12 = and i32 255, %conv11, !dbg !129
  %shl13 = shl i32 %and12, 24, !dbg !130
  %15 = load i32, i32* %tmp, align 4, !dbg !131
  %or14 = or i32 %15, %shl13, !dbg !131
  store i32 %or14, i32* %tmp, align 4, !dbg !131
  %16 = load i32, i32* %tmp, align 4, !dbg !132
  %17 = load i32*, i32** %p1, align 8, !dbg !133
  store i32 %16, i32* %17, align 4, !dbg !134
  %18 = load i32*, i32** %p1, align 8, !dbg !135
  %incdec.ptr15 = getelementptr inbounds i32, i32* %18, i32 1, !dbg !135
  store i32* %incdec.ptr15, i32** %p1, align 8, !dbg !135
  br label %while.cond, !dbg !108, !llvm.loop !136

while.end:                                        ; preds = %while.cond
  ret void, !dbg !138
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sha_transform() #0 !dbg !139 {
entry:
  %i = alloca i32, align 4
  %temp = alloca i32, align 4
  %A = alloca i32, align 4
  %B = alloca i32, align 4
  %C = alloca i32, align 4
  %D = alloca i32, align 4
  %E = alloca i32, align 4
  %W = alloca [80 x i32], align 16
  call void @llvm.dbg.declare(metadata i32* %i, metadata !142, metadata !DIExpression()), !dbg !143
  call void @llvm.dbg.declare(metadata i32* %temp, metadata !144, metadata !DIExpression()), !dbg !145
  call void @llvm.dbg.declare(metadata i32* %A, metadata !146, metadata !DIExpression()), !dbg !147
  call void @llvm.dbg.declare(metadata i32* %B, metadata !148, metadata !DIExpression()), !dbg !149
  call void @llvm.dbg.declare(metadata i32* %C, metadata !150, metadata !DIExpression()), !dbg !151
  call void @llvm.dbg.declare(metadata i32* %D, metadata !152, metadata !DIExpression()), !dbg !153
  call void @llvm.dbg.declare(metadata i32* %E, metadata !154, metadata !DIExpression()), !dbg !155
  call void @llvm.dbg.declare(metadata [80 x i32]* %W, metadata !156, metadata !DIExpression()), !dbg !160
  br label %sha_transform_label1, !dbg !161

sha_transform_label1:                             ; preds = %entry
  call void @llvm.dbg.label(metadata !162), !dbg !163
  store i32 0, i32* %i, align 4, !dbg !164
  br label %for.cond, !dbg !166

for.cond:                                         ; preds = %for.inc, %sha_transform_label1
  %0 = load i32, i32* %i, align 4, !dbg !167
  %cmp = icmp slt i32 %0, 16, !dbg !169
  br i1 %cmp, label %for.body, label %for.end, !dbg !170

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4, !dbg !171
  %idxprom = sext i32 %1 to i64, !dbg !173
  %arrayidx = getelementptr inbounds [16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 %idxprom, !dbg !173
  %2 = load i32, i32* %arrayidx, align 4, !dbg !173
  %3 = load i32, i32* %i, align 4, !dbg !174
  %idxprom1 = sext i32 %3 to i64, !dbg !175
  %arrayidx2 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom1, !dbg !175
  store i32 %2, i32* %arrayidx2, align 4, !dbg !176
  br label %for.inc, !dbg !177

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !dbg !178
  %inc = add nsw i32 %4, 1, !dbg !178
  store i32 %inc, i32* %i, align 4, !dbg !178
  br label %for.cond, !dbg !179, !llvm.loop !180

for.end:                                          ; preds = %for.cond
  br label %sha_transform_label2, !dbg !181

sha_transform_label2:                             ; preds = %for.end
  call void @llvm.dbg.label(metadata !182), !dbg !183
  store i32 16, i32* %i, align 4, !dbg !184
  br label %for.cond3, !dbg !186

for.cond3:                                        ; preds = %for.inc21, %sha_transform_label2
  %5 = load i32, i32* %i, align 4, !dbg !187
  %cmp4 = icmp slt i32 %5, 80, !dbg !189
  br i1 %cmp4, label %for.body5, label %for.end23, !dbg !190

for.body5:                                        ; preds = %for.cond3
  %6 = load i32, i32* %i, align 4, !dbg !191
  %sub = sub nsw i32 %6, 3, !dbg !193
  %idxprom6 = sext i32 %sub to i64, !dbg !194
  %arrayidx7 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom6, !dbg !194
  %7 = load i32, i32* %arrayidx7, align 4, !dbg !194
  %8 = load i32, i32* %i, align 4, !dbg !195
  %sub8 = sub nsw i32 %8, 8, !dbg !196
  %idxprom9 = sext i32 %sub8 to i64, !dbg !197
  %arrayidx10 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom9, !dbg !197
  %9 = load i32, i32* %arrayidx10, align 4, !dbg !197
  %xor = xor i32 %7, %9, !dbg !198
  %10 = load i32, i32* %i, align 4, !dbg !199
  %sub11 = sub nsw i32 %10, 14, !dbg !200
  %idxprom12 = sext i32 %sub11 to i64, !dbg !201
  %arrayidx13 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom12, !dbg !201
  %11 = load i32, i32* %arrayidx13, align 4, !dbg !201
  %xor14 = xor i32 %xor, %11, !dbg !202
  %12 = load i32, i32* %i, align 4, !dbg !203
  %sub15 = sub nsw i32 %12, 16, !dbg !204
  %idxprom16 = sext i32 %sub15 to i64, !dbg !205
  %arrayidx17 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom16, !dbg !205
  %13 = load i32, i32* %arrayidx17, align 4, !dbg !205
  %xor18 = xor i32 %xor14, %13, !dbg !206
  %14 = load i32, i32* %i, align 4, !dbg !207
  %idxprom19 = sext i32 %14 to i64, !dbg !208
  %arrayidx20 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom19, !dbg !208
  store i32 %xor18, i32* %arrayidx20, align 4, !dbg !209
  br label %for.inc21, !dbg !210

for.inc21:                                        ; preds = %for.body5
  %15 = load i32, i32* %i, align 4, !dbg !211
  %inc22 = add nsw i32 %15, 1, !dbg !211
  store i32 %inc22, i32* %i, align 4, !dbg !211
  br label %for.cond3, !dbg !212, !llvm.loop !213

for.end23:                                        ; preds = %for.cond3
  %16 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 0), align 16, !dbg !215
  store i32 %16, i32* %A, align 4, !dbg !216
  %17 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 1), align 4, !dbg !217
  store i32 %17, i32* %B, align 4, !dbg !218
  %18 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 2), align 8, !dbg !219
  store i32 %18, i32* %C, align 4, !dbg !220
  %19 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 3), align 4, !dbg !221
  store i32 %19, i32* %D, align 4, !dbg !222
  %20 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 4), align 16, !dbg !223
  store i32 %20, i32* %E, align 4, !dbg !224
  br label %sha_transform_label3, !dbg !225

sha_transform_label3:                             ; preds = %for.end23
  call void @llvm.dbg.label(metadata !226), !dbg !227
  store i32 0, i32* %i, align 4, !dbg !228
  br label %for.cond24, !dbg !230

for.cond24:                                       ; preds = %for.inc38, %sha_transform_label3
  %21 = load i32, i32* %i, align 4, !dbg !231
  %cmp25 = icmp slt i32 %21, 20, !dbg !233
  br i1 %cmp25, label %for.body26, label %for.end40, !dbg !234

for.body26:                                       ; preds = %for.cond24
  %22 = load i32, i32* %A, align 4, !dbg !235
  %shl = shl i32 %22, 5, !dbg !235
  %23 = load i32, i32* %A, align 4, !dbg !235
  %shr = lshr i32 %23, 27, !dbg !235
  %or = or i32 %shl, %shr, !dbg !235
  %24 = load i32, i32* %B, align 4, !dbg !235
  %25 = load i32, i32* %C, align 4, !dbg !235
  %and = and i32 %24, %25, !dbg !235
  %26 = load i32, i32* %B, align 4, !dbg !235
  %neg = xor i32 %26, -1, !dbg !235
  %27 = load i32, i32* %D, align 4, !dbg !235
  %and27 = and i32 %neg, %27, !dbg !235
  %or28 = or i32 %and, %and27, !dbg !235
  %add = add i32 %or, %or28, !dbg !235
  %28 = load i32, i32* %E, align 4, !dbg !235
  %add29 = add i32 %add, %28, !dbg !235
  %29 = load i32, i32* %i, align 4, !dbg !235
  %idxprom30 = sext i32 %29 to i64, !dbg !235
  %arrayidx31 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom30, !dbg !235
  %30 = load i32, i32* %arrayidx31, align 4, !dbg !235
  %add32 = add i32 %add29, %30, !dbg !235
  %conv = zext i32 %add32 to i64, !dbg !235
  %add33 = add nsw i64 %conv, 1518500249, !dbg !235
  %conv34 = trunc i64 %add33 to i32, !dbg !235
  store i32 %conv34, i32* %temp, align 4, !dbg !235
  %31 = load i32, i32* %D, align 4, !dbg !235
  store i32 %31, i32* %E, align 4, !dbg !235
  %32 = load i32, i32* %C, align 4, !dbg !235
  store i32 %32, i32* %D, align 4, !dbg !235
  %33 = load i32, i32* %B, align 4, !dbg !235
  %shl35 = shl i32 %33, 30, !dbg !235
  %34 = load i32, i32* %B, align 4, !dbg !235
  %shr36 = lshr i32 %34, 2, !dbg !235
  %or37 = or i32 %shl35, %shr36, !dbg !235
  store i32 %or37, i32* %C, align 4, !dbg !235
  %35 = load i32, i32* %A, align 4, !dbg !235
  store i32 %35, i32* %B, align 4, !dbg !235
  %36 = load i32, i32* %temp, align 4, !dbg !235
  store i32 %36, i32* %A, align 4, !dbg !235
  br label %for.inc38, !dbg !237

for.inc38:                                        ; preds = %for.body26
  %37 = load i32, i32* %i, align 4, !dbg !238
  %inc39 = add nsw i32 %37, 1, !dbg !238
  store i32 %inc39, i32* %i, align 4, !dbg !238
  br label %for.cond24, !dbg !239, !llvm.loop !240

for.end40:                                        ; preds = %for.cond24
  br label %sha_transform_label4, !dbg !241

sha_transform_label4:                             ; preds = %for.end40
  call void @llvm.dbg.label(metadata !242), !dbg !243
  store i32 20, i32* %i, align 4, !dbg !244
  br label %for.cond41, !dbg !246

for.cond41:                                       ; preds = %for.inc61, %sha_transform_label4
  %38 = load i32, i32* %i, align 4, !dbg !247
  %cmp42 = icmp slt i32 %38, 40, !dbg !249
  br i1 %cmp42, label %for.body44, label %for.end63, !dbg !250

for.body44:                                       ; preds = %for.cond41
  %39 = load i32, i32* %A, align 4, !dbg !251
  %shl45 = shl i32 %39, 5, !dbg !251
  %40 = load i32, i32* %A, align 4, !dbg !251
  %shr46 = lshr i32 %40, 27, !dbg !251
  %or47 = or i32 %shl45, %shr46, !dbg !251
  %41 = load i32, i32* %B, align 4, !dbg !251
  %42 = load i32, i32* %C, align 4, !dbg !251
  %xor48 = xor i32 %41, %42, !dbg !251
  %43 = load i32, i32* %D, align 4, !dbg !251
  %xor49 = xor i32 %xor48, %43, !dbg !251
  %add50 = add i32 %or47, %xor49, !dbg !251
  %44 = load i32, i32* %E, align 4, !dbg !251
  %add51 = add i32 %add50, %44, !dbg !251
  %45 = load i32, i32* %i, align 4, !dbg !251
  %idxprom52 = sext i32 %45 to i64, !dbg !251
  %arrayidx53 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom52, !dbg !251
  %46 = load i32, i32* %arrayidx53, align 4, !dbg !251
  %add54 = add i32 %add51, %46, !dbg !251
  %conv55 = zext i32 %add54 to i64, !dbg !251
  %add56 = add nsw i64 %conv55, 1859775393, !dbg !251
  %conv57 = trunc i64 %add56 to i32, !dbg !251
  store i32 %conv57, i32* %temp, align 4, !dbg !251
  %47 = load i32, i32* %D, align 4, !dbg !251
  store i32 %47, i32* %E, align 4, !dbg !251
  %48 = load i32, i32* %C, align 4, !dbg !251
  store i32 %48, i32* %D, align 4, !dbg !251
  %49 = load i32, i32* %B, align 4, !dbg !251
  %shl58 = shl i32 %49, 30, !dbg !251
  %50 = load i32, i32* %B, align 4, !dbg !251
  %shr59 = lshr i32 %50, 2, !dbg !251
  %or60 = or i32 %shl58, %shr59, !dbg !251
  store i32 %or60, i32* %C, align 4, !dbg !251
  %51 = load i32, i32* %A, align 4, !dbg !251
  store i32 %51, i32* %B, align 4, !dbg !251
  %52 = load i32, i32* %temp, align 4, !dbg !251
  store i32 %52, i32* %A, align 4, !dbg !251
  br label %for.inc61, !dbg !253

for.inc61:                                        ; preds = %for.body44
  %53 = load i32, i32* %i, align 4, !dbg !254
  %inc62 = add nsw i32 %53, 1, !dbg !254
  store i32 %inc62, i32* %i, align 4, !dbg !254
  br label %for.cond41, !dbg !255, !llvm.loop !256

for.end63:                                        ; preds = %for.cond41
  br label %sha_transform_label5, !dbg !257

sha_transform_label5:                             ; preds = %for.end63
  call void @llvm.dbg.label(metadata !258), !dbg !259
  store i32 40, i32* %i, align 4, !dbg !260
  br label %for.cond64, !dbg !262

for.cond64:                                       ; preds = %for.inc87, %sha_transform_label5
  %54 = load i32, i32* %i, align 4, !dbg !263
  %cmp65 = icmp slt i32 %54, 60, !dbg !265
  br i1 %cmp65, label %for.body67, label %for.end89, !dbg !266

for.body67:                                       ; preds = %for.cond64
  %55 = load i32, i32* %A, align 4, !dbg !267
  %shl68 = shl i32 %55, 5, !dbg !267
  %56 = load i32, i32* %A, align 4, !dbg !267
  %shr69 = lshr i32 %56, 27, !dbg !267
  %or70 = or i32 %shl68, %shr69, !dbg !267
  %57 = load i32, i32* %B, align 4, !dbg !267
  %58 = load i32, i32* %C, align 4, !dbg !267
  %and71 = and i32 %57, %58, !dbg !267
  %59 = load i32, i32* %B, align 4, !dbg !267
  %60 = load i32, i32* %D, align 4, !dbg !267
  %and72 = and i32 %59, %60, !dbg !267
  %or73 = or i32 %and71, %and72, !dbg !267
  %61 = load i32, i32* %C, align 4, !dbg !267
  %62 = load i32, i32* %D, align 4, !dbg !267
  %and74 = and i32 %61, %62, !dbg !267
  %or75 = or i32 %or73, %and74, !dbg !267
  %add76 = add i32 %or70, %or75, !dbg !267
  %63 = load i32, i32* %E, align 4, !dbg !267
  %add77 = add i32 %add76, %63, !dbg !267
  %64 = load i32, i32* %i, align 4, !dbg !267
  %idxprom78 = sext i32 %64 to i64, !dbg !267
  %arrayidx79 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom78, !dbg !267
  %65 = load i32, i32* %arrayidx79, align 4, !dbg !267
  %add80 = add i32 %add77, %65, !dbg !267
  %conv81 = zext i32 %add80 to i64, !dbg !267
  %add82 = add nsw i64 %conv81, 2400959708, !dbg !267
  %conv83 = trunc i64 %add82 to i32, !dbg !267
  store i32 %conv83, i32* %temp, align 4, !dbg !267
  %66 = load i32, i32* %D, align 4, !dbg !267
  store i32 %66, i32* %E, align 4, !dbg !267
  %67 = load i32, i32* %C, align 4, !dbg !267
  store i32 %67, i32* %D, align 4, !dbg !267
  %68 = load i32, i32* %B, align 4, !dbg !267
  %shl84 = shl i32 %68, 30, !dbg !267
  %69 = load i32, i32* %B, align 4, !dbg !267
  %shr85 = lshr i32 %69, 2, !dbg !267
  %or86 = or i32 %shl84, %shr85, !dbg !267
  store i32 %or86, i32* %C, align 4, !dbg !267
  %70 = load i32, i32* %A, align 4, !dbg !267
  store i32 %70, i32* %B, align 4, !dbg !267
  %71 = load i32, i32* %temp, align 4, !dbg !267
  store i32 %71, i32* %A, align 4, !dbg !267
  br label %for.inc87, !dbg !269

for.inc87:                                        ; preds = %for.body67
  %72 = load i32, i32* %i, align 4, !dbg !270
  %inc88 = add nsw i32 %72, 1, !dbg !270
  store i32 %inc88, i32* %i, align 4, !dbg !270
  br label %for.cond64, !dbg !271, !llvm.loop !272

for.end89:                                        ; preds = %for.cond64
  br label %sha_transform_label6, !dbg !273

sha_transform_label6:                             ; preds = %for.end89
  call void @llvm.dbg.label(metadata !274), !dbg !275
  store i32 60, i32* %i, align 4, !dbg !276
  br label %for.cond90, !dbg !278

for.cond90:                                       ; preds = %for.inc110, %sha_transform_label6
  %73 = load i32, i32* %i, align 4, !dbg !279
  %cmp91 = icmp slt i32 %73, 80, !dbg !281
  br i1 %cmp91, label %for.body93, label %for.end112, !dbg !282

for.body93:                                       ; preds = %for.cond90
  %74 = load i32, i32* %A, align 4, !dbg !283
  %shl94 = shl i32 %74, 5, !dbg !283
  %75 = load i32, i32* %A, align 4, !dbg !283
  %shr95 = lshr i32 %75, 27, !dbg !283
  %or96 = or i32 %shl94, %shr95, !dbg !283
  %76 = load i32, i32* %B, align 4, !dbg !283
  %77 = load i32, i32* %C, align 4, !dbg !283
  %xor97 = xor i32 %76, %77, !dbg !283
  %78 = load i32, i32* %D, align 4, !dbg !283
  %xor98 = xor i32 %xor97, %78, !dbg !283
  %add99 = add i32 %or96, %xor98, !dbg !283
  %79 = load i32, i32* %E, align 4, !dbg !283
  %add100 = add i32 %add99, %79, !dbg !283
  %80 = load i32, i32* %i, align 4, !dbg !283
  %idxprom101 = sext i32 %80 to i64, !dbg !283
  %arrayidx102 = getelementptr inbounds [80 x i32], [80 x i32]* %W, i64 0, i64 %idxprom101, !dbg !283
  %81 = load i32, i32* %arrayidx102, align 4, !dbg !283
  %add103 = add i32 %add100, %81, !dbg !283
  %conv104 = zext i32 %add103 to i64, !dbg !283
  %add105 = add nsw i64 %conv104, 3395469782, !dbg !283
  %conv106 = trunc i64 %add105 to i32, !dbg !283
  store i32 %conv106, i32* %temp, align 4, !dbg !283
  %82 = load i32, i32* %D, align 4, !dbg !283
  store i32 %82, i32* %E, align 4, !dbg !283
  %83 = load i32, i32* %C, align 4, !dbg !283
  store i32 %83, i32* %D, align 4, !dbg !283
  %84 = load i32, i32* %B, align 4, !dbg !283
  %shl107 = shl i32 %84, 30, !dbg !283
  %85 = load i32, i32* %B, align 4, !dbg !283
  %shr108 = lshr i32 %85, 2, !dbg !283
  %or109 = or i32 %shl107, %shr108, !dbg !283
  store i32 %or109, i32* %C, align 4, !dbg !283
  %86 = load i32, i32* %A, align 4, !dbg !283
  store i32 %86, i32* %B, align 4, !dbg !283
  %87 = load i32, i32* %temp, align 4, !dbg !283
  store i32 %87, i32* %A, align 4, !dbg !283
  br label %for.inc110, !dbg !285

for.inc110:                                       ; preds = %for.body93
  %88 = load i32, i32* %i, align 4, !dbg !286
  %inc111 = add nsw i32 %88, 1, !dbg !286
  store i32 %inc111, i32* %i, align 4, !dbg !286
  br label %for.cond90, !dbg !287, !llvm.loop !288

for.end112:                                       ; preds = %for.cond90
  %89 = load i32, i32* %A, align 4, !dbg !290
  %90 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 0), align 16, !dbg !291
  %add113 = add i32 %90, %89, !dbg !291
  store i32 %add113, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 0), align 16, !dbg !291
  %91 = load i32, i32* %B, align 4, !dbg !292
  %92 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 1), align 4, !dbg !293
  %add114 = add i32 %92, %91, !dbg !293
  store i32 %add114, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 1), align 4, !dbg !293
  %93 = load i32, i32* %C, align 4, !dbg !294
  %94 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 2), align 8, !dbg !295
  %add115 = add i32 %94, %93, !dbg !295
  store i32 %add115, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 2), align 8, !dbg !295
  %95 = load i32, i32* %D, align 4, !dbg !296
  %96 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 3), align 4, !dbg !297
  %add116 = add i32 %96, %95, !dbg !297
  store i32 %add116, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 3), align 4, !dbg !297
  %97 = load i32, i32* %E, align 4, !dbg !298
  %98 = load i32, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 4), align 16, !dbg !299
  %add117 = add i32 %98, %97, !dbg !299
  store i32 %add117, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 4), align 16, !dbg !299
  ret void, !dbg !300
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sha_init() #0 !dbg !301 {
entry:
  store i32 1732584193, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 0), align 16, !dbg !302
  store i32 -271733879, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 1), align 4, !dbg !303
  store i32 -1732584194, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 2), align 8, !dbg !304
  store i32 271733878, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 3), align 4, !dbg !305
  store i32 -1009589776, i32* getelementptr inbounds ([5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 4), align 16, !dbg !306
  store i32 0, i32* @sha_info_count_lo, align 4, !dbg !307
  store i32 0, i32* @sha_info_count_hi, align 4, !dbg !308
  ret void, !dbg !309
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sha_update(i8* noundef %buffer, i32 noundef %count) #0 !dbg !310 {
entry:
  %buffer.addr = alloca i8*, align 8
  %count.addr = alloca i32, align 4
  store i8* %buffer, i8** %buffer.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %buffer.addr, metadata !313, metadata !DIExpression()), !dbg !314
  store i32 %count, i32* %count.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %count.addr, metadata !315, metadata !DIExpression()), !dbg !316
  %0 = load i32, i32* @sha_info_count_lo, align 4, !dbg !317
  %1 = load i32, i32* %count.addr, align 4, !dbg !319
  %shl = shl i32 %1, 3, !dbg !320
  %add = add i32 %0, %shl, !dbg !321
  %2 = load i32, i32* @sha_info_count_lo, align 4, !dbg !322
  %cmp = icmp ult i32 %add, %2, !dbg !323
  br i1 %cmp, label %if.then, label %if.end, !dbg !324

if.then:                                          ; preds = %entry
  %3 = load i32, i32* @sha_info_count_hi, align 4, !dbg !325
  %inc = add i32 %3, 1, !dbg !325
  store i32 %inc, i32* @sha_info_count_hi, align 4, !dbg !325
  br label %if.end, !dbg !327

if.end:                                           ; preds = %if.then, %entry
  %4 = load i32, i32* %count.addr, align 4, !dbg !328
  %shl1 = shl i32 %4, 3, !dbg !329
  %5 = load i32, i32* @sha_info_count_lo, align 4, !dbg !330
  %add2 = add i32 %5, %shl1, !dbg !330
  store i32 %add2, i32* @sha_info_count_lo, align 4, !dbg !330
  %6 = load i32, i32* %count.addr, align 4, !dbg !331
  %shr = lshr i32 %6, 29, !dbg !332
  %7 = load i32, i32* @sha_info_count_hi, align 4, !dbg !333
  %add3 = add i32 %7, %shr, !dbg !333
  store i32 %add3, i32* @sha_info_count_hi, align 4, !dbg !333
  br label %sha_update_label4, !dbg !334

sha_update_label4:                                ; preds = %if.end
  call void @llvm.dbg.label(metadata !335), !dbg !336
  br label %while.cond, !dbg !337

while.cond:                                       ; preds = %while.body, %sha_update_label4
  %8 = load i32, i32* %count.addr, align 4, !dbg !338
  %cmp4 = icmp sge i32 %8, 64, !dbg !339
  br i1 %cmp4, label %while.body, label %while.end, !dbg !337

while.body:                                       ; preds = %while.cond
  %9 = load i8*, i8** %buffer.addr, align 8, !dbg !340
  call void @local_memcpy(i32* noundef getelementptr inbounds ([16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 0), i8* noundef %9, i32 noundef 64), !dbg !342
  call void @sha_transform(), !dbg !343
  %10 = load i8*, i8** %buffer.addr, align 8, !dbg !344
  %add.ptr = getelementptr inbounds i8, i8* %10, i64 64, !dbg !344
  store i8* %add.ptr, i8** %buffer.addr, align 8, !dbg !344
  %11 = load i32, i32* %count.addr, align 4, !dbg !345
  %sub = sub nsw i32 %11, 64, !dbg !345
  store i32 %sub, i32* %count.addr, align 4, !dbg !345
  br label %while.cond, !dbg !337, !llvm.loop !346

while.end:                                        ; preds = %while.cond
  %12 = load i8*, i8** %buffer.addr, align 8, !dbg !348
  %13 = load i32, i32* %count.addr, align 4, !dbg !349
  call void @local_memcpy(i32* noundef getelementptr inbounds ([16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 0), i8* noundef %12, i32 noundef %13), !dbg !350
  ret void, !dbg !351
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sha_final() #0 !dbg !352 {
entry:
  %count = alloca i32, align 4
  %lo_bit_count = alloca i32, align 4
  %hi_bit_count = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %count, metadata !353, metadata !DIExpression()), !dbg !354
  call void @llvm.dbg.declare(metadata i32* %lo_bit_count, metadata !355, metadata !DIExpression()), !dbg !356
  %0 = load i32, i32* @sha_info_count_lo, align 4, !dbg !357
  store i32 %0, i32* %lo_bit_count, align 4, !dbg !356
  call void @llvm.dbg.declare(metadata i32* %hi_bit_count, metadata !358, metadata !DIExpression()), !dbg !359
  %1 = load i32, i32* @sha_info_count_hi, align 4, !dbg !360
  store i32 %1, i32* %hi_bit_count, align 4, !dbg !359
  %2 = load i32, i32* %lo_bit_count, align 4, !dbg !361
  %shr = lshr i32 %2, 3, !dbg !362
  %and = and i32 %shr, 63, !dbg !363
  store i32 %and, i32* %count, align 4, !dbg !364
  %3 = load i32, i32* %count, align 4, !dbg !365
  %inc = add nsw i32 %3, 1, !dbg !365
  store i32 %inc, i32* %count, align 4, !dbg !365
  %idxprom = sext i32 %3 to i64, !dbg !366
  %arrayidx = getelementptr inbounds [16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 %idxprom, !dbg !366
  store i32 128, i32* %arrayidx, align 4, !dbg !367
  %4 = load i32, i32* %count, align 4, !dbg !368
  %cmp = icmp sgt i32 %4, 56, !dbg !370
  br i1 %cmp, label %if.then, label %if.else, !dbg !371

if.then:                                          ; preds = %entry
  %5 = load i32, i32* %count, align 4, !dbg !372
  %sub = sub nsw i32 64, %5, !dbg !374
  %6 = load i32, i32* %count, align 4, !dbg !375
  call void @local_memset(i32* noundef getelementptr inbounds ([16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 0), i32 noundef 0, i32 noundef %sub, i32 noundef %6), !dbg !376
  call void @sha_transform(), !dbg !377
  call void @local_memset(i32* noundef getelementptr inbounds ([16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 0), i32 noundef 0, i32 noundef 56, i32 noundef 0), !dbg !378
  br label %if.end, !dbg !379

if.else:                                          ; preds = %entry
  %7 = load i32, i32* %count, align 4, !dbg !380
  %sub1 = sub nsw i32 56, %7, !dbg !382
  %8 = load i32, i32* %count, align 4, !dbg !383
  call void @local_memset(i32* noundef getelementptr inbounds ([16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 0), i32 noundef 0, i32 noundef %sub1, i32 noundef %8), !dbg !384
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %9 = load i32, i32* %hi_bit_count, align 4, !dbg !385
  store i32 %9, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 14), align 8, !dbg !386
  %10 = load i32, i32* %lo_bit_count, align 4, !dbg !387
  store i32 %10, i32* getelementptr inbounds ([16 x i32], [16 x i32]* @sha_info_data, i64 0, i64 15), align 4, !dbg !388
  call void @sha_transform(), !dbg !389
  ret void, !dbg !390
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sha_stream([8192 x i8]* noundef %indata, i32* noundef %in_i, i32* noundef %outdata) #0 !dbg !391 {
entry:
  %indata.addr = alloca [8192 x i8]*, align 8
  %in_i.addr = alloca i32*, align 8
  %outdata.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %p = alloca i8*, align 8
  store [8192 x i8]* %indata, [8192 x i8]** %indata.addr, align 8
  call void @llvm.dbg.declare(metadata [8192 x i8]** %indata.addr, metadata !399, metadata !DIExpression()), !dbg !400
  store i32* %in_i, i32** %in_i.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %in_i.addr, metadata !401, metadata !DIExpression()), !dbg !402
  store i32* %outdata, i32** %outdata.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %outdata.addr, metadata !403, metadata !DIExpression()), !dbg !404
  call void @llvm.dbg.declare(metadata i32* %i, metadata !405, metadata !DIExpression()), !dbg !406
  call void @llvm.dbg.declare(metadata i32* %j, metadata !407, metadata !DIExpression()), !dbg !408
  call void @llvm.dbg.declare(metadata i8** %p, metadata !409, metadata !DIExpression()), !dbg !410
  br label %sha_stream_label1, !dbg !411

sha_stream_label1:                                ; preds = %entry
  call void @llvm.dbg.label(metadata !412), !dbg !413
  store i32 0, i32* %i, align 4, !dbg !414
  br label %for.cond, !dbg !416

for.cond:                                         ; preds = %for.inc10, %sha_stream_label1
  %0 = load i32, i32* %i, align 4, !dbg !417
  %cmp = icmp slt i32 %0, 2, !dbg !419
  br i1 %cmp, label %for.body, label %for.end12, !dbg !420

for.body:                                         ; preds = %for.cond
  br label %sha_stream_label3, !dbg !421

sha_stream_label3:                                ; preds = %for.body
  call void @llvm.dbg.label(metadata !422), !dbg !424
  store i32 0, i32* %j, align 4, !dbg !425
  br label %for.cond1, !dbg !427

for.cond1:                                        ; preds = %for.inc, %sha_stream_label3
  %1 = load i32, i32* %j, align 4, !dbg !428
  %cmp2 = icmp slt i32 %1, 8192, !dbg !430
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !431

for.body3:                                        ; preds = %for.cond1
  %2 = load [8192 x i8]*, [8192 x i8]** %indata.addr, align 8, !dbg !432
  %3 = load i32, i32* %i, align 4, !dbg !434
  %idxprom = sext i32 %3 to i64, !dbg !432
  %arrayidx = getelementptr inbounds [8192 x i8], [8192 x i8]* %2, i64 %idxprom, !dbg !432
  %4 = load i32, i32* %j, align 4, !dbg !435
  %idxprom4 = sext i32 %4 to i64, !dbg !432
  %arrayidx5 = getelementptr inbounds [8192 x i8], [8192 x i8]* %arrayidx, i64 0, i64 %idxprom4, !dbg !432
  %5 = load i8, i8* %arrayidx5, align 1, !dbg !432
  %6 = load i32, i32* %i, align 4, !dbg !436
  %idxprom6 = sext i32 %6 to i64, !dbg !437
  %arrayidx7 = getelementptr inbounds [2 x [8192 x i8]], [2 x [8192 x i8]]* @local_indata, i64 0, i64 %idxprom6, !dbg !437
  %7 = load i32, i32* %j, align 4, !dbg !438
  %idxprom8 = sext i32 %7 to i64, !dbg !437
  %arrayidx9 = getelementptr inbounds [8192 x i8], [8192 x i8]* %arrayidx7, i64 0, i64 %idxprom8, !dbg !437
  store i8 %5, i8* %arrayidx9, align 1, !dbg !439
  br label %for.inc, !dbg !440

for.inc:                                          ; preds = %for.body3
  %8 = load i32, i32* %j, align 4, !dbg !441
  %inc = add nsw i32 %8, 1, !dbg !441
  store i32 %inc, i32* %j, align 4, !dbg !441
  br label %for.cond1, !dbg !442, !llvm.loop !443

for.end:                                          ; preds = %for.cond1
  br label %for.inc10, !dbg !445

for.inc10:                                        ; preds = %for.end
  %9 = load i32, i32* %i, align 4, !dbg !446
  %inc11 = add nsw i32 %9, 1, !dbg !446
  store i32 %inc11, i32* %i, align 4, !dbg !446
  br label %for.cond, !dbg !447, !llvm.loop !448

for.end12:                                        ; preds = %for.cond
  call void @sha_init(), !dbg !450
  br label %sha_stream_label0, !dbg !450

sha_stream_label0:                                ; preds = %for.end12
  call void @llvm.dbg.label(metadata !451), !dbg !452
  store i32 0, i32* %j, align 4, !dbg !453
  br label %for.cond13, !dbg !455

for.cond13:                                       ; preds = %for.inc21, %sha_stream_label0
  %10 = load i32, i32* %j, align 4, !dbg !456
  %cmp14 = icmp slt i32 %10, 2, !dbg !458
  br i1 %cmp14, label %for.body15, label %for.end23, !dbg !459

for.body15:                                       ; preds = %for.cond13
  %11 = load i32*, i32** %in_i.addr, align 8, !dbg !460
  %12 = load i32, i32* %j, align 4, !dbg !462
  %idxprom16 = sext i32 %12 to i64, !dbg !460
  %arrayidx17 = getelementptr inbounds i32, i32* %11, i64 %idxprom16, !dbg !460
  %13 = load i32, i32* %arrayidx17, align 4, !dbg !460
  store i32 %13, i32* %i, align 4, !dbg !463
  %14 = load i32, i32* %j, align 4, !dbg !464
  %idxprom18 = sext i32 %14 to i64, !dbg !465
  %arrayidx19 = getelementptr inbounds [2 x [8192 x i8]], [2 x [8192 x i8]]* @local_indata, i64 0, i64 %idxprom18, !dbg !465
  %arrayidx20 = getelementptr inbounds [8192 x i8], [8192 x i8]* %arrayidx19, i64 0, i64 0, !dbg !465
  store i8* %arrayidx20, i8** %p, align 8, !dbg !466
  %15 = load i8*, i8** %p, align 8, !dbg !467
  %16 = load i32, i32* %i, align 4, !dbg !468
  call void @sha_update(i8* noundef %15, i32 noundef %16), !dbg !469
  br label %for.inc21, !dbg !470

for.inc21:                                        ; preds = %for.body15
  %17 = load i32, i32* %j, align 4, !dbg !471
  %inc22 = add nsw i32 %17, 1, !dbg !471
  store i32 %inc22, i32* %j, align 4, !dbg !471
  br label %for.cond13, !dbg !472, !llvm.loop !473

for.end23:                                        ; preds = %for.cond13
  call void @sha_final(), !dbg !475
  br label %sha_stream_label2, !dbg !475

sha_stream_label2:                                ; preds = %for.end23
  call void @llvm.dbg.label(metadata !476), !dbg !477
  store i32 0, i32* %i, align 4, !dbg !478
  br label %for.cond24, !dbg !480

for.cond24:                                       ; preds = %for.inc31, %sha_stream_label2
  %18 = load i32, i32* %i, align 4, !dbg !481
  %cmp25 = icmp slt i32 %18, 5, !dbg !483
  br i1 %cmp25, label %for.body26, label %for.end33, !dbg !484

for.body26:                                       ; preds = %for.cond24
  %19 = load i32, i32* %i, align 4, !dbg !485
  %idxprom27 = sext i32 %19 to i64, !dbg !487
  %arrayidx28 = getelementptr inbounds [5 x i32], [5 x i32]* @sha_info_digest, i64 0, i64 %idxprom27, !dbg !487
  %20 = load i32, i32* %arrayidx28, align 4, !dbg !487
  %21 = load i32*, i32** %outdata.addr, align 8, !dbg !488
  %22 = load i32, i32* %i, align 4, !dbg !489
  %idxprom29 = sext i32 %22 to i64, !dbg !488
  %arrayidx30 = getelementptr inbounds i32, i32* %21, i64 %idxprom29, !dbg !488
  store i32 %20, i32* %arrayidx30, align 4, !dbg !490
  br label %for.inc31, !dbg !491

for.inc31:                                        ; preds = %for.body26
  %23 = load i32, i32* %i, align 4, !dbg !492
  %inc32 = add nsw i32 %23, 1, !dbg !492
  store i32 %inc32, i32* %i, align 4, !dbg !492
  br label %for.cond24, !dbg !493, !llvm.loop !494

for.end33:                                        ; preds = %for.cond24
  ret void, !dbg !496
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!29, !30, !31, !32, !33, !34, !35}
!llvm.ident = !{!36}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sha_info_data", scope: !2, file: !3, line: 49, type: !26, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !10, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "data/benchmarks/real/sha/sha.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "aa013eff45eb35de98f2002212cf0454")
!4 = !{!5, !7, !6, !9}
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!6 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !{!11, !13, !0, !15, !20}
!11 = !DIGlobalVariableExpression(var: !12, expr: !DIExpression())
!12 = distinct !DIGlobalVariable(name: "sha_info_count_lo", scope: !2, file: !3, line: 48, type: !6, isLocal: false, isDefinition: true)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(name: "sha_info_count_hi", scope: !2, file: !3, line: 48, type: !6, isLocal: false, isDefinition: true)
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "sha_info_digest", scope: !2, file: !3, line: 50, type: !17, isLocal: false, isDefinition: true)
!17 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 160, elements: !18)
!18 = !{!19}
!19 = !DISubrange(count: 5)
!20 = !DIGlobalVariableExpression(var: !21, expr: !DIExpression())
!21 = distinct !DIGlobalVariable(name: "local_indata", scope: !2, file: !3, line: 52, type: !22, isLocal: false, isDefinition: true)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !8, size: 131072, elements: !23)
!23 = !{!24, !25}
!24 = !DISubrange(count: 2)
!25 = !DISubrange(count: 8192)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 512, elements: !27)
!27 = !{!28}
!28 = !DISubrange(count: 16)
!29 = !{i32 7, !"Dwarf Version", i32 5}
!30 = !{i32 2, !"Debug Info Version", i32 3}
!31 = !{i32 1, !"wchar_size", i32 4}
!32 = !{i32 7, !"PIC Level", i32 2}
!33 = !{i32 7, !"PIE Level", i32 2}
!34 = !{i32 7, !"uwtable", i32 1}
!35 = !{i32 7, !"frame-pointer", i32 2}
!36 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!37 = distinct !DISubprogram(name: "local_memset", scope: !3, file: !3, line: 55, type: !38, scopeLine: 55, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !40)
!38 = !DISubroutineType(types: !39)
!39 = !{null, !5, !9, !9, !9}
!40 = !{}
!41 = !DILocalVariable(name: "s", arg: 1, scope: !37, file: !3, line: 55, type: !5)
!42 = !DILocation(line: 55, column: 33, scope: !37)
!43 = !DILocalVariable(name: "c", arg: 2, scope: !37, file: !3, line: 55, type: !9)
!44 = !DILocation(line: 55, column: 40, scope: !37)
!45 = !DILocalVariable(name: "n", arg: 3, scope: !37, file: !3, line: 55, type: !9)
!46 = !DILocation(line: 55, column: 47, scope: !37)
!47 = !DILocalVariable(name: "e", arg: 4, scope: !37, file: !3, line: 55, type: !9)
!48 = !DILocation(line: 55, column: 54, scope: !37)
!49 = !DILocalVariable(name: "uc", scope: !37, file: !3, line: 56, type: !6)
!50 = !DILocation(line: 56, column: 18, scope: !37)
!51 = !DILocation(line: 56, column: 23, scope: !37)
!52 = !DILocalVariable(name: "p", scope: !37, file: !3, line: 57, type: !5)
!53 = !DILocation(line: 57, column: 19, scope: !37)
!54 = !DILocation(line: 57, column: 39, scope: !37)
!55 = !DILocalVariable(name: "m", scope: !37, file: !3, line: 58, type: !9)
!56 = !DILocation(line: 58, column: 9, scope: !37)
!57 = !DILocation(line: 58, column: 13, scope: !37)
!58 = !DILocation(line: 58, column: 15, scope: !37)
!59 = !DILocation(line: 58, column: 5, scope: !37)
!60 = !DILabel(scope: !37, name: "local_memset_label0", file: !3, line: 60)
!61 = !DILocation(line: 60, column: 5, scope: !37)
!62 = !DILocation(line: 61, column: 5, scope: !37)
!63 = !DILocation(line: 61, column: 13, scope: !37)
!64 = !DILocation(line: 61, column: 16, scope: !37)
!65 = !DILocation(line: 62, column: 10, scope: !66)
!66 = distinct !DILexicalBlock(scope: !37, file: !3, line: 61, column: 21)
!67 = distinct !{!67, !62, !68, !69}
!68 = !DILocation(line: 63, column: 5, scope: !37)
!69 = !{!"llvm.loop.mustprogress"}
!70 = !DILabel(scope: !37, name: "local_memset_label1", file: !3, line: 64)
!71 = !DILocation(line: 64, column: 5, scope: !37)
!72 = !DILocation(line: 65, column: 5, scope: !37)
!73 = !DILocation(line: 65, column: 13, scope: !37)
!74 = !DILocation(line: 65, column: 16, scope: !37)
!75 = !DILocation(line: 67, column: 16, scope: !76)
!76 = distinct !DILexicalBlock(scope: !37, file: !3, line: 65, column: 21)
!77 = !DILocation(line: 67, column: 11, scope: !76)
!78 = !DILocation(line: 67, column: 14, scope: !76)
!79 = distinct !{!79, !72, !80, !69}
!80 = !DILocation(line: 68, column: 5, scope: !37)
!81 = !DILocation(line: 69, column: 1, scope: !37)
!82 = distinct !DISubprogram(name: "local_memcpy", scope: !3, file: !3, line: 72, type: !83, scopeLine: 72, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !40)
!83 = !DISubroutineType(types: !84)
!84 = !{null, !5, !85, !9}
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !86, size: 64)
!86 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !8)
!87 = !DILocalVariable(name: "s1", arg: 1, scope: !82, file: !3, line: 72, type: !5)
!88 = !DILocation(line: 72, column: 33, scope: !82)
!89 = !DILocalVariable(name: "s2", arg: 2, scope: !82, file: !3, line: 72, type: !85)
!90 = !DILocation(line: 72, column: 58, scope: !82)
!91 = !DILocalVariable(name: "n", arg: 3, scope: !82, file: !3, line: 72, type: !9)
!92 = !DILocation(line: 72, column: 66, scope: !82)
!93 = !DILocalVariable(name: "p1", scope: !82, file: !3, line: 73, type: !5)
!94 = !DILocation(line: 73, column: 19, scope: !82)
!95 = !DILocation(line: 73, column: 40, scope: !82)
!96 = !DILocalVariable(name: "p2", scope: !82, file: !3, line: 74, type: !7)
!97 = !DILocation(line: 74, column: 20, scope: !82)
!98 = !DILocation(line: 74, column: 42, scope: !82)
!99 = !DILocalVariable(name: "tmp", scope: !82, file: !3, line: 75, type: !6)
!100 = !DILocation(line: 75, column: 18, scope: !82)
!101 = !DILocalVariable(name: "m", scope: !82, file: !3, line: 76, type: !9)
!102 = !DILocation(line: 76, column: 9, scope: !82)
!103 = !DILocation(line: 76, column: 13, scope: !82)
!104 = !DILocation(line: 76, column: 15, scope: !82)
!105 = !DILocation(line: 76, column: 5, scope: !82)
!106 = !DILabel(scope: !82, name: "local_memcpy_label3", file: !3, line: 78)
!107 = !DILocation(line: 78, column: 5, scope: !82)
!108 = !DILocation(line: 79, column: 5, scope: !82)
!109 = !DILocation(line: 79, column: 13, scope: !82)
!110 = !DILocation(line: 79, column: 16, scope: !82)
!111 = !DILocation(line: 81, column: 13, scope: !112)
!112 = distinct !DILexicalBlock(scope: !82, file: !3, line: 79, column: 21)
!113 = !DILocation(line: 82, column: 26, scope: !112)
!114 = !DILocation(line: 82, column: 23, scope: !112)
!115 = !DILocation(line: 82, column: 21, scope: !112)
!116 = !DILocation(line: 82, column: 13, scope: !112)
!117 = !DILocation(line: 83, column: 27, scope: !112)
!118 = !DILocation(line: 83, column: 24, scope: !112)
!119 = !DILocation(line: 83, column: 22, scope: !112)
!120 = !DILocation(line: 83, column: 31, scope: !112)
!121 = !DILocation(line: 83, column: 13, scope: !112)
!122 = !DILocation(line: 84, column: 27, scope: !112)
!123 = !DILocation(line: 84, column: 24, scope: !112)
!124 = !DILocation(line: 84, column: 22, scope: !112)
!125 = !DILocation(line: 84, column: 31, scope: !112)
!126 = !DILocation(line: 84, column: 13, scope: !112)
!127 = !DILocation(line: 85, column: 27, scope: !112)
!128 = !DILocation(line: 85, column: 24, scope: !112)
!129 = !DILocation(line: 85, column: 22, scope: !112)
!130 = !DILocation(line: 85, column: 31, scope: !112)
!131 = !DILocation(line: 85, column: 13, scope: !112)
!132 = !DILocation(line: 86, column: 15, scope: !112)
!133 = !DILocation(line: 86, column: 10, scope: !112)
!134 = !DILocation(line: 86, column: 13, scope: !112)
!135 = !DILocation(line: 87, column: 11, scope: !112)
!136 = distinct !{!136, !108, !137, !69}
!137 = !DILocation(line: 88, column: 5, scope: !82)
!138 = !DILocation(line: 89, column: 1, scope: !82)
!139 = distinct !DISubprogram(name: "sha_transform", scope: !3, file: !3, line: 92, type: !140, scopeLine: 92, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !40)
!140 = !DISubroutineType(types: !141)
!141 = !{null}
!142 = !DILocalVariable(name: "i", scope: !139, file: !3, line: 93, type: !9)
!143 = !DILocation(line: 93, column: 9, scope: !139)
!144 = !DILocalVariable(name: "temp", scope: !139, file: !3, line: 94, type: !6)
!145 = !DILocation(line: 94, column: 18, scope: !139)
!146 = !DILocalVariable(name: "A", scope: !139, file: !3, line: 94, type: !6)
!147 = !DILocation(line: 94, column: 24, scope: !139)
!148 = !DILocalVariable(name: "B", scope: !139, file: !3, line: 94, type: !6)
!149 = !DILocation(line: 94, column: 27, scope: !139)
!150 = !DILocalVariable(name: "C", scope: !139, file: !3, line: 94, type: !6)
!151 = !DILocation(line: 94, column: 30, scope: !139)
!152 = !DILocalVariable(name: "D", scope: !139, file: !3, line: 94, type: !6)
!153 = !DILocation(line: 94, column: 33, scope: !139)
!154 = !DILocalVariable(name: "E", scope: !139, file: !3, line: 94, type: !6)
!155 = !DILocation(line: 94, column: 36, scope: !139)
!156 = !DILocalVariable(name: "W", scope: !139, file: !3, line: 94, type: !157)
!157 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 2560, elements: !158)
!158 = !{!159}
!159 = !DISubrange(count: 80)
!160 = !DILocation(line: 94, column: 39, scope: !139)
!161 = !DILocation(line: 94, column: 5, scope: !139)
!162 = !DILabel(scope: !139, name: "sha_transform_label1", file: !3, line: 97)
!163 = !DILocation(line: 97, column: 5, scope: !139)
!164 = !DILocation(line: 98, column: 12, scope: !165)
!165 = distinct !DILexicalBlock(scope: !139, file: !3, line: 98, column: 5)
!166 = !DILocation(line: 98, column: 10, scope: !165)
!167 = !DILocation(line: 98, column: 17, scope: !168)
!168 = distinct !DILexicalBlock(scope: !165, file: !3, line: 98, column: 5)
!169 = !DILocation(line: 98, column: 19, scope: !168)
!170 = !DILocation(line: 98, column: 5, scope: !165)
!171 = !DILocation(line: 100, column: 30, scope: !172)
!172 = distinct !DILexicalBlock(scope: !168, file: !3, line: 98, column: 30)
!173 = !DILocation(line: 100, column: 16, scope: !172)
!174 = !DILocation(line: 100, column: 11, scope: !172)
!175 = !DILocation(line: 100, column: 9, scope: !172)
!176 = !DILocation(line: 100, column: 14, scope: !172)
!177 = !DILocation(line: 101, column: 5, scope: !172)
!178 = !DILocation(line: 98, column: 25, scope: !168)
!179 = !DILocation(line: 98, column: 5, scope: !168)
!180 = distinct !{!180, !170, !181, !69}
!181 = !DILocation(line: 101, column: 5, scope: !165)
!182 = !DILabel(scope: !139, name: "sha_transform_label2", file: !3, line: 103)
!183 = !DILocation(line: 103, column: 5, scope: !139)
!184 = !DILocation(line: 104, column: 12, scope: !185)
!185 = distinct !DILexicalBlock(scope: !139, file: !3, line: 104, column: 5)
!186 = !DILocation(line: 104, column: 10, scope: !185)
!187 = !DILocation(line: 104, column: 18, scope: !188)
!188 = distinct !DILexicalBlock(scope: !185, file: !3, line: 104, column: 5)
!189 = !DILocation(line: 104, column: 20, scope: !188)
!190 = !DILocation(line: 104, column: 5, scope: !185)
!191 = !DILocation(line: 106, column: 18, scope: !192)
!192 = distinct !DILexicalBlock(scope: !188, file: !3, line: 104, column: 31)
!193 = !DILocation(line: 106, column: 20, scope: !192)
!194 = !DILocation(line: 106, column: 16, scope: !192)
!195 = !DILocation(line: 106, column: 29, scope: !192)
!196 = !DILocation(line: 106, column: 31, scope: !192)
!197 = !DILocation(line: 106, column: 27, scope: !192)
!198 = !DILocation(line: 106, column: 25, scope: !192)
!199 = !DILocation(line: 106, column: 40, scope: !192)
!200 = !DILocation(line: 106, column: 42, scope: !192)
!201 = !DILocation(line: 106, column: 38, scope: !192)
!202 = !DILocation(line: 106, column: 36, scope: !192)
!203 = !DILocation(line: 106, column: 52, scope: !192)
!204 = !DILocation(line: 106, column: 54, scope: !192)
!205 = !DILocation(line: 106, column: 50, scope: !192)
!206 = !DILocation(line: 106, column: 48, scope: !192)
!207 = !DILocation(line: 106, column: 11, scope: !192)
!208 = !DILocation(line: 106, column: 9, scope: !192)
!209 = !DILocation(line: 106, column: 14, scope: !192)
!210 = !DILocation(line: 107, column: 5, scope: !192)
!211 = !DILocation(line: 104, column: 26, scope: !188)
!212 = !DILocation(line: 104, column: 5, scope: !188)
!213 = distinct !{!213, !190, !214, !69}
!214 = !DILocation(line: 107, column: 5, scope: !185)
!215 = !DILocation(line: 110, column: 9, scope: !139)
!216 = !DILocation(line: 110, column: 7, scope: !139)
!217 = !DILocation(line: 111, column: 9, scope: !139)
!218 = !DILocation(line: 111, column: 7, scope: !139)
!219 = !DILocation(line: 112, column: 9, scope: !139)
!220 = !DILocation(line: 112, column: 7, scope: !139)
!221 = !DILocation(line: 113, column: 9, scope: !139)
!222 = !DILocation(line: 113, column: 7, scope: !139)
!223 = !DILocation(line: 114, column: 9, scope: !139)
!224 = !DILocation(line: 114, column: 7, scope: !139)
!225 = !DILocation(line: 114, column: 5, scope: !139)
!226 = !DILabel(scope: !139, name: "sha_transform_label3", file: !3, line: 117)
!227 = !DILocation(line: 117, column: 5, scope: !139)
!228 = !DILocation(line: 117, column: 34, scope: !229)
!229 = distinct !DILexicalBlock(scope: !139, file: !3, line: 117, column: 27)
!230 = !DILocation(line: 117, column: 32, scope: !229)
!231 = !DILocation(line: 117, column: 39, scope: !232)
!232 = distinct !DILexicalBlock(scope: !229, file: !3, line: 117, column: 27)
!233 = !DILocation(line: 117, column: 41, scope: !232)
!234 = !DILocation(line: 117, column: 27, scope: !229)
!235 = !DILocation(line: 119, column: 9, scope: !236)
!236 = distinct !DILexicalBlock(scope: !232, file: !3, line: 117, column: 52)
!237 = !DILocation(line: 120, column: 5, scope: !236)
!238 = !DILocation(line: 117, column: 47, scope: !232)
!239 = !DILocation(line: 117, column: 27, scope: !232)
!240 = distinct !{!240, !234, !241, !69}
!241 = !DILocation(line: 120, column: 5, scope: !229)
!242 = !DILabel(scope: !139, name: "sha_transform_label4", file: !3, line: 121)
!243 = !DILocation(line: 121, column: 5, scope: !139)
!244 = !DILocation(line: 121, column: 34, scope: !245)
!245 = distinct !DILexicalBlock(scope: !139, file: !3, line: 121, column: 27)
!246 = !DILocation(line: 121, column: 32, scope: !245)
!247 = !DILocation(line: 121, column: 40, scope: !248)
!248 = distinct !DILexicalBlock(scope: !245, file: !3, line: 121, column: 27)
!249 = !DILocation(line: 121, column: 42, scope: !248)
!250 = !DILocation(line: 121, column: 27, scope: !245)
!251 = !DILocation(line: 123, column: 9, scope: !252)
!252 = distinct !DILexicalBlock(scope: !248, file: !3, line: 121, column: 53)
!253 = !DILocation(line: 124, column: 5, scope: !252)
!254 = !DILocation(line: 121, column: 48, scope: !248)
!255 = !DILocation(line: 121, column: 27, scope: !248)
!256 = distinct !{!256, !250, !257, !69}
!257 = !DILocation(line: 124, column: 5, scope: !245)
!258 = !DILabel(scope: !139, name: "sha_transform_label5", file: !3, line: 125)
!259 = !DILocation(line: 125, column: 5, scope: !139)
!260 = !DILocation(line: 125, column: 34, scope: !261)
!261 = distinct !DILexicalBlock(scope: !139, file: !3, line: 125, column: 27)
!262 = !DILocation(line: 125, column: 32, scope: !261)
!263 = !DILocation(line: 125, column: 40, scope: !264)
!264 = distinct !DILexicalBlock(scope: !261, file: !3, line: 125, column: 27)
!265 = !DILocation(line: 125, column: 42, scope: !264)
!266 = !DILocation(line: 125, column: 27, scope: !261)
!267 = !DILocation(line: 127, column: 9, scope: !268)
!268 = distinct !DILexicalBlock(scope: !264, file: !3, line: 125, column: 53)
!269 = !DILocation(line: 128, column: 5, scope: !268)
!270 = !DILocation(line: 125, column: 48, scope: !264)
!271 = !DILocation(line: 125, column: 27, scope: !264)
!272 = distinct !{!272, !266, !273, !69}
!273 = !DILocation(line: 128, column: 5, scope: !261)
!274 = !DILabel(scope: !139, name: "sha_transform_label6", file: !3, line: 129)
!275 = !DILocation(line: 129, column: 5, scope: !139)
!276 = !DILocation(line: 129, column: 34, scope: !277)
!277 = distinct !DILexicalBlock(scope: !139, file: !3, line: 129, column: 27)
!278 = !DILocation(line: 129, column: 32, scope: !277)
!279 = !DILocation(line: 129, column: 40, scope: !280)
!280 = distinct !DILexicalBlock(scope: !277, file: !3, line: 129, column: 27)
!281 = !DILocation(line: 129, column: 42, scope: !280)
!282 = !DILocation(line: 129, column: 27, scope: !277)
!283 = !DILocation(line: 131, column: 9, scope: !284)
!284 = distinct !DILexicalBlock(scope: !280, file: !3, line: 129, column: 53)
!285 = !DILocation(line: 132, column: 5, scope: !284)
!286 = !DILocation(line: 129, column: 48, scope: !280)
!287 = !DILocation(line: 129, column: 27, scope: !280)
!288 = distinct !{!288, !282, !289, !69}
!289 = !DILocation(line: 132, column: 5, scope: !277)
!290 = !DILocation(line: 135, column: 27, scope: !139)
!291 = !DILocation(line: 135, column: 24, scope: !139)
!292 = !DILocation(line: 136, column: 27, scope: !139)
!293 = !DILocation(line: 136, column: 24, scope: !139)
!294 = !DILocation(line: 137, column: 27, scope: !139)
!295 = !DILocation(line: 137, column: 24, scope: !139)
!296 = !DILocation(line: 138, column: 27, scope: !139)
!297 = !DILocation(line: 138, column: 24, scope: !139)
!298 = !DILocation(line: 139, column: 27, scope: !139)
!299 = !DILocation(line: 139, column: 24, scope: !139)
!300 = !DILocation(line: 140, column: 1, scope: !139)
!301 = distinct !DISubprogram(name: "sha_init", scope: !3, file: !3, line: 143, type: !140, scopeLine: 143, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !40)
!302 = !DILocation(line: 144, column: 24, scope: !301)
!303 = !DILocation(line: 145, column: 24, scope: !301)
!304 = !DILocation(line: 146, column: 24, scope: !301)
!305 = !DILocation(line: 147, column: 24, scope: !301)
!306 = !DILocation(line: 148, column: 24, scope: !301)
!307 = !DILocation(line: 149, column: 23, scope: !301)
!308 = !DILocation(line: 150, column: 23, scope: !301)
!309 = !DILocation(line: 151, column: 1, scope: !301)
!310 = distinct !DISubprogram(name: "sha_update", scope: !3, file: !3, line: 154, type: !311, scopeLine: 154, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !40)
!311 = !DISubroutineType(types: !312)
!312 = !{null, !85, !9}
!313 = !DILocalVariable(name: "buffer", arg: 1, scope: !310, file: !3, line: 154, type: !85)
!314 = !DILocation(line: 154, column: 38, scope: !310)
!315 = !DILocalVariable(name: "count", arg: 2, scope: !310, file: !3, line: 154, type: !9)
!316 = !DILocation(line: 154, column: 50, scope: !310)
!317 = !DILocation(line: 155, column: 10, scope: !318)
!318 = distinct !DILexicalBlock(scope: !310, file: !3, line: 155, column: 9)
!319 = !DILocation(line: 155, column: 45, scope: !318)
!320 = !DILocation(line: 155, column: 51, scope: !318)
!321 = !DILocation(line: 155, column: 28, scope: !318)
!322 = !DILocation(line: 155, column: 60, scope: !318)
!323 = !DILocation(line: 155, column: 58, scope: !318)
!324 = !DILocation(line: 155, column: 9, scope: !310)
!325 = !DILocation(line: 156, column: 9, scope: !326)
!326 = distinct !DILexicalBlock(scope: !318, file: !3, line: 155, column: 79)
!327 = !DILocation(line: 157, column: 5, scope: !326)
!328 = !DILocation(line: 158, column: 40, scope: !310)
!329 = !DILocation(line: 158, column: 46, scope: !310)
!330 = !DILocation(line: 158, column: 23, scope: !310)
!331 = !DILocation(line: 159, column: 40, scope: !310)
!332 = !DILocation(line: 159, column: 46, scope: !310)
!333 = !DILocation(line: 159, column: 23, scope: !310)
!334 = !DILocation(line: 159, column: 5, scope: !310)
!335 = !DILabel(scope: !310, name: "sha_update_label4", file: !3, line: 161)
!336 = !DILocation(line: 161, column: 5, scope: !310)
!337 = !DILocation(line: 162, column: 5, scope: !310)
!338 = !DILocation(line: 162, column: 12, scope: !310)
!339 = !DILocation(line: 162, column: 18, scope: !310)
!340 = !DILocation(line: 164, column: 37, scope: !341)
!341 = distinct !DILexicalBlock(scope: !310, file: !3, line: 162, column: 38)
!342 = !DILocation(line: 164, column: 9, scope: !341)
!343 = !DILocation(line: 165, column: 9, scope: !341)
!344 = !DILocation(line: 166, column: 16, scope: !341)
!345 = !DILocation(line: 167, column: 15, scope: !341)
!346 = distinct !{!346, !337, !347, !69}
!347 = !DILocation(line: 168, column: 5, scope: !310)
!348 = !DILocation(line: 169, column: 33, scope: !310)
!349 = !DILocation(line: 169, column: 41, scope: !310)
!350 = !DILocation(line: 169, column: 5, scope: !310)
!351 = !DILocation(line: 170, column: 1, scope: !310)
!352 = distinct !DISubprogram(name: "sha_final", scope: !3, file: !3, line: 173, type: !140, scopeLine: 173, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !40)
!353 = !DILocalVariable(name: "count", scope: !352, file: !3, line: 174, type: !9)
!354 = !DILocation(line: 174, column: 9, scope: !352)
!355 = !DILocalVariable(name: "lo_bit_count", scope: !352, file: !3, line: 175, type: !6)
!356 = !DILocation(line: 175, column: 18, scope: !352)
!357 = !DILocation(line: 175, column: 33, scope: !352)
!358 = !DILocalVariable(name: "hi_bit_count", scope: !352, file: !3, line: 176, type: !6)
!359 = !DILocation(line: 176, column: 18, scope: !352)
!360 = !DILocation(line: 176, column: 33, scope: !352)
!361 = !DILocation(line: 178, column: 20, scope: !352)
!362 = !DILocation(line: 178, column: 33, scope: !352)
!363 = !DILocation(line: 178, column: 39, scope: !352)
!364 = !DILocation(line: 178, column: 11, scope: !352)
!365 = !DILocation(line: 179, column: 24, scope: !352)
!366 = !DILocation(line: 179, column: 5, scope: !352)
!367 = !DILocation(line: 179, column: 28, scope: !352)
!368 = !DILocation(line: 181, column: 9, scope: !369)
!369 = distinct !DILexicalBlock(scope: !352, file: !3, line: 181, column: 9)
!370 = !DILocation(line: 181, column: 15, scope: !369)
!371 = !DILocation(line: 181, column: 9, scope: !352)
!372 = !DILocation(line: 182, column: 45, scope: !373)
!373 = distinct !DILexicalBlock(scope: !369, file: !3, line: 181, column: 21)
!374 = !DILocation(line: 182, column: 43, scope: !373)
!375 = !DILocation(line: 182, column: 52, scope: !373)
!376 = !DILocation(line: 182, column: 9, scope: !373)
!377 = !DILocation(line: 183, column: 9, scope: !373)
!378 = !DILocation(line: 184, column: 9, scope: !373)
!379 = !DILocation(line: 185, column: 5, scope: !373)
!380 = !DILocation(line: 186, column: 45, scope: !381)
!381 = distinct !DILexicalBlock(scope: !369, file: !3, line: 185, column: 12)
!382 = !DILocation(line: 186, column: 43, scope: !381)
!383 = !DILocation(line: 186, column: 52, scope: !381)
!384 = !DILocation(line: 186, column: 9, scope: !381)
!385 = !DILocation(line: 189, column: 25, scope: !352)
!386 = !DILocation(line: 189, column: 23, scope: !352)
!387 = !DILocation(line: 190, column: 25, scope: !352)
!388 = !DILocation(line: 190, column: 23, scope: !352)
!389 = !DILocation(line: 191, column: 5, scope: !352)
!390 = !DILocation(line: 192, column: 1, scope: !352)
!391 = distinct !DISubprogram(name: "sha_stream", scope: !3, file: !3, line: 196, type: !392, scopeLine: 200, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !40)
!392 = !DISubroutineType(types: !393)
!393 = !{null, !394, !397, !5}
!394 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !395, size: 64)
!395 = !DICompositeType(tag: DW_TAG_array_type, baseType: !86, size: 65536, elements: !396)
!396 = !{!25}
!397 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !398, size: 64)
!398 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !9)
!399 = !DILocalVariable(name: "indata", arg: 1, scope: !391, file: !3, line: 197, type: !394)
!400 = !DILocation(line: 197, column: 25, scope: !391)
!401 = !DILocalVariable(name: "in_i", arg: 2, scope: !391, file: !3, line: 198, type: !397)
!402 = !DILocation(line: 198, column: 15, scope: !391)
!403 = !DILocalVariable(name: "outdata", arg: 3, scope: !391, file: !3, line: 199, type: !5)
!404 = !DILocation(line: 199, column: 18, scope: !391)
!405 = !DILocalVariable(name: "i", scope: !391, file: !3, line: 201, type: !9)
!406 = !DILocation(line: 201, column: 9, scope: !391)
!407 = !DILocalVariable(name: "j", scope: !391, file: !3, line: 201, type: !9)
!408 = !DILocation(line: 201, column: 12, scope: !391)
!409 = !DILocalVariable(name: "p", scope: !391, file: !3, line: 202, type: !85)
!410 = !DILocation(line: 202, column: 26, scope: !391)
!411 = !DILocation(line: 202, column: 5, scope: !391)
!412 = !DILabel(scope: !391, name: "sha_stream_label1", file: !3, line: 204)
!413 = !DILocation(line: 204, column: 5, scope: !391)
!414 = !DILocation(line: 205, column: 12, scope: !415)
!415 = distinct !DILexicalBlock(scope: !391, file: !3, line: 205, column: 5)
!416 = !DILocation(line: 205, column: 10, scope: !415)
!417 = !DILocation(line: 205, column: 17, scope: !418)
!418 = distinct !DILexicalBlock(scope: !415, file: !3, line: 205, column: 5)
!419 = !DILocation(line: 205, column: 19, scope: !418)
!420 = !DILocation(line: 205, column: 5, scope: !415)
!421 = !DILocation(line: 205, column: 38, scope: !418)
!422 = !DILabel(scope: !423, name: "sha_stream_label3", file: !3, line: 207)
!423 = distinct !DILexicalBlock(scope: !418, file: !3, line: 205, column: 38)
!424 = !DILocation(line: 207, column: 9, scope: !423)
!425 = !DILocation(line: 208, column: 16, scope: !426)
!426 = distinct !DILexicalBlock(scope: !423, file: !3, line: 208, column: 9)
!427 = !DILocation(line: 208, column: 14, scope: !426)
!428 = !DILocation(line: 208, column: 21, scope: !429)
!429 = distinct !DILexicalBlock(scope: !426, file: !3, line: 208, column: 9)
!430 = !DILocation(line: 208, column: 23, scope: !429)
!431 = !DILocation(line: 208, column: 9, scope: !426)
!432 = !DILocation(line: 210, column: 34, scope: !433)
!433 = distinct !DILexicalBlock(scope: !429, file: !3, line: 208, column: 42)
!434 = !DILocation(line: 210, column: 41, scope: !433)
!435 = !DILocation(line: 210, column: 44, scope: !433)
!436 = !DILocation(line: 210, column: 26, scope: !433)
!437 = !DILocation(line: 210, column: 13, scope: !433)
!438 = !DILocation(line: 210, column: 29, scope: !433)
!439 = !DILocation(line: 210, column: 32, scope: !433)
!440 = !DILocation(line: 211, column: 9, scope: !433)
!441 = !DILocation(line: 208, column: 38, scope: !429)
!442 = !DILocation(line: 208, column: 9, scope: !429)
!443 = distinct !{!443, !431, !444, !69}
!444 = !DILocation(line: 211, column: 9, scope: !426)
!445 = !DILocation(line: 212, column: 5, scope: !423)
!446 = !DILocation(line: 205, column: 34, scope: !418)
!447 = !DILocation(line: 205, column: 5, scope: !418)
!448 = distinct !{!448, !420, !449, !69}
!449 = !DILocation(line: 212, column: 5, scope: !415)
!450 = !DILocation(line: 214, column: 5, scope: !391)
!451 = !DILabel(scope: !391, name: "sha_stream_label0", file: !3, line: 216)
!452 = !DILocation(line: 216, column: 5, scope: !391)
!453 = !DILocation(line: 217, column: 12, scope: !454)
!454 = distinct !DILexicalBlock(scope: !391, file: !3, line: 217, column: 5)
!455 = !DILocation(line: 217, column: 10, scope: !454)
!456 = !DILocation(line: 217, column: 17, scope: !457)
!457 = distinct !DILexicalBlock(scope: !454, file: !3, line: 217, column: 5)
!458 = !DILocation(line: 217, column: 19, scope: !457)
!459 = !DILocation(line: 217, column: 5, scope: !454)
!460 = !DILocation(line: 219, column: 13, scope: !461)
!461 = distinct !DILexicalBlock(scope: !457, file: !3, line: 217, column: 38)
!462 = !DILocation(line: 219, column: 18, scope: !461)
!463 = !DILocation(line: 219, column: 11, scope: !461)
!464 = !DILocation(line: 220, column: 27, scope: !461)
!465 = !DILocation(line: 220, column: 14, scope: !461)
!466 = !DILocation(line: 220, column: 11, scope: !461)
!467 = !DILocation(line: 221, column: 20, scope: !461)
!468 = !DILocation(line: 221, column: 23, scope: !461)
!469 = !DILocation(line: 221, column: 9, scope: !461)
!470 = !DILocation(line: 222, column: 5, scope: !461)
!471 = !DILocation(line: 217, column: 34, scope: !457)
!472 = !DILocation(line: 217, column: 5, scope: !457)
!473 = distinct !{!473, !459, !474, !69}
!474 = !DILocation(line: 222, column: 5, scope: !454)
!475 = !DILocation(line: 224, column: 5, scope: !391)
!476 = !DILabel(scope: !391, name: "sha_stream_label2", file: !3, line: 225)
!477 = !DILocation(line: 225, column: 5, scope: !391)
!478 = !DILocation(line: 226, column: 12, scope: !479)
!479 = distinct !DILexicalBlock(scope: !391, file: !3, line: 226, column: 5)
!480 = !DILocation(line: 226, column: 10, scope: !479)
!481 = !DILocation(line: 226, column: 17, scope: !482)
!482 = distinct !DILexicalBlock(scope: !479, file: !3, line: 226, column: 5)
!483 = !DILocation(line: 226, column: 19, scope: !482)
!484 = !DILocation(line: 226, column: 5, scope: !479)
!485 = !DILocation(line: 228, column: 38, scope: !486)
!486 = distinct !DILexicalBlock(scope: !482, file: !3, line: 226, column: 39)
!487 = !DILocation(line: 228, column: 22, scope: !486)
!488 = !DILocation(line: 228, column: 9, scope: !486)
!489 = !DILocation(line: 228, column: 17, scope: !486)
!490 = !DILocation(line: 228, column: 20, scope: !486)
!491 = !DILocation(line: 229, column: 5, scope: !486)
!492 = !DILocation(line: 226, column: 35, scope: !482)
!493 = !DILocation(line: 226, column: 5, scope: !482)
!494 = distinct !{!494, !484, !495, !69}
!495 = !DILocation(line: 229, column: 5, scope: !479)
!496 = !DILocation(line: 230, column: 1, scope: !391)
