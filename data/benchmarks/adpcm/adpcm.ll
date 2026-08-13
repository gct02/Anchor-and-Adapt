; ModuleID = 'data/benchmarks/real/adpcm/adpcm.c'
source_filename = "data/benchmarks/real/adpcm/adpcm.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@h = dso_local constant [24 x i32] [i32 12, i32 -44, i32 -44, i32 212, i32 48, i32 -624, i32 128, i32 1448, i32 -840, i32 -3220, i32 3804, i32 15504, i32 15504, i32 3804, i32 -3220, i32 -840, i32 1448, i32 128, i32 -624, i32 48, i32 212, i32 -44, i32 -44, i32 12], align 16, !dbg !0
@qq4_code4_table = dso_local constant [16 x i32] [i32 0, i32 -20456, i32 -12896, i32 -8968, i32 -6288, i32 -4240, i32 -2584, i32 -1200, i32 20456, i32 12896, i32 8968, i32 6288, i32 4240, i32 2584, i32 1200, i32 0], align 16, !dbg !8
@qq6_code6_table = dso_local constant [64 x i32] [i32 -136, i32 -136, i32 -136, i32 -136, i32 -24808, i32 -21904, i32 -19008, i32 -16704, i32 -14984, i32 -13512, i32 -12280, i32 -11192, i32 -10232, i32 -9360, i32 -8576, i32 -7856, i32 -7192, i32 -6576, i32 -6000, i32 -5456, i32 -4944, i32 -4464, i32 -4008, i32 -3576, i32 -3168, i32 -2776, i32 -2400, i32 -2032, i32 -1688, i32 -1360, i32 -1040, i32 -728, i32 24808, i32 21904, i32 19008, i32 16704, i32 14984, i32 13512, i32 12280, i32 11192, i32 10232, i32 9360, i32 8576, i32 7856, i32 7192, i32 6576, i32 6000, i32 5456, i32 4944, i32 4464, i32 4008, i32 3576, i32 3168, i32 2776, i32 2400, i32 2032, i32 1688, i32 1360, i32 1040, i32 728, i32 432, i32 136, i32 -432, i32 -136], align 16, !dbg !14
@wl_code_table = dso_local constant [16 x i32] [i32 -60, i32 3042, i32 1198, i32 538, i32 334, i32 172, i32 58, i32 -30, i32 3042, i32 1198, i32 538, i32 334, i32 172, i32 58, i32 -30, i32 -60], align 16, !dbg !19
@ilb_table = dso_local constant [32 x i32] [i32 2048, i32 2093, i32 2139, i32 2186, i32 2233, i32 2282, i32 2332, i32 2383, i32 2435, i32 2489, i32 2543, i32 2599, i32 2656, i32 2714, i32 2774, i32 2834, i32 2896, i32 2960, i32 3025, i32 3091, i32 3158, i32 3228, i32 3298, i32 3371, i32 3444, i32 3520, i32 3597, i32 3676, i32 3756, i32 3838, i32 3922, i32 4008], align 16, !dbg !21
@decis_levl = dso_local constant [30 x i32] [i32 280, i32 576, i32 880, i32 1200, i32 1520, i32 1864, i32 2208, i32 2584, i32 2960, i32 3376, i32 3784, i32 4240, i32 4696, i32 5200, i32 5712, i32 6288, i32 6864, i32 7520, i32 8184, i32 8968, i32 9752, i32 10712, i32 11664, i32 12896, i32 14120, i32 15840, i32 17560, i32 20456, i32 23352, i32 32767], align 16, !dbg !26
@quant26bt_pos = dso_local constant [31 x i32] [i32 61, i32 60, i32 59, i32 58, i32 57, i32 56, i32 55, i32 54, i32 53, i32 52, i32 51, i32 50, i32 49, i32 48, i32 47, i32 46, i32 45, i32 44, i32 43, i32 42, i32 41, i32 40, i32 39, i32 38, i32 37, i32 36, i32 35, i32 34, i32 33, i32 32, i32 32], align 16, !dbg !31
@quant26bt_neg = dso_local constant [31 x i32] [i32 63, i32 62, i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 4], align 16, !dbg !36
@qq2_code2_table = dso_local constant [4 x i32] [i32 -7408, i32 -1616, i32 7408, i32 1616], align 16, !dbg !38
@wh_code_table = dso_local constant [4 x i32] [i32 798, i32 -214, i32 798, i32 -214], align 16, !dbg !43
@xout1 = dso_local global i32 0, align 4, !dbg !138
@xout2 = dso_local global i32 0, align 4, !dbg !140
@tqmf = dso_local global [24 x i32] zeroinitializer, align 16, !dbg !45
@xl = dso_local global i32 0, align 4, !dbg !130
@xh = dso_local global i32 0, align 4, !dbg !132
@delay_bpl = dso_local global [6 x i32] zeroinitializer, align 16, !dbg !142
@delay_dltx = dso_local global [6 x i32] zeroinitializer, align 16, !dbg !144
@szl = dso_local global i32 0, align 4, !dbg !206
@rlt1 = dso_local global i32 0, align 4, !dbg !162
@al1 = dso_local global i32 0, align 4, !dbg !148
@rlt2 = dso_local global i32 0, align 4, !dbg !164
@al2 = dso_local global i32 0, align 4, !dbg !150
@spl = dso_local global i32 0, align 4, !dbg !208
@sl = dso_local global i32 0, align 4, !dbg !210
@el = dso_local global i32 0, align 4, !dbg !212
@detl = dso_local global i32 0, align 4, !dbg !57
@il = dso_local global i32 0, align 4, !dbg !204
@dlt = dso_local global i32 0, align 4, !dbg !158
@nbl = dso_local global i32 0, align 4, !dbg !146
@plt = dso_local global i32 0, align 4, !dbg !152
@plt1 = dso_local global i32 0, align 4, !dbg !154
@plt2 = dso_local global i32 0, align 4, !dbg !156
@rlt = dso_local global i32 0, align 4, !dbg !160
@delay_bph = dso_local global [6 x i32] zeroinitializer, align 16, !dbg !184
@delay_dhx = dso_local global [6 x i32] zeroinitializer, align 16, !dbg !182
@szh = dso_local global i32 0, align 4, !dbg !172
@rh1 = dso_local global i32 0, align 4, !dbg !194
@ah1 = dso_local global i32 0, align 4, !dbg !186
@rh2 = dso_local global i32 0, align 4, !dbg !196
@ah2 = dso_local global i32 0, align 4, !dbg !188
@sph = dso_local global i32 0, align 4, !dbg !174
@sh = dso_local global i32 0, align 4, !dbg !200
@eh = dso_local global i32 0, align 4, !dbg !202
@ih = dso_local global i32 0, align 4, !dbg !168
@deth = dso_local global i32 0, align 4, !dbg !198
@dh = dso_local global i32 0, align 4, !dbg !166
@nbh = dso_local global i32 0, align 4, !dbg !170
@ph = dso_local global i32 0, align 4, !dbg !176
@ph1 = dso_local global i32 0, align 4, !dbg !190
@ph2 = dso_local global i32 0, align 4, !dbg !192
@yh = dso_local global i32 0, align 4, !dbg !178
@ilr = dso_local global i32 0, align 4, !dbg !116
@dec_del_bpl = dso_local global [6 x i32] zeroinitializer, align 16, !dbg !126
@dec_del_dltx = dso_local global [6 x i32] zeroinitializer, align 16, !dbg !128
@dec_szl = dso_local global i32 0, align 4, !dbg !92
@dec_rlt1 = dso_local global i32 0, align 4, !dbg !98
@dec_al1 = dso_local global i32 0, align 4, !dbg !104
@dec_rlt2 = dso_local global i32 0, align 4, !dbg !100
@dec_al2 = dso_local global i32 0, align 4, !dbg !106
@dec_spl = dso_local global i32 0, align 4, !dbg !94
@dec_sl = dso_local global i32 0, align 4, !dbg !96
@dec_detl = dso_local global i32 0, align 4, !dbg !122
@dec_dlt = dso_local global i32 0, align 4, !dbg !124
@dl = dso_local global i32 0, align 4, !dbg !108
@rl = dso_local global i32 0, align 4, !dbg !118
@dec_nbl = dso_local global i32 0, align 4, !dbg !110
@dec_plt = dso_local global i32 0, align 4, !dbg !86
@dec_plt1 = dso_local global i32 0, align 4, !dbg !88
@dec_plt2 = dso_local global i32 0, align 4, !dbg !90
@dec_rlt = dso_local global i32 0, align 4, !dbg !102
@dec_del_bph = dso_local global [6 x i32] zeroinitializer, align 16, !dbg !59
@dec_del_dhx = dso_local global [6 x i32] zeroinitializer, align 16, !dbg !64
@dec_szh = dso_local global i32 0, align 4, !dbg !78
@dec_rh1 = dso_local global i32 0, align 4, !dbg !66
@dec_ah1 = dso_local global i32 0, align 4, !dbg !70
@dec_rh2 = dso_local global i32 0, align 4, !dbg !68
@dec_ah2 = dso_local global i32 0, align 4, !dbg !72
@dec_sph = dso_local global i32 0, align 4, !dbg !76
@dec_sh = dso_local global i32 0, align 4, !dbg !80
@dec_deth = dso_local global i32 0, align 4, !dbg !120
@dec_dh = dso_local global i32 0, align 4, !dbg !112
@dec_nbh = dso_local global i32 0, align 4, !dbg !114
@dec_ph = dso_local global i32 0, align 4, !dbg !74
@dec_ph1 = dso_local global i32 0, align 4, !dbg !82
@dec_ph2 = dso_local global i32 0, align 4, !dbg !84
@rh = dso_local global i32 0, align 4, !dbg !180
@xd = dso_local global i32 0, align 4, !dbg !136
@xs = dso_local global i32 0, align 4, !dbg !134
@accumc = dso_local global [11 x i32] zeroinitializer, align 16, !dbg !50
@accumd = dso_local global [11 x i32] zeroinitializer, align 16, !dbg !55

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @adpcm_main(i32* noundef %in_data, i32* noundef %encoded, i32* noundef %decoded) #0 !dbg !223 {
entry:
  %in_data.addr = alloca i32*, align 8
  %encoded.addr = alloca i32*, align 8
  %decoded.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  store i32* %in_data, i32** %in_data.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %in_data.addr, metadata !229, metadata !DIExpression()), !dbg !230
  store i32* %encoded, i32** %encoded.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %encoded.addr, metadata !231, metadata !DIExpression()), !dbg !232
  store i32* %decoded, i32** %decoded.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %decoded.addr, metadata !233, metadata !DIExpression()), !dbg !234
  call void @llvm.dbg.declare(metadata i32* %i, metadata !235, metadata !DIExpression()), !dbg !236
  call void @reset(), !dbg !237
  br label %adpcm_main_label12, !dbg !237

adpcm_main_label12:                               ; preds = %entry
  call void @llvm.dbg.label(metadata !238), !dbg !239
  store i32 0, i32* %i, align 4, !dbg !240
  br label %for.cond, !dbg !242

for.cond:                                         ; preds = %for.inc, %adpcm_main_label12
  %0 = load i32, i32* %i, align 4, !dbg !243
  %cmp = icmp slt i32 %0, 50, !dbg !245
  br i1 %cmp, label %for.body, label %for.end, !dbg !246

for.body:                                         ; preds = %for.cond
  %1 = load i32*, i32** %in_data.addr, align 8, !dbg !247
  %2 = load i32, i32* %i, align 4, !dbg !249
  %mul = mul nsw i32 2, %2, !dbg !250
  %idxprom = sext i32 %mul to i64, !dbg !247
  %arrayidx = getelementptr inbounds i32, i32* %1, i64 %idxprom, !dbg !247
  %3 = load i32, i32* %arrayidx, align 4, !dbg !247
  %4 = load i32*, i32** %in_data.addr, align 8, !dbg !251
  %5 = load i32, i32* %i, align 4, !dbg !252
  %mul1 = mul nsw i32 2, %5, !dbg !253
  %add = add nsw i32 %mul1, 1, !dbg !254
  %idxprom2 = sext i32 %add to i64, !dbg !251
  %arrayidx3 = getelementptr inbounds i32, i32* %4, i64 %idxprom2, !dbg !251
  %6 = load i32, i32* %arrayidx3, align 4, !dbg !251
  %call = call i32 @encode(i32 noundef %3, i32 noundef %6), !dbg !255
  %7 = load i32*, i32** %encoded.addr, align 8, !dbg !256
  %8 = load i32, i32* %i, align 4, !dbg !257
  %idxprom4 = sext i32 %8 to i64, !dbg !256
  %arrayidx5 = getelementptr inbounds i32, i32* %7, i64 %idxprom4, !dbg !256
  store i32 %call, i32* %arrayidx5, align 4, !dbg !258
  br label %for.inc, !dbg !259

for.inc:                                          ; preds = %for.body
  %9 = load i32, i32* %i, align 4, !dbg !260
  %inc = add nsw i32 %9, 1, !dbg !260
  store i32 %inc, i32* %i, align 4, !dbg !260
  br label %for.cond, !dbg !261, !llvm.loop !262

for.end:                                          ; preds = %for.cond
  br label %adpcm_main_label13, !dbg !263

adpcm_main_label13:                               ; preds = %for.end
  call void @llvm.dbg.label(metadata !265), !dbg !266
  store i32 0, i32* %i, align 4, !dbg !267
  br label %for.cond6, !dbg !269

for.cond6:                                        ; preds = %for.inc18, %adpcm_main_label13
  %10 = load i32, i32* %i, align 4, !dbg !270
  %cmp7 = icmp slt i32 %10, 50, !dbg !272
  br i1 %cmp7, label %for.body8, label %for.end20, !dbg !273

for.body8:                                        ; preds = %for.cond6
  %11 = load i32*, i32** %encoded.addr, align 8, !dbg !274
  %12 = load i32, i32* %i, align 4, !dbg !276
  %idxprom9 = sext i32 %12 to i64, !dbg !274
  %arrayidx10 = getelementptr inbounds i32, i32* %11, i64 %idxprom9, !dbg !274
  %13 = load i32, i32* %arrayidx10, align 4, !dbg !274
  call void @decode(i32 noundef %13), !dbg !277
  %14 = load i32, i32* @xout1, align 4, !dbg !278
  %15 = load i32*, i32** %decoded.addr, align 8, !dbg !279
  %16 = load i32, i32* %i, align 4, !dbg !280
  %mul11 = mul nsw i32 2, %16, !dbg !281
  %idxprom12 = sext i32 %mul11 to i64, !dbg !279
  %arrayidx13 = getelementptr inbounds i32, i32* %15, i64 %idxprom12, !dbg !279
  store i32 %14, i32* %arrayidx13, align 4, !dbg !282
  %17 = load i32, i32* @xout2, align 4, !dbg !283
  %18 = load i32*, i32** %decoded.addr, align 8, !dbg !284
  %19 = load i32, i32* %i, align 4, !dbg !285
  %mul14 = mul nsw i32 2, %19, !dbg !286
  %add15 = add nsw i32 %mul14, 1, !dbg !287
  %idxprom16 = sext i32 %add15 to i64, !dbg !284
  %arrayidx17 = getelementptr inbounds i32, i32* %18, i64 %idxprom16, !dbg !284
  store i32 %17, i32* %arrayidx17, align 4, !dbg !288
  br label %for.inc18, !dbg !289

for.inc18:                                        ; preds = %for.body8
  %20 = load i32, i32* %i, align 4, !dbg !290
  %inc19 = add nsw i32 %20, 1, !dbg !290
  store i32 %inc19, i32* %i, align 4, !dbg !290
  br label %for.cond6, !dbg !291, !llvm.loop !292

for.end20:                                        ; preds = %for.cond6
  ret void, !dbg !294
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @encode(i32 noundef %xin1, i32 noundef %xin2) #0 !dbg !295 {
entry:
  %xin1.addr = alloca i32, align 4
  %xin2.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %h_ptr = alloca i32*, align 8
  %tqmf_ptr = alloca i32*, align 8
  %tqmf_ptr1 = alloca i32*, align 8
  %xa = alloca i64, align 8
  %xb = alloca i64, align 8
  %decis = alloca i32, align 4
  store i32 %xin1, i32* %xin1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %xin1.addr, metadata !298, metadata !DIExpression()), !dbg !299
  store i32 %xin2, i32* %xin2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %xin2.addr, metadata !300, metadata !DIExpression()), !dbg !301
  call void @llvm.dbg.declare(metadata i32* %i, metadata !302, metadata !DIExpression()), !dbg !303
  call void @llvm.dbg.declare(metadata i32** %h_ptr, metadata !304, metadata !DIExpression()), !dbg !305
  call void @llvm.dbg.declare(metadata i32** %tqmf_ptr, metadata !306, metadata !DIExpression()), !dbg !307
  call void @llvm.dbg.declare(metadata i32** %tqmf_ptr1, metadata !308, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.declare(metadata i64* %xa, metadata !310, metadata !DIExpression()), !dbg !311
  call void @llvm.dbg.declare(metadata i64* %xb, metadata !312, metadata !DIExpression()), !dbg !313
  call void @llvm.dbg.declare(metadata i32* %decis, metadata !314, metadata !DIExpression()), !dbg !315
  store i32* getelementptr inbounds ([24 x i32], [24 x i32]* @h, i64 0, i64 0), i32** %h_ptr, align 8, !dbg !316
  store i32* getelementptr inbounds ([24 x i32], [24 x i32]* @tqmf, i64 0, i64 0), i32** %tqmf_ptr, align 8, !dbg !317
  %0 = load i32*, i32** %tqmf_ptr, align 8, !dbg !318
  %incdec.ptr = getelementptr inbounds i32, i32* %0, i32 1, !dbg !318
  store i32* %incdec.ptr, i32** %tqmf_ptr, align 8, !dbg !318
  %1 = load i32, i32* %0, align 4, !dbg !319
  %conv = sext i32 %1 to i64, !dbg !320
  %2 = load i32*, i32** %h_ptr, align 8, !dbg !321
  %incdec.ptr1 = getelementptr inbounds i32, i32* %2, i32 1, !dbg !321
  store i32* %incdec.ptr1, i32** %h_ptr, align 8, !dbg !321
  %3 = load i32, i32* %2, align 4, !dbg !322
  %conv2 = sext i32 %3 to i64, !dbg !323
  %mul = mul nsw i64 %conv, %conv2, !dbg !324
  store i64 %mul, i64* %xa, align 8, !dbg !325
  %4 = load i32*, i32** %tqmf_ptr, align 8, !dbg !326
  %incdec.ptr3 = getelementptr inbounds i32, i32* %4, i32 1, !dbg !326
  store i32* %incdec.ptr3, i32** %tqmf_ptr, align 8, !dbg !326
  %5 = load i32, i32* %4, align 4, !dbg !327
  %conv4 = sext i32 %5 to i64, !dbg !328
  %6 = load i32*, i32** %h_ptr, align 8, !dbg !329
  %incdec.ptr5 = getelementptr inbounds i32, i32* %6, i32 1, !dbg !329
  store i32* %incdec.ptr5, i32** %h_ptr, align 8, !dbg !329
  %7 = load i32, i32* %6, align 4, !dbg !330
  %conv6 = sext i32 %7 to i64, !dbg !331
  %mul7 = mul nsw i64 %conv4, %conv6, !dbg !332
  store i64 %mul7, i64* %xb, align 8, !dbg !333
  br label %encode_label0, !dbg !334

encode_label0:                                    ; preds = %entry
  call void @llvm.dbg.label(metadata !335), !dbg !336
  store i32 0, i32* %i, align 4, !dbg !337
  br label %for.cond, !dbg !339

for.cond:                                         ; preds = %for.inc, %encode_label0
  %8 = load i32, i32* %i, align 4, !dbg !340
  %cmp = icmp slt i32 %8, 10, !dbg !342
  br i1 %cmp, label %for.body, label %for.end, !dbg !343

for.body:                                         ; preds = %for.cond
  %9 = load i32*, i32** %tqmf_ptr, align 8, !dbg !344
  %incdec.ptr9 = getelementptr inbounds i32, i32* %9, i32 1, !dbg !344
  store i32* %incdec.ptr9, i32** %tqmf_ptr, align 8, !dbg !344
  %10 = load i32, i32* %9, align 4, !dbg !346
  %conv10 = sext i32 %10 to i64, !dbg !347
  %11 = load i32*, i32** %h_ptr, align 8, !dbg !348
  %incdec.ptr11 = getelementptr inbounds i32, i32* %11, i32 1, !dbg !348
  store i32* %incdec.ptr11, i32** %h_ptr, align 8, !dbg !348
  %12 = load i32, i32* %11, align 4, !dbg !349
  %conv12 = sext i32 %12 to i64, !dbg !350
  %mul13 = mul nsw i64 %conv10, %conv12, !dbg !351
  %13 = load i64, i64* %xa, align 8, !dbg !352
  %add = add nsw i64 %13, %mul13, !dbg !352
  store i64 %add, i64* %xa, align 8, !dbg !352
  %14 = load i32*, i32** %tqmf_ptr, align 8, !dbg !353
  %incdec.ptr14 = getelementptr inbounds i32, i32* %14, i32 1, !dbg !353
  store i32* %incdec.ptr14, i32** %tqmf_ptr, align 8, !dbg !353
  %15 = load i32, i32* %14, align 4, !dbg !354
  %conv15 = sext i32 %15 to i64, !dbg !355
  %16 = load i32*, i32** %h_ptr, align 8, !dbg !356
  %incdec.ptr16 = getelementptr inbounds i32, i32* %16, i32 1, !dbg !356
  store i32* %incdec.ptr16, i32** %h_ptr, align 8, !dbg !356
  %17 = load i32, i32* %16, align 4, !dbg !357
  %conv17 = sext i32 %17 to i64, !dbg !358
  %mul18 = mul nsw i64 %conv15, %conv17, !dbg !359
  %18 = load i64, i64* %xb, align 8, !dbg !360
  %add19 = add nsw i64 %18, %mul18, !dbg !360
  store i64 %add19, i64* %xb, align 8, !dbg !360
  br label %for.inc, !dbg !361

for.inc:                                          ; preds = %for.body
  %19 = load i32, i32* %i, align 4, !dbg !362
  %inc = add nsw i32 %19, 1, !dbg !362
  store i32 %inc, i32* %i, align 4, !dbg !362
  br label %for.cond, !dbg !363, !llvm.loop !364

for.end:                                          ; preds = %for.cond
  %20 = load i32*, i32** %tqmf_ptr, align 8, !dbg !366
  %incdec.ptr20 = getelementptr inbounds i32, i32* %20, i32 1, !dbg !366
  store i32* %incdec.ptr20, i32** %tqmf_ptr, align 8, !dbg !366
  %21 = load i32, i32* %20, align 4, !dbg !367
  %conv21 = sext i32 %21 to i64, !dbg !368
  %22 = load i32*, i32** %h_ptr, align 8, !dbg !369
  %incdec.ptr22 = getelementptr inbounds i32, i32* %22, i32 1, !dbg !369
  store i32* %incdec.ptr22, i32** %h_ptr, align 8, !dbg !369
  %23 = load i32, i32* %22, align 4, !dbg !370
  %conv23 = sext i32 %23 to i64, !dbg !371
  %mul24 = mul nsw i64 %conv21, %conv23, !dbg !372
  %24 = load i64, i64* %xa, align 8, !dbg !373
  %add25 = add nsw i64 %24, %mul24, !dbg !373
  store i64 %add25, i64* %xa, align 8, !dbg !373
  %25 = load i32*, i32** %tqmf_ptr, align 8, !dbg !374
  %26 = load i32, i32* %25, align 4, !dbg !375
  %conv26 = sext i32 %26 to i64, !dbg !376
  %27 = load i32*, i32** %h_ptr, align 8, !dbg !377
  %incdec.ptr27 = getelementptr inbounds i32, i32* %27, i32 1, !dbg !377
  store i32* %incdec.ptr27, i32** %h_ptr, align 8, !dbg !377
  %28 = load i32, i32* %27, align 4, !dbg !378
  %conv28 = sext i32 %28 to i64, !dbg !379
  %mul29 = mul nsw i64 %conv26, %conv28, !dbg !380
  %29 = load i64, i64* %xb, align 8, !dbg !381
  %add30 = add nsw i64 %29, %mul29, !dbg !381
  store i64 %add30, i64* %xb, align 8, !dbg !381
  %30 = load i32*, i32** %tqmf_ptr, align 8, !dbg !382
  %add.ptr = getelementptr inbounds i32, i32* %30, i64 -2, !dbg !383
  store i32* %add.ptr, i32** %tqmf_ptr1, align 8, !dbg !384
  br label %encode_label1, !dbg !385

encode_label1:                                    ; preds = %for.end
  call void @llvm.dbg.label(metadata !386), !dbg !387
  store i32 0, i32* %i, align 4, !dbg !388
  br label %for.cond31, !dbg !390

for.cond31:                                       ; preds = %for.inc37, %encode_label1
  %31 = load i32, i32* %i, align 4, !dbg !391
  %cmp32 = icmp slt i32 %31, 22, !dbg !393
  br i1 %cmp32, label %for.body34, label %for.end39, !dbg !394

for.body34:                                       ; preds = %for.cond31
  %32 = load i32*, i32** %tqmf_ptr1, align 8, !dbg !395
  %incdec.ptr35 = getelementptr inbounds i32, i32* %32, i32 -1, !dbg !395
  store i32* %incdec.ptr35, i32** %tqmf_ptr1, align 8, !dbg !395
  %33 = load i32, i32* %32, align 4, !dbg !397
  %34 = load i32*, i32** %tqmf_ptr, align 8, !dbg !398
  %incdec.ptr36 = getelementptr inbounds i32, i32* %34, i32 -1, !dbg !398
  store i32* %incdec.ptr36, i32** %tqmf_ptr, align 8, !dbg !398
  store i32 %33, i32* %34, align 4, !dbg !399
  br label %for.inc37, !dbg !400

for.inc37:                                        ; preds = %for.body34
  %35 = load i32, i32* %i, align 4, !dbg !401
  %inc38 = add nsw i32 %35, 1, !dbg !401
  store i32 %inc38, i32* %i, align 4, !dbg !401
  br label %for.cond31, !dbg !402, !llvm.loop !403

for.end39:                                        ; preds = %for.cond31
  %36 = load i32, i32* %xin1.addr, align 4, !dbg !405
  %37 = load i32*, i32** %tqmf_ptr, align 8, !dbg !406
  %incdec.ptr40 = getelementptr inbounds i32, i32* %37, i32 -1, !dbg !406
  store i32* %incdec.ptr40, i32** %tqmf_ptr, align 8, !dbg !406
  store i32 %36, i32* %37, align 4, !dbg !407
  %38 = load i32, i32* %xin2.addr, align 4, !dbg !408
  %39 = load i32*, i32** %tqmf_ptr, align 8, !dbg !409
  store i32 %38, i32* %39, align 4, !dbg !410
  %40 = load i64, i64* %xa, align 8, !dbg !411
  %41 = load i64, i64* %xb, align 8, !dbg !412
  %add41 = add nsw i64 %40, %41, !dbg !413
  %shr = ashr i64 %add41, 15, !dbg !414
  %conv42 = trunc i64 %shr to i32, !dbg !415
  store i32 %conv42, i32* @xl, align 4, !dbg !416
  %42 = load i64, i64* %xa, align 8, !dbg !417
  %43 = load i64, i64* %xb, align 8, !dbg !418
  %sub = sub nsw i64 %42, %43, !dbg !419
  %shr43 = ashr i64 %sub, 15, !dbg !420
  %conv44 = trunc i64 %shr43 to i32, !dbg !421
  store i32 %conv44, i32* @xh, align 4, !dbg !422
  %call = call i32 @filtez(i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @delay_bpl, i64 0, i64 0), i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @delay_dltx, i64 0, i64 0)), !dbg !423
  store i32 %call, i32* @szl, align 4, !dbg !424
  %44 = load i32, i32* @rlt1, align 4, !dbg !425
  %45 = load i32, i32* @al1, align 4, !dbg !426
  %46 = load i32, i32* @rlt2, align 4, !dbg !427
  %47 = load i32, i32* @al2, align 4, !dbg !428
  %call45 = call i32 @filtep(i32 noundef %44, i32 noundef %45, i32 noundef %46, i32 noundef %47), !dbg !429
  store i32 %call45, i32* @spl, align 4, !dbg !430
  %48 = load i32, i32* @szl, align 4, !dbg !431
  %49 = load i32, i32* @spl, align 4, !dbg !432
  %add46 = add nsw i32 %48, %49, !dbg !433
  store i32 %add46, i32* @sl, align 4, !dbg !434
  %50 = load i32, i32* @xl, align 4, !dbg !435
  %51 = load i32, i32* @sl, align 4, !dbg !436
  %sub47 = sub nsw i32 %50, %51, !dbg !437
  store i32 %sub47, i32* @el, align 4, !dbg !438
  %52 = load i32, i32* @el, align 4, !dbg !439
  %53 = load i32, i32* @detl, align 4, !dbg !440
  %call48 = call i32 @quantl(i32 noundef %52, i32 noundef %53), !dbg !441
  store i32 %call48, i32* @il, align 4, !dbg !442
  %54 = load i32, i32* @detl, align 4, !dbg !443
  %conv49 = sext i32 %54 to i64, !dbg !444
  %55 = load i32, i32* @il, align 4, !dbg !445
  %shr50 = ashr i32 %55, 2, !dbg !446
  %idxprom = sext i32 %shr50 to i64, !dbg !447
  %arrayidx = getelementptr inbounds [16 x i32], [16 x i32]* @qq4_code4_table, i64 0, i64 %idxprom, !dbg !447
  %56 = load i32, i32* %arrayidx, align 4, !dbg !447
  %conv51 = sext i32 %56 to i64, !dbg !447
  %mul52 = mul nsw i64 %conv49, %conv51, !dbg !448
  %shr53 = ashr i64 %mul52, 15, !dbg !449
  %conv54 = trunc i64 %shr53 to i32, !dbg !450
  store i32 %conv54, i32* @dlt, align 4, !dbg !451
  %57 = load i32, i32* @il, align 4, !dbg !452
  %58 = load i32, i32* @nbl, align 4, !dbg !453
  %call55 = call i32 @logscl(i32 noundef %57, i32 noundef %58), !dbg !454
  store i32 %call55, i32* @nbl, align 4, !dbg !455
  %59 = load i32, i32* @nbl, align 4, !dbg !456
  %call56 = call i32 @scalel(i32 noundef %59, i32 noundef 8), !dbg !457
  store i32 %call56, i32* @detl, align 4, !dbg !458
  %60 = load i32, i32* @dlt, align 4, !dbg !459
  %61 = load i32, i32* @szl, align 4, !dbg !460
  %add57 = add nsw i32 %60, %61, !dbg !461
  store i32 %add57, i32* @plt, align 4, !dbg !462
  %62 = load i32, i32* @dlt, align 4, !dbg !463
  call void @upzero(i32 noundef %62, i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @delay_dltx, i64 0, i64 0), i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @delay_bpl, i64 0, i64 0)), !dbg !464
  %63 = load i32, i32* @al1, align 4, !dbg !465
  %64 = load i32, i32* @al2, align 4, !dbg !466
  %65 = load i32, i32* @plt, align 4, !dbg !467
  %66 = load i32, i32* @plt1, align 4, !dbg !468
  %67 = load i32, i32* @plt2, align 4, !dbg !469
  %call58 = call i32 @uppol2(i32 noundef %63, i32 noundef %64, i32 noundef %65, i32 noundef %66, i32 noundef %67), !dbg !470
  store i32 %call58, i32* @al2, align 4, !dbg !471
  %68 = load i32, i32* @al1, align 4, !dbg !472
  %69 = load i32, i32* @al2, align 4, !dbg !473
  %70 = load i32, i32* @plt, align 4, !dbg !474
  %71 = load i32, i32* @plt1, align 4, !dbg !475
  %call59 = call i32 @uppol1(i32 noundef %68, i32 noundef %69, i32 noundef %70, i32 noundef %71), !dbg !476
  store i32 %call59, i32* @al1, align 4, !dbg !477
  %72 = load i32, i32* @sl, align 4, !dbg !478
  %73 = load i32, i32* @dlt, align 4, !dbg !479
  %add60 = add nsw i32 %72, %73, !dbg !480
  store i32 %add60, i32* @rlt, align 4, !dbg !481
  %74 = load i32, i32* @rlt1, align 4, !dbg !482
  store i32 %74, i32* @rlt2, align 4, !dbg !483
  %75 = load i32, i32* @rlt, align 4, !dbg !484
  store i32 %75, i32* @rlt1, align 4, !dbg !485
  %76 = load i32, i32* @plt1, align 4, !dbg !486
  store i32 %76, i32* @plt2, align 4, !dbg !487
  %77 = load i32, i32* @plt, align 4, !dbg !488
  store i32 %77, i32* @plt1, align 4, !dbg !489
  %call61 = call i32 @filtez(i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @delay_bph, i64 0, i64 0), i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @delay_dhx, i64 0, i64 0)), !dbg !490
  store i32 %call61, i32* @szh, align 4, !dbg !491
  %78 = load i32, i32* @rh1, align 4, !dbg !492
  %79 = load i32, i32* @ah1, align 4, !dbg !493
  %80 = load i32, i32* @rh2, align 4, !dbg !494
  %81 = load i32, i32* @ah2, align 4, !dbg !495
  %call62 = call i32 @filtep(i32 noundef %78, i32 noundef %79, i32 noundef %80, i32 noundef %81), !dbg !496
  store i32 %call62, i32* @sph, align 4, !dbg !497
  %82 = load i32, i32* @sph, align 4, !dbg !498
  %83 = load i32, i32* @szh, align 4, !dbg !499
  %add63 = add nsw i32 %82, %83, !dbg !500
  store i32 %add63, i32* @sh, align 4, !dbg !501
  %84 = load i32, i32* @xh, align 4, !dbg !502
  %85 = load i32, i32* @sh, align 4, !dbg !503
  %sub64 = sub nsw i32 %84, %85, !dbg !504
  store i32 %sub64, i32* @eh, align 4, !dbg !505
  %86 = load i32, i32* @eh, align 4, !dbg !506
  %cmp65 = icmp sge i32 %86, 0, !dbg !508
  br i1 %cmp65, label %if.then, label %if.else, !dbg !509

if.then:                                          ; preds = %for.end39
  store i32 3, i32* @ih, align 4, !dbg !510
  br label %if.end, !dbg !512

if.else:                                          ; preds = %for.end39
  store i32 1, i32* @ih, align 4, !dbg !513
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %87 = load i32, i32* @deth, align 4, !dbg !515
  %conv67 = sext i32 %87 to i64, !dbg !516
  %mul68 = mul nsw i64 564, %conv67, !dbg !517
  %shr69 = ashr i64 %mul68, 12, !dbg !518
  %conv70 = trunc i64 %shr69 to i32, !dbg !519
  store i32 %conv70, i32* %decis, align 4, !dbg !520
  %88 = load i32, i32* @eh, align 4, !dbg !521
  %call71 = call i32 @abs(i32 noundef %88) #3, !dbg !523
  %89 = load i32, i32* %decis, align 4, !dbg !524
  %cmp72 = icmp sgt i32 %call71, %89, !dbg !525
  br i1 %cmp72, label %if.then74, label %if.end75, !dbg !526

if.then74:                                        ; preds = %if.end
  %90 = load i32, i32* @ih, align 4, !dbg !527
  %dec = add nsw i32 %90, -1, !dbg !527
  store i32 %dec, i32* @ih, align 4, !dbg !527
  br label %if.end75, !dbg !528

if.end75:                                         ; preds = %if.then74, %if.end
  %91 = load i32, i32* @deth, align 4, !dbg !529
  %conv76 = sext i32 %91 to i64, !dbg !530
  %92 = load i32, i32* @ih, align 4, !dbg !531
  %idxprom77 = sext i32 %92 to i64, !dbg !532
  %arrayidx78 = getelementptr inbounds [4 x i32], [4 x i32]* @qq2_code2_table, i64 0, i64 %idxprom77, !dbg !532
  %93 = load i32, i32* %arrayidx78, align 4, !dbg !532
  %conv79 = sext i32 %93 to i64, !dbg !532
  %mul80 = mul nsw i64 %conv76, %conv79, !dbg !533
  %shr81 = ashr i64 %mul80, 15, !dbg !534
  %conv82 = trunc i64 %shr81 to i32, !dbg !535
  store i32 %conv82, i32* @dh, align 4, !dbg !536
  %94 = load i32, i32* @ih, align 4, !dbg !537
  %95 = load i32, i32* @nbh, align 4, !dbg !538
  %call83 = call i32 @logsch(i32 noundef %94, i32 noundef %95), !dbg !539
  store i32 %call83, i32* @nbh, align 4, !dbg !540
  %96 = load i32, i32* @nbh, align 4, !dbg !541
  %call84 = call i32 @scalel(i32 noundef %96, i32 noundef 10), !dbg !542
  store i32 %call84, i32* @deth, align 4, !dbg !543
  %97 = load i32, i32* @dh, align 4, !dbg !544
  %98 = load i32, i32* @szh, align 4, !dbg !545
  %add85 = add nsw i32 %97, %98, !dbg !546
  store i32 %add85, i32* @ph, align 4, !dbg !547
  %99 = load i32, i32* @dh, align 4, !dbg !548
  call void @upzero(i32 noundef %99, i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @delay_dhx, i64 0, i64 0), i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @delay_bph, i64 0, i64 0)), !dbg !549
  %100 = load i32, i32* @ah1, align 4, !dbg !550
  %101 = load i32, i32* @ah2, align 4, !dbg !551
  %102 = load i32, i32* @ph, align 4, !dbg !552
  %103 = load i32, i32* @ph1, align 4, !dbg !553
  %104 = load i32, i32* @ph2, align 4, !dbg !554
  %call86 = call i32 @uppol2(i32 noundef %100, i32 noundef %101, i32 noundef %102, i32 noundef %103, i32 noundef %104), !dbg !555
  store i32 %call86, i32* @ah2, align 4, !dbg !556
  %105 = load i32, i32* @ah1, align 4, !dbg !557
  %106 = load i32, i32* @ah2, align 4, !dbg !558
  %107 = load i32, i32* @ph, align 4, !dbg !559
  %108 = load i32, i32* @ph1, align 4, !dbg !560
  %call87 = call i32 @uppol1(i32 noundef %105, i32 noundef %106, i32 noundef %107, i32 noundef %108), !dbg !561
  store i32 %call87, i32* @ah1, align 4, !dbg !562
  %109 = load i32, i32* @sh, align 4, !dbg !563
  %110 = load i32, i32* @dh, align 4, !dbg !564
  %add88 = add nsw i32 %109, %110, !dbg !565
  store i32 %add88, i32* @yh, align 4, !dbg !566
  %111 = load i32, i32* @rh1, align 4, !dbg !567
  store i32 %111, i32* @rh2, align 4, !dbg !568
  %112 = load i32, i32* @yh, align 4, !dbg !569
  store i32 %112, i32* @rh1, align 4, !dbg !570
  %113 = load i32, i32* @ph1, align 4, !dbg !571
  store i32 %113, i32* @ph2, align 4, !dbg !572
  %114 = load i32, i32* @ph, align 4, !dbg !573
  store i32 %114, i32* @ph1, align 4, !dbg !574
  %115 = load i32, i32* @il, align 4, !dbg !575
  %116 = load i32, i32* @ih, align 4, !dbg !576
  %shl = shl i32 %116, 6, !dbg !577
  %or = or i32 %115, %shl, !dbg !578
  ret i32 %or, !dbg !579
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @decode(i32 noundef %input) #0 !dbg !580 {
entry:
  %input.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %xa1 = alloca i64, align 8
  %xa2 = alloca i64, align 8
  %h_ptr = alloca i32*, align 8
  %ac_ptr = alloca i32*, align 8
  %ac_ptr1 = alloca i32*, align 8
  %ad_ptr = alloca i32*, align 8
  %ad_ptr1 = alloca i32*, align 8
  store i32 %input, i32* %input.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %input.addr, metadata !583, metadata !DIExpression()), !dbg !584
  call void @llvm.dbg.declare(metadata i32* %i, metadata !585, metadata !DIExpression()), !dbg !586
  call void @llvm.dbg.declare(metadata i64* %xa1, metadata !587, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.declare(metadata i64* %xa2, metadata !589, metadata !DIExpression()), !dbg !590
  call void @llvm.dbg.declare(metadata i32** %h_ptr, metadata !591, metadata !DIExpression()), !dbg !592
  call void @llvm.dbg.declare(metadata i32** %ac_ptr, metadata !593, metadata !DIExpression()), !dbg !594
  call void @llvm.dbg.declare(metadata i32** %ac_ptr1, metadata !595, metadata !DIExpression()), !dbg !596
  call void @llvm.dbg.declare(metadata i32** %ad_ptr, metadata !597, metadata !DIExpression()), !dbg !598
  call void @llvm.dbg.declare(metadata i32** %ad_ptr1, metadata !599, metadata !DIExpression()), !dbg !600
  %0 = load i32, i32* %input.addr, align 4, !dbg !601
  %and = and i32 %0, 63, !dbg !602
  store i32 %and, i32* @ilr, align 4, !dbg !603
  %1 = load i32, i32* %input.addr, align 4, !dbg !604
  %shr = ashr i32 %1, 6, !dbg !605
  store i32 %shr, i32* @ih, align 4, !dbg !606
  %call = call i32 @filtez(i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @dec_del_bpl, i64 0, i64 0), i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @dec_del_dltx, i64 0, i64 0)), !dbg !607
  store i32 %call, i32* @dec_szl, align 4, !dbg !608
  %2 = load i32, i32* @dec_rlt1, align 4, !dbg !609
  %3 = load i32, i32* @dec_al1, align 4, !dbg !610
  %4 = load i32, i32* @dec_rlt2, align 4, !dbg !611
  %5 = load i32, i32* @dec_al2, align 4, !dbg !612
  %call1 = call i32 @filtep(i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5), !dbg !613
  store i32 %call1, i32* @dec_spl, align 4, !dbg !614
  %6 = load i32, i32* @dec_spl, align 4, !dbg !615
  %7 = load i32, i32* @dec_szl, align 4, !dbg !616
  %add = add nsw i32 %6, %7, !dbg !617
  store i32 %add, i32* @dec_sl, align 4, !dbg !618
  %8 = load i32, i32* @dec_detl, align 4, !dbg !619
  %conv = sext i32 %8 to i64, !dbg !620
  %9 = load i32, i32* @ilr, align 4, !dbg !621
  %shr2 = ashr i32 %9, 2, !dbg !622
  %idxprom = sext i32 %shr2 to i64, !dbg !623
  %arrayidx = getelementptr inbounds [16 x i32], [16 x i32]* @qq4_code4_table, i64 0, i64 %idxprom, !dbg !623
  %10 = load i32, i32* %arrayidx, align 4, !dbg !623
  %conv3 = sext i32 %10 to i64, !dbg !623
  %mul = mul nsw i64 %conv, %conv3, !dbg !624
  %shr4 = ashr i64 %mul, 15, !dbg !625
  %conv5 = trunc i64 %shr4 to i32, !dbg !626
  store i32 %conv5, i32* @dec_dlt, align 4, !dbg !627
  %11 = load i32, i32* @dec_detl, align 4, !dbg !628
  %conv6 = sext i32 %11 to i64, !dbg !629
  %12 = load i32, i32* @il, align 4, !dbg !630
  %idxprom7 = sext i32 %12 to i64, !dbg !631
  %arrayidx8 = getelementptr inbounds [64 x i32], [64 x i32]* @qq6_code6_table, i64 0, i64 %idxprom7, !dbg !631
  %13 = load i32, i32* %arrayidx8, align 4, !dbg !631
  %conv9 = sext i32 %13 to i64, !dbg !631
  %mul10 = mul nsw i64 %conv6, %conv9, !dbg !632
  %shr11 = ashr i64 %mul10, 15, !dbg !633
  %conv12 = trunc i64 %shr11 to i32, !dbg !634
  store i32 %conv12, i32* @dl, align 4, !dbg !635
  %14 = load i32, i32* @dl, align 4, !dbg !636
  %15 = load i32, i32* @dec_sl, align 4, !dbg !637
  %add13 = add nsw i32 %14, %15, !dbg !638
  store i32 %add13, i32* @rl, align 4, !dbg !639
  %16 = load i32, i32* @ilr, align 4, !dbg !640
  %17 = load i32, i32* @dec_nbl, align 4, !dbg !641
  %call14 = call i32 @logscl(i32 noundef %16, i32 noundef %17), !dbg !642
  store i32 %call14, i32* @dec_nbl, align 4, !dbg !643
  %18 = load i32, i32* @dec_nbl, align 4, !dbg !644
  %call15 = call i32 @scalel(i32 noundef %18, i32 noundef 8), !dbg !645
  store i32 %call15, i32* @dec_detl, align 4, !dbg !646
  %19 = load i32, i32* @dec_dlt, align 4, !dbg !647
  %20 = load i32, i32* @dec_szl, align 4, !dbg !648
  %add16 = add nsw i32 %19, %20, !dbg !649
  store i32 %add16, i32* @dec_plt, align 4, !dbg !650
  %21 = load i32, i32* @dec_dlt, align 4, !dbg !651
  call void @upzero(i32 noundef %21, i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @dec_del_dltx, i64 0, i64 0), i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @dec_del_bpl, i64 0, i64 0)), !dbg !652
  %22 = load i32, i32* @dec_al1, align 4, !dbg !653
  %23 = load i32, i32* @dec_al2, align 4, !dbg !654
  %24 = load i32, i32* @dec_plt, align 4, !dbg !655
  %25 = load i32, i32* @dec_plt1, align 4, !dbg !656
  %26 = load i32, i32* @dec_plt2, align 4, !dbg !657
  %call17 = call i32 @uppol2(i32 noundef %22, i32 noundef %23, i32 noundef %24, i32 noundef %25, i32 noundef %26), !dbg !658
  store i32 %call17, i32* @dec_al2, align 4, !dbg !659
  %27 = load i32, i32* @dec_al1, align 4, !dbg !660
  %28 = load i32, i32* @dec_al2, align 4, !dbg !661
  %29 = load i32, i32* @dec_plt, align 4, !dbg !662
  %30 = load i32, i32* @dec_plt1, align 4, !dbg !663
  %call18 = call i32 @uppol1(i32 noundef %27, i32 noundef %28, i32 noundef %29, i32 noundef %30), !dbg !664
  store i32 %call18, i32* @dec_al1, align 4, !dbg !665
  %31 = load i32, i32* @dec_sl, align 4, !dbg !666
  %32 = load i32, i32* @dec_dlt, align 4, !dbg !667
  %add19 = add nsw i32 %31, %32, !dbg !668
  store i32 %add19, i32* @dec_rlt, align 4, !dbg !669
  %33 = load i32, i32* @dec_rlt1, align 4, !dbg !670
  store i32 %33, i32* @dec_rlt2, align 4, !dbg !671
  %34 = load i32, i32* @dec_rlt, align 4, !dbg !672
  store i32 %34, i32* @dec_rlt1, align 4, !dbg !673
  %35 = load i32, i32* @dec_plt1, align 4, !dbg !674
  store i32 %35, i32* @dec_plt2, align 4, !dbg !675
  %36 = load i32, i32* @dec_plt, align 4, !dbg !676
  store i32 %36, i32* @dec_plt1, align 4, !dbg !677
  %call20 = call i32 @filtez(i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @dec_del_bph, i64 0, i64 0), i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @dec_del_dhx, i64 0, i64 0)), !dbg !678
  store i32 %call20, i32* @dec_szh, align 4, !dbg !679
  %37 = load i32, i32* @dec_rh1, align 4, !dbg !680
  %38 = load i32, i32* @dec_ah1, align 4, !dbg !681
  %39 = load i32, i32* @dec_rh2, align 4, !dbg !682
  %40 = load i32, i32* @dec_ah2, align 4, !dbg !683
  %call21 = call i32 @filtep(i32 noundef %37, i32 noundef %38, i32 noundef %39, i32 noundef %40), !dbg !684
  store i32 %call21, i32* @dec_sph, align 4, !dbg !685
  %41 = load i32, i32* @dec_sph, align 4, !dbg !686
  %42 = load i32, i32* @dec_szh, align 4, !dbg !687
  %add22 = add nsw i32 %41, %42, !dbg !688
  store i32 %add22, i32* @dec_sh, align 4, !dbg !689
  %43 = load i32, i32* @dec_deth, align 4, !dbg !690
  %conv23 = sext i32 %43 to i64, !dbg !691
  %44 = load i32, i32* @ih, align 4, !dbg !692
  %idxprom24 = sext i32 %44 to i64, !dbg !693
  %arrayidx25 = getelementptr inbounds [4 x i32], [4 x i32]* @qq2_code2_table, i64 0, i64 %idxprom24, !dbg !693
  %45 = load i32, i32* %arrayidx25, align 4, !dbg !693
  %conv26 = sext i32 %45 to i64, !dbg !693
  %mul27 = mul nsw i64 %conv23, %conv26, !dbg !694
  %shr28 = ashr i64 %mul27, 15, !dbg !695
  %conv29 = trunc i64 %shr28 to i32, !dbg !696
  store i32 %conv29, i32* @dec_dh, align 4, !dbg !697
  %46 = load i32, i32* @ih, align 4, !dbg !698
  %47 = load i32, i32* @dec_nbh, align 4, !dbg !699
  %call30 = call i32 @logsch(i32 noundef %46, i32 noundef %47), !dbg !700
  store i32 %call30, i32* @dec_nbh, align 4, !dbg !701
  %48 = load i32, i32* @dec_nbh, align 4, !dbg !702
  %call31 = call i32 @scalel(i32 noundef %48, i32 noundef 10), !dbg !703
  store i32 %call31, i32* @dec_deth, align 4, !dbg !704
  %49 = load i32, i32* @dec_dh, align 4, !dbg !705
  %50 = load i32, i32* @dec_szh, align 4, !dbg !706
  %add32 = add nsw i32 %49, %50, !dbg !707
  store i32 %add32, i32* @dec_ph, align 4, !dbg !708
  %51 = load i32, i32* @dec_dh, align 4, !dbg !709
  call void @upzero(i32 noundef %51, i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @dec_del_dhx, i64 0, i64 0), i32* noundef getelementptr inbounds ([6 x i32], [6 x i32]* @dec_del_bph, i64 0, i64 0)), !dbg !710
  %52 = load i32, i32* @dec_ah1, align 4, !dbg !711
  %53 = load i32, i32* @dec_ah2, align 4, !dbg !712
  %54 = load i32, i32* @dec_ph, align 4, !dbg !713
  %55 = load i32, i32* @dec_ph1, align 4, !dbg !714
  %56 = load i32, i32* @dec_ph2, align 4, !dbg !715
  %call33 = call i32 @uppol2(i32 noundef %52, i32 noundef %53, i32 noundef %54, i32 noundef %55, i32 noundef %56), !dbg !716
  store i32 %call33, i32* @dec_ah2, align 4, !dbg !717
  %57 = load i32, i32* @dec_ah1, align 4, !dbg !718
  %58 = load i32, i32* @dec_ah2, align 4, !dbg !719
  %59 = load i32, i32* @dec_ph, align 4, !dbg !720
  %60 = load i32, i32* @dec_ph1, align 4, !dbg !721
  %call34 = call i32 @uppol1(i32 noundef %57, i32 noundef %58, i32 noundef %59, i32 noundef %60), !dbg !722
  store i32 %call34, i32* @dec_ah1, align 4, !dbg !723
  %61 = load i32, i32* @dec_sh, align 4, !dbg !724
  %62 = load i32, i32* @dec_dh, align 4, !dbg !725
  %add35 = add nsw i32 %61, %62, !dbg !726
  store i32 %add35, i32* @rh, align 4, !dbg !727
  %63 = load i32, i32* @dec_rh1, align 4, !dbg !728
  store i32 %63, i32* @dec_rh2, align 4, !dbg !729
  %64 = load i32, i32* @rh, align 4, !dbg !730
  store i32 %64, i32* @dec_rh1, align 4, !dbg !731
  %65 = load i32, i32* @dec_ph1, align 4, !dbg !732
  store i32 %65, i32* @dec_ph2, align 4, !dbg !733
  %66 = load i32, i32* @dec_ph, align 4, !dbg !734
  store i32 %66, i32* @dec_ph1, align 4, !dbg !735
  %67 = load i32, i32* @rl, align 4, !dbg !736
  %68 = load i32, i32* @rh, align 4, !dbg !737
  %sub = sub nsw i32 %67, %68, !dbg !738
  store i32 %sub, i32* @xd, align 4, !dbg !739
  %69 = load i32, i32* @rl, align 4, !dbg !740
  %70 = load i32, i32* @rh, align 4, !dbg !741
  %add36 = add nsw i32 %69, %70, !dbg !742
  store i32 %add36, i32* @xs, align 4, !dbg !743
  store i32* getelementptr inbounds ([24 x i32], [24 x i32]* @h, i64 0, i64 0), i32** %h_ptr, align 8, !dbg !744
  store i32* getelementptr inbounds ([11 x i32], [11 x i32]* @accumc, i64 0, i64 0), i32** %ac_ptr, align 8, !dbg !745
  store i32* getelementptr inbounds ([11 x i32], [11 x i32]* @accumd, i64 0, i64 0), i32** %ad_ptr, align 8, !dbg !746
  %71 = load i32, i32* @xd, align 4, !dbg !747
  %conv37 = sext i32 %71 to i64, !dbg !748
  %72 = load i32*, i32** %h_ptr, align 8, !dbg !749
  %incdec.ptr = getelementptr inbounds i32, i32* %72, i32 1, !dbg !749
  store i32* %incdec.ptr, i32** %h_ptr, align 8, !dbg !749
  %73 = load i32, i32* %72, align 4, !dbg !750
  %conv38 = sext i32 %73 to i64, !dbg !751
  %mul39 = mul nsw i64 %conv37, %conv38, !dbg !752
  store i64 %mul39, i64* %xa1, align 8, !dbg !753
  %74 = load i32, i32* @xs, align 4, !dbg !754
  %conv40 = sext i32 %74 to i64, !dbg !755
  %75 = load i32*, i32** %h_ptr, align 8, !dbg !756
  %incdec.ptr41 = getelementptr inbounds i32, i32* %75, i32 1, !dbg !756
  store i32* %incdec.ptr41, i32** %h_ptr, align 8, !dbg !756
  %76 = load i32, i32* %75, align 4, !dbg !757
  %conv42 = sext i32 %76 to i64, !dbg !758
  %mul43 = mul nsw i64 %conv40, %conv42, !dbg !759
  store i64 %mul43, i64* %xa2, align 8, !dbg !760
  br label %decode_label2, !dbg !761

decode_label2:                                    ; preds = %entry
  call void @llvm.dbg.label(metadata !762), !dbg !763
  store i32 0, i32* %i, align 4, !dbg !764
  br label %for.cond, !dbg !766

for.cond:                                         ; preds = %for.inc, %decode_label2
  %77 = load i32, i32* %i, align 4, !dbg !767
  %cmp = icmp slt i32 %77, 10, !dbg !769
  br i1 %cmp, label %for.body, label %for.end, !dbg !770

for.body:                                         ; preds = %for.cond
  %78 = load i32*, i32** %ac_ptr, align 8, !dbg !771
  %incdec.ptr45 = getelementptr inbounds i32, i32* %78, i32 1, !dbg !771
  store i32* %incdec.ptr45, i32** %ac_ptr, align 8, !dbg !771
  %79 = load i32, i32* %78, align 4, !dbg !773
  %conv46 = sext i32 %79 to i64, !dbg !774
  %80 = load i32*, i32** %h_ptr, align 8, !dbg !775
  %incdec.ptr47 = getelementptr inbounds i32, i32* %80, i32 1, !dbg !775
  store i32* %incdec.ptr47, i32** %h_ptr, align 8, !dbg !775
  %81 = load i32, i32* %80, align 4, !dbg !776
  %conv48 = sext i32 %81 to i64, !dbg !777
  %mul49 = mul nsw i64 %conv46, %conv48, !dbg !778
  %82 = load i64, i64* %xa1, align 8, !dbg !779
  %add50 = add nsw i64 %82, %mul49, !dbg !779
  store i64 %add50, i64* %xa1, align 8, !dbg !779
  %83 = load i32*, i32** %ad_ptr, align 8, !dbg !780
  %incdec.ptr51 = getelementptr inbounds i32, i32* %83, i32 1, !dbg !780
  store i32* %incdec.ptr51, i32** %ad_ptr, align 8, !dbg !780
  %84 = load i32, i32* %83, align 4, !dbg !781
  %conv52 = sext i32 %84 to i64, !dbg !782
  %85 = load i32*, i32** %h_ptr, align 8, !dbg !783
  %incdec.ptr53 = getelementptr inbounds i32, i32* %85, i32 1, !dbg !783
  store i32* %incdec.ptr53, i32** %h_ptr, align 8, !dbg !783
  %86 = load i32, i32* %85, align 4, !dbg !784
  %conv54 = sext i32 %86 to i64, !dbg !785
  %mul55 = mul nsw i64 %conv52, %conv54, !dbg !786
  %87 = load i64, i64* %xa2, align 8, !dbg !787
  %add56 = add nsw i64 %87, %mul55, !dbg !787
  store i64 %add56, i64* %xa2, align 8, !dbg !787
  br label %for.inc, !dbg !788

for.inc:                                          ; preds = %for.body
  %88 = load i32, i32* %i, align 4, !dbg !789
  %inc = add nsw i32 %88, 1, !dbg !789
  store i32 %inc, i32* %i, align 4, !dbg !789
  br label %for.cond, !dbg !790, !llvm.loop !791

for.end:                                          ; preds = %for.cond
  %89 = load i32*, i32** %ac_ptr, align 8, !dbg !793
  %90 = load i32, i32* %89, align 4, !dbg !794
  %conv57 = sext i32 %90 to i64, !dbg !795
  %91 = load i32*, i32** %h_ptr, align 8, !dbg !796
  %incdec.ptr58 = getelementptr inbounds i32, i32* %91, i32 1, !dbg !796
  store i32* %incdec.ptr58, i32** %h_ptr, align 8, !dbg !796
  %92 = load i32, i32* %91, align 4, !dbg !797
  %conv59 = sext i32 %92 to i64, !dbg !798
  %mul60 = mul nsw i64 %conv57, %conv59, !dbg !799
  %93 = load i64, i64* %xa1, align 8, !dbg !800
  %add61 = add nsw i64 %93, %mul60, !dbg !800
  store i64 %add61, i64* %xa1, align 8, !dbg !800
  %94 = load i32*, i32** %ad_ptr, align 8, !dbg !801
  %95 = load i32, i32* %94, align 4, !dbg !802
  %conv62 = sext i32 %95 to i64, !dbg !803
  %96 = load i32*, i32** %h_ptr, align 8, !dbg !804
  %incdec.ptr63 = getelementptr inbounds i32, i32* %96, i32 1, !dbg !804
  store i32* %incdec.ptr63, i32** %h_ptr, align 8, !dbg !804
  %97 = load i32, i32* %96, align 4, !dbg !805
  %conv64 = sext i32 %97 to i64, !dbg !806
  %mul65 = mul nsw i64 %conv62, %conv64, !dbg !807
  %98 = load i64, i64* %xa2, align 8, !dbg !808
  %add66 = add nsw i64 %98, %mul65, !dbg !808
  store i64 %add66, i64* %xa2, align 8, !dbg !808
  %99 = load i64, i64* %xa1, align 8, !dbg !809
  %shr67 = ashr i64 %99, 14, !dbg !810
  %conv68 = trunc i64 %shr67 to i32, !dbg !809
  store i32 %conv68, i32* @xout1, align 4, !dbg !811
  %100 = load i64, i64* %xa2, align 8, !dbg !812
  %shr69 = ashr i64 %100, 14, !dbg !813
  %conv70 = trunc i64 %shr69 to i32, !dbg !812
  store i32 %conv70, i32* @xout2, align 4, !dbg !814
  %101 = load i32*, i32** %ac_ptr, align 8, !dbg !815
  %add.ptr = getelementptr inbounds i32, i32* %101, i64 -1, !dbg !816
  store i32* %add.ptr, i32** %ac_ptr1, align 8, !dbg !817
  %102 = load i32*, i32** %ad_ptr, align 8, !dbg !818
  %add.ptr71 = getelementptr inbounds i32, i32* %102, i64 -1, !dbg !819
  store i32* %add.ptr71, i32** %ad_ptr1, align 8, !dbg !820
  br label %decode_label3, !dbg !821

decode_label3:                                    ; preds = %for.end
  call void @llvm.dbg.label(metadata !822), !dbg !823
  store i32 0, i32* %i, align 4, !dbg !824
  br label %for.cond72, !dbg !826

for.cond72:                                       ; preds = %for.inc80, %decode_label3
  %103 = load i32, i32* %i, align 4, !dbg !827
  %cmp73 = icmp slt i32 %103, 10, !dbg !829
  br i1 %cmp73, label %for.body75, label %for.end82, !dbg !830

for.body75:                                       ; preds = %for.cond72
  %104 = load i32*, i32** %ac_ptr1, align 8, !dbg !831
  %incdec.ptr76 = getelementptr inbounds i32, i32* %104, i32 -1, !dbg !831
  store i32* %incdec.ptr76, i32** %ac_ptr1, align 8, !dbg !831
  %105 = load i32, i32* %104, align 4, !dbg !833
  %106 = load i32*, i32** %ac_ptr, align 8, !dbg !834
  %incdec.ptr77 = getelementptr inbounds i32, i32* %106, i32 -1, !dbg !834
  store i32* %incdec.ptr77, i32** %ac_ptr, align 8, !dbg !834
  store i32 %105, i32* %106, align 4, !dbg !835
  %107 = load i32*, i32** %ad_ptr1, align 8, !dbg !836
  %incdec.ptr78 = getelementptr inbounds i32, i32* %107, i32 -1, !dbg !836
  store i32* %incdec.ptr78, i32** %ad_ptr1, align 8, !dbg !836
  %108 = load i32, i32* %107, align 4, !dbg !837
  %109 = load i32*, i32** %ad_ptr, align 8, !dbg !838
  %incdec.ptr79 = getelementptr inbounds i32, i32* %109, i32 -1, !dbg !838
  store i32* %incdec.ptr79, i32** %ad_ptr, align 8, !dbg !838
  store i32 %108, i32* %109, align 4, !dbg !839
  br label %for.inc80, !dbg !840

for.inc80:                                        ; preds = %for.body75
  %110 = load i32, i32* %i, align 4, !dbg !841
  %inc81 = add nsw i32 %110, 1, !dbg !841
  store i32 %inc81, i32* %i, align 4, !dbg !841
  br label %for.cond72, !dbg !842, !llvm.loop !843

for.end82:                                        ; preds = %for.cond72
  %111 = load i32, i32* @xd, align 4, !dbg !845
  %112 = load i32*, i32** %ac_ptr, align 8, !dbg !846
  store i32 %111, i32* %112, align 4, !dbg !847
  %113 = load i32, i32* @xs, align 4, !dbg !848
  %114 = load i32*, i32** %ad_ptr, align 8, !dbg !849
  store i32 %113, i32* %114, align 4, !dbg !850
  ret void, !dbg !851
}

; Function Attrs: noinline nounwind optnone readnone uwtable willreturn
define dso_local i32 @abs(i32 noundef %n) #2 !dbg !852 {
entry:
  %n.addr = alloca i32, align 4
  %m = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !855, metadata !DIExpression()), !dbg !856
  call void @llvm.dbg.declare(metadata i32* %m, metadata !857, metadata !DIExpression()), !dbg !858
  %0 = load i32, i32* %n.addr, align 4, !dbg !859
  %cmp = icmp sge i32 %0, 0, !dbg !861
  br i1 %cmp, label %if.then, label %if.else, !dbg !862

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %n.addr, align 4, !dbg !863
  store i32 %1, i32* %m, align 4, !dbg !864
  br label %if.end, !dbg !865

if.else:                                          ; preds = %entry
  %2 = load i32, i32* %n.addr, align 4, !dbg !866
  %sub = sub nsw i32 0, %2, !dbg !867
  store i32 %sub, i32* %m, align 4, !dbg !868
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %3 = load i32, i32* %m, align 4, !dbg !869
  ret i32 %3, !dbg !870
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @filtez(i32* noundef %bpl, i32* noundef %dlt) #0 !dbg !871 {
entry:
  %bpl.addr = alloca i32*, align 8
  %dlt.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  %zl = alloca i64, align 8
  store i32* %bpl, i32** %bpl.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %bpl.addr, metadata !874, metadata !DIExpression()), !dbg !875
  store i32* %dlt, i32** %dlt.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %dlt.addr, metadata !876, metadata !DIExpression()), !dbg !877
  call void @llvm.dbg.declare(metadata i32* %i, metadata !878, metadata !DIExpression()), !dbg !879
  call void @llvm.dbg.declare(metadata i64* %zl, metadata !880, metadata !DIExpression()), !dbg !881
  %0 = load i32*, i32** %bpl.addr, align 8, !dbg !882
  %incdec.ptr = getelementptr inbounds i32, i32* %0, i32 1, !dbg !882
  store i32* %incdec.ptr, i32** %bpl.addr, align 8, !dbg !882
  %1 = load i32, i32* %0, align 4, !dbg !883
  %conv = sext i32 %1 to i64, !dbg !884
  %2 = load i32*, i32** %dlt.addr, align 8, !dbg !885
  %incdec.ptr1 = getelementptr inbounds i32, i32* %2, i32 1, !dbg !885
  store i32* %incdec.ptr1, i32** %dlt.addr, align 8, !dbg !885
  %3 = load i32, i32* %2, align 4, !dbg !886
  %conv2 = sext i32 %3 to i64, !dbg !887
  %mul = mul nsw i64 %conv, %conv2, !dbg !888
  store i64 %mul, i64* %zl, align 8, !dbg !889
  br label %filtez_label8, !dbg !890

filtez_label8:                                    ; preds = %entry
  call void @llvm.dbg.label(metadata !891), !dbg !892
  store i32 1, i32* %i, align 4, !dbg !893
  br label %for.cond, !dbg !895

for.cond:                                         ; preds = %for.inc, %filtez_label8
  %4 = load i32, i32* %i, align 4, !dbg !896
  %cmp = icmp slt i32 %4, 6, !dbg !898
  br i1 %cmp, label %for.body, label %for.end, !dbg !899

for.body:                                         ; preds = %for.cond
  %5 = load i32*, i32** %bpl.addr, align 8, !dbg !900
  %incdec.ptr4 = getelementptr inbounds i32, i32* %5, i32 1, !dbg !900
  store i32* %incdec.ptr4, i32** %bpl.addr, align 8, !dbg !900
  %6 = load i32, i32* %5, align 4, !dbg !902
  %conv5 = sext i32 %6 to i64, !dbg !903
  %7 = load i32*, i32** %dlt.addr, align 8, !dbg !904
  %incdec.ptr6 = getelementptr inbounds i32, i32* %7, i32 1, !dbg !904
  store i32* %incdec.ptr6, i32** %dlt.addr, align 8, !dbg !904
  %8 = load i32, i32* %7, align 4, !dbg !905
  %conv7 = sext i32 %8 to i64, !dbg !906
  %mul8 = mul nsw i64 %conv5, %conv7, !dbg !907
  %9 = load i64, i64* %zl, align 8, !dbg !908
  %add = add nsw i64 %9, %mul8, !dbg !908
  store i64 %add, i64* %zl, align 8, !dbg !908
  br label %for.inc, !dbg !909

for.inc:                                          ; preds = %for.body
  %10 = load i32, i32* %i, align 4, !dbg !910
  %inc = add nsw i32 %10, 1, !dbg !910
  store i32 %inc, i32* %i, align 4, !dbg !910
  br label %for.cond, !dbg !911, !llvm.loop !912

for.end:                                          ; preds = %for.cond
  %11 = load i64, i64* %zl, align 8, !dbg !914
  %shr = ashr i64 %11, 14, !dbg !915
  %conv9 = trunc i64 %shr to i32, !dbg !916
  ret i32 %conv9, !dbg !917
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @filtep(i32 noundef %rlt1, i32 noundef %al1, i32 noundef %rlt2, i32 noundef %al2) #0 !dbg !918 {
entry:
  %rlt1.addr = alloca i32, align 4
  %al1.addr = alloca i32, align 4
  %rlt2.addr = alloca i32, align 4
  %al2.addr = alloca i32, align 4
  %pl = alloca i64, align 8
  %pl2 = alloca i64, align 8
  store i32 %rlt1, i32* %rlt1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %rlt1.addr, metadata !921, metadata !DIExpression()), !dbg !922
  store i32 %al1, i32* %al1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %al1.addr, metadata !923, metadata !DIExpression()), !dbg !924
  store i32 %rlt2, i32* %rlt2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %rlt2.addr, metadata !925, metadata !DIExpression()), !dbg !926
  store i32 %al2, i32* %al2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %al2.addr, metadata !927, metadata !DIExpression()), !dbg !928
  call void @llvm.dbg.declare(metadata i64* %pl, metadata !929, metadata !DIExpression()), !dbg !930
  call void @llvm.dbg.declare(metadata i64* %pl2, metadata !931, metadata !DIExpression()), !dbg !932
  %0 = load i32, i32* %rlt1.addr, align 4, !dbg !933
  %mul = mul nsw i32 2, %0, !dbg !934
  %conv = sext i32 %mul to i64, !dbg !935
  store i64 %conv, i64* %pl, align 8, !dbg !936
  %1 = load i32, i32* %al1.addr, align 4, !dbg !937
  %conv1 = sext i32 %1 to i64, !dbg !938
  %2 = load i64, i64* %pl, align 8, !dbg !939
  %mul2 = mul nsw i64 %conv1, %2, !dbg !940
  store i64 %mul2, i64* %pl, align 8, !dbg !941
  %3 = load i32, i32* %rlt2.addr, align 4, !dbg !942
  %mul3 = mul nsw i32 2, %3, !dbg !943
  %conv4 = sext i32 %mul3 to i64, !dbg !944
  store i64 %conv4, i64* %pl2, align 8, !dbg !945
  %4 = load i32, i32* %al2.addr, align 4, !dbg !946
  %conv5 = sext i32 %4 to i64, !dbg !947
  %5 = load i64, i64* %pl2, align 8, !dbg !948
  %mul6 = mul nsw i64 %conv5, %5, !dbg !949
  %6 = load i64, i64* %pl, align 8, !dbg !950
  %add = add nsw i64 %6, %mul6, !dbg !950
  store i64 %add, i64* %pl, align 8, !dbg !950
  %7 = load i64, i64* %pl, align 8, !dbg !951
  %shr = ashr i64 %7, 15, !dbg !952
  %conv7 = trunc i64 %shr to i32, !dbg !953
  ret i32 %conv7, !dbg !954
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @quantl(i32 noundef %el, i32 noundef %detl) #0 !dbg !955 {
entry:
  %el.addr = alloca i32, align 4
  %detl.addr = alloca i32, align 4
  %ril = alloca i32, align 4
  %mil = alloca i32, align 4
  %wd = alloca i64, align 8
  %decis = alloca i64, align 8
  store i32 %el, i32* %el.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %el.addr, metadata !956, metadata !DIExpression()), !dbg !957
  store i32 %detl, i32* %detl.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %detl.addr, metadata !958, metadata !DIExpression()), !dbg !959
  call void @llvm.dbg.declare(metadata i32* %ril, metadata !960, metadata !DIExpression()), !dbg !961
  call void @llvm.dbg.declare(metadata i32* %mil, metadata !962, metadata !DIExpression()), !dbg !963
  call void @llvm.dbg.declare(metadata i64* %wd, metadata !964, metadata !DIExpression()), !dbg !965
  call void @llvm.dbg.declare(metadata i64* %decis, metadata !966, metadata !DIExpression()), !dbg !967
  %0 = load i32, i32* %el.addr, align 4, !dbg !968
  %call = call i32 @abs(i32 noundef %0) #3, !dbg !969
  %conv = sext i32 %call to i64, !dbg !969
  store i64 %conv, i64* %wd, align 8, !dbg !970
  br label %quantl_label9, !dbg !971

quantl_label9:                                    ; preds = %entry
  call void @llvm.dbg.label(metadata !972), !dbg !973
  store i32 0, i32* %mil, align 4, !dbg !974
  br label %for.cond, !dbg !976

for.cond:                                         ; preds = %for.inc, %quantl_label9
  %1 = load i32, i32* %mil, align 4, !dbg !977
  %cmp = icmp slt i32 %1, 30, !dbg !979
  br i1 %cmp, label %for.body, label %for.end, !dbg !980

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %mil, align 4, !dbg !981
  %idxprom = sext i32 %2 to i64, !dbg !983
  %arrayidx = getelementptr inbounds [30 x i32], [30 x i32]* @decis_levl, i64 0, i64 %idxprom, !dbg !983
  %3 = load i32, i32* %arrayidx, align 4, !dbg !983
  %conv2 = sext i32 %3 to i64, !dbg !983
  %4 = load i32, i32* %detl.addr, align 4, !dbg !984
  %conv3 = sext i32 %4 to i64, !dbg !985
  %mul = mul nsw i64 %conv2, %conv3, !dbg !986
  %shr = ashr i64 %mul, 15, !dbg !987
  store i64 %shr, i64* %decis, align 8, !dbg !988
  %5 = load i64, i64* %wd, align 8, !dbg !989
  %6 = load i64, i64* %decis, align 8, !dbg !991
  %cmp4 = icmp sle i64 %5, %6, !dbg !992
  br i1 %cmp4, label %if.then, label %if.end, !dbg !993

if.then:                                          ; preds = %for.body
  br label %for.end, !dbg !994

if.end:                                           ; preds = %for.body
  br label %for.inc, !dbg !995

for.inc:                                          ; preds = %if.end
  %7 = load i32, i32* %mil, align 4, !dbg !996
  %inc = add nsw i32 %7, 1, !dbg !996
  store i32 %inc, i32* %mil, align 4, !dbg !996
  br label %for.cond, !dbg !997, !llvm.loop !998

for.end:                                          ; preds = %if.then, %for.cond
  %8 = load i32, i32* %el.addr, align 4, !dbg !1000
  %cmp6 = icmp sge i32 %8, 0, !dbg !1002
  br i1 %cmp6, label %if.then8, label %if.else, !dbg !1003

if.then8:                                         ; preds = %for.end
  %9 = load i32, i32* %mil, align 4, !dbg !1004
  %idxprom9 = sext i32 %9 to i64, !dbg !1005
  %arrayidx10 = getelementptr inbounds [31 x i32], [31 x i32]* @quant26bt_pos, i64 0, i64 %idxprom9, !dbg !1005
  %10 = load i32, i32* %arrayidx10, align 4, !dbg !1005
  store i32 %10, i32* %ril, align 4, !dbg !1006
  br label %if.end13, !dbg !1007

if.else:                                          ; preds = %for.end
  %11 = load i32, i32* %mil, align 4, !dbg !1008
  %idxprom11 = sext i32 %11 to i64, !dbg !1009
  %arrayidx12 = getelementptr inbounds [31 x i32], [31 x i32]* @quant26bt_neg, i64 0, i64 %idxprom11, !dbg !1009
  %12 = load i32, i32* %arrayidx12, align 4, !dbg !1009
  store i32 %12, i32* %ril, align 4, !dbg !1010
  br label %if.end13

if.end13:                                         ; preds = %if.else, %if.then8
  %13 = load i32, i32* %ril, align 4, !dbg !1011
  ret i32 %13, !dbg !1012
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @logscl(i32 noundef %il, i32 noundef %nbl) #0 !dbg !1013 {
entry:
  %il.addr = alloca i32, align 4
  %nbl.addr = alloca i32, align 4
  %wd = alloca i64, align 8
  store i32 %il, i32* %il.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %il.addr, metadata !1014, metadata !DIExpression()), !dbg !1015
  store i32 %nbl, i32* %nbl.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nbl.addr, metadata !1016, metadata !DIExpression()), !dbg !1017
  call void @llvm.dbg.declare(metadata i64* %wd, metadata !1018, metadata !DIExpression()), !dbg !1019
  %0 = load i32, i32* %nbl.addr, align 4, !dbg !1020
  %conv = sext i32 %0 to i64, !dbg !1021
  %mul = mul nsw i64 %conv, 127, !dbg !1022
  %shr = ashr i64 %mul, 7, !dbg !1023
  store i64 %shr, i64* %wd, align 8, !dbg !1024
  %1 = load i64, i64* %wd, align 8, !dbg !1025
  %conv1 = trunc i64 %1 to i32, !dbg !1026
  %2 = load i32, i32* %il.addr, align 4, !dbg !1027
  %shr2 = ashr i32 %2, 2, !dbg !1028
  %idxprom = sext i32 %shr2 to i64, !dbg !1029
  %arrayidx = getelementptr inbounds [16 x i32], [16 x i32]* @wl_code_table, i64 0, i64 %idxprom, !dbg !1029
  %3 = load i32, i32* %arrayidx, align 4, !dbg !1029
  %add = add nsw i32 %conv1, %3, !dbg !1030
  store i32 %add, i32* %nbl.addr, align 4, !dbg !1031
  %4 = load i32, i32* %nbl.addr, align 4, !dbg !1032
  %cmp = icmp slt i32 %4, 0, !dbg !1034
  br i1 %cmp, label %if.then, label %if.end, !dbg !1035

if.then:                                          ; preds = %entry
  store i32 0, i32* %nbl.addr, align 4, !dbg !1036
  br label %if.end, !dbg !1037

if.end:                                           ; preds = %if.then, %entry
  %5 = load i32, i32* %nbl.addr, align 4, !dbg !1038
  %cmp4 = icmp sgt i32 %5, 18432, !dbg !1040
  br i1 %cmp4, label %if.then6, label %if.end7, !dbg !1041

if.then6:                                         ; preds = %if.end
  store i32 18432, i32* %nbl.addr, align 4, !dbg !1042
  br label %if.end7, !dbg !1043

if.end7:                                          ; preds = %if.then6, %if.end
  %6 = load i32, i32* %nbl.addr, align 4, !dbg !1044
  ret i32 %6, !dbg !1045
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @scalel(i32 noundef %nbl, i32 noundef %shift_constant) #0 !dbg !1046 {
entry:
  %nbl.addr = alloca i32, align 4
  %shift_constant.addr = alloca i32, align 4
  %wd1 = alloca i32, align 4
  %wd2 = alloca i32, align 4
  %wd3 = alloca i32, align 4
  store i32 %nbl, i32* %nbl.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nbl.addr, metadata !1047, metadata !DIExpression()), !dbg !1048
  store i32 %shift_constant, i32* %shift_constant.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %shift_constant.addr, metadata !1049, metadata !DIExpression()), !dbg !1050
  call void @llvm.dbg.declare(metadata i32* %wd1, metadata !1051, metadata !DIExpression()), !dbg !1052
  call void @llvm.dbg.declare(metadata i32* %wd2, metadata !1053, metadata !DIExpression()), !dbg !1054
  call void @llvm.dbg.declare(metadata i32* %wd3, metadata !1055, metadata !DIExpression()), !dbg !1056
  %0 = load i32, i32* %nbl.addr, align 4, !dbg !1057
  %shr = ashr i32 %0, 6, !dbg !1058
  %and = and i32 %shr, 31, !dbg !1059
  store i32 %and, i32* %wd1, align 4, !dbg !1060
  %1 = load i32, i32* %nbl.addr, align 4, !dbg !1061
  %shr1 = ashr i32 %1, 11, !dbg !1062
  store i32 %shr1, i32* %wd2, align 4, !dbg !1063
  %2 = load i32, i32* %wd1, align 4, !dbg !1064
  %idxprom = sext i32 %2 to i64, !dbg !1065
  %arrayidx = getelementptr inbounds [32 x i32], [32 x i32]* @ilb_table, i64 0, i64 %idxprom, !dbg !1065
  %3 = load i32, i32* %arrayidx, align 4, !dbg !1065
  %4 = load i32, i32* %shift_constant.addr, align 4, !dbg !1066
  %add = add nsw i32 %4, 1, !dbg !1067
  %5 = load i32, i32* %wd2, align 4, !dbg !1068
  %sub = sub nsw i32 %add, %5, !dbg !1069
  %shr2 = ashr i32 %3, %sub, !dbg !1070
  store i32 %shr2, i32* %wd3, align 4, !dbg !1071
  %6 = load i32, i32* %wd3, align 4, !dbg !1072
  %shl = shl i32 %6, 3, !dbg !1073
  ret i32 %shl, !dbg !1074
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @upzero(i32 noundef %dlt, i32* noundef %dlti, i32* noundef %bli) #0 !dbg !1075 {
entry:
  %dlt.addr = alloca i32, align 4
  %dlti.addr = alloca i32*, align 8
  %bli.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  %wd2 = alloca i32, align 4
  %wd3 = alloca i32, align 4
  store i32 %dlt, i32* %dlt.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %dlt.addr, metadata !1078, metadata !DIExpression()), !dbg !1079
  store i32* %dlti, i32** %dlti.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %dlti.addr, metadata !1080, metadata !DIExpression()), !dbg !1081
  store i32* %bli, i32** %bli.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %bli.addr, metadata !1082, metadata !DIExpression()), !dbg !1083
  call void @llvm.dbg.declare(metadata i32* %i, metadata !1084, metadata !DIExpression()), !dbg !1085
  call void @llvm.dbg.declare(metadata i32* %wd2, metadata !1086, metadata !DIExpression()), !dbg !1087
  call void @llvm.dbg.declare(metadata i32* %wd3, metadata !1088, metadata !DIExpression()), !dbg !1089
  %0 = load i32, i32* %dlt.addr, align 4, !dbg !1090
  %cmp = icmp eq i32 %0, 0, !dbg !1092
  br i1 %cmp, label %if.then, label %if.else, !dbg !1093

if.then:                                          ; preds = %entry
  br label %upzero_label10, !dbg !1094

upzero_label10:                                   ; preds = %if.then
  call void @llvm.dbg.label(metadata !1095), !dbg !1097
  store i32 0, i32* %i, align 4, !dbg !1098
  br label %for.cond, !dbg !1100

for.cond:                                         ; preds = %for.inc, %upzero_label10
  %1 = load i32, i32* %i, align 4, !dbg !1101
  %cmp1 = icmp slt i32 %1, 6, !dbg !1103
  br i1 %cmp1, label %for.body, label %for.end, !dbg !1104

for.body:                                         ; preds = %for.cond
  %2 = load i32*, i32** %bli.addr, align 8, !dbg !1105
  %3 = load i32, i32* %i, align 4, !dbg !1107
  %idxprom = sext i32 %3 to i64, !dbg !1105
  %arrayidx = getelementptr inbounds i32, i32* %2, i64 %idxprom, !dbg !1105
  %4 = load i32, i32* %arrayidx, align 4, !dbg !1105
  %conv = sext i32 %4 to i64, !dbg !1105
  %mul = mul nsw i64 255, %conv, !dbg !1108
  %shr = ashr i64 %mul, 8, !dbg !1109
  %conv2 = trunc i64 %shr to i32, !dbg !1110
  %5 = load i32*, i32** %bli.addr, align 8, !dbg !1111
  %6 = load i32, i32* %i, align 4, !dbg !1112
  %idxprom3 = sext i32 %6 to i64, !dbg !1111
  %arrayidx4 = getelementptr inbounds i32, i32* %5, i64 %idxprom3, !dbg !1111
  store i32 %conv2, i32* %arrayidx4, align 4, !dbg !1113
  br label %for.inc, !dbg !1114

for.inc:                                          ; preds = %for.body
  %7 = load i32, i32* %i, align 4, !dbg !1115
  %inc = add nsw i32 %7, 1, !dbg !1115
  store i32 %inc, i32* %i, align 4, !dbg !1115
  br label %for.cond, !dbg !1116, !llvm.loop !1117

for.end:                                          ; preds = %for.cond
  br label %if.end29, !dbg !1119

if.else:                                          ; preds = %entry
  br label %upzero_label11, !dbg !1120

upzero_label11:                                   ; preds = %if.else
  call void @llvm.dbg.label(metadata !1121), !dbg !1123
  store i32 0, i32* %i, align 4, !dbg !1124
  br label %for.cond5, !dbg !1126

for.cond5:                                        ; preds = %for.inc26, %upzero_label11
  %8 = load i32, i32* %i, align 4, !dbg !1127
  %cmp6 = icmp slt i32 %8, 6, !dbg !1129
  br i1 %cmp6, label %for.body8, label %for.end28, !dbg !1130

for.body8:                                        ; preds = %for.cond5
  %9 = load i32, i32* %dlt.addr, align 4, !dbg !1131
  %conv9 = sext i32 %9 to i64, !dbg !1134
  %10 = load i32*, i32** %dlti.addr, align 8, !dbg !1135
  %11 = load i32, i32* %i, align 4, !dbg !1136
  %idxprom10 = sext i32 %11 to i64, !dbg !1135
  %arrayidx11 = getelementptr inbounds i32, i32* %10, i64 %idxprom10, !dbg !1135
  %12 = load i32, i32* %arrayidx11, align 4, !dbg !1135
  %conv12 = sext i32 %12 to i64, !dbg !1135
  %mul13 = mul nsw i64 %conv9, %conv12, !dbg !1137
  %cmp14 = icmp sge i64 %mul13, 0, !dbg !1138
  br i1 %cmp14, label %if.then16, label %if.else17, !dbg !1139

if.then16:                                        ; preds = %for.body8
  store i32 128, i32* %wd2, align 4, !dbg !1140
  br label %if.end, !dbg !1141

if.else17:                                        ; preds = %for.body8
  store i32 -128, i32* %wd2, align 4, !dbg !1142
  br label %if.end

if.end:                                           ; preds = %if.else17, %if.then16
  %13 = load i32*, i32** %bli.addr, align 8, !dbg !1143
  %14 = load i32, i32* %i, align 4, !dbg !1144
  %idxprom18 = sext i32 %14 to i64, !dbg !1143
  %arrayidx19 = getelementptr inbounds i32, i32* %13, i64 %idxprom18, !dbg !1143
  %15 = load i32, i32* %arrayidx19, align 4, !dbg !1143
  %conv20 = sext i32 %15 to i64, !dbg !1143
  %mul21 = mul nsw i64 255, %conv20, !dbg !1145
  %shr22 = ashr i64 %mul21, 8, !dbg !1146
  %conv23 = trunc i64 %shr22 to i32, !dbg !1147
  store i32 %conv23, i32* %wd3, align 4, !dbg !1148
  %16 = load i32, i32* %wd2, align 4, !dbg !1149
  %17 = load i32, i32* %wd3, align 4, !dbg !1150
  %add = add nsw i32 %16, %17, !dbg !1151
  %18 = load i32*, i32** %bli.addr, align 8, !dbg !1152
  %19 = load i32, i32* %i, align 4, !dbg !1153
  %idxprom24 = sext i32 %19 to i64, !dbg !1152
  %arrayidx25 = getelementptr inbounds i32, i32* %18, i64 %idxprom24, !dbg !1152
  store i32 %add, i32* %arrayidx25, align 4, !dbg !1154
  br label %for.inc26, !dbg !1155

for.inc26:                                        ; preds = %if.end
  %20 = load i32, i32* %i, align 4, !dbg !1156
  %inc27 = add nsw i32 %20, 1, !dbg !1156
  store i32 %inc27, i32* %i, align 4, !dbg !1156
  br label %for.cond5, !dbg !1157, !llvm.loop !1158

for.end28:                                        ; preds = %for.cond5
  br label %if.end29

if.end29:                                         ; preds = %for.end28, %for.end
  %21 = load i32*, i32** %dlti.addr, align 8, !dbg !1160
  %arrayidx30 = getelementptr inbounds i32, i32* %21, i64 4, !dbg !1160
  %22 = load i32, i32* %arrayidx30, align 4, !dbg !1160
  %23 = load i32*, i32** %dlti.addr, align 8, !dbg !1161
  %arrayidx31 = getelementptr inbounds i32, i32* %23, i64 5, !dbg !1161
  store i32 %22, i32* %arrayidx31, align 4, !dbg !1162
  %24 = load i32*, i32** %dlti.addr, align 8, !dbg !1163
  %arrayidx32 = getelementptr inbounds i32, i32* %24, i64 3, !dbg !1163
  %25 = load i32, i32* %arrayidx32, align 4, !dbg !1163
  %26 = load i32*, i32** %dlti.addr, align 8, !dbg !1164
  %arrayidx33 = getelementptr inbounds i32, i32* %26, i64 4, !dbg !1164
  store i32 %25, i32* %arrayidx33, align 4, !dbg !1165
  %27 = load i32*, i32** %dlti.addr, align 8, !dbg !1166
  %arrayidx34 = getelementptr inbounds i32, i32* %27, i64 2, !dbg !1166
  %28 = load i32, i32* %arrayidx34, align 4, !dbg !1166
  %29 = load i32*, i32** %dlti.addr, align 8, !dbg !1167
  %arrayidx35 = getelementptr inbounds i32, i32* %29, i64 3, !dbg !1167
  store i32 %28, i32* %arrayidx35, align 4, !dbg !1168
  %30 = load i32*, i32** %dlti.addr, align 8, !dbg !1169
  %arrayidx36 = getelementptr inbounds i32, i32* %30, i64 1, !dbg !1169
  %31 = load i32, i32* %arrayidx36, align 4, !dbg !1169
  %32 = load i32*, i32** %dlti.addr, align 8, !dbg !1170
  %arrayidx37 = getelementptr inbounds i32, i32* %32, i64 2, !dbg !1170
  store i32 %31, i32* %arrayidx37, align 4, !dbg !1171
  %33 = load i32*, i32** %dlti.addr, align 8, !dbg !1172
  %arrayidx38 = getelementptr inbounds i32, i32* %33, i64 0, !dbg !1172
  %34 = load i32, i32* %arrayidx38, align 4, !dbg !1172
  %35 = load i32*, i32** %dlti.addr, align 8, !dbg !1173
  %arrayidx39 = getelementptr inbounds i32, i32* %35, i64 1, !dbg !1173
  store i32 %34, i32* %arrayidx39, align 4, !dbg !1174
  %36 = load i32, i32* %dlt.addr, align 4, !dbg !1175
  %37 = load i32*, i32** %dlti.addr, align 8, !dbg !1176
  %arrayidx40 = getelementptr inbounds i32, i32* %37, i64 0, !dbg !1176
  store i32 %36, i32* %arrayidx40, align 4, !dbg !1177
  ret void, !dbg !1178
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @uppol2(i32 noundef %al1, i32 noundef %al2, i32 noundef %plt, i32 noundef %plt1, i32 noundef %plt2) #0 !dbg !1179 {
entry:
  %al1.addr = alloca i32, align 4
  %al2.addr = alloca i32, align 4
  %plt.addr = alloca i32, align 4
  %plt1.addr = alloca i32, align 4
  %plt2.addr = alloca i32, align 4
  %wd2 = alloca i64, align 8
  %wd4 = alloca i64, align 8
  %apl2 = alloca i32, align 4
  store i32 %al1, i32* %al1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %al1.addr, metadata !1182, metadata !DIExpression()), !dbg !1183
  store i32 %al2, i32* %al2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %al2.addr, metadata !1184, metadata !DIExpression()), !dbg !1185
  store i32 %plt, i32* %plt.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %plt.addr, metadata !1186, metadata !DIExpression()), !dbg !1187
  store i32 %plt1, i32* %plt1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %plt1.addr, metadata !1188, metadata !DIExpression()), !dbg !1189
  store i32 %plt2, i32* %plt2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %plt2.addr, metadata !1190, metadata !DIExpression()), !dbg !1191
  call void @llvm.dbg.declare(metadata i64* %wd2, metadata !1192, metadata !DIExpression()), !dbg !1193
  call void @llvm.dbg.declare(metadata i64* %wd4, metadata !1194, metadata !DIExpression()), !dbg !1195
  call void @llvm.dbg.declare(metadata i32* %apl2, metadata !1196, metadata !DIExpression()), !dbg !1197
  %0 = load i32, i32* %al1.addr, align 4, !dbg !1198
  %conv = sext i32 %0 to i64, !dbg !1199
  %mul = mul nsw i64 4, %conv, !dbg !1200
  store i64 %mul, i64* %wd2, align 8, !dbg !1201
  %1 = load i32, i32* %plt.addr, align 4, !dbg !1202
  %conv1 = sext i32 %1 to i64, !dbg !1204
  %2 = load i32, i32* %plt1.addr, align 4, !dbg !1205
  %conv2 = sext i32 %2 to i64, !dbg !1205
  %mul3 = mul nsw i64 %conv1, %conv2, !dbg !1206
  %cmp = icmp sge i64 %mul3, 0, !dbg !1207
  br i1 %cmp, label %if.then, label %if.end, !dbg !1208

if.then:                                          ; preds = %entry
  %3 = load i64, i64* %wd2, align 8, !dbg !1209
  %sub = sub nsw i64 0, %3, !dbg !1210
  store i64 %sub, i64* %wd2, align 8, !dbg !1211
  br label %if.end, !dbg !1212

if.end:                                           ; preds = %if.then, %entry
  %4 = load i64, i64* %wd2, align 8, !dbg !1213
  %shr = ashr i64 %4, 7, !dbg !1214
  store i64 %shr, i64* %wd2, align 8, !dbg !1215
  %5 = load i32, i32* %plt.addr, align 4, !dbg !1216
  %conv5 = sext i32 %5 to i64, !dbg !1218
  %6 = load i32, i32* %plt2.addr, align 4, !dbg !1219
  %conv6 = sext i32 %6 to i64, !dbg !1219
  %mul7 = mul nsw i64 %conv5, %conv6, !dbg !1220
  %cmp8 = icmp sge i64 %mul7, 0, !dbg !1221
  br i1 %cmp8, label %if.then10, label %if.else, !dbg !1222

if.then10:                                        ; preds = %if.end
  %7 = load i64, i64* %wd2, align 8, !dbg !1223
  %add = add nsw i64 %7, 128, !dbg !1225
  store i64 %add, i64* %wd4, align 8, !dbg !1226
  br label %if.end12, !dbg !1227

if.else:                                          ; preds = %if.end
  %8 = load i64, i64* %wd2, align 8, !dbg !1228
  %sub11 = sub nsw i64 %8, 128, !dbg !1230
  store i64 %sub11, i64* %wd4, align 8, !dbg !1231
  br label %if.end12

if.end12:                                         ; preds = %if.else, %if.then10
  %9 = load i64, i64* %wd4, align 8, !dbg !1232
  %10 = load i32, i32* %al2.addr, align 4, !dbg !1233
  %conv13 = sext i32 %10 to i64, !dbg !1234
  %mul14 = mul nsw i64 127, %conv13, !dbg !1235
  %shr15 = ashr i64 %mul14, 7, !dbg !1236
  %add16 = add nsw i64 %9, %shr15, !dbg !1237
  %conv17 = trunc i64 %add16 to i32, !dbg !1232
  store i32 %conv17, i32* %apl2, align 4, !dbg !1238
  %11 = load i32, i32* %apl2, align 4, !dbg !1239
  %cmp18 = icmp sgt i32 %11, 12288, !dbg !1241
  br i1 %cmp18, label %if.then20, label %if.end21, !dbg !1242

if.then20:                                        ; preds = %if.end12
  store i32 12288, i32* %apl2, align 4, !dbg !1243
  br label %if.end21, !dbg !1244

if.end21:                                         ; preds = %if.then20, %if.end12
  %12 = load i32, i32* %apl2, align 4, !dbg !1245
  %cmp22 = icmp slt i32 %12, -12288, !dbg !1247
  br i1 %cmp22, label %if.then24, label %if.end25, !dbg !1248

if.then24:                                        ; preds = %if.end21
  store i32 -12288, i32* %apl2, align 4, !dbg !1249
  br label %if.end25, !dbg !1250

if.end25:                                         ; preds = %if.then24, %if.end21
  %13 = load i32, i32* %apl2, align 4, !dbg !1251
  ret i32 %13, !dbg !1252
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @uppol1(i32 noundef %al1, i32 noundef %apl2, i32 noundef %plt, i32 noundef %plt1) #0 !dbg !1253 {
entry:
  %al1.addr = alloca i32, align 4
  %apl2.addr = alloca i32, align 4
  %plt.addr = alloca i32, align 4
  %plt1.addr = alloca i32, align 4
  %wd2 = alloca i64, align 8
  %wd3 = alloca i32, align 4
  %apl1 = alloca i32, align 4
  store i32 %al1, i32* %al1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %al1.addr, metadata !1254, metadata !DIExpression()), !dbg !1255
  store i32 %apl2, i32* %apl2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %apl2.addr, metadata !1256, metadata !DIExpression()), !dbg !1257
  store i32 %plt, i32* %plt.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %plt.addr, metadata !1258, metadata !DIExpression()), !dbg !1259
  store i32 %plt1, i32* %plt1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %plt1.addr, metadata !1260, metadata !DIExpression()), !dbg !1261
  call void @llvm.dbg.declare(metadata i64* %wd2, metadata !1262, metadata !DIExpression()), !dbg !1263
  call void @llvm.dbg.declare(metadata i32* %wd3, metadata !1264, metadata !DIExpression()), !dbg !1265
  call void @llvm.dbg.declare(metadata i32* %apl1, metadata !1266, metadata !DIExpression()), !dbg !1267
  %0 = load i32, i32* %al1.addr, align 4, !dbg !1268
  %conv = sext i32 %0 to i64, !dbg !1269
  %mul = mul nsw i64 %conv, 255, !dbg !1270
  %shr = ashr i64 %mul, 8, !dbg !1271
  store i64 %shr, i64* %wd2, align 8, !dbg !1272
  %1 = load i32, i32* %plt.addr, align 4, !dbg !1273
  %conv1 = sext i32 %1 to i64, !dbg !1275
  %2 = load i32, i32* %plt1.addr, align 4, !dbg !1276
  %conv2 = sext i32 %2 to i64, !dbg !1276
  %mul3 = mul nsw i64 %conv1, %conv2, !dbg !1277
  %cmp = icmp sge i64 %mul3, 0, !dbg !1278
  br i1 %cmp, label %if.then, label %if.else, !dbg !1279

if.then:                                          ; preds = %entry
  %3 = load i64, i64* %wd2, align 8, !dbg !1280
  %conv5 = trunc i64 %3 to i32, !dbg !1282
  %add = add nsw i32 %conv5, 192, !dbg !1283
  store i32 %add, i32* %apl1, align 4, !dbg !1284
  br label %if.end, !dbg !1285

if.else:                                          ; preds = %entry
  %4 = load i64, i64* %wd2, align 8, !dbg !1286
  %conv6 = trunc i64 %4 to i32, !dbg !1288
  %sub = sub nsw i32 %conv6, 192, !dbg !1289
  store i32 %sub, i32* %apl1, align 4, !dbg !1290
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %5 = load i32, i32* %apl2.addr, align 4, !dbg !1291
  %sub7 = sub nsw i32 15360, %5, !dbg !1292
  store i32 %sub7, i32* %wd3, align 4, !dbg !1293
  %6 = load i32, i32* %apl1, align 4, !dbg !1294
  %7 = load i32, i32* %wd3, align 4, !dbg !1296
  %cmp8 = icmp sgt i32 %6, %7, !dbg !1297
  br i1 %cmp8, label %if.then10, label %if.end11, !dbg !1298

if.then10:                                        ; preds = %if.end
  %8 = load i32, i32* %wd3, align 4, !dbg !1299
  store i32 %8, i32* %apl1, align 4, !dbg !1300
  br label %if.end11, !dbg !1301

if.end11:                                         ; preds = %if.then10, %if.end
  %9 = load i32, i32* %apl1, align 4, !dbg !1302
  %10 = load i32, i32* %wd3, align 4, !dbg !1304
  %sub12 = sub nsw i32 0, %10, !dbg !1305
  %cmp13 = icmp slt i32 %9, %sub12, !dbg !1306
  br i1 %cmp13, label %if.then15, label %if.end17, !dbg !1307

if.then15:                                        ; preds = %if.end11
  %11 = load i32, i32* %wd3, align 4, !dbg !1308
  %sub16 = sub nsw i32 0, %11, !dbg !1309
  store i32 %sub16, i32* %apl1, align 4, !dbg !1310
  br label %if.end17, !dbg !1311

if.end17:                                         ; preds = %if.then15, %if.end11
  %12 = load i32, i32* %apl1, align 4, !dbg !1312
  ret i32 %12, !dbg !1313
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @logsch(i32 noundef %ih, i32 noundef %nbh) #0 !dbg !1314 {
entry:
  %ih.addr = alloca i32, align 4
  %nbh.addr = alloca i32, align 4
  %wd = alloca i32, align 4
  store i32 %ih, i32* %ih.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %ih.addr, metadata !1315, metadata !DIExpression()), !dbg !1316
  store i32 %nbh, i32* %nbh.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %nbh.addr, metadata !1317, metadata !DIExpression()), !dbg !1318
  call void @llvm.dbg.declare(metadata i32* %wd, metadata !1319, metadata !DIExpression()), !dbg !1320
  %0 = load i32, i32* %nbh.addr, align 4, !dbg !1321
  %conv = sext i32 %0 to i64, !dbg !1322
  %mul = mul nsw i64 %conv, 127, !dbg !1323
  %shr = ashr i64 %mul, 7, !dbg !1324
  %conv1 = trunc i64 %shr to i32, !dbg !1325
  store i32 %conv1, i32* %wd, align 4, !dbg !1326
  %1 = load i32, i32* %wd, align 4, !dbg !1327
  %2 = load i32, i32* %ih.addr, align 4, !dbg !1328
  %idxprom = sext i32 %2 to i64, !dbg !1329
  %arrayidx = getelementptr inbounds [4 x i32], [4 x i32]* @wh_code_table, i64 0, i64 %idxprom, !dbg !1329
  %3 = load i32, i32* %arrayidx, align 4, !dbg !1329
  %add = add nsw i32 %1, %3, !dbg !1330
  store i32 %add, i32* %nbh.addr, align 4, !dbg !1331
  %4 = load i32, i32* %nbh.addr, align 4, !dbg !1332
  %cmp = icmp slt i32 %4, 0, !dbg !1334
  br i1 %cmp, label %if.then, label %if.end, !dbg !1335

if.then:                                          ; preds = %entry
  store i32 0, i32* %nbh.addr, align 4, !dbg !1336
  br label %if.end, !dbg !1337

if.end:                                           ; preds = %if.then, %entry
  %5 = load i32, i32* %nbh.addr, align 4, !dbg !1338
  %cmp3 = icmp sgt i32 %5, 22528, !dbg !1340
  br i1 %cmp3, label %if.then5, label %if.end6, !dbg !1341

if.then5:                                         ; preds = %if.end
  store i32 22528, i32* %nbh.addr, align 4, !dbg !1342
  br label %if.end6, !dbg !1343

if.end6:                                          ; preds = %if.then5, %if.end
  %6 = load i32, i32* %nbh.addr, align 4, !dbg !1344
  ret i32 %6, !dbg !1345
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reset() #0 !dbg !1346 {
entry:
  %i = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !1349, metadata !DIExpression()), !dbg !1350
  store i32 32, i32* @dec_detl, align 4, !dbg !1351
  store i32 32, i32* @detl, align 4, !dbg !1352
  store i32 8, i32* @dec_deth, align 4, !dbg !1353
  store i32 8, i32* @deth, align 4, !dbg !1354
  store i32 0, i32* @rlt2, align 4, !dbg !1355
  store i32 0, i32* @rlt1, align 4, !dbg !1356
  store i32 0, i32* @plt2, align 4, !dbg !1357
  store i32 0, i32* @plt1, align 4, !dbg !1358
  store i32 0, i32* @al2, align 4, !dbg !1359
  store i32 0, i32* @al1, align 4, !dbg !1360
  store i32 0, i32* @nbl, align 4, !dbg !1361
  store i32 0, i32* @rh2, align 4, !dbg !1362
  store i32 0, i32* @rh1, align 4, !dbg !1363
  store i32 0, i32* @ph2, align 4, !dbg !1364
  store i32 0, i32* @ph1, align 4, !dbg !1365
  store i32 0, i32* @ah2, align 4, !dbg !1366
  store i32 0, i32* @ah1, align 4, !dbg !1367
  store i32 0, i32* @nbh, align 4, !dbg !1368
  store i32 0, i32* @dec_rlt2, align 4, !dbg !1369
  store i32 0, i32* @dec_rlt1, align 4, !dbg !1370
  store i32 0, i32* @dec_plt2, align 4, !dbg !1371
  store i32 0, i32* @dec_plt1, align 4, !dbg !1372
  store i32 0, i32* @dec_al2, align 4, !dbg !1373
  store i32 0, i32* @dec_al1, align 4, !dbg !1374
  store i32 0, i32* @dec_nbl, align 4, !dbg !1375
  store i32 0, i32* @dec_rh2, align 4, !dbg !1376
  store i32 0, i32* @dec_rh1, align 4, !dbg !1377
  store i32 0, i32* @dec_ph2, align 4, !dbg !1378
  store i32 0, i32* @dec_ph1, align 4, !dbg !1379
  store i32 0, i32* @dec_ah2, align 4, !dbg !1380
  store i32 0, i32* @dec_ah1, align 4, !dbg !1381
  store i32 0, i32* @dec_nbh, align 4, !dbg !1382
  br label %reset_label4, !dbg !1383

reset_label4:                                     ; preds = %entry
  call void @llvm.dbg.label(metadata !1384), !dbg !1385
  store i32 0, i32* %i, align 4, !dbg !1386
  br label %for.cond, !dbg !1388

for.cond:                                         ; preds = %for.inc, %reset_label4
  %0 = load i32, i32* %i, align 4, !dbg !1389
  %cmp = icmp slt i32 %0, 6, !dbg !1391
  br i1 %cmp, label %for.body, label %for.end, !dbg !1392

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4, !dbg !1393
  %idxprom = sext i32 %1 to i64, !dbg !1395
  %arrayidx = getelementptr inbounds [6 x i32], [6 x i32]* @delay_dltx, i64 0, i64 %idxprom, !dbg !1395
  store i32 0, i32* %arrayidx, align 4, !dbg !1396
  %2 = load i32, i32* %i, align 4, !dbg !1397
  %idxprom1 = sext i32 %2 to i64, !dbg !1398
  %arrayidx2 = getelementptr inbounds [6 x i32], [6 x i32]* @delay_dhx, i64 0, i64 %idxprom1, !dbg !1398
  store i32 0, i32* %arrayidx2, align 4, !dbg !1399
  %3 = load i32, i32* %i, align 4, !dbg !1400
  %idxprom3 = sext i32 %3 to i64, !dbg !1401
  %arrayidx4 = getelementptr inbounds [6 x i32], [6 x i32]* @dec_del_dltx, i64 0, i64 %idxprom3, !dbg !1401
  store i32 0, i32* %arrayidx4, align 4, !dbg !1402
  %4 = load i32, i32* %i, align 4, !dbg !1403
  %idxprom5 = sext i32 %4 to i64, !dbg !1404
  %arrayidx6 = getelementptr inbounds [6 x i32], [6 x i32]* @dec_del_dhx, i64 0, i64 %idxprom5, !dbg !1404
  store i32 0, i32* %arrayidx6, align 4, !dbg !1405
  br label %for.inc, !dbg !1406

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4, !dbg !1407
  %inc = add nsw i32 %5, 1, !dbg !1407
  store i32 %inc, i32* %i, align 4, !dbg !1407
  br label %for.cond, !dbg !1408, !llvm.loop !1409

for.end:                                          ; preds = %for.cond
  br label %reset_label5, !dbg !1410

reset_label5:                                     ; preds = %for.end
  call void @llvm.dbg.label(metadata !1411), !dbg !1412
  store i32 0, i32* %i, align 4, !dbg !1413
  br label %for.cond7, !dbg !1415

for.cond7:                                        ; preds = %for.inc18, %reset_label5
  %6 = load i32, i32* %i, align 4, !dbg !1416
  %cmp8 = icmp slt i32 %6, 6, !dbg !1418
  br i1 %cmp8, label %for.body9, label %for.end20, !dbg !1419

for.body9:                                        ; preds = %for.cond7
  %7 = load i32, i32* %i, align 4, !dbg !1420
  %idxprom10 = sext i32 %7 to i64, !dbg !1422
  %arrayidx11 = getelementptr inbounds [6 x i32], [6 x i32]* @delay_bpl, i64 0, i64 %idxprom10, !dbg !1422
  store i32 0, i32* %arrayidx11, align 4, !dbg !1423
  %8 = load i32, i32* %i, align 4, !dbg !1424
  %idxprom12 = sext i32 %8 to i64, !dbg !1425
  %arrayidx13 = getelementptr inbounds [6 x i32], [6 x i32]* @delay_bph, i64 0, i64 %idxprom12, !dbg !1425
  store i32 0, i32* %arrayidx13, align 4, !dbg !1426
  %9 = load i32, i32* %i, align 4, !dbg !1427
  %idxprom14 = sext i32 %9 to i64, !dbg !1428
  %arrayidx15 = getelementptr inbounds [6 x i32], [6 x i32]* @dec_del_bpl, i64 0, i64 %idxprom14, !dbg !1428
  store i32 0, i32* %arrayidx15, align 4, !dbg !1429
  %10 = load i32, i32* %i, align 4, !dbg !1430
  %idxprom16 = sext i32 %10 to i64, !dbg !1431
  %arrayidx17 = getelementptr inbounds [6 x i32], [6 x i32]* @dec_del_bph, i64 0, i64 %idxprom16, !dbg !1431
  store i32 0, i32* %arrayidx17, align 4, !dbg !1432
  br label %for.inc18, !dbg !1433

for.inc18:                                        ; preds = %for.body9
  %11 = load i32, i32* %i, align 4, !dbg !1434
  %inc19 = add nsw i32 %11, 1, !dbg !1434
  store i32 %inc19, i32* %i, align 4, !dbg !1434
  br label %for.cond7, !dbg !1435, !llvm.loop !1436

for.end20:                                        ; preds = %for.cond7
  br label %reset_label6, !dbg !1437

reset_label6:                                     ; preds = %for.end20
  call void @llvm.dbg.label(metadata !1438), !dbg !1439
  store i32 0, i32* %i, align 4, !dbg !1440
  br label %for.cond21, !dbg !1442

for.cond21:                                       ; preds = %for.inc26, %reset_label6
  %12 = load i32, i32* %i, align 4, !dbg !1443
  %cmp22 = icmp slt i32 %12, 24, !dbg !1445
  br i1 %cmp22, label %for.body23, label %for.end28, !dbg !1446

for.body23:                                       ; preds = %for.cond21
  %13 = load i32, i32* %i, align 4, !dbg !1447
  %idxprom24 = sext i32 %13 to i64, !dbg !1449
  %arrayidx25 = getelementptr inbounds [24 x i32], [24 x i32]* @tqmf, i64 0, i64 %idxprom24, !dbg !1449
  store i32 0, i32* %arrayidx25, align 4, !dbg !1450
  br label %for.inc26, !dbg !1451

for.inc26:                                        ; preds = %for.body23
  %14 = load i32, i32* %i, align 4, !dbg !1452
  %inc27 = add nsw i32 %14, 1, !dbg !1452
  store i32 %inc27, i32* %i, align 4, !dbg !1452
  br label %for.cond21, !dbg !1453, !llvm.loop !1454

for.end28:                                        ; preds = %for.cond21
  br label %reset_label7, !dbg !1455

reset_label7:                                     ; preds = %for.end28
  call void @llvm.dbg.label(metadata !1456), !dbg !1457
  store i32 0, i32* %i, align 4, !dbg !1458
  br label %for.cond29, !dbg !1460

for.cond29:                                       ; preds = %for.inc36, %reset_label7
  %15 = load i32, i32* %i, align 4, !dbg !1461
  %cmp30 = icmp slt i32 %15, 11, !dbg !1463
  br i1 %cmp30, label %for.body31, label %for.end38, !dbg !1464

for.body31:                                       ; preds = %for.cond29
  %16 = load i32, i32* %i, align 4, !dbg !1465
  %idxprom32 = sext i32 %16 to i64, !dbg !1467
  %arrayidx33 = getelementptr inbounds [11 x i32], [11 x i32]* @accumc, i64 0, i64 %idxprom32, !dbg !1467
  store i32 0, i32* %arrayidx33, align 4, !dbg !1468
  %17 = load i32, i32* %i, align 4, !dbg !1469
  %idxprom34 = sext i32 %17 to i64, !dbg !1470
  %arrayidx35 = getelementptr inbounds [11 x i32], [11 x i32]* @accumd, i64 0, i64 %idxprom34, !dbg !1470
  store i32 0, i32* %arrayidx35, align 4, !dbg !1471
  br label %for.inc36, !dbg !1472

for.inc36:                                        ; preds = %for.body31
  %18 = load i32, i32* %i, align 4, !dbg !1473
  %inc37 = add nsw i32 %18, 1, !dbg !1473
  store i32 %inc37, i32* %i, align 4, !dbg !1473
  br label %for.cond29, !dbg !1474, !llvm.loop !1475

for.end38:                                        ; preds = %for.cond29
  ret void, !dbg !1477
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { noinline nounwind optnone readnone uwtable willreturn "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind readnone willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!215, !216, !217, !218, !219, !220, !221}
!llvm.ident = !{!222}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "h", scope: !2, file: !3, line: 75, type: !214, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !7, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "data/benchmarks/real/adpcm/adpcm.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "ae327c9d8a78c17646317a45ab0ca9ed")
!4 = !{!5, !6}
!5 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{!0, !8, !14, !19, !21, !26, !31, !36, !38, !43, !45, !50, !55, !57, !59, !64, !66, !68, !70, !72, !74, !76, !78, !80, !82, !84, !86, !88, !90, !92, !94, !96, !98, !100, !102, !104, !106, !108, !110, !112, !114, !116, !118, !120, !122, !124, !126, !128, !130, !132, !134, !136, !138, !140, !142, !144, !146, !148, !150, !152, !154, !156, !158, !160, !162, !164, !166, !168, !170, !172, !174, !176, !178, !180, !182, !184, !186, !188, !190, !192, !194, !196, !198, !200, !202, !204, !206, !208, !210, !212}
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(name: "qq4_code4_table", scope: !2, file: !3, line: 84, type: !10, isLocal: false, isDefinition: true)
!10 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 512, elements: !12)
!11 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6)
!12 = !{!13}
!13 = !DISubrange(count: 16)
!14 = !DIGlobalVariableExpression(var: !15, expr: !DIExpression())
!15 = distinct !DIGlobalVariable(name: "qq6_code6_table", scope: !2, file: !3, line: 89, type: !16, isLocal: false, isDefinition: true)
!16 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 2048, elements: !17)
!17 = !{!18}
!18 = !DISubrange(count: 64)
!19 = !DIGlobalVariableExpression(var: !20, expr: !DIExpression())
!20 = distinct !DIGlobalVariable(name: "wl_code_table", scope: !2, file: !3, line: 100, type: !10, isLocal: false, isDefinition: true)
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "ilb_table", scope: !2, file: !3, line: 105, type: !23, isLocal: false, isDefinition: true)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 1024, elements: !24)
!24 = !{!25}
!25 = !DISubrange(count: 32)
!26 = !DIGlobalVariableExpression(var: !27, expr: !DIExpression())
!27 = distinct !DIGlobalVariable(name: "decis_levl", scope: !2, file: !3, line: 113, type: !28, isLocal: false, isDefinition: true)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 960, elements: !29)
!29 = !{!30}
!30 = !DISubrange(count: 30)
!31 = !DIGlobalVariableExpression(var: !32, expr: !DIExpression())
!32 = distinct !DIGlobalVariable(name: "quant26bt_pos", scope: !2, file: !3, line: 124, type: !33, isLocal: false, isDefinition: true)
!33 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 992, elements: !34)
!34 = !{!35}
!35 = !DISubrange(count: 31)
!36 = !DIGlobalVariableExpression(var: !37, expr: !DIExpression())
!37 = distinct !DIGlobalVariable(name: "quant26bt_neg", scope: !2, file: !3, line: 133, type: !33, isLocal: false, isDefinition: true)
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression())
!39 = distinct !DIGlobalVariable(name: "qq2_code2_table", scope: !2, file: !3, line: 140, type: !40, isLocal: false, isDefinition: true)
!40 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 128, elements: !41)
!41 = !{!42}
!42 = !DISubrange(count: 4)
!43 = !DIGlobalVariableExpression(var: !44, expr: !DIExpression())
!44 = distinct !DIGlobalVariable(name: "wh_code_table", scope: !2, file: !3, line: 141, type: !40, isLocal: false, isDefinition: true)
!45 = !DIGlobalVariableExpression(var: !46, expr: !DIExpression())
!46 = distinct !DIGlobalVariable(name: "tqmf", scope: !2, file: !3, line: 71, type: !47, isLocal: false, isDefinition: true)
!47 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 768, elements: !48)
!48 = !{!49}
!49 = !DISubrange(count: 24)
!50 = !DIGlobalVariableExpression(var: !51, expr: !DIExpression())
!51 = distinct !DIGlobalVariable(name: "accumc", scope: !2, file: !3, line: 82, type: !52, isLocal: false, isDefinition: true)
!52 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 352, elements: !53)
!53 = !{!54}
!54 = !DISubrange(count: 11)
!55 = !DIGlobalVariableExpression(var: !56, expr: !DIExpression())
!56 = distinct !DIGlobalVariable(name: "accumd", scope: !2, file: !3, line: 82, type: !52, isLocal: false, isDefinition: true)
!57 = !DIGlobalVariableExpression(var: !58, expr: !DIExpression())
!58 = distinct !DIGlobalVariable(name: "detl", scope: !2, file: !3, line: 120, type: !6, isLocal: false, isDefinition: true)
!59 = !DIGlobalVariableExpression(var: !60, expr: !DIExpression())
!60 = distinct !DIGlobalVariable(name: "dec_del_bph", scope: !2, file: !3, line: 144, type: !61, isLocal: false, isDefinition: true)
!61 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 192, elements: !62)
!62 = !{!63}
!63 = !DISubrange(count: 6)
!64 = !DIGlobalVariableExpression(var: !65, expr: !DIExpression())
!65 = distinct !DIGlobalVariable(name: "dec_del_dhx", scope: !2, file: !3, line: 145, type: !61, isLocal: false, isDefinition: true)
!66 = !DIGlobalVariableExpression(var: !67, expr: !DIExpression())
!67 = distinct !DIGlobalVariable(name: "dec_rh1", scope: !2, file: !3, line: 148, type: !6, isLocal: false, isDefinition: true)
!68 = !DIGlobalVariableExpression(var: !69, expr: !DIExpression())
!69 = distinct !DIGlobalVariable(name: "dec_rh2", scope: !2, file: !3, line: 148, type: !6, isLocal: false, isDefinition: true)
!70 = !DIGlobalVariableExpression(var: !71, expr: !DIExpression())
!71 = distinct !DIGlobalVariable(name: "dec_ah1", scope: !2, file: !3, line: 149, type: !6, isLocal: false, isDefinition: true)
!72 = !DIGlobalVariableExpression(var: !73, expr: !DIExpression())
!73 = distinct !DIGlobalVariable(name: "dec_ah2", scope: !2, file: !3, line: 149, type: !6, isLocal: false, isDefinition: true)
!74 = !DIGlobalVariableExpression(var: !75, expr: !DIExpression())
!75 = distinct !DIGlobalVariable(name: "dec_ph", scope: !2, file: !3, line: 150, type: !6, isLocal: false, isDefinition: true)
!76 = !DIGlobalVariableExpression(var: !77, expr: !DIExpression())
!77 = distinct !DIGlobalVariable(name: "dec_sph", scope: !2, file: !3, line: 150, type: !6, isLocal: false, isDefinition: true)
!78 = !DIGlobalVariableExpression(var: !79, expr: !DIExpression())
!79 = distinct !DIGlobalVariable(name: "dec_szh", scope: !2, file: !3, line: 153, type: !6, isLocal: false, isDefinition: true)
!80 = !DIGlobalVariableExpression(var: !81, expr: !DIExpression())
!81 = distinct !DIGlobalVariable(name: "dec_sh", scope: !2, file: !3, line: 153, type: !6, isLocal: false, isDefinition: true)
!82 = !DIGlobalVariableExpression(var: !83, expr: !DIExpression())
!83 = distinct !DIGlobalVariable(name: "dec_ph1", scope: !2, file: !3, line: 154, type: !6, isLocal: false, isDefinition: true)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "dec_ph2", scope: !2, file: !3, line: 154, type: !6, isLocal: false, isDefinition: true)
!86 = !DIGlobalVariableExpression(var: !87, expr: !DIExpression())
!87 = distinct !DIGlobalVariable(name: "dec_plt", scope: !2, file: !3, line: 155, type: !6, isLocal: false, isDefinition: true)
!88 = !DIGlobalVariableExpression(var: !89, expr: !DIExpression())
!89 = distinct !DIGlobalVariable(name: "dec_plt1", scope: !2, file: !3, line: 155, type: !6, isLocal: false, isDefinition: true)
!90 = !DIGlobalVariableExpression(var: !91, expr: !DIExpression())
!91 = distinct !DIGlobalVariable(name: "dec_plt2", scope: !2, file: !3, line: 155, type: !6, isLocal: false, isDefinition: true)
!92 = !DIGlobalVariableExpression(var: !93, expr: !DIExpression())
!93 = distinct !DIGlobalVariable(name: "dec_szl", scope: !2, file: !3, line: 156, type: !6, isLocal: false, isDefinition: true)
!94 = !DIGlobalVariableExpression(var: !95, expr: !DIExpression())
!95 = distinct !DIGlobalVariable(name: "dec_spl", scope: !2, file: !3, line: 156, type: !6, isLocal: false, isDefinition: true)
!96 = !DIGlobalVariableExpression(var: !97, expr: !DIExpression())
!97 = distinct !DIGlobalVariable(name: "dec_sl", scope: !2, file: !3, line: 156, type: !6, isLocal: false, isDefinition: true)
!98 = !DIGlobalVariableExpression(var: !99, expr: !DIExpression())
!99 = distinct !DIGlobalVariable(name: "dec_rlt1", scope: !2, file: !3, line: 157, type: !6, isLocal: false, isDefinition: true)
!100 = !DIGlobalVariableExpression(var: !101, expr: !DIExpression())
!101 = distinct !DIGlobalVariable(name: "dec_rlt2", scope: !2, file: !3, line: 157, type: !6, isLocal: false, isDefinition: true)
!102 = !DIGlobalVariableExpression(var: !103, expr: !DIExpression())
!103 = distinct !DIGlobalVariable(name: "dec_rlt", scope: !2, file: !3, line: 157, type: !6, isLocal: false, isDefinition: true)
!104 = !DIGlobalVariableExpression(var: !105, expr: !DIExpression())
!105 = distinct !DIGlobalVariable(name: "dec_al1", scope: !2, file: !3, line: 158, type: !6, isLocal: false, isDefinition: true)
!106 = !DIGlobalVariableExpression(var: !107, expr: !DIExpression())
!107 = distinct !DIGlobalVariable(name: "dec_al2", scope: !2, file: !3, line: 158, type: !6, isLocal: false, isDefinition: true)
!108 = !DIGlobalVariableExpression(var: !109, expr: !DIExpression())
!109 = distinct !DIGlobalVariable(name: "dl", scope: !2, file: !3, line: 159, type: !6, isLocal: false, isDefinition: true)
!110 = !DIGlobalVariableExpression(var: !111, expr: !DIExpression())
!111 = distinct !DIGlobalVariable(name: "dec_nbl", scope: !2, file: !3, line: 159, type: !6, isLocal: false, isDefinition: true)
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(name: "dec_dh", scope: !2, file: !3, line: 159, type: !6, isLocal: false, isDefinition: true)
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(name: "dec_nbh", scope: !2, file: !3, line: 159, type: !6, isLocal: false, isDefinition: true)
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(name: "ilr", scope: !2, file: !3, line: 160, type: !6, isLocal: false, isDefinition: true)
!118 = !DIGlobalVariableExpression(var: !119, expr: !DIExpression())
!119 = distinct !DIGlobalVariable(name: "rl", scope: !2, file: !3, line: 160, type: !6, isLocal: false, isDefinition: true)
!120 = !DIGlobalVariableExpression(var: !121, expr: !DIExpression())
!121 = distinct !DIGlobalVariable(name: "dec_deth", scope: !2, file: !3, line: 161, type: !6, isLocal: false, isDefinition: true)
!122 = !DIGlobalVariableExpression(var: !123, expr: !DIExpression())
!123 = distinct !DIGlobalVariable(name: "dec_detl", scope: !2, file: !3, line: 161, type: !6, isLocal: false, isDefinition: true)
!124 = !DIGlobalVariableExpression(var: !125, expr: !DIExpression())
!125 = distinct !DIGlobalVariable(name: "dec_dlt", scope: !2, file: !3, line: 161, type: !6, isLocal: false, isDefinition: true)
!126 = !DIGlobalVariableExpression(var: !127, expr: !DIExpression())
!127 = distinct !DIGlobalVariable(name: "dec_del_bpl", scope: !2, file: !3, line: 162, type: !61, isLocal: false, isDefinition: true)
!128 = !DIGlobalVariableExpression(var: !129, expr: !DIExpression())
!129 = distinct !DIGlobalVariable(name: "dec_del_dltx", scope: !2, file: !3, line: 163, type: !61, isLocal: false, isDefinition: true)
!130 = !DIGlobalVariableExpression(var: !131, expr: !DIExpression())
!131 = distinct !DIGlobalVariable(name: "xl", scope: !2, file: !3, line: 164, type: !6, isLocal: false, isDefinition: true)
!132 = !DIGlobalVariableExpression(var: !133, expr: !DIExpression())
!133 = distinct !DIGlobalVariable(name: "xh", scope: !2, file: !3, line: 164, type: !6, isLocal: false, isDefinition: true)
!134 = !DIGlobalVariableExpression(var: !135, expr: !DIExpression())
!135 = distinct !DIGlobalVariable(name: "xs", scope: !2, file: !3, line: 165, type: !6, isLocal: false, isDefinition: true)
!136 = !DIGlobalVariableExpression(var: !137, expr: !DIExpression())
!137 = distinct !DIGlobalVariable(name: "xd", scope: !2, file: !3, line: 165, type: !6, isLocal: false, isDefinition: true)
!138 = !DIGlobalVariableExpression(var: !139, expr: !DIExpression())
!139 = distinct !DIGlobalVariable(name: "xout1", scope: !2, file: !3, line: 168, type: !6, isLocal: false, isDefinition: true)
!140 = !DIGlobalVariableExpression(var: !141, expr: !DIExpression())
!141 = distinct !DIGlobalVariable(name: "xout2", scope: !2, file: !3, line: 168, type: !6, isLocal: false, isDefinition: true)
!142 = !DIGlobalVariableExpression(var: !143, expr: !DIExpression())
!143 = distinct !DIGlobalVariable(name: "delay_bpl", scope: !2, file: !3, line: 171, type: !61, isLocal: false, isDefinition: true)
!144 = !DIGlobalVariableExpression(var: !145, expr: !DIExpression())
!145 = distinct !DIGlobalVariable(name: "delay_dltx", scope: !2, file: !3, line: 172, type: !61, isLocal: false, isDefinition: true)
!146 = !DIGlobalVariableExpression(var: !147, expr: !DIExpression())
!147 = distinct !DIGlobalVariable(name: "nbl", scope: !2, file: !3, line: 173, type: !6, isLocal: false, isDefinition: true)
!148 = !DIGlobalVariableExpression(var: !149, expr: !DIExpression())
!149 = distinct !DIGlobalVariable(name: "al1", scope: !2, file: !3, line: 174, type: !6, isLocal: false, isDefinition: true)
!150 = !DIGlobalVariableExpression(var: !151, expr: !DIExpression())
!151 = distinct !DIGlobalVariable(name: "al2", scope: !2, file: !3, line: 174, type: !6, isLocal: false, isDefinition: true)
!152 = !DIGlobalVariableExpression(var: !153, expr: !DIExpression())
!153 = distinct !DIGlobalVariable(name: "plt", scope: !2, file: !3, line: 175, type: !6, isLocal: false, isDefinition: true)
!154 = !DIGlobalVariableExpression(var: !155, expr: !DIExpression())
!155 = distinct !DIGlobalVariable(name: "plt1", scope: !2, file: !3, line: 175, type: !6, isLocal: false, isDefinition: true)
!156 = !DIGlobalVariableExpression(var: !157, expr: !DIExpression())
!157 = distinct !DIGlobalVariable(name: "plt2", scope: !2, file: !3, line: 175, type: !6, isLocal: false, isDefinition: true)
!158 = !DIGlobalVariableExpression(var: !159, expr: !DIExpression())
!159 = distinct !DIGlobalVariable(name: "dlt", scope: !2, file: !3, line: 176, type: !6, isLocal: false, isDefinition: true)
!160 = !DIGlobalVariableExpression(var: !161, expr: !DIExpression())
!161 = distinct !DIGlobalVariable(name: "rlt", scope: !2, file: !3, line: 177, type: !6, isLocal: false, isDefinition: true)
!162 = !DIGlobalVariableExpression(var: !163, expr: !DIExpression())
!163 = distinct !DIGlobalVariable(name: "rlt1", scope: !2, file: !3, line: 177, type: !6, isLocal: false, isDefinition: true)
!164 = !DIGlobalVariableExpression(var: !165, expr: !DIExpression())
!165 = distinct !DIGlobalVariable(name: "rlt2", scope: !2, file: !3, line: 177, type: !6, isLocal: false, isDefinition: true)
!166 = !DIGlobalVariableExpression(var: !167, expr: !DIExpression())
!167 = distinct !DIGlobalVariable(name: "dh", scope: !2, file: !3, line: 178, type: !6, isLocal: false, isDefinition: true)
!168 = !DIGlobalVariableExpression(var: !169, expr: !DIExpression())
!169 = distinct !DIGlobalVariable(name: "ih", scope: !2, file: !3, line: 178, type: !6, isLocal: false, isDefinition: true)
!170 = !DIGlobalVariableExpression(var: !171, expr: !DIExpression())
!171 = distinct !DIGlobalVariable(name: "nbh", scope: !2, file: !3, line: 179, type: !6, isLocal: false, isDefinition: true)
!172 = !DIGlobalVariableExpression(var: !173, expr: !DIExpression())
!173 = distinct !DIGlobalVariable(name: "szh", scope: !2, file: !3, line: 179, type: !6, isLocal: false, isDefinition: true)
!174 = !DIGlobalVariableExpression(var: !175, expr: !DIExpression())
!175 = distinct !DIGlobalVariable(name: "sph", scope: !2, file: !3, line: 180, type: !6, isLocal: false, isDefinition: true)
!176 = !DIGlobalVariableExpression(var: !177, expr: !DIExpression())
!177 = distinct !DIGlobalVariable(name: "ph", scope: !2, file: !3, line: 180, type: !6, isLocal: false, isDefinition: true)
!178 = !DIGlobalVariableExpression(var: !179, expr: !DIExpression())
!179 = distinct !DIGlobalVariable(name: "yh", scope: !2, file: !3, line: 180, type: !6, isLocal: false, isDefinition: true)
!180 = !DIGlobalVariableExpression(var: !181, expr: !DIExpression())
!181 = distinct !DIGlobalVariable(name: "rh", scope: !2, file: !3, line: 180, type: !6, isLocal: false, isDefinition: true)
!182 = !DIGlobalVariableExpression(var: !183, expr: !DIExpression())
!183 = distinct !DIGlobalVariable(name: "delay_dhx", scope: !2, file: !3, line: 181, type: !61, isLocal: false, isDefinition: true)
!184 = !DIGlobalVariableExpression(var: !185, expr: !DIExpression())
!185 = distinct !DIGlobalVariable(name: "delay_bph", scope: !2, file: !3, line: 182, type: !61, isLocal: false, isDefinition: true)
!186 = !DIGlobalVariableExpression(var: !187, expr: !DIExpression())
!187 = distinct !DIGlobalVariable(name: "ah1", scope: !2, file: !3, line: 183, type: !6, isLocal: false, isDefinition: true)
!188 = !DIGlobalVariableExpression(var: !189, expr: !DIExpression())
!189 = distinct !DIGlobalVariable(name: "ah2", scope: !2, file: !3, line: 183, type: !6, isLocal: false, isDefinition: true)
!190 = !DIGlobalVariableExpression(var: !191, expr: !DIExpression())
!191 = distinct !DIGlobalVariable(name: "ph1", scope: !2, file: !3, line: 184, type: !6, isLocal: false, isDefinition: true)
!192 = !DIGlobalVariableExpression(var: !193, expr: !DIExpression())
!193 = distinct !DIGlobalVariable(name: "ph2", scope: !2, file: !3, line: 184, type: !6, isLocal: false, isDefinition: true)
!194 = !DIGlobalVariableExpression(var: !195, expr: !DIExpression())
!195 = distinct !DIGlobalVariable(name: "rh1", scope: !2, file: !3, line: 185, type: !6, isLocal: false, isDefinition: true)
!196 = !DIGlobalVariableExpression(var: !197, expr: !DIExpression())
!197 = distinct !DIGlobalVariable(name: "rh2", scope: !2, file: !3, line: 185, type: !6, isLocal: false, isDefinition: true)
!198 = !DIGlobalVariableExpression(var: !199, expr: !DIExpression())
!199 = distinct !DIGlobalVariable(name: "deth", scope: !2, file: !3, line: 186, type: !6, isLocal: false, isDefinition: true)
!200 = !DIGlobalVariableExpression(var: !201, expr: !DIExpression())
!201 = distinct !DIGlobalVariable(name: "sh", scope: !2, file: !3, line: 187, type: !6, isLocal: false, isDefinition: true)
!202 = !DIGlobalVariableExpression(var: !203, expr: !DIExpression())
!203 = distinct !DIGlobalVariable(name: "eh", scope: !2, file: !3, line: 188, type: !6, isLocal: false, isDefinition: true)
!204 = !DIGlobalVariableExpression(var: !205, expr: !DIExpression())
!205 = distinct !DIGlobalVariable(name: "il", scope: !2, file: !3, line: 189, type: !6, isLocal: false, isDefinition: true)
!206 = !DIGlobalVariableExpression(var: !207, expr: !DIExpression())
!207 = distinct !DIGlobalVariable(name: "szl", scope: !2, file: !3, line: 189, type: !6, isLocal: false, isDefinition: true)
!208 = !DIGlobalVariableExpression(var: !209, expr: !DIExpression())
!209 = distinct !DIGlobalVariable(name: "spl", scope: !2, file: !3, line: 189, type: !6, isLocal: false, isDefinition: true)
!210 = !DIGlobalVariableExpression(var: !211, expr: !DIExpression())
!211 = distinct !DIGlobalVariable(name: "sl", scope: !2, file: !3, line: 189, type: !6, isLocal: false, isDefinition: true)
!212 = !DIGlobalVariableExpression(var: !213, expr: !DIExpression())
!213 = distinct !DIGlobalVariable(name: "el", scope: !2, file: !3, line: 189, type: !6, isLocal: false, isDefinition: true)
!214 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 768, elements: !48)
!215 = !{i32 7, !"Dwarf Version", i32 5}
!216 = !{i32 2, !"Debug Info Version", i32 3}
!217 = !{i32 1, !"wchar_size", i32 4}
!218 = !{i32 7, !"PIC Level", i32 2}
!219 = !{i32 7, !"PIE Level", i32 2}
!220 = !{i32 7, !"uwtable", i32 1}
!221 = !{i32 7, !"frame-pointer", i32 2}
!222 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!223 = distinct !DISubprogram(name: "adpcm_main", scope: !3, file: !3, line: 207, type: !224, scopeLine: 211, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!224 = !DISubroutineType(types: !225)
!225 = !{null, !226, !227, !227}
!226 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!227 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!228 = !{}
!229 = !DILocalVariable(name: "in_data", arg: 1, scope: !223, file: !3, line: 208, type: !226)
!230 = !DILocation(line: 208, column: 15, scope: !223)
!231 = !DILocalVariable(name: "encoded", arg: 2, scope: !223, file: !3, line: 209, type: !227)
!232 = !DILocation(line: 209, column: 9, scope: !223)
!233 = !DILocalVariable(name: "decoded", arg: 3, scope: !223, file: !3, line: 210, type: !227)
!234 = !DILocation(line: 210, column: 9, scope: !223)
!235 = !DILocalVariable(name: "i", scope: !223, file: !3, line: 212, type: !6)
!236 = !DILocation(line: 212, column: 9, scope: !223)
!237 = !DILocation(line: 214, column: 5, scope: !223)
!238 = !DILabel(scope: !223, name: "adpcm_main_label12", file: !3, line: 216)
!239 = !DILocation(line: 216, column: 5, scope: !223)
!240 = !DILocation(line: 217, column: 12, scope: !241)
!241 = distinct !DILexicalBlock(scope: !223, file: !3, line: 217, column: 5)
!242 = !DILocation(line: 217, column: 10, scope: !241)
!243 = !DILocation(line: 217, column: 17, scope: !244)
!244 = distinct !DILexicalBlock(scope: !241, file: !3, line: 217, column: 5)
!245 = !DILocation(line: 217, column: 19, scope: !244)
!246 = !DILocation(line: 217, column: 5, scope: !241)
!247 = !DILocation(line: 219, column: 30, scope: !248)
!248 = distinct !DILexicalBlock(scope: !244, file: !3, line: 217, column: 34)
!249 = !DILocation(line: 219, column: 40, scope: !248)
!250 = !DILocation(line: 219, column: 39, scope: !248)
!251 = !DILocation(line: 219, column: 44, scope: !248)
!252 = !DILocation(line: 219, column: 54, scope: !248)
!253 = !DILocation(line: 219, column: 53, scope: !248)
!254 = !DILocation(line: 219, column: 56, scope: !248)
!255 = !DILocation(line: 219, column: 22, scope: !248)
!256 = !DILocation(line: 219, column: 9, scope: !248)
!257 = !DILocation(line: 219, column: 17, scope: !248)
!258 = !DILocation(line: 219, column: 20, scope: !248)
!259 = !DILocation(line: 220, column: 5, scope: !248)
!260 = !DILocation(line: 217, column: 30, scope: !244)
!261 = !DILocation(line: 217, column: 5, scope: !244)
!262 = distinct !{!262, !246, !263, !264}
!263 = !DILocation(line: 220, column: 5, scope: !241)
!264 = !{!"llvm.loop.mustprogress"}
!265 = !DILabel(scope: !223, name: "adpcm_main_label13", file: !3, line: 222)
!266 = !DILocation(line: 222, column: 5, scope: !223)
!267 = !DILocation(line: 223, column: 12, scope: !268)
!268 = distinct !DILexicalBlock(scope: !223, file: !3, line: 223, column: 5)
!269 = !DILocation(line: 223, column: 10, scope: !268)
!270 = !DILocation(line: 223, column: 17, scope: !271)
!271 = distinct !DILexicalBlock(scope: !268, file: !3, line: 223, column: 5)
!272 = !DILocation(line: 223, column: 19, scope: !271)
!273 = !DILocation(line: 223, column: 5, scope: !268)
!274 = !DILocation(line: 225, column: 17, scope: !275)
!275 = distinct !DILexicalBlock(scope: !271, file: !3, line: 223, column: 34)
!276 = !DILocation(line: 225, column: 25, scope: !275)
!277 = !DILocation(line: 225, column: 9, scope: !275)
!278 = !DILocation(line: 226, column: 24, scope: !275)
!279 = !DILocation(line: 226, column: 9, scope: !275)
!280 = !DILocation(line: 226, column: 19, scope: !275)
!281 = !DILocation(line: 226, column: 18, scope: !275)
!282 = !DILocation(line: 226, column: 22, scope: !275)
!283 = !DILocation(line: 227, column: 28, scope: !275)
!284 = !DILocation(line: 227, column: 9, scope: !275)
!285 = !DILocation(line: 227, column: 19, scope: !275)
!286 = !DILocation(line: 227, column: 18, scope: !275)
!287 = !DILocation(line: 227, column: 21, scope: !275)
!288 = !DILocation(line: 227, column: 26, scope: !275)
!289 = !DILocation(line: 228, column: 5, scope: !275)
!290 = !DILocation(line: 223, column: 30, scope: !271)
!291 = !DILocation(line: 223, column: 5, scope: !271)
!292 = distinct !{!292, !273, !293, !264}
!293 = !DILocation(line: 228, column: 5, scope: !268)
!294 = !DILocation(line: 229, column: 1, scope: !223)
!295 = distinct !DISubprogram(name: "encode", scope: !3, file: !3, line: 240, type: !296, scopeLine: 240, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!296 = !DISubroutineType(types: !297)
!297 = !{!6, !6, !6}
!298 = !DILocalVariable(name: "xin1", arg: 1, scope: !295, file: !3, line: 240, type: !6)
!299 = !DILocation(line: 240, column: 16, scope: !295)
!300 = !DILocalVariable(name: "xin2", arg: 2, scope: !295, file: !3, line: 240, type: !6)
!301 = !DILocation(line: 240, column: 26, scope: !295)
!302 = !DILocalVariable(name: "i", scope: !295, file: !3, line: 241, type: !6)
!303 = !DILocation(line: 241, column: 9, scope: !295)
!304 = !DILocalVariable(name: "h_ptr", scope: !295, file: !3, line: 242, type: !226)
!305 = !DILocation(line: 242, column: 16, scope: !295)
!306 = !DILocalVariable(name: "tqmf_ptr", scope: !295, file: !3, line: 243, type: !227)
!307 = !DILocation(line: 243, column: 10, scope: !295)
!308 = !DILocalVariable(name: "tqmf_ptr1", scope: !295, file: !3, line: 243, type: !227)
!309 = !DILocation(line: 243, column: 21, scope: !295)
!310 = !DILocalVariable(name: "xa", scope: !295, file: !3, line: 244, type: !5)
!311 = !DILocation(line: 244, column: 14, scope: !295)
!312 = !DILocalVariable(name: "xb", scope: !295, file: !3, line: 244, type: !5)
!313 = !DILocation(line: 244, column: 18, scope: !295)
!314 = !DILocalVariable(name: "decis", scope: !295, file: !3, line: 245, type: !6)
!315 = !DILocation(line: 245, column: 9, scope: !295)
!316 = !DILocation(line: 248, column: 11, scope: !295)
!317 = !DILocation(line: 249, column: 14, scope: !295)
!318 = !DILocation(line: 250, column: 26, scope: !295)
!319 = !DILocation(line: 250, column: 17, scope: !295)
!320 = !DILocation(line: 250, column: 10, scope: !295)
!321 = !DILocation(line: 250, column: 39, scope: !295)
!322 = !DILocation(line: 250, column: 33, scope: !295)
!323 = !DILocation(line: 250, column: 32, scope: !295)
!324 = !DILocation(line: 250, column: 30, scope: !295)
!325 = !DILocation(line: 250, column: 8, scope: !295)
!326 = !DILocation(line: 251, column: 26, scope: !295)
!327 = !DILocation(line: 251, column: 17, scope: !295)
!328 = !DILocation(line: 251, column: 10, scope: !295)
!329 = !DILocation(line: 251, column: 39, scope: !295)
!330 = !DILocation(line: 251, column: 33, scope: !295)
!331 = !DILocation(line: 251, column: 32, scope: !295)
!332 = !DILocation(line: 251, column: 30, scope: !295)
!333 = !DILocation(line: 251, column: 8, scope: !295)
!334 = !DILocation(line: 251, column: 5, scope: !295)
!335 = !DILabel(scope: !295, name: "encode_label0", file: !3, line: 254)
!336 = !DILocation(line: 254, column: 5, scope: !295)
!337 = !DILocation(line: 255, column: 12, scope: !338)
!338 = distinct !DILexicalBlock(scope: !295, file: !3, line: 255, column: 5)
!339 = !DILocation(line: 255, column: 10, scope: !338)
!340 = !DILocation(line: 255, column: 17, scope: !341)
!341 = distinct !DILexicalBlock(scope: !338, file: !3, line: 255, column: 5)
!342 = !DILocation(line: 255, column: 19, scope: !341)
!343 = !DILocation(line: 255, column: 5, scope: !338)
!344 = !DILocation(line: 257, column: 31, scope: !345)
!345 = distinct !DILexicalBlock(scope: !341, file: !3, line: 255, column: 30)
!346 = !DILocation(line: 257, column: 22, scope: !345)
!347 = !DILocation(line: 257, column: 15, scope: !345)
!348 = !DILocation(line: 257, column: 44, scope: !345)
!349 = !DILocation(line: 257, column: 38, scope: !345)
!350 = !DILocation(line: 257, column: 37, scope: !345)
!351 = !DILocation(line: 257, column: 35, scope: !345)
!352 = !DILocation(line: 257, column: 12, scope: !345)
!353 = !DILocation(line: 258, column: 31, scope: !345)
!354 = !DILocation(line: 258, column: 22, scope: !345)
!355 = !DILocation(line: 258, column: 15, scope: !345)
!356 = !DILocation(line: 258, column: 44, scope: !345)
!357 = !DILocation(line: 258, column: 38, scope: !345)
!358 = !DILocation(line: 258, column: 37, scope: !345)
!359 = !DILocation(line: 258, column: 35, scope: !345)
!360 = !DILocation(line: 258, column: 12, scope: !345)
!361 = !DILocation(line: 259, column: 5, scope: !345)
!362 = !DILocation(line: 255, column: 26, scope: !341)
!363 = !DILocation(line: 255, column: 5, scope: !341)
!364 = distinct !{!364, !343, !365, !264}
!365 = !DILocation(line: 259, column: 5, scope: !338)
!366 = !DILocation(line: 262, column: 27, scope: !295)
!367 = !DILocation(line: 262, column: 18, scope: !295)
!368 = !DILocation(line: 262, column: 11, scope: !295)
!369 = !DILocation(line: 262, column: 40, scope: !295)
!370 = !DILocation(line: 262, column: 34, scope: !295)
!371 = !DILocation(line: 262, column: 33, scope: !295)
!372 = !DILocation(line: 262, column: 31, scope: !295)
!373 = !DILocation(line: 262, column: 8, scope: !295)
!374 = !DILocation(line: 263, column: 19, scope: !295)
!375 = !DILocation(line: 263, column: 18, scope: !295)
!376 = !DILocation(line: 263, column: 11, scope: !295)
!377 = !DILocation(line: 263, column: 38, scope: !295)
!378 = !DILocation(line: 263, column: 32, scope: !295)
!379 = !DILocation(line: 263, column: 31, scope: !295)
!380 = !DILocation(line: 263, column: 29, scope: !295)
!381 = !DILocation(line: 263, column: 8, scope: !295)
!382 = !DILocation(line: 266, column: 17, scope: !295)
!383 = !DILocation(line: 266, column: 26, scope: !295)
!384 = !DILocation(line: 266, column: 15, scope: !295)
!385 = !DILocation(line: 266, column: 5, scope: !295)
!386 = !DILabel(scope: !295, name: "encode_label1", file: !3, line: 268)
!387 = !DILocation(line: 268, column: 5, scope: !295)
!388 = !DILocation(line: 269, column: 12, scope: !389)
!389 = distinct !DILexicalBlock(scope: !295, file: !3, line: 269, column: 5)
!390 = !DILocation(line: 269, column: 10, scope: !389)
!391 = !DILocation(line: 269, column: 17, scope: !392)
!392 = distinct !DILexicalBlock(scope: !389, file: !3, line: 269, column: 5)
!393 = !DILocation(line: 269, column: 19, scope: !392)
!394 = !DILocation(line: 269, column: 5, scope: !389)
!395 = !DILocation(line: 271, column: 33, scope: !396)
!396 = distinct !DILexicalBlock(scope: !392, file: !3, line: 269, column: 30)
!397 = !DILocation(line: 271, column: 23, scope: !396)
!398 = !DILocation(line: 271, column: 18, scope: !396)
!399 = !DILocation(line: 271, column: 21, scope: !396)
!400 = !DILocation(line: 272, column: 5, scope: !396)
!401 = !DILocation(line: 269, column: 26, scope: !392)
!402 = !DILocation(line: 269, column: 5, scope: !392)
!403 = distinct !{!403, !394, !404, !264}
!404 = !DILocation(line: 272, column: 5, scope: !389)
!405 = !DILocation(line: 274, column: 19, scope: !295)
!406 = !DILocation(line: 274, column: 14, scope: !295)
!407 = !DILocation(line: 274, column: 17, scope: !295)
!408 = !DILocation(line: 275, column: 17, scope: !295)
!409 = !DILocation(line: 275, column: 6, scope: !295)
!410 = !DILocation(line: 275, column: 15, scope: !295)
!411 = !DILocation(line: 278, column: 11, scope: !295)
!412 = !DILocation(line: 278, column: 16, scope: !295)
!413 = !DILocation(line: 278, column: 14, scope: !295)
!414 = !DILocation(line: 278, column: 20, scope: !295)
!415 = !DILocation(line: 278, column: 10, scope: !295)
!416 = !DILocation(line: 278, column: 8, scope: !295)
!417 = !DILocation(line: 279, column: 11, scope: !295)
!418 = !DILocation(line: 279, column: 16, scope: !295)
!419 = !DILocation(line: 279, column: 14, scope: !295)
!420 = !DILocation(line: 279, column: 20, scope: !295)
!421 = !DILocation(line: 279, column: 10, scope: !295)
!422 = !DILocation(line: 279, column: 8, scope: !295)
!423 = !DILocation(line: 282, column: 11, scope: !295)
!424 = !DILocation(line: 282, column: 9, scope: !295)
!425 = !DILocation(line: 283, column: 18, scope: !295)
!426 = !DILocation(line: 283, column: 24, scope: !295)
!427 = !DILocation(line: 283, column: 29, scope: !295)
!428 = !DILocation(line: 283, column: 35, scope: !295)
!429 = !DILocation(line: 283, column: 11, scope: !295)
!430 = !DILocation(line: 283, column: 9, scope: !295)
!431 = !DILocation(line: 284, column: 10, scope: !295)
!432 = !DILocation(line: 284, column: 16, scope: !295)
!433 = !DILocation(line: 284, column: 14, scope: !295)
!434 = !DILocation(line: 284, column: 8, scope: !295)
!435 = !DILocation(line: 285, column: 10, scope: !295)
!436 = !DILocation(line: 285, column: 15, scope: !295)
!437 = !DILocation(line: 285, column: 13, scope: !295)
!438 = !DILocation(line: 285, column: 8, scope: !295)
!439 = !DILocation(line: 286, column: 17, scope: !295)
!440 = !DILocation(line: 286, column: 21, scope: !295)
!441 = !DILocation(line: 286, column: 10, scope: !295)
!442 = !DILocation(line: 286, column: 8, scope: !295)
!443 = !DILocation(line: 287, column: 18, scope: !295)
!444 = !DILocation(line: 287, column: 12, scope: !295)
!445 = !DILocation(line: 287, column: 41, scope: !295)
!446 = !DILocation(line: 287, column: 44, scope: !295)
!447 = !DILocation(line: 287, column: 25, scope: !295)
!448 = !DILocation(line: 287, column: 23, scope: !295)
!449 = !DILocation(line: 287, column: 51, scope: !295)
!450 = !DILocation(line: 287, column: 11, scope: !295)
!451 = !DILocation(line: 287, column: 9, scope: !295)
!452 = !DILocation(line: 288, column: 18, scope: !295)
!453 = !DILocation(line: 288, column: 22, scope: !295)
!454 = !DILocation(line: 288, column: 11, scope: !295)
!455 = !DILocation(line: 288, column: 9, scope: !295)
!456 = !DILocation(line: 289, column: 19, scope: !295)
!457 = !DILocation(line: 289, column: 12, scope: !295)
!458 = !DILocation(line: 289, column: 10, scope: !295)
!459 = !DILocation(line: 290, column: 11, scope: !295)
!460 = !DILocation(line: 290, column: 17, scope: !295)
!461 = !DILocation(line: 290, column: 15, scope: !295)
!462 = !DILocation(line: 290, column: 9, scope: !295)
!463 = !DILocation(line: 291, column: 12, scope: !295)
!464 = !DILocation(line: 291, column: 5, scope: !295)
!465 = !DILocation(line: 292, column: 18, scope: !295)
!466 = !DILocation(line: 292, column: 23, scope: !295)
!467 = !DILocation(line: 292, column: 28, scope: !295)
!468 = !DILocation(line: 292, column: 33, scope: !295)
!469 = !DILocation(line: 292, column: 39, scope: !295)
!470 = !DILocation(line: 292, column: 11, scope: !295)
!471 = !DILocation(line: 292, column: 9, scope: !295)
!472 = !DILocation(line: 293, column: 18, scope: !295)
!473 = !DILocation(line: 293, column: 23, scope: !295)
!474 = !DILocation(line: 293, column: 28, scope: !295)
!475 = !DILocation(line: 293, column: 33, scope: !295)
!476 = !DILocation(line: 293, column: 11, scope: !295)
!477 = !DILocation(line: 293, column: 9, scope: !295)
!478 = !DILocation(line: 294, column: 11, scope: !295)
!479 = !DILocation(line: 294, column: 16, scope: !295)
!480 = !DILocation(line: 294, column: 14, scope: !295)
!481 = !DILocation(line: 294, column: 9, scope: !295)
!482 = !DILocation(line: 295, column: 12, scope: !295)
!483 = !DILocation(line: 295, column: 10, scope: !295)
!484 = !DILocation(line: 296, column: 12, scope: !295)
!485 = !DILocation(line: 296, column: 10, scope: !295)
!486 = !DILocation(line: 297, column: 12, scope: !295)
!487 = !DILocation(line: 297, column: 10, scope: !295)
!488 = !DILocation(line: 298, column: 12, scope: !295)
!489 = !DILocation(line: 298, column: 10, scope: !295)
!490 = !DILocation(line: 301, column: 11, scope: !295)
!491 = !DILocation(line: 301, column: 9, scope: !295)
!492 = !DILocation(line: 302, column: 18, scope: !295)
!493 = !DILocation(line: 302, column: 23, scope: !295)
!494 = !DILocation(line: 302, column: 28, scope: !295)
!495 = !DILocation(line: 302, column: 33, scope: !295)
!496 = !DILocation(line: 302, column: 11, scope: !295)
!497 = !DILocation(line: 302, column: 9, scope: !295)
!498 = !DILocation(line: 303, column: 10, scope: !295)
!499 = !DILocation(line: 303, column: 16, scope: !295)
!500 = !DILocation(line: 303, column: 14, scope: !295)
!501 = !DILocation(line: 303, column: 8, scope: !295)
!502 = !DILocation(line: 304, column: 10, scope: !295)
!503 = !DILocation(line: 304, column: 15, scope: !295)
!504 = !DILocation(line: 304, column: 13, scope: !295)
!505 = !DILocation(line: 304, column: 8, scope: !295)
!506 = !DILocation(line: 305, column: 9, scope: !507)
!507 = distinct !DILexicalBlock(scope: !295, file: !3, line: 305, column: 9)
!508 = !DILocation(line: 305, column: 12, scope: !507)
!509 = !DILocation(line: 305, column: 9, scope: !295)
!510 = !DILocation(line: 306, column: 12, scope: !511)
!511 = distinct !DILexicalBlock(scope: !507, file: !3, line: 305, column: 18)
!512 = !DILocation(line: 307, column: 5, scope: !511)
!513 = !DILocation(line: 308, column: 12, scope: !514)
!514 = distinct !DILexicalBlock(scope: !507, file: !3, line: 307, column: 12)
!515 = !DILocation(line: 310, column: 27, scope: !295)
!516 = !DILocation(line: 310, column: 21, scope: !295)
!517 = !DILocation(line: 310, column: 19, scope: !295)
!518 = !DILocation(line: 310, column: 33, scope: !295)
!519 = !DILocation(line: 310, column: 13, scope: !295)
!520 = !DILocation(line: 310, column: 11, scope: !295)
!521 = !DILocation(line: 311, column: 13, scope: !522)
!522 = distinct !DILexicalBlock(scope: !295, file: !3, line: 311, column: 9)
!523 = !DILocation(line: 311, column: 9, scope: !522)
!524 = !DILocation(line: 311, column: 19, scope: !522)
!525 = !DILocation(line: 311, column: 17, scope: !522)
!526 = !DILocation(line: 311, column: 9, scope: !295)
!527 = !DILocation(line: 312, column: 11, scope: !522)
!528 = !DILocation(line: 312, column: 9, scope: !522)
!529 = !DILocation(line: 314, column: 17, scope: !295)
!530 = !DILocation(line: 314, column: 11, scope: !295)
!531 = !DILocation(line: 314, column: 40, scope: !295)
!532 = !DILocation(line: 314, column: 24, scope: !295)
!533 = !DILocation(line: 314, column: 22, scope: !295)
!534 = !DILocation(line: 314, column: 45, scope: !295)
!535 = !DILocation(line: 314, column: 10, scope: !295)
!536 = !DILocation(line: 314, column: 8, scope: !295)
!537 = !DILocation(line: 315, column: 18, scope: !295)
!538 = !DILocation(line: 315, column: 22, scope: !295)
!539 = !DILocation(line: 315, column: 11, scope: !295)
!540 = !DILocation(line: 315, column: 9, scope: !295)
!541 = !DILocation(line: 316, column: 19, scope: !295)
!542 = !DILocation(line: 316, column: 12, scope: !295)
!543 = !DILocation(line: 316, column: 10, scope: !295)
!544 = !DILocation(line: 317, column: 10, scope: !295)
!545 = !DILocation(line: 317, column: 15, scope: !295)
!546 = !DILocation(line: 317, column: 13, scope: !295)
!547 = !DILocation(line: 317, column: 8, scope: !295)
!548 = !DILocation(line: 318, column: 12, scope: !295)
!549 = !DILocation(line: 318, column: 5, scope: !295)
!550 = !DILocation(line: 319, column: 18, scope: !295)
!551 = !DILocation(line: 319, column: 23, scope: !295)
!552 = !DILocation(line: 319, column: 28, scope: !295)
!553 = !DILocation(line: 319, column: 32, scope: !295)
!554 = !DILocation(line: 319, column: 37, scope: !295)
!555 = !DILocation(line: 319, column: 11, scope: !295)
!556 = !DILocation(line: 319, column: 9, scope: !295)
!557 = !DILocation(line: 320, column: 18, scope: !295)
!558 = !DILocation(line: 320, column: 23, scope: !295)
!559 = !DILocation(line: 320, column: 28, scope: !295)
!560 = !DILocation(line: 320, column: 32, scope: !295)
!561 = !DILocation(line: 320, column: 11, scope: !295)
!562 = !DILocation(line: 320, column: 9, scope: !295)
!563 = !DILocation(line: 321, column: 10, scope: !295)
!564 = !DILocation(line: 321, column: 15, scope: !295)
!565 = !DILocation(line: 321, column: 13, scope: !295)
!566 = !DILocation(line: 321, column: 8, scope: !295)
!567 = !DILocation(line: 322, column: 11, scope: !295)
!568 = !DILocation(line: 322, column: 9, scope: !295)
!569 = !DILocation(line: 323, column: 11, scope: !295)
!570 = !DILocation(line: 323, column: 9, scope: !295)
!571 = !DILocation(line: 324, column: 11, scope: !295)
!572 = !DILocation(line: 324, column: 9, scope: !295)
!573 = !DILocation(line: 325, column: 11, scope: !295)
!574 = !DILocation(line: 325, column: 9, scope: !295)
!575 = !DILocation(line: 328, column: 13, scope: !295)
!576 = !DILocation(line: 328, column: 19, scope: !295)
!577 = !DILocation(line: 328, column: 22, scope: !295)
!578 = !DILocation(line: 328, column: 16, scope: !295)
!579 = !DILocation(line: 328, column: 5, scope: !295)
!580 = distinct !DISubprogram(name: "decode", scope: !3, file: !3, line: 331, type: !581, scopeLine: 331, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!581 = !DISubroutineType(types: !582)
!582 = !{null, !6}
!583 = !DILocalVariable(name: "input", arg: 1, scope: !580, file: !3, line: 331, type: !6)
!584 = !DILocation(line: 331, column: 17, scope: !580)
!585 = !DILocalVariable(name: "i", scope: !580, file: !3, line: 332, type: !6)
!586 = !DILocation(line: 332, column: 9, scope: !580)
!587 = !DILocalVariable(name: "xa1", scope: !580, file: !3, line: 333, type: !5)
!588 = !DILocation(line: 333, column: 14, scope: !580)
!589 = !DILocalVariable(name: "xa2", scope: !580, file: !3, line: 333, type: !5)
!590 = !DILocation(line: 333, column: 19, scope: !580)
!591 = !DILocalVariable(name: "h_ptr", scope: !580, file: !3, line: 334, type: !226)
!592 = !DILocation(line: 334, column: 16, scope: !580)
!593 = !DILocalVariable(name: "ac_ptr", scope: !580, file: !3, line: 335, type: !227)
!594 = !DILocation(line: 335, column: 10, scope: !580)
!595 = !DILocalVariable(name: "ac_ptr1", scope: !580, file: !3, line: 335, type: !227)
!596 = !DILocation(line: 335, column: 19, scope: !580)
!597 = !DILocalVariable(name: "ad_ptr", scope: !580, file: !3, line: 335, type: !227)
!598 = !DILocation(line: 335, column: 29, scope: !580)
!599 = !DILocalVariable(name: "ad_ptr1", scope: !580, file: !3, line: 335, type: !227)
!600 = !DILocation(line: 335, column: 38, scope: !580)
!601 = !DILocation(line: 338, column: 11, scope: !580)
!602 = !DILocation(line: 338, column: 17, scope: !580)
!603 = !DILocation(line: 338, column: 9, scope: !580)
!604 = !DILocation(line: 339, column: 10, scope: !580)
!605 = !DILocation(line: 339, column: 16, scope: !580)
!606 = !DILocation(line: 339, column: 8, scope: !580)
!607 = !DILocation(line: 342, column: 15, scope: !580)
!608 = !DILocation(line: 342, column: 13, scope: !580)
!609 = !DILocation(line: 343, column: 22, scope: !580)
!610 = !DILocation(line: 343, column: 32, scope: !580)
!611 = !DILocation(line: 343, column: 41, scope: !580)
!612 = !DILocation(line: 343, column: 51, scope: !580)
!613 = !DILocation(line: 343, column: 15, scope: !580)
!614 = !DILocation(line: 343, column: 13, scope: !580)
!615 = !DILocation(line: 344, column: 14, scope: !580)
!616 = !DILocation(line: 344, column: 24, scope: !580)
!617 = !DILocation(line: 344, column: 22, scope: !580)
!618 = !DILocation(line: 344, column: 12, scope: !580)
!619 = !DILocation(line: 345, column: 22, scope: !580)
!620 = !DILocation(line: 345, column: 16, scope: !580)
!621 = !DILocation(line: 345, column: 49, scope: !580)
!622 = !DILocation(line: 345, column: 53, scope: !580)
!623 = !DILocation(line: 345, column: 33, scope: !580)
!624 = !DILocation(line: 345, column: 31, scope: !580)
!625 = !DILocation(line: 345, column: 60, scope: !580)
!626 = !DILocation(line: 345, column: 15, scope: !580)
!627 = !DILocation(line: 345, column: 13, scope: !580)
!628 = !DILocation(line: 346, column: 17, scope: !580)
!629 = !DILocation(line: 346, column: 11, scope: !580)
!630 = !DILocation(line: 346, column: 44, scope: !580)
!631 = !DILocation(line: 346, column: 28, scope: !580)
!632 = !DILocation(line: 346, column: 26, scope: !580)
!633 = !DILocation(line: 346, column: 49, scope: !580)
!634 = !DILocation(line: 346, column: 10, scope: !580)
!635 = !DILocation(line: 346, column: 8, scope: !580)
!636 = !DILocation(line: 347, column: 10, scope: !580)
!637 = !DILocation(line: 347, column: 15, scope: !580)
!638 = !DILocation(line: 347, column: 13, scope: !580)
!639 = !DILocation(line: 347, column: 8, scope: !580)
!640 = !DILocation(line: 348, column: 22, scope: !580)
!641 = !DILocation(line: 348, column: 27, scope: !580)
!642 = !DILocation(line: 348, column: 15, scope: !580)
!643 = !DILocation(line: 348, column: 13, scope: !580)
!644 = !DILocation(line: 349, column: 23, scope: !580)
!645 = !DILocation(line: 349, column: 16, scope: !580)
!646 = !DILocation(line: 349, column: 14, scope: !580)
!647 = !DILocation(line: 350, column: 15, scope: !580)
!648 = !DILocation(line: 350, column: 25, scope: !580)
!649 = !DILocation(line: 350, column: 23, scope: !580)
!650 = !DILocation(line: 350, column: 13, scope: !580)
!651 = !DILocation(line: 351, column: 12, scope: !580)
!652 = !DILocation(line: 351, column: 5, scope: !580)
!653 = !DILocation(line: 352, column: 22, scope: !580)
!654 = !DILocation(line: 352, column: 31, scope: !580)
!655 = !DILocation(line: 352, column: 40, scope: !580)
!656 = !DILocation(line: 352, column: 49, scope: !580)
!657 = !DILocation(line: 352, column: 59, scope: !580)
!658 = !DILocation(line: 352, column: 15, scope: !580)
!659 = !DILocation(line: 352, column: 13, scope: !580)
!660 = !DILocation(line: 353, column: 22, scope: !580)
!661 = !DILocation(line: 353, column: 31, scope: !580)
!662 = !DILocation(line: 353, column: 40, scope: !580)
!663 = !DILocation(line: 353, column: 49, scope: !580)
!664 = !DILocation(line: 353, column: 15, scope: !580)
!665 = !DILocation(line: 353, column: 13, scope: !580)
!666 = !DILocation(line: 354, column: 15, scope: !580)
!667 = !DILocation(line: 354, column: 24, scope: !580)
!668 = !DILocation(line: 354, column: 22, scope: !580)
!669 = !DILocation(line: 354, column: 13, scope: !580)
!670 = !DILocation(line: 355, column: 16, scope: !580)
!671 = !DILocation(line: 355, column: 14, scope: !580)
!672 = !DILocation(line: 356, column: 16, scope: !580)
!673 = !DILocation(line: 356, column: 14, scope: !580)
!674 = !DILocation(line: 357, column: 16, scope: !580)
!675 = !DILocation(line: 357, column: 14, scope: !580)
!676 = !DILocation(line: 358, column: 16, scope: !580)
!677 = !DILocation(line: 358, column: 14, scope: !580)
!678 = !DILocation(line: 361, column: 15, scope: !580)
!679 = !DILocation(line: 361, column: 13, scope: !580)
!680 = !DILocation(line: 362, column: 22, scope: !580)
!681 = !DILocation(line: 362, column: 31, scope: !580)
!682 = !DILocation(line: 362, column: 40, scope: !580)
!683 = !DILocation(line: 362, column: 49, scope: !580)
!684 = !DILocation(line: 362, column: 15, scope: !580)
!685 = !DILocation(line: 362, column: 13, scope: !580)
!686 = !DILocation(line: 363, column: 14, scope: !580)
!687 = !DILocation(line: 363, column: 24, scope: !580)
!688 = !DILocation(line: 363, column: 22, scope: !580)
!689 = !DILocation(line: 363, column: 12, scope: !580)
!690 = !DILocation(line: 364, column: 21, scope: !580)
!691 = !DILocation(line: 364, column: 15, scope: !580)
!692 = !DILocation(line: 364, column: 48, scope: !580)
!693 = !DILocation(line: 364, column: 32, scope: !580)
!694 = !DILocation(line: 364, column: 30, scope: !580)
!695 = !DILocation(line: 364, column: 53, scope: !580)
!696 = !DILocation(line: 364, column: 14, scope: !580)
!697 = !DILocation(line: 364, column: 12, scope: !580)
!698 = !DILocation(line: 365, column: 22, scope: !580)
!699 = !DILocation(line: 365, column: 26, scope: !580)
!700 = !DILocation(line: 365, column: 15, scope: !580)
!701 = !DILocation(line: 365, column: 13, scope: !580)
!702 = !DILocation(line: 366, column: 23, scope: !580)
!703 = !DILocation(line: 366, column: 16, scope: !580)
!704 = !DILocation(line: 366, column: 14, scope: !580)
!705 = !DILocation(line: 367, column: 14, scope: !580)
!706 = !DILocation(line: 367, column: 23, scope: !580)
!707 = !DILocation(line: 367, column: 21, scope: !580)
!708 = !DILocation(line: 367, column: 12, scope: !580)
!709 = !DILocation(line: 368, column: 12, scope: !580)
!710 = !DILocation(line: 368, column: 5, scope: !580)
!711 = !DILocation(line: 369, column: 22, scope: !580)
!712 = !DILocation(line: 369, column: 31, scope: !580)
!713 = !DILocation(line: 369, column: 40, scope: !580)
!714 = !DILocation(line: 369, column: 48, scope: !580)
!715 = !DILocation(line: 369, column: 57, scope: !580)
!716 = !DILocation(line: 369, column: 15, scope: !580)
!717 = !DILocation(line: 369, column: 13, scope: !580)
!718 = !DILocation(line: 370, column: 22, scope: !580)
!719 = !DILocation(line: 370, column: 31, scope: !580)
!720 = !DILocation(line: 370, column: 40, scope: !580)
!721 = !DILocation(line: 370, column: 48, scope: !580)
!722 = !DILocation(line: 370, column: 15, scope: !580)
!723 = !DILocation(line: 370, column: 13, scope: !580)
!724 = !DILocation(line: 371, column: 10, scope: !580)
!725 = !DILocation(line: 371, column: 19, scope: !580)
!726 = !DILocation(line: 371, column: 17, scope: !580)
!727 = !DILocation(line: 371, column: 8, scope: !580)
!728 = !DILocation(line: 372, column: 15, scope: !580)
!729 = !DILocation(line: 372, column: 13, scope: !580)
!730 = !DILocation(line: 373, column: 15, scope: !580)
!731 = !DILocation(line: 373, column: 13, scope: !580)
!732 = !DILocation(line: 374, column: 15, scope: !580)
!733 = !DILocation(line: 374, column: 13, scope: !580)
!734 = !DILocation(line: 375, column: 15, scope: !580)
!735 = !DILocation(line: 375, column: 13, scope: !580)
!736 = !DILocation(line: 378, column: 10, scope: !580)
!737 = !DILocation(line: 378, column: 15, scope: !580)
!738 = !DILocation(line: 378, column: 13, scope: !580)
!739 = !DILocation(line: 378, column: 8, scope: !580)
!740 = !DILocation(line: 379, column: 10, scope: !580)
!741 = !DILocation(line: 379, column: 15, scope: !580)
!742 = !DILocation(line: 379, column: 13, scope: !580)
!743 = !DILocation(line: 379, column: 8, scope: !580)
!744 = !DILocation(line: 382, column: 11, scope: !580)
!745 = !DILocation(line: 383, column: 12, scope: !580)
!746 = !DILocation(line: 384, column: 12, scope: !580)
!747 = !DILocation(line: 385, column: 17, scope: !580)
!748 = !DILocation(line: 385, column: 11, scope: !580)
!749 = !DILocation(line: 385, column: 29, scope: !580)
!750 = !DILocation(line: 385, column: 23, scope: !580)
!751 = !DILocation(line: 385, column: 22, scope: !580)
!752 = !DILocation(line: 385, column: 20, scope: !580)
!753 = !DILocation(line: 385, column: 9, scope: !580)
!754 = !DILocation(line: 386, column: 17, scope: !580)
!755 = !DILocation(line: 386, column: 11, scope: !580)
!756 = !DILocation(line: 386, column: 29, scope: !580)
!757 = !DILocation(line: 386, column: 23, scope: !580)
!758 = !DILocation(line: 386, column: 22, scope: !580)
!759 = !DILocation(line: 386, column: 20, scope: !580)
!760 = !DILocation(line: 386, column: 9, scope: !580)
!761 = !DILocation(line: 386, column: 5, scope: !580)
!762 = !DILabel(scope: !580, name: "decode_label2", file: !3, line: 388)
!763 = !DILocation(line: 388, column: 5, scope: !580)
!764 = !DILocation(line: 389, column: 12, scope: !765)
!765 = distinct !DILexicalBlock(scope: !580, file: !3, line: 389, column: 5)
!766 = !DILocation(line: 389, column: 10, scope: !765)
!767 = !DILocation(line: 389, column: 17, scope: !768)
!768 = distinct !DILexicalBlock(scope: !765, file: !3, line: 389, column: 5)
!769 = !DILocation(line: 389, column: 19, scope: !768)
!770 = !DILocation(line: 389, column: 5, scope: !765)
!771 = !DILocation(line: 391, column: 30, scope: !772)
!772 = distinct !DILexicalBlock(scope: !768, file: !3, line: 389, column: 30)
!773 = !DILocation(line: 391, column: 23, scope: !772)
!774 = !DILocation(line: 391, column: 16, scope: !772)
!775 = !DILocation(line: 391, column: 43, scope: !772)
!776 = !DILocation(line: 391, column: 37, scope: !772)
!777 = !DILocation(line: 391, column: 36, scope: !772)
!778 = !DILocation(line: 391, column: 34, scope: !772)
!779 = !DILocation(line: 391, column: 13, scope: !772)
!780 = !DILocation(line: 392, column: 30, scope: !772)
!781 = !DILocation(line: 392, column: 23, scope: !772)
!782 = !DILocation(line: 392, column: 16, scope: !772)
!783 = !DILocation(line: 392, column: 43, scope: !772)
!784 = !DILocation(line: 392, column: 37, scope: !772)
!785 = !DILocation(line: 392, column: 36, scope: !772)
!786 = !DILocation(line: 392, column: 34, scope: !772)
!787 = !DILocation(line: 392, column: 13, scope: !772)
!788 = !DILocation(line: 393, column: 5, scope: !772)
!789 = !DILocation(line: 389, column: 26, scope: !768)
!790 = !DILocation(line: 389, column: 5, scope: !768)
!791 = distinct !{!791, !770, !792, !264}
!792 = !DILocation(line: 393, column: 5, scope: !765)
!793 = !DILocation(line: 395, column: 20, scope: !580)
!794 = !DILocation(line: 395, column: 19, scope: !580)
!795 = !DILocation(line: 395, column: 12, scope: !580)
!796 = !DILocation(line: 395, column: 37, scope: !580)
!797 = !DILocation(line: 395, column: 31, scope: !580)
!798 = !DILocation(line: 395, column: 30, scope: !580)
!799 = !DILocation(line: 395, column: 28, scope: !580)
!800 = !DILocation(line: 395, column: 9, scope: !580)
!801 = !DILocation(line: 396, column: 20, scope: !580)
!802 = !DILocation(line: 396, column: 19, scope: !580)
!803 = !DILocation(line: 396, column: 12, scope: !580)
!804 = !DILocation(line: 396, column: 37, scope: !580)
!805 = !DILocation(line: 396, column: 31, scope: !580)
!806 = !DILocation(line: 396, column: 30, scope: !580)
!807 = !DILocation(line: 396, column: 28, scope: !580)
!808 = !DILocation(line: 396, column: 9, scope: !580)
!809 = !DILocation(line: 397, column: 13, scope: !580)
!810 = !DILocation(line: 397, column: 17, scope: !580)
!811 = !DILocation(line: 397, column: 11, scope: !580)
!812 = !DILocation(line: 398, column: 13, scope: !580)
!813 = !DILocation(line: 398, column: 17, scope: !580)
!814 = !DILocation(line: 398, column: 11, scope: !580)
!815 = !DILocation(line: 401, column: 15, scope: !580)
!816 = !DILocation(line: 401, column: 22, scope: !580)
!817 = !DILocation(line: 401, column: 13, scope: !580)
!818 = !DILocation(line: 402, column: 15, scope: !580)
!819 = !DILocation(line: 402, column: 22, scope: !580)
!820 = !DILocation(line: 402, column: 13, scope: !580)
!821 = !DILocation(line: 402, column: 5, scope: !580)
!822 = !DILabel(scope: !580, name: "decode_label3", file: !3, line: 404)
!823 = !DILocation(line: 404, column: 5, scope: !580)
!824 = !DILocation(line: 405, column: 12, scope: !825)
!825 = distinct !DILexicalBlock(scope: !580, file: !3, line: 405, column: 5)
!826 = !DILocation(line: 405, column: 10, scope: !825)
!827 = !DILocation(line: 405, column: 17, scope: !828)
!828 = distinct !DILexicalBlock(scope: !825, file: !3, line: 405, column: 5)
!829 = !DILocation(line: 405, column: 19, scope: !828)
!830 = !DILocation(line: 405, column: 5, scope: !825)
!831 = !DILocation(line: 407, column: 29, scope: !832)
!832 = distinct !DILexicalBlock(scope: !828, file: !3, line: 405, column: 30)
!833 = !DILocation(line: 407, column: 21, scope: !832)
!834 = !DILocation(line: 407, column: 16, scope: !832)
!835 = !DILocation(line: 407, column: 19, scope: !832)
!836 = !DILocation(line: 408, column: 29, scope: !832)
!837 = !DILocation(line: 408, column: 21, scope: !832)
!838 = !DILocation(line: 408, column: 16, scope: !832)
!839 = !DILocation(line: 408, column: 19, scope: !832)
!840 = !DILocation(line: 409, column: 5, scope: !832)
!841 = !DILocation(line: 405, column: 26, scope: !828)
!842 = !DILocation(line: 405, column: 5, scope: !828)
!843 = distinct !{!843, !830, !844, !264}
!844 = !DILocation(line: 409, column: 5, scope: !825)
!845 = !DILocation(line: 411, column: 15, scope: !580)
!846 = !DILocation(line: 411, column: 6, scope: !580)
!847 = !DILocation(line: 411, column: 13, scope: !580)
!848 = !DILocation(line: 412, column: 15, scope: !580)
!849 = !DILocation(line: 412, column: 6, scope: !580)
!850 = !DILocation(line: 412, column: 13, scope: !580)
!851 = !DILocation(line: 413, column: 1, scope: !580)
!852 = distinct !DISubprogram(name: "abs", scope: !3, file: !3, line: 231, type: !853, scopeLine: 231, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!853 = !DISubroutineType(types: !854)
!854 = !{!6, !6}
!855 = !DILocalVariable(name: "n", arg: 1, scope: !852, file: !3, line: 231, type: !6)
!856 = !DILocation(line: 231, column: 13, scope: !852)
!857 = !DILocalVariable(name: "m", scope: !852, file: !3, line: 232, type: !6)
!858 = !DILocation(line: 232, column: 9, scope: !852)
!859 = !DILocation(line: 233, column: 9, scope: !860)
!860 = distinct !DILexicalBlock(scope: !852, file: !3, line: 233, column: 9)
!861 = !DILocation(line: 233, column: 11, scope: !860)
!862 = !DILocation(line: 233, column: 9, scope: !852)
!863 = !DILocation(line: 234, column: 13, scope: !860)
!864 = !DILocation(line: 234, column: 11, scope: !860)
!865 = !DILocation(line: 234, column: 9, scope: !860)
!866 = !DILocation(line: 236, column: 14, scope: !860)
!867 = !DILocation(line: 236, column: 13, scope: !860)
!868 = !DILocation(line: 236, column: 11, scope: !860)
!869 = !DILocation(line: 237, column: 12, scope: !852)
!870 = !DILocation(line: 237, column: 5, scope: !852)
!871 = distinct !DISubprogram(name: "filtez", scope: !3, file: !3, line: 458, type: !872, scopeLine: 458, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!872 = !DISubroutineType(types: !873)
!873 = !{!6, !227, !227}
!874 = !DILocalVariable(name: "bpl", arg: 1, scope: !871, file: !3, line: 458, type: !227)
!875 = !DILocation(line: 458, column: 17, scope: !871)
!876 = !DILocalVariable(name: "dlt", arg: 2, scope: !871, file: !3, line: 458, type: !227)
!877 = !DILocation(line: 458, column: 27, scope: !871)
!878 = !DILocalVariable(name: "i", scope: !871, file: !3, line: 459, type: !6)
!879 = !DILocation(line: 459, column: 9, scope: !871)
!880 = !DILocalVariable(name: "zl", scope: !871, file: !3, line: 460, type: !5)
!881 = !DILocation(line: 460, column: 14, scope: !871)
!882 = !DILocation(line: 461, column: 21, scope: !871)
!883 = !DILocation(line: 461, column: 17, scope: !871)
!884 = !DILocation(line: 461, column: 10, scope: !871)
!885 = !DILocation(line: 461, column: 32, scope: !871)
!886 = !DILocation(line: 461, column: 28, scope: !871)
!887 = !DILocation(line: 461, column: 27, scope: !871)
!888 = !DILocation(line: 461, column: 25, scope: !871)
!889 = !DILocation(line: 461, column: 8, scope: !871)
!890 = !DILocation(line: 461, column: 5, scope: !871)
!891 = !DILabel(scope: !871, name: "filtez_label8", file: !3, line: 463)
!892 = !DILocation(line: 463, column: 5, scope: !871)
!893 = !DILocation(line: 464, column: 12, scope: !894)
!894 = distinct !DILexicalBlock(scope: !871, file: !3, line: 464, column: 5)
!895 = !DILocation(line: 464, column: 10, scope: !894)
!896 = !DILocation(line: 464, column: 17, scope: !897)
!897 = distinct !DILexicalBlock(scope: !894, file: !3, line: 464, column: 5)
!898 = !DILocation(line: 464, column: 19, scope: !897)
!899 = !DILocation(line: 464, column: 5, scope: !894)
!900 = !DILocation(line: 466, column: 26, scope: !901)
!901 = distinct !DILexicalBlock(scope: !897, file: !3, line: 464, column: 29)
!902 = !DILocation(line: 466, column: 22, scope: !901)
!903 = !DILocation(line: 466, column: 15, scope: !901)
!904 = !DILocation(line: 466, column: 37, scope: !901)
!905 = !DILocation(line: 466, column: 33, scope: !901)
!906 = !DILocation(line: 466, column: 32, scope: !901)
!907 = !DILocation(line: 466, column: 30, scope: !901)
!908 = !DILocation(line: 466, column: 12, scope: !901)
!909 = !DILocation(line: 467, column: 5, scope: !901)
!910 = !DILocation(line: 464, column: 25, scope: !897)
!911 = !DILocation(line: 464, column: 5, scope: !897)
!912 = distinct !{!912, !899, !913, !264}
!913 = !DILocation(line: 467, column: 5, scope: !894)
!914 = !DILocation(line: 469, column: 19, scope: !871)
!915 = !DILocation(line: 469, column: 22, scope: !871)
!916 = !DILocation(line: 469, column: 13, scope: !871)
!917 = !DILocation(line: 469, column: 5, scope: !871)
!918 = distinct !DISubprogram(name: "filtep", scope: !3, file: !3, line: 474, type: !919, scopeLine: 474, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!919 = !DISubroutineType(types: !920)
!920 = !{!6, !6, !6, !6, !6}
!921 = !DILocalVariable(name: "rlt1", arg: 1, scope: !918, file: !3, line: 474, type: !6)
!922 = !DILocation(line: 474, column: 16, scope: !918)
!923 = !DILocalVariable(name: "al1", arg: 2, scope: !918, file: !3, line: 474, type: !6)
!924 = !DILocation(line: 474, column: 26, scope: !918)
!925 = !DILocalVariable(name: "rlt2", arg: 3, scope: !918, file: !3, line: 474, type: !6)
!926 = !DILocation(line: 474, column: 35, scope: !918)
!927 = !DILocalVariable(name: "al2", arg: 4, scope: !918, file: !3, line: 474, type: !6)
!928 = !DILocation(line: 474, column: 45, scope: !918)
!929 = !DILocalVariable(name: "pl", scope: !918, file: !3, line: 475, type: !5)
!930 = !DILocation(line: 475, column: 14, scope: !918)
!931 = !DILocalVariable(name: "pl2", scope: !918, file: !3, line: 475, type: !5)
!932 = !DILocation(line: 475, column: 18, scope: !918)
!933 = !DILocation(line: 476, column: 14, scope: !918)
!934 = !DILocation(line: 476, column: 12, scope: !918)
!935 = !DILocation(line: 476, column: 10, scope: !918)
!936 = !DILocation(line: 476, column: 8, scope: !918)
!937 = !DILocation(line: 477, column: 16, scope: !918)
!938 = !DILocation(line: 477, column: 10, scope: !918)
!939 = !DILocation(line: 477, column: 22, scope: !918)
!940 = !DILocation(line: 477, column: 20, scope: !918)
!941 = !DILocation(line: 477, column: 8, scope: !918)
!942 = !DILocation(line: 478, column: 15, scope: !918)
!943 = !DILocation(line: 478, column: 13, scope: !918)
!944 = !DILocation(line: 478, column: 11, scope: !918)
!945 = !DILocation(line: 478, column: 9, scope: !918)
!946 = !DILocation(line: 479, column: 17, scope: !918)
!947 = !DILocation(line: 479, column: 11, scope: !918)
!948 = !DILocation(line: 479, column: 23, scope: !918)
!949 = !DILocation(line: 479, column: 21, scope: !918)
!950 = !DILocation(line: 479, column: 8, scope: !918)
!951 = !DILocation(line: 480, column: 19, scope: !918)
!952 = !DILocation(line: 480, column: 22, scope: !918)
!953 = !DILocation(line: 480, column: 13, scope: !918)
!954 = !DILocation(line: 480, column: 5, scope: !918)
!955 = distinct !DISubprogram(name: "quantl", scope: !3, file: !3, line: 484, type: !296, scopeLine: 484, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!956 = !DILocalVariable(name: "el", arg: 1, scope: !955, file: !3, line: 484, type: !6)
!957 = !DILocation(line: 484, column: 16, scope: !955)
!958 = !DILocalVariable(name: "detl", arg: 2, scope: !955, file: !3, line: 484, type: !6)
!959 = !DILocation(line: 484, column: 24, scope: !955)
!960 = !DILocalVariable(name: "ril", scope: !955, file: !3, line: 485, type: !6)
!961 = !DILocation(line: 485, column: 9, scope: !955)
!962 = !DILocalVariable(name: "mil", scope: !955, file: !3, line: 485, type: !6)
!963 = !DILocation(line: 485, column: 14, scope: !955)
!964 = !DILocalVariable(name: "wd", scope: !955, file: !3, line: 486, type: !5)
!965 = !DILocation(line: 486, column: 14, scope: !955)
!966 = !DILocalVariable(name: "decis", scope: !955, file: !3, line: 486, type: !5)
!967 = !DILocation(line: 486, column: 18, scope: !955)
!968 = !DILocation(line: 489, column: 14, scope: !955)
!969 = !DILocation(line: 489, column: 10, scope: !955)
!970 = !DILocation(line: 489, column: 8, scope: !955)
!971 = !DILocation(line: 489, column: 5, scope: !955)
!972 = !DILabel(scope: !955, name: "quantl_label9", file: !3, line: 492)
!973 = !DILocation(line: 492, column: 5, scope: !955)
!974 = !DILocation(line: 493, column: 14, scope: !975)
!975 = distinct !DILexicalBlock(scope: !955, file: !3, line: 493, column: 5)
!976 = !DILocation(line: 493, column: 10, scope: !975)
!977 = !DILocation(line: 493, column: 19, scope: !978)
!978 = distinct !DILexicalBlock(scope: !975, file: !3, line: 493, column: 5)
!979 = !DILocation(line: 493, column: 23, scope: !978)
!980 = !DILocation(line: 493, column: 5, scope: !975)
!981 = !DILocation(line: 495, column: 29, scope: !982)
!982 = distinct !DILexicalBlock(scope: !978, file: !3, line: 493, column: 36)
!983 = !DILocation(line: 495, column: 18, scope: !982)
!984 = !DILocation(line: 495, column: 42, scope: !982)
!985 = !DILocation(line: 495, column: 36, scope: !982)
!986 = !DILocation(line: 495, column: 34, scope: !982)
!987 = !DILocation(line: 495, column: 48, scope: !982)
!988 = !DILocation(line: 495, column: 15, scope: !982)
!989 = !DILocation(line: 496, column: 13, scope: !990)
!990 = distinct !DILexicalBlock(scope: !982, file: !3, line: 496, column: 13)
!991 = !DILocation(line: 496, column: 19, scope: !990)
!992 = !DILocation(line: 496, column: 16, scope: !990)
!993 = !DILocation(line: 496, column: 13, scope: !982)
!994 = !DILocation(line: 497, column: 13, scope: !990)
!995 = !DILocation(line: 498, column: 5, scope: !982)
!996 = !DILocation(line: 493, column: 32, scope: !978)
!997 = !DILocation(line: 493, column: 5, scope: !978)
!998 = distinct !{!998, !980, !999, !264}
!999 = !DILocation(line: 498, column: 5, scope: !975)
!1000 = !DILocation(line: 501, column: 9, scope: !1001)
!1001 = distinct !DILexicalBlock(scope: !955, file: !3, line: 501, column: 9)
!1002 = !DILocation(line: 501, column: 12, scope: !1001)
!1003 = !DILocation(line: 501, column: 9, scope: !955)
!1004 = !DILocation(line: 502, column: 29, scope: !1001)
!1005 = !DILocation(line: 502, column: 15, scope: !1001)
!1006 = !DILocation(line: 502, column: 13, scope: !1001)
!1007 = !DILocation(line: 502, column: 9, scope: !1001)
!1008 = !DILocation(line: 504, column: 29, scope: !1001)
!1009 = !DILocation(line: 504, column: 15, scope: !1001)
!1010 = !DILocation(line: 504, column: 13, scope: !1001)
!1011 = !DILocation(line: 505, column: 13, scope: !955)
!1012 = !DILocation(line: 505, column: 5, scope: !955)
!1013 = distinct !DISubprogram(name: "logscl", scope: !3, file: !3, line: 509, type: !296, scopeLine: 509, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!1014 = !DILocalVariable(name: "il", arg: 1, scope: !1013, file: !3, line: 509, type: !6)
!1015 = !DILocation(line: 509, column: 16, scope: !1013)
!1016 = !DILocalVariable(name: "nbl", arg: 2, scope: !1013, file: !3, line: 509, type: !6)
!1017 = !DILocation(line: 509, column: 24, scope: !1013)
!1018 = !DILocalVariable(name: "wd", scope: !1013, file: !3, line: 510, type: !5)
!1019 = !DILocation(line: 510, column: 14, scope: !1013)
!1020 = !DILocation(line: 511, column: 17, scope: !1013)
!1021 = !DILocation(line: 511, column: 11, scope: !1013)
!1022 = !DILocation(line: 511, column: 21, scope: !1013)
!1023 = !DILocation(line: 511, column: 29, scope: !1013)
!1024 = !DILocation(line: 511, column: 8, scope: !1013)
!1025 = !DILocation(line: 512, column: 16, scope: !1013)
!1026 = !DILocation(line: 512, column: 11, scope: !1013)
!1027 = !DILocation(line: 512, column: 35, scope: !1013)
!1028 = !DILocation(line: 512, column: 38, scope: !1013)
!1029 = !DILocation(line: 512, column: 21, scope: !1013)
!1030 = !DILocation(line: 512, column: 19, scope: !1013)
!1031 = !DILocation(line: 512, column: 9, scope: !1013)
!1032 = !DILocation(line: 513, column: 9, scope: !1033)
!1033 = distinct !DILexicalBlock(scope: !1013, file: !3, line: 513, column: 9)
!1034 = !DILocation(line: 513, column: 13, scope: !1033)
!1035 = !DILocation(line: 513, column: 9, scope: !1013)
!1036 = !DILocation(line: 514, column: 13, scope: !1033)
!1037 = !DILocation(line: 514, column: 9, scope: !1033)
!1038 = !DILocation(line: 515, column: 9, scope: !1039)
!1039 = distinct !DILexicalBlock(scope: !1013, file: !3, line: 515, column: 9)
!1040 = !DILocation(line: 515, column: 13, scope: !1039)
!1041 = !DILocation(line: 515, column: 9, scope: !1013)
!1042 = !DILocation(line: 516, column: 13, scope: !1039)
!1043 = !DILocation(line: 516, column: 9, scope: !1039)
!1044 = !DILocation(line: 517, column: 13, scope: !1013)
!1045 = !DILocation(line: 517, column: 5, scope: !1013)
!1046 = distinct !DISubprogram(name: "scalel", scope: !3, file: !3, line: 521, type: !296, scopeLine: 521, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!1047 = !DILocalVariable(name: "nbl", arg: 1, scope: !1046, file: !3, line: 521, type: !6)
!1048 = !DILocation(line: 521, column: 16, scope: !1046)
!1049 = !DILocalVariable(name: "shift_constant", arg: 2, scope: !1046, file: !3, line: 521, type: !6)
!1050 = !DILocation(line: 521, column: 25, scope: !1046)
!1051 = !DILocalVariable(name: "wd1", scope: !1046, file: !3, line: 522, type: !6)
!1052 = !DILocation(line: 522, column: 9, scope: !1046)
!1053 = !DILocalVariable(name: "wd2", scope: !1046, file: !3, line: 522, type: !6)
!1054 = !DILocation(line: 522, column: 14, scope: !1046)
!1055 = !DILocalVariable(name: "wd3", scope: !1046, file: !3, line: 522, type: !6)
!1056 = !DILocation(line: 522, column: 19, scope: !1046)
!1057 = !DILocation(line: 523, column: 12, scope: !1046)
!1058 = !DILocation(line: 523, column: 16, scope: !1046)
!1059 = !DILocation(line: 523, column: 22, scope: !1046)
!1060 = !DILocation(line: 523, column: 9, scope: !1046)
!1061 = !DILocation(line: 524, column: 11, scope: !1046)
!1062 = !DILocation(line: 524, column: 15, scope: !1046)
!1063 = !DILocation(line: 524, column: 9, scope: !1046)
!1064 = !DILocation(line: 525, column: 21, scope: !1046)
!1065 = !DILocation(line: 525, column: 11, scope: !1046)
!1066 = !DILocation(line: 525, column: 30, scope: !1046)
!1067 = !DILocation(line: 525, column: 45, scope: !1046)
!1068 = !DILocation(line: 525, column: 51, scope: !1046)
!1069 = !DILocation(line: 525, column: 49, scope: !1046)
!1070 = !DILocation(line: 525, column: 26, scope: !1046)
!1071 = !DILocation(line: 525, column: 9, scope: !1046)
!1072 = !DILocation(line: 526, column: 13, scope: !1046)
!1073 = !DILocation(line: 526, column: 17, scope: !1046)
!1074 = !DILocation(line: 526, column: 5, scope: !1046)
!1075 = distinct !DISubprogram(name: "upzero", scope: !3, file: !3, line: 531, type: !1076, scopeLine: 531, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!1076 = !DISubroutineType(types: !1077)
!1077 = !{null, !6, !227, !227}
!1078 = !DILocalVariable(name: "dlt", arg: 1, scope: !1075, file: !3, line: 531, type: !6)
!1079 = !DILocation(line: 531, column: 17, scope: !1075)
!1080 = !DILocalVariable(name: "dlti", arg: 2, scope: !1075, file: !3, line: 531, type: !227)
!1081 = !DILocation(line: 531, column: 27, scope: !1075)
!1082 = !DILocalVariable(name: "bli", arg: 3, scope: !1075, file: !3, line: 531, type: !227)
!1083 = !DILocation(line: 531, column: 38, scope: !1075)
!1084 = !DILocalVariable(name: "i", scope: !1075, file: !3, line: 532, type: !6)
!1085 = !DILocation(line: 532, column: 9, scope: !1075)
!1086 = !DILocalVariable(name: "wd2", scope: !1075, file: !3, line: 532, type: !6)
!1087 = !DILocation(line: 532, column: 12, scope: !1075)
!1088 = !DILocalVariable(name: "wd3", scope: !1075, file: !3, line: 532, type: !6)
!1089 = !DILocation(line: 532, column: 17, scope: !1075)
!1090 = !DILocation(line: 535, column: 9, scope: !1091)
!1091 = distinct !DILexicalBlock(scope: !1075, file: !3, line: 535, column: 9)
!1092 = !DILocation(line: 535, column: 13, scope: !1091)
!1093 = !DILocation(line: 535, column: 9, scope: !1075)
!1094 = !DILocation(line: 535, column: 19, scope: !1091)
!1095 = !DILabel(scope: !1096, name: "upzero_label10", file: !3, line: 536)
!1096 = distinct !DILexicalBlock(scope: !1091, file: !3, line: 535, column: 19)
!1097 = !DILocation(line: 536, column: 9, scope: !1096)
!1098 = !DILocation(line: 537, column: 16, scope: !1099)
!1099 = distinct !DILexicalBlock(scope: !1096, file: !3, line: 537, column: 9)
!1100 = !DILocation(line: 537, column: 14, scope: !1099)
!1101 = !DILocation(line: 537, column: 21, scope: !1102)
!1102 = distinct !DILexicalBlock(scope: !1099, file: !3, line: 537, column: 9)
!1103 = !DILocation(line: 537, column: 23, scope: !1102)
!1104 = !DILocation(line: 537, column: 9, scope: !1099)
!1105 = !DILocation(line: 539, column: 36, scope: !1106)
!1106 = distinct !DILexicalBlock(scope: !1102, file: !3, line: 537, column: 33)
!1107 = !DILocation(line: 539, column: 40, scope: !1106)
!1108 = !DILocation(line: 539, column: 34, scope: !1106)
!1109 = !DILocation(line: 539, column: 44, scope: !1106)
!1110 = !DILocation(line: 539, column: 22, scope: !1106)
!1111 = !DILocation(line: 539, column: 13, scope: !1106)
!1112 = !DILocation(line: 539, column: 17, scope: !1106)
!1113 = !DILocation(line: 539, column: 20, scope: !1106)
!1114 = !DILocation(line: 540, column: 9, scope: !1106)
!1115 = !DILocation(line: 537, column: 29, scope: !1102)
!1116 = !DILocation(line: 537, column: 9, scope: !1102)
!1117 = distinct !{!1117, !1104, !1118, !264}
!1118 = !DILocation(line: 540, column: 9, scope: !1099)
!1119 = !DILocation(line: 541, column: 5, scope: !1096)
!1120 = !DILocation(line: 541, column: 12, scope: !1091)
!1121 = !DILabel(scope: !1122, name: "upzero_label11", file: !3, line: 542)
!1122 = distinct !DILexicalBlock(scope: !1091, file: !3, line: 541, column: 12)
!1123 = !DILocation(line: 542, column: 9, scope: !1122)
!1124 = !DILocation(line: 543, column: 16, scope: !1125)
!1125 = distinct !DILexicalBlock(scope: !1122, file: !3, line: 543, column: 9)
!1126 = !DILocation(line: 543, column: 14, scope: !1125)
!1127 = !DILocation(line: 543, column: 21, scope: !1128)
!1128 = distinct !DILexicalBlock(scope: !1125, file: !3, line: 543, column: 9)
!1129 = !DILocation(line: 543, column: 23, scope: !1128)
!1130 = !DILocation(line: 543, column: 9, scope: !1125)
!1131 = !DILocation(line: 545, column: 23, scope: !1132)
!1132 = distinct !DILexicalBlock(scope: !1133, file: !3, line: 545, column: 17)
!1133 = distinct !DILexicalBlock(scope: !1128, file: !3, line: 543, column: 33)
!1134 = !DILocation(line: 545, column: 17, scope: !1132)
!1135 = !DILocation(line: 545, column: 29, scope: !1132)
!1136 = !DILocation(line: 545, column: 34, scope: !1132)
!1137 = !DILocation(line: 545, column: 27, scope: !1132)
!1138 = !DILocation(line: 545, column: 37, scope: !1132)
!1139 = !DILocation(line: 545, column: 17, scope: !1133)
!1140 = !DILocation(line: 546, column: 21, scope: !1132)
!1141 = !DILocation(line: 546, column: 17, scope: !1132)
!1142 = !DILocation(line: 548, column: 21, scope: !1132)
!1143 = !DILocation(line: 549, column: 33, scope: !1133)
!1144 = !DILocation(line: 549, column: 37, scope: !1133)
!1145 = !DILocation(line: 549, column: 31, scope: !1133)
!1146 = !DILocation(line: 549, column: 41, scope: !1133)
!1147 = !DILocation(line: 549, column: 19, scope: !1133)
!1148 = !DILocation(line: 549, column: 17, scope: !1133)
!1149 = !DILocation(line: 550, column: 22, scope: !1133)
!1150 = !DILocation(line: 550, column: 28, scope: !1133)
!1151 = !DILocation(line: 550, column: 26, scope: !1133)
!1152 = !DILocation(line: 550, column: 13, scope: !1133)
!1153 = !DILocation(line: 550, column: 17, scope: !1133)
!1154 = !DILocation(line: 550, column: 20, scope: !1133)
!1155 = !DILocation(line: 551, column: 9, scope: !1133)
!1156 = !DILocation(line: 543, column: 29, scope: !1128)
!1157 = !DILocation(line: 543, column: 9, scope: !1128)
!1158 = distinct !{!1158, !1130, !1159, !264}
!1159 = !DILocation(line: 551, column: 9, scope: !1125)
!1160 = !DILocation(line: 555, column: 15, scope: !1075)
!1161 = !DILocation(line: 555, column: 5, scope: !1075)
!1162 = !DILocation(line: 555, column: 13, scope: !1075)
!1163 = !DILocation(line: 556, column: 15, scope: !1075)
!1164 = !DILocation(line: 556, column: 5, scope: !1075)
!1165 = !DILocation(line: 556, column: 13, scope: !1075)
!1166 = !DILocation(line: 557, column: 15, scope: !1075)
!1167 = !DILocation(line: 557, column: 5, scope: !1075)
!1168 = !DILocation(line: 557, column: 13, scope: !1075)
!1169 = !DILocation(line: 558, column: 15, scope: !1075)
!1170 = !DILocation(line: 558, column: 5, scope: !1075)
!1171 = !DILocation(line: 558, column: 13, scope: !1075)
!1172 = !DILocation(line: 559, column: 15, scope: !1075)
!1173 = !DILocation(line: 559, column: 5, scope: !1075)
!1174 = !DILocation(line: 559, column: 13, scope: !1075)
!1175 = !DILocation(line: 560, column: 15, scope: !1075)
!1176 = !DILocation(line: 560, column: 5, scope: !1075)
!1177 = !DILocation(line: 560, column: 13, scope: !1075)
!1178 = !DILocation(line: 561, column: 1, scope: !1075)
!1179 = distinct !DISubprogram(name: "uppol2", scope: !3, file: !3, line: 565, type: !1180, scopeLine: 565, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!1180 = !DISubroutineType(types: !1181)
!1181 = !{!6, !6, !6, !6, !6, !6}
!1182 = !DILocalVariable(name: "al1", arg: 1, scope: !1179, file: !3, line: 565, type: !6)
!1183 = !DILocation(line: 565, column: 16, scope: !1179)
!1184 = !DILocalVariable(name: "al2", arg: 2, scope: !1179, file: !3, line: 565, type: !6)
!1185 = !DILocation(line: 565, column: 25, scope: !1179)
!1186 = !DILocalVariable(name: "plt", arg: 3, scope: !1179, file: !3, line: 565, type: !6)
!1187 = !DILocation(line: 565, column: 34, scope: !1179)
!1188 = !DILocalVariable(name: "plt1", arg: 4, scope: !1179, file: !3, line: 565, type: !6)
!1189 = !DILocation(line: 565, column: 43, scope: !1179)
!1190 = !DILocalVariable(name: "plt2", arg: 5, scope: !1179, file: !3, line: 565, type: !6)
!1191 = !DILocation(line: 565, column: 53, scope: !1179)
!1192 = !DILocalVariable(name: "wd2", scope: !1179, file: !3, line: 566, type: !5)
!1193 = !DILocation(line: 566, column: 14, scope: !1179)
!1194 = !DILocalVariable(name: "wd4", scope: !1179, file: !3, line: 566, type: !5)
!1195 = !DILocation(line: 566, column: 19, scope: !1179)
!1196 = !DILocalVariable(name: "apl2", scope: !1179, file: !3, line: 567, type: !6)
!1197 = !DILocation(line: 567, column: 9, scope: !1179)
!1198 = !DILocation(line: 569, column: 22, scope: !1179)
!1199 = !DILocation(line: 569, column: 16, scope: !1179)
!1200 = !DILocation(line: 569, column: 14, scope: !1179)
!1201 = !DILocation(line: 569, column: 9, scope: !1179)
!1202 = !DILocation(line: 570, column: 15, scope: !1203)
!1203 = distinct !DILexicalBlock(scope: !1179, file: !3, line: 570, column: 9)
!1204 = !DILocation(line: 570, column: 9, scope: !1203)
!1205 = !DILocation(line: 570, column: 21, scope: !1203)
!1206 = !DILocation(line: 570, column: 19, scope: !1203)
!1207 = !DILocation(line: 570, column: 26, scope: !1203)
!1208 = !DILocation(line: 570, column: 9, scope: !1179)
!1209 = !DILocation(line: 571, column: 16, scope: !1203)
!1210 = !DILocation(line: 571, column: 15, scope: !1203)
!1211 = !DILocation(line: 571, column: 13, scope: !1203)
!1212 = !DILocation(line: 571, column: 9, scope: !1203)
!1213 = !DILocation(line: 572, column: 11, scope: !1179)
!1214 = !DILocation(line: 572, column: 15, scope: !1179)
!1215 = !DILocation(line: 572, column: 9, scope: !1179)
!1216 = !DILocation(line: 574, column: 15, scope: !1217)
!1217 = distinct !DILexicalBlock(scope: !1179, file: !3, line: 574, column: 9)
!1218 = !DILocation(line: 574, column: 9, scope: !1217)
!1219 = !DILocation(line: 574, column: 21, scope: !1217)
!1220 = !DILocation(line: 574, column: 19, scope: !1217)
!1221 = !DILocation(line: 574, column: 26, scope: !1217)
!1222 = !DILocation(line: 574, column: 9, scope: !1179)
!1223 = !DILocation(line: 575, column: 15, scope: !1224)
!1224 = distinct !DILexicalBlock(scope: !1217, file: !3, line: 574, column: 33)
!1225 = !DILocation(line: 575, column: 19, scope: !1224)
!1226 = !DILocation(line: 575, column: 13, scope: !1224)
!1227 = !DILocation(line: 576, column: 5, scope: !1224)
!1228 = !DILocation(line: 577, column: 15, scope: !1229)
!1229 = distinct !DILexicalBlock(scope: !1217, file: !3, line: 576, column: 12)
!1230 = !DILocation(line: 577, column: 19, scope: !1229)
!1231 = !DILocation(line: 577, column: 13, scope: !1229)
!1232 = !DILocation(line: 580, column: 12, scope: !1179)
!1233 = !DILocation(line: 580, column: 32, scope: !1179)
!1234 = !DILocation(line: 580, column: 26, scope: !1179)
!1235 = !DILocation(line: 580, column: 24, scope: !1179)
!1236 = !DILocation(line: 580, column: 36, scope: !1179)
!1237 = !DILocation(line: 580, column: 16, scope: !1179)
!1238 = !DILocation(line: 580, column: 10, scope: !1179)
!1239 = !DILocation(line: 583, column: 9, scope: !1240)
!1240 = distinct !DILexicalBlock(scope: !1179, file: !3, line: 583, column: 9)
!1241 = !DILocation(line: 583, column: 14, scope: !1240)
!1242 = !DILocation(line: 583, column: 9, scope: !1179)
!1243 = !DILocation(line: 584, column: 14, scope: !1240)
!1244 = !DILocation(line: 584, column: 9, scope: !1240)
!1245 = !DILocation(line: 585, column: 9, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1179, file: !3, line: 585, column: 9)
!1247 = !DILocation(line: 585, column: 14, scope: !1246)
!1248 = !DILocation(line: 585, column: 9, scope: !1179)
!1249 = !DILocation(line: 586, column: 14, scope: !1246)
!1250 = !DILocation(line: 586, column: 9, scope: !1246)
!1251 = !DILocation(line: 588, column: 12, scope: !1179)
!1252 = !DILocation(line: 588, column: 5, scope: !1179)
!1253 = distinct !DISubprogram(name: "uppol1", scope: !3, file: !3, line: 593, type: !919, scopeLine: 593, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!1254 = !DILocalVariable(name: "al1", arg: 1, scope: !1253, file: !3, line: 593, type: !6)
!1255 = !DILocation(line: 593, column: 16, scope: !1253)
!1256 = !DILocalVariable(name: "apl2", arg: 2, scope: !1253, file: !3, line: 593, type: !6)
!1257 = !DILocation(line: 593, column: 25, scope: !1253)
!1258 = !DILocalVariable(name: "plt", arg: 3, scope: !1253, file: !3, line: 593, type: !6)
!1259 = !DILocation(line: 593, column: 35, scope: !1253)
!1260 = !DILocalVariable(name: "plt1", arg: 4, scope: !1253, file: !3, line: 593, type: !6)
!1261 = !DILocation(line: 593, column: 44, scope: !1253)
!1262 = !DILocalVariable(name: "wd2", scope: !1253, file: !3, line: 594, type: !5)
!1263 = !DILocation(line: 594, column: 14, scope: !1253)
!1264 = !DILocalVariable(name: "wd3", scope: !1253, file: !3, line: 595, type: !6)
!1265 = !DILocation(line: 595, column: 9, scope: !1253)
!1266 = !DILocalVariable(name: "apl1", scope: !1253, file: !3, line: 595, type: !6)
!1267 = !DILocation(line: 595, column: 14, scope: !1253)
!1268 = !DILocation(line: 597, column: 18, scope: !1253)
!1269 = !DILocation(line: 597, column: 12, scope: !1253)
!1270 = !DILocation(line: 597, column: 22, scope: !1253)
!1271 = !DILocation(line: 597, column: 30, scope: !1253)
!1272 = !DILocation(line: 597, column: 9, scope: !1253)
!1273 = !DILocation(line: 599, column: 15, scope: !1274)
!1274 = distinct !DILexicalBlock(scope: !1253, file: !3, line: 599, column: 9)
!1275 = !DILocation(line: 599, column: 9, scope: !1274)
!1276 = !DILocation(line: 599, column: 21, scope: !1274)
!1277 = !DILocation(line: 599, column: 19, scope: !1274)
!1278 = !DILocation(line: 599, column: 26, scope: !1274)
!1279 = !DILocation(line: 599, column: 9, scope: !1253)
!1280 = !DILocation(line: 600, column: 21, scope: !1281)
!1281 = distinct !DILexicalBlock(scope: !1274, file: !3, line: 599, column: 33)
!1282 = !DILocation(line: 600, column: 16, scope: !1281)
!1283 = !DILocation(line: 600, column: 25, scope: !1281)
!1284 = !DILocation(line: 600, column: 14, scope: !1281)
!1285 = !DILocation(line: 601, column: 5, scope: !1281)
!1286 = !DILocation(line: 602, column: 21, scope: !1287)
!1287 = distinct !DILexicalBlock(scope: !1274, file: !3, line: 601, column: 12)
!1288 = !DILocation(line: 602, column: 16, scope: !1287)
!1289 = !DILocation(line: 602, column: 25, scope: !1287)
!1290 = !DILocation(line: 602, column: 14, scope: !1287)
!1291 = !DILocation(line: 606, column: 19, scope: !1253)
!1292 = !DILocation(line: 606, column: 17, scope: !1253)
!1293 = !DILocation(line: 606, column: 9, scope: !1253)
!1294 = !DILocation(line: 607, column: 9, scope: !1295)
!1295 = distinct !DILexicalBlock(scope: !1253, file: !3, line: 607, column: 9)
!1296 = !DILocation(line: 607, column: 16, scope: !1295)
!1297 = !DILocation(line: 607, column: 14, scope: !1295)
!1298 = !DILocation(line: 607, column: 9, scope: !1253)
!1299 = !DILocation(line: 608, column: 16, scope: !1295)
!1300 = !DILocation(line: 608, column: 14, scope: !1295)
!1301 = !DILocation(line: 608, column: 9, scope: !1295)
!1302 = !DILocation(line: 609, column: 9, scope: !1303)
!1303 = distinct !DILexicalBlock(scope: !1253, file: !3, line: 609, column: 9)
!1304 = !DILocation(line: 609, column: 17, scope: !1303)
!1305 = !DILocation(line: 609, column: 16, scope: !1303)
!1306 = !DILocation(line: 609, column: 14, scope: !1303)
!1307 = !DILocation(line: 609, column: 9, scope: !1253)
!1308 = !DILocation(line: 610, column: 17, scope: !1303)
!1309 = !DILocation(line: 610, column: 16, scope: !1303)
!1310 = !DILocation(line: 610, column: 14, scope: !1303)
!1311 = !DILocation(line: 610, column: 9, scope: !1303)
!1312 = !DILocation(line: 612, column: 12, scope: !1253)
!1313 = !DILocation(line: 612, column: 5, scope: !1253)
!1314 = distinct !DISubprogram(name: "logsch", scope: !3, file: !3, line: 617, type: !296, scopeLine: 617, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!1315 = !DILocalVariable(name: "ih", arg: 1, scope: !1314, file: !3, line: 617, type: !6)
!1316 = !DILocation(line: 617, column: 16, scope: !1314)
!1317 = !DILocalVariable(name: "nbh", arg: 2, scope: !1314, file: !3, line: 617, type: !6)
!1318 = !DILocation(line: 617, column: 24, scope: !1314)
!1319 = !DILocalVariable(name: "wd", scope: !1314, file: !3, line: 618, type: !6)
!1320 = !DILocation(line: 618, column: 9, scope: !1314)
!1321 = !DILocation(line: 620, column: 17, scope: !1314)
!1322 = !DILocation(line: 620, column: 11, scope: !1314)
!1323 = !DILocation(line: 620, column: 21, scope: !1314)
!1324 = !DILocation(line: 620, column: 29, scope: !1314)
!1325 = !DILocation(line: 620, column: 10, scope: !1314)
!1326 = !DILocation(line: 620, column: 8, scope: !1314)
!1327 = !DILocation(line: 621, column: 11, scope: !1314)
!1328 = !DILocation(line: 621, column: 30, scope: !1314)
!1329 = !DILocation(line: 621, column: 16, scope: !1314)
!1330 = !DILocation(line: 621, column: 14, scope: !1314)
!1331 = !DILocation(line: 621, column: 9, scope: !1314)
!1332 = !DILocation(line: 622, column: 9, scope: !1333)
!1333 = distinct !DILexicalBlock(scope: !1314, file: !3, line: 622, column: 9)
!1334 = !DILocation(line: 622, column: 13, scope: !1333)
!1335 = !DILocation(line: 622, column: 9, scope: !1314)
!1336 = !DILocation(line: 623, column: 13, scope: !1333)
!1337 = !DILocation(line: 623, column: 9, scope: !1333)
!1338 = !DILocation(line: 624, column: 9, scope: !1339)
!1339 = distinct !DILexicalBlock(scope: !1314, file: !3, line: 624, column: 9)
!1340 = !DILocation(line: 624, column: 13, scope: !1339)
!1341 = !DILocation(line: 624, column: 9, scope: !1314)
!1342 = !DILocation(line: 625, column: 13, scope: !1339)
!1343 = !DILocation(line: 625, column: 9, scope: !1339)
!1344 = !DILocation(line: 627, column: 12, scope: !1314)
!1345 = !DILocation(line: 627, column: 5, scope: !1314)
!1346 = distinct !DISubprogram(name: "reset", scope: !3, file: !3, line: 416, type: !1347, scopeLine: 416, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !228)
!1347 = !DISubroutineType(types: !1348)
!1348 = !{null}
!1349 = !DILocalVariable(name: "i", scope: !1346, file: !3, line: 417, type: !6)
!1350 = !DILocation(line: 417, column: 9, scope: !1346)
!1351 = !DILocation(line: 419, column: 21, scope: !1346)
!1352 = !DILocation(line: 419, column: 10, scope: !1346)
!1353 = !DILocation(line: 420, column: 21, scope: !1346)
!1354 = !DILocation(line: 420, column: 10, scope: !1346)
!1355 = !DILocation(line: 421, column: 49, scope: !1346)
!1356 = !DILocation(line: 421, column: 42, scope: !1346)
!1357 = !DILocation(line: 421, column: 35, scope: !1346)
!1358 = !DILocation(line: 421, column: 28, scope: !1346)
!1359 = !DILocation(line: 421, column: 21, scope: !1346)
!1360 = !DILocation(line: 421, column: 15, scope: !1346)
!1361 = !DILocation(line: 421, column: 9, scope: !1346)
!1362 = !DILocation(line: 422, column: 45, scope: !1346)
!1363 = !DILocation(line: 422, column: 39, scope: !1346)
!1364 = !DILocation(line: 422, column: 33, scope: !1346)
!1365 = !DILocation(line: 422, column: 27, scope: !1346)
!1366 = !DILocation(line: 422, column: 21, scope: !1346)
!1367 = !DILocation(line: 422, column: 15, scope: !1346)
!1368 = !DILocation(line: 422, column: 9, scope: !1346)
!1369 = !DILocation(line: 423, column: 77, scope: !1346)
!1370 = !DILocation(line: 423, column: 66, scope: !1346)
!1371 = !DILocation(line: 423, column: 55, scope: !1346)
!1372 = !DILocation(line: 423, column: 44, scope: !1346)
!1373 = !DILocation(line: 423, column: 33, scope: !1346)
!1374 = !DILocation(line: 423, column: 23, scope: !1346)
!1375 = !DILocation(line: 423, column: 13, scope: !1346)
!1376 = !DILocation(line: 424, column: 73, scope: !1346)
!1377 = !DILocation(line: 424, column: 63, scope: !1346)
!1378 = !DILocation(line: 424, column: 53, scope: !1346)
!1379 = !DILocation(line: 424, column: 43, scope: !1346)
!1380 = !DILocation(line: 424, column: 33, scope: !1346)
!1381 = !DILocation(line: 424, column: 23, scope: !1346)
!1382 = !DILocation(line: 424, column: 13, scope: !1346)
!1383 = !DILocation(line: 424, column: 5, scope: !1346)
!1384 = !DILabel(scope: !1346, name: "reset_label4", file: !3, line: 426)
!1385 = !DILocation(line: 426, column: 5, scope: !1346)
!1386 = !DILocation(line: 427, column: 12, scope: !1387)
!1387 = distinct !DILexicalBlock(scope: !1346, file: !3, line: 427, column: 5)
!1388 = !DILocation(line: 427, column: 10, scope: !1387)
!1389 = !DILocation(line: 427, column: 17, scope: !1390)
!1390 = distinct !DILexicalBlock(scope: !1387, file: !3, line: 427, column: 5)
!1391 = !DILocation(line: 427, column: 19, scope: !1390)
!1392 = !DILocation(line: 427, column: 5, scope: !1387)
!1393 = !DILocation(line: 429, column: 20, scope: !1394)
!1394 = distinct !DILexicalBlock(scope: !1390, file: !3, line: 427, column: 29)
!1395 = !DILocation(line: 429, column: 9, scope: !1394)
!1396 = !DILocation(line: 429, column: 23, scope: !1394)
!1397 = !DILocation(line: 430, column: 19, scope: !1394)
!1398 = !DILocation(line: 430, column: 9, scope: !1394)
!1399 = !DILocation(line: 430, column: 22, scope: !1394)
!1400 = !DILocation(line: 431, column: 22, scope: !1394)
!1401 = !DILocation(line: 431, column: 9, scope: !1394)
!1402 = !DILocation(line: 431, column: 25, scope: !1394)
!1403 = !DILocation(line: 432, column: 21, scope: !1394)
!1404 = !DILocation(line: 432, column: 9, scope: !1394)
!1405 = !DILocation(line: 432, column: 24, scope: !1394)
!1406 = !DILocation(line: 433, column: 5, scope: !1394)
!1407 = !DILocation(line: 427, column: 25, scope: !1390)
!1408 = !DILocation(line: 427, column: 5, scope: !1390)
!1409 = distinct !{!1409, !1392, !1410, !264}
!1410 = !DILocation(line: 433, column: 5, scope: !1387)
!1411 = !DILabel(scope: !1346, name: "reset_label5", file: !3, line: 435)
!1412 = !DILocation(line: 435, column: 5, scope: !1346)
!1413 = !DILocation(line: 436, column: 12, scope: !1414)
!1414 = distinct !DILexicalBlock(scope: !1346, file: !3, line: 436, column: 5)
!1415 = !DILocation(line: 436, column: 10, scope: !1414)
!1416 = !DILocation(line: 436, column: 17, scope: !1417)
!1417 = distinct !DILexicalBlock(scope: !1414, file: !3, line: 436, column: 5)
!1418 = !DILocation(line: 436, column: 19, scope: !1417)
!1419 = !DILocation(line: 436, column: 5, scope: !1414)
!1420 = !DILocation(line: 438, column: 19, scope: !1421)
!1421 = distinct !DILexicalBlock(scope: !1417, file: !3, line: 436, column: 29)
!1422 = !DILocation(line: 438, column: 9, scope: !1421)
!1423 = !DILocation(line: 438, column: 22, scope: !1421)
!1424 = !DILocation(line: 439, column: 19, scope: !1421)
!1425 = !DILocation(line: 439, column: 9, scope: !1421)
!1426 = !DILocation(line: 439, column: 22, scope: !1421)
!1427 = !DILocation(line: 440, column: 21, scope: !1421)
!1428 = !DILocation(line: 440, column: 9, scope: !1421)
!1429 = !DILocation(line: 440, column: 24, scope: !1421)
!1430 = !DILocation(line: 441, column: 21, scope: !1421)
!1431 = !DILocation(line: 441, column: 9, scope: !1421)
!1432 = !DILocation(line: 441, column: 24, scope: !1421)
!1433 = !DILocation(line: 442, column: 5, scope: !1421)
!1434 = !DILocation(line: 436, column: 25, scope: !1417)
!1435 = !DILocation(line: 436, column: 5, scope: !1417)
!1436 = distinct !{!1436, !1419, !1437, !264}
!1437 = !DILocation(line: 442, column: 5, scope: !1414)
!1438 = !DILabel(scope: !1346, name: "reset_label6", file: !3, line: 444)
!1439 = !DILocation(line: 444, column: 5, scope: !1346)
!1440 = !DILocation(line: 445, column: 12, scope: !1441)
!1441 = distinct !DILexicalBlock(scope: !1346, file: !3, line: 445, column: 5)
!1442 = !DILocation(line: 445, column: 10, scope: !1441)
!1443 = !DILocation(line: 445, column: 17, scope: !1444)
!1444 = distinct !DILexicalBlock(scope: !1441, file: !3, line: 445, column: 5)
!1445 = !DILocation(line: 445, column: 19, scope: !1444)
!1446 = !DILocation(line: 445, column: 5, scope: !1441)
!1447 = !DILocation(line: 447, column: 14, scope: !1448)
!1448 = distinct !DILexicalBlock(scope: !1444, file: !3, line: 445, column: 30)
!1449 = !DILocation(line: 447, column: 9, scope: !1448)
!1450 = !DILocation(line: 447, column: 17, scope: !1448)
!1451 = !DILocation(line: 448, column: 5, scope: !1448)
!1452 = !DILocation(line: 445, column: 26, scope: !1444)
!1453 = !DILocation(line: 445, column: 5, scope: !1444)
!1454 = distinct !{!1454, !1446, !1455, !264}
!1455 = !DILocation(line: 448, column: 5, scope: !1441)
!1456 = !DILabel(scope: !1346, name: "reset_label7", file: !3, line: 450)
!1457 = !DILocation(line: 450, column: 5, scope: !1346)
!1458 = !DILocation(line: 451, column: 12, scope: !1459)
!1459 = distinct !DILexicalBlock(scope: !1346, file: !3, line: 451, column: 5)
!1460 = !DILocation(line: 451, column: 10, scope: !1459)
!1461 = !DILocation(line: 451, column: 17, scope: !1462)
!1462 = distinct !DILexicalBlock(scope: !1459, file: !3, line: 451, column: 5)
!1463 = !DILocation(line: 451, column: 19, scope: !1462)
!1464 = !DILocation(line: 451, column: 5, scope: !1459)
!1465 = !DILocation(line: 453, column: 16, scope: !1466)
!1466 = distinct !DILexicalBlock(scope: !1462, file: !3, line: 451, column: 30)
!1467 = !DILocation(line: 453, column: 9, scope: !1466)
!1468 = !DILocation(line: 453, column: 19, scope: !1466)
!1469 = !DILocation(line: 454, column: 16, scope: !1466)
!1470 = !DILocation(line: 454, column: 9, scope: !1466)
!1471 = !DILocation(line: 454, column: 19, scope: !1466)
!1472 = !DILocation(line: 455, column: 5, scope: !1466)
!1473 = !DILocation(line: 451, column: 26, scope: !1462)
!1474 = !DILocation(line: 451, column: 5, scope: !1462)
!1475 = distinct !{!1475, !1464, !1476, !264}
!1476 = !DILocation(line: 455, column: 5, scope: !1459)
!1477 = !DILocation(line: 456, column: 1, scope: !1346)
