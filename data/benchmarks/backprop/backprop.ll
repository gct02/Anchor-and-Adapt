; ModuleID = 'data/benchmarks/real/backprop/backprop.c'
source_filename = "data/benchmarks/real/backprop/backprop.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @soft_max(double* noundef %net_outputs, double* noundef %activations) #0 !dbg !12 {
entry:
  %net_outputs.addr = alloca double*, align 8
  %activations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %sum = alloca double, align 8
  store double* %net_outputs, double** %net_outputs.addr, align 8
  call void @llvm.dbg.declare(metadata double** %net_outputs.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store double* %activations, double** %activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %activations.addr, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %i, metadata !21, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata double* %sum, metadata !24, metadata !DIExpression()), !dbg !25
  store double 0.000000e+00, double* %sum, align 8, !dbg !26
  br label %soft_max_loop1, !dbg !27

soft_max_loop1:                                   ; preds = %entry
  call void @llvm.dbg.label(metadata !28), !dbg !29
  store i32 0, i32* %i, align 4, !dbg !30
  br label %for.cond, !dbg !32

for.cond:                                         ; preds = %for.inc, %soft_max_loop1
  %0 = load i32, i32* %i, align 4, !dbg !33
  %cmp = icmp slt i32 %0, 3, !dbg !35
  br i1 %cmp, label %for.body, label %for.end, !dbg !36

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %activations.addr, align 8, !dbg !37
  %2 = load i32, i32* %i, align 4, !dbg !39
  %idxprom = sext i32 %2 to i64, !dbg !37
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !37
  %3 = load double, double* %arrayidx, align 8, !dbg !37
  %fneg = fneg double %3, !dbg !40
  %call = call double @exp(double noundef %fneg) #3, !dbg !41
  %4 = load double, double* %sum, align 8, !dbg !42
  %add = fadd double %4, %call, !dbg !42
  store double %add, double* %sum, align 8, !dbg !42
  br label %for.inc, !dbg !43

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4, !dbg !44
  %inc = add nsw i32 %5, 1, !dbg !44
  store i32 %inc, i32* %i, align 4, !dbg !44
  br label %for.cond, !dbg !45, !llvm.loop !46

for.end:                                          ; preds = %for.cond
  br label %soft_max_loop2, !dbg !47

soft_max_loop2:                                   ; preds = %for.end
  call void @llvm.dbg.label(metadata !49), !dbg !50
  store i32 0, i32* %i, align 4, !dbg !51
  br label %for.cond1, !dbg !53

for.cond1:                                        ; preds = %for.inc10, %soft_max_loop2
  %6 = load i32, i32* %i, align 4, !dbg !54
  %cmp2 = icmp slt i32 %6, 3, !dbg !56
  br i1 %cmp2, label %for.body3, label %for.end12, !dbg !57

for.body3:                                        ; preds = %for.cond1
  %7 = load double*, double** %activations.addr, align 8, !dbg !58
  %8 = load i32, i32* %i, align 4, !dbg !60
  %idxprom4 = sext i32 %8 to i64, !dbg !58
  %arrayidx5 = getelementptr inbounds double, double* %7, i64 %idxprom4, !dbg !58
  %9 = load double, double* %arrayidx5, align 8, !dbg !58
  %fneg6 = fneg double %9, !dbg !61
  %call7 = call double @exp(double noundef %fneg6) #3, !dbg !62
  %10 = load double, double* %sum, align 8, !dbg !63
  %div = fdiv double %call7, %10, !dbg !64
  %11 = load double*, double** %net_outputs.addr, align 8, !dbg !65
  %12 = load i32, i32* %i, align 4, !dbg !66
  %idxprom8 = sext i32 %12 to i64, !dbg !65
  %arrayidx9 = getelementptr inbounds double, double* %11, i64 %idxprom8, !dbg !65
  store double %div, double* %arrayidx9, align 8, !dbg !67
  br label %for.inc10, !dbg !68

for.inc10:                                        ; preds = %for.body3
  %13 = load i32, i32* %i, align 4, !dbg !69
  %inc11 = add nsw i32 %13, 1, !dbg !69
  store i32 %inc11, i32* %i, align 4, !dbg !69
  br label %for.cond1, !dbg !70, !llvm.loop !71

for.end12:                                        ; preds = %for.cond1
  ret void, !dbg !73
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: nounwind
declare double @exp(double noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @RELU(double* noundef %activations, double* noundef %dactivations, i32 noundef %size) #0 !dbg !74 {
entry:
  %activations.addr = alloca double*, align 8
  %dactivations.addr = alloca double*, align 8
  %size.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store double* %activations, double** %activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %activations.addr, metadata !77, metadata !DIExpression()), !dbg !78
  store double* %dactivations, double** %dactivations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %dactivations.addr, metadata !79, metadata !DIExpression()), !dbg !80
  store i32 %size, i32* %size.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %size.addr, metadata !81, metadata !DIExpression()), !dbg !82
  call void @llvm.dbg.declare(metadata i32* %i, metadata !83, metadata !DIExpression()), !dbg !84
  br label %RELU_loop1, !dbg !85

RELU_loop1:                                       ; preds = %entry
  call void @llvm.dbg.label(metadata !86), !dbg !87
  store i32 0, i32* %i, align 4, !dbg !88
  br label %for.cond, !dbg !90

for.cond:                                         ; preds = %for.inc, %RELU_loop1
  %0 = load i32, i32* %i, align 4, !dbg !91
  %1 = load i32, i32* %size.addr, align 4, !dbg !93
  %cmp = icmp slt i32 %0, %1, !dbg !94
  br i1 %cmp, label %for.body, label %for.end, !dbg !95

for.body:                                         ; preds = %for.cond
  %2 = load double*, double** %activations.addr, align 8, !dbg !96
  %3 = load i32, i32* %i, align 4, !dbg !98
  %idxprom = sext i32 %3 to i64, !dbg !96
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom, !dbg !96
  %4 = load double, double* %arrayidx, align 8, !dbg !96
  %5 = load double*, double** %activations.addr, align 8, !dbg !99
  %6 = load i32, i32* %i, align 4, !dbg !100
  %idxprom1 = sext i32 %6 to i64, !dbg !99
  %arrayidx2 = getelementptr inbounds double, double* %5, i64 %idxprom1, !dbg !99
  %7 = load double, double* %arrayidx2, align 8, !dbg !99
  %sub = fsub double 1.000000e+00, %7, !dbg !101
  %mul = fmul double %4, %sub, !dbg !102
  %8 = load double*, double** %dactivations.addr, align 8, !dbg !103
  %9 = load i32, i32* %i, align 4, !dbg !104
  %idxprom3 = sext i32 %9 to i64, !dbg !103
  %arrayidx4 = getelementptr inbounds double, double* %8, i64 %idxprom3, !dbg !103
  store double %mul, double* %arrayidx4, align 8, !dbg !105
  %10 = load double*, double** %activations.addr, align 8, !dbg !106
  %11 = load i32, i32* %i, align 4, !dbg !107
  %idxprom5 = sext i32 %11 to i64, !dbg !106
  %arrayidx6 = getelementptr inbounds double, double* %10, i64 %idxprom5, !dbg !106
  %12 = load double, double* %arrayidx6, align 8, !dbg !106
  %fneg = fneg double %12, !dbg !108
  %call = call double @exp(double noundef %fneg) #3, !dbg !109
  %add = fadd double 1.000000e+00, %call, !dbg !110
  %div = fdiv double 1.000000e+00, %add, !dbg !111
  %13 = load double*, double** %activations.addr, align 8, !dbg !112
  %14 = load i32, i32* %i, align 4, !dbg !113
  %idxprom7 = sext i32 %14 to i64, !dbg !112
  %arrayidx8 = getelementptr inbounds double, double* %13, i64 %idxprom7, !dbg !112
  store double %div, double* %arrayidx8, align 8, !dbg !114
  br label %for.inc, !dbg !115

for.inc:                                          ; preds = %for.body
  %15 = load i32, i32* %i, align 4, !dbg !116
  %inc = add nsw i32 %15, 1, !dbg !116
  store i32 %inc, i32* %i, align 4, !dbg !116
  br label %for.cond, !dbg !117, !llvm.loop !118

for.end:                                          ; preds = %for.cond
  ret void, !dbg !120
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @add_bias_to_activations(double* noundef %biases, double* noundef %activations, i32 noundef %size) #0 !dbg !121 {
entry:
  %biases.addr = alloca double*, align 8
  %activations.addr = alloca double*, align 8
  %size.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store double* %biases, double** %biases.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases.addr, metadata !122, metadata !DIExpression()), !dbg !123
  store double* %activations, double** %activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %activations.addr, metadata !124, metadata !DIExpression()), !dbg !125
  store i32 %size, i32* %size.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %size.addr, metadata !126, metadata !DIExpression()), !dbg !127
  call void @llvm.dbg.declare(metadata i32* %i, metadata !128, metadata !DIExpression()), !dbg !129
  br label %add_bias_to_activations_loop1, !dbg !130

add_bias_to_activations_loop1:                    ; preds = %entry
  call void @llvm.dbg.label(metadata !131), !dbg !132
  store i32 0, i32* %i, align 4, !dbg !133
  br label %for.cond, !dbg !135

for.cond:                                         ; preds = %for.inc, %add_bias_to_activations_loop1
  %0 = load i32, i32* %i, align 4, !dbg !136
  %1 = load i32, i32* %size.addr, align 4, !dbg !138
  %cmp = icmp slt i32 %0, %1, !dbg !139
  br i1 %cmp, label %for.body, label %for.end, !dbg !140

for.body:                                         ; preds = %for.cond
  %2 = load double*, double** %activations.addr, align 8, !dbg !141
  %3 = load i32, i32* %i, align 4, !dbg !143
  %idxprom = sext i32 %3 to i64, !dbg !141
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom, !dbg !141
  %4 = load double, double* %arrayidx, align 8, !dbg !141
  %5 = load double*, double** %biases.addr, align 8, !dbg !144
  %6 = load i32, i32* %i, align 4, !dbg !145
  %idxprom1 = sext i32 %6 to i64, !dbg !144
  %arrayidx2 = getelementptr inbounds double, double* %5, i64 %idxprom1, !dbg !144
  %7 = load double, double* %arrayidx2, align 8, !dbg !144
  %add = fadd double %4, %7, !dbg !146
  %8 = load double*, double** %activations.addr, align 8, !dbg !147
  %9 = load i32, i32* %i, align 4, !dbg !148
  %idxprom3 = sext i32 %9 to i64, !dbg !147
  %arrayidx4 = getelementptr inbounds double, double* %8, i64 %idxprom3, !dbg !147
  store double %add, double* %arrayidx4, align 8, !dbg !149
  br label %for.inc, !dbg !150

for.inc:                                          ; preds = %for.body
  %10 = load i32, i32* %i, align 4, !dbg !151
  %inc = add nsw i32 %10, 1, !dbg !151
  store i32 %inc, i32* %i, align 4, !dbg !151
  br label %for.cond, !dbg !152, !llvm.loop !153

for.end:                                          ; preds = %for.cond
  ret void, !dbg !155
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @matrix_vector_product_with_bias_input_layer(double* noundef %biases, double* noundef %weights, double* noundef %activations, double* noundef %input_sample) #0 !dbg !156 {
entry:
  %biases.addr = alloca double*, align 8
  %weights.addr = alloca double*, align 8
  %activations.addr = alloca double*, align 8
  %input_sample.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %biases, double** %biases.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases.addr, metadata !159, metadata !DIExpression()), !dbg !160
  store double* %weights, double** %weights.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights.addr, metadata !161, metadata !DIExpression()), !dbg !162
  store double* %activations, double** %activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %activations.addr, metadata !163, metadata !DIExpression()), !dbg !164
  store double* %input_sample, double** %input_sample.addr, align 8
  call void @llvm.dbg.declare(metadata double** %input_sample.addr, metadata !165, metadata !DIExpression()), !dbg !166
  call void @llvm.dbg.declare(metadata i32* %i, metadata !167, metadata !DIExpression()), !dbg !168
  call void @llvm.dbg.declare(metadata i32* %j, metadata !169, metadata !DIExpression()), !dbg !170
  br label %matrix_vector_product_with_bias_input_layer_loop1, !dbg !171

matrix_vector_product_with_bias_input_layer_loop1: ; preds = %entry
  call void @llvm.dbg.label(metadata !172), !dbg !173
  store i32 0, i32* %j, align 4, !dbg !174
  br label %for.cond, !dbg !176

for.cond:                                         ; preds = %for.inc11, %matrix_vector_product_with_bias_input_layer_loop1
  %0 = load i32, i32* %j, align 4, !dbg !177
  %cmp = icmp slt i32 %0, 64, !dbg !179
  br i1 %cmp, label %for.body, label %for.end13, !dbg !180

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %activations.addr, align 8, !dbg !181
  %2 = load i32, i32* %j, align 4, !dbg !183
  %idxprom = sext i32 %2 to i64, !dbg !181
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !181
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !184
  br label %matrix_vector_product_with_bias_input_layer_loop1_1, !dbg !181

matrix_vector_product_with_bias_input_layer_loop1_1: ; preds = %for.body
  call void @llvm.dbg.label(metadata !185), !dbg !186
  store i32 0, i32* %i, align 4, !dbg !187
  br label %for.cond1, !dbg !189

for.cond1:                                        ; preds = %for.inc, %matrix_vector_product_with_bias_input_layer_loop1_1
  %3 = load i32, i32* %i, align 4, !dbg !190
  %cmp2 = icmp slt i32 %3, 13, !dbg !192
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !193

for.body3:                                        ; preds = %for.cond1
  %4 = load double*, double** %weights.addr, align 8, !dbg !194
  %5 = load i32, i32* %j, align 4, !dbg !196
  %mul = mul nsw i32 %5, 13, !dbg !197
  %6 = load i32, i32* %i, align 4, !dbg !198
  %add = add nsw i32 %mul, %6, !dbg !199
  %idxprom4 = sext i32 %add to i64, !dbg !194
  %arrayidx5 = getelementptr inbounds double, double* %4, i64 %idxprom4, !dbg !194
  %7 = load double, double* %arrayidx5, align 8, !dbg !194
  %8 = load double*, double** %input_sample.addr, align 8, !dbg !200
  %9 = load i32, i32* %i, align 4, !dbg !201
  %idxprom6 = sext i32 %9 to i64, !dbg !200
  %arrayidx7 = getelementptr inbounds double, double* %8, i64 %idxprom6, !dbg !200
  %10 = load double, double* %arrayidx7, align 8, !dbg !200
  %11 = load double*, double** %activations.addr, align 8, !dbg !202
  %12 = load i32, i32* %j, align 4, !dbg !203
  %idxprom9 = sext i32 %12 to i64, !dbg !202
  %arrayidx10 = getelementptr inbounds double, double* %11, i64 %idxprom9, !dbg !202
  %13 = load double, double* %arrayidx10, align 8, !dbg !204
  %14 = call double @llvm.fmuladd.f64(double %7, double %10, double %13), !dbg !204
  store double %14, double* %arrayidx10, align 8, !dbg !204
  br label %for.inc, !dbg !205

for.inc:                                          ; preds = %for.body3
  %15 = load i32, i32* %i, align 4, !dbg !206
  %inc = add nsw i32 %15, 1, !dbg !206
  store i32 %inc, i32* %i, align 4, !dbg !206
  br label %for.cond1, !dbg !207, !llvm.loop !208

for.end:                                          ; preds = %for.cond1
  br label %for.inc11, !dbg !210

for.inc11:                                        ; preds = %for.end
  %16 = load i32, i32* %j, align 4, !dbg !211
  %inc12 = add nsw i32 %16, 1, !dbg !211
  store i32 %inc12, i32* %j, align 4, !dbg !211
  br label %for.cond, !dbg !212, !llvm.loop !213

for.end13:                                        ; preds = %for.cond
  %17 = load double*, double** %biases.addr, align 8, !dbg !215
  %18 = load double*, double** %activations.addr, align 8, !dbg !216
  call void @add_bias_to_activations(double* noundef %17, double* noundef %18, i32 noundef 64), !dbg !217
  ret void, !dbg !218
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @matrix_vector_product_with_bias_second_layer(double* noundef %biases, double* noundef %weights, double* noundef %activations, double* noundef %input_activations) #0 !dbg !219 {
entry:
  %biases.addr = alloca double*, align 8
  %weights.addr = alloca double*, align 8
  %activations.addr = alloca double*, align 8
  %input_activations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %biases, double** %biases.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases.addr, metadata !220, metadata !DIExpression()), !dbg !221
  store double* %weights, double** %weights.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights.addr, metadata !222, metadata !DIExpression()), !dbg !223
  store double* %activations, double** %activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %activations.addr, metadata !224, metadata !DIExpression()), !dbg !225
  store double* %input_activations, double** %input_activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %input_activations.addr, metadata !226, metadata !DIExpression()), !dbg !227
  call void @llvm.dbg.declare(metadata i32* %i, metadata !228, metadata !DIExpression()), !dbg !229
  call void @llvm.dbg.declare(metadata i32* %j, metadata !230, metadata !DIExpression()), !dbg !231
  br label %matrix_vector_product_with_bias_second_layer_loop1, !dbg !232

matrix_vector_product_with_bias_second_layer_loop1: ; preds = %entry
  call void @llvm.dbg.label(metadata !233), !dbg !234
  store i32 0, i32* %i, align 4, !dbg !235
  br label %for.cond, !dbg !237

for.cond:                                         ; preds = %for.inc11, %matrix_vector_product_with_bias_second_layer_loop1
  %0 = load i32, i32* %i, align 4, !dbg !238
  %cmp = icmp slt i32 %0, 64, !dbg !240
  br i1 %cmp, label %for.body, label %for.end13, !dbg !241

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %activations.addr, align 8, !dbg !242
  %2 = load i32, i32* %i, align 4, !dbg !244
  %idxprom = sext i32 %2 to i64, !dbg !242
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !242
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !245
  br label %matrix_vector_product_with_bias_second_layer_loop1_1, !dbg !242

matrix_vector_product_with_bias_second_layer_loop1_1: ; preds = %for.body
  call void @llvm.dbg.label(metadata !246), !dbg !247
  store i32 0, i32* %j, align 4, !dbg !248
  br label %for.cond1, !dbg !250

for.cond1:                                        ; preds = %for.inc, %matrix_vector_product_with_bias_second_layer_loop1_1
  %3 = load i32, i32* %j, align 4, !dbg !251
  %cmp2 = icmp slt i32 %3, 64, !dbg !253
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !254

for.body3:                                        ; preds = %for.cond1
  %4 = load double*, double** %weights.addr, align 8, !dbg !255
  %5 = load i32, i32* %i, align 4, !dbg !257
  %mul = mul nsw i32 %5, 64, !dbg !258
  %6 = load i32, i32* %j, align 4, !dbg !259
  %add = add nsw i32 %mul, %6, !dbg !260
  %idxprom4 = sext i32 %add to i64, !dbg !255
  %arrayidx5 = getelementptr inbounds double, double* %4, i64 %idxprom4, !dbg !255
  %7 = load double, double* %arrayidx5, align 8, !dbg !255
  %8 = load double*, double** %input_activations.addr, align 8, !dbg !261
  %9 = load i32, i32* %j, align 4, !dbg !262
  %idxprom6 = sext i32 %9 to i64, !dbg !261
  %arrayidx7 = getelementptr inbounds double, double* %8, i64 %idxprom6, !dbg !261
  %10 = load double, double* %arrayidx7, align 8, !dbg !261
  %11 = load double*, double** %activations.addr, align 8, !dbg !263
  %12 = load i32, i32* %i, align 4, !dbg !264
  %idxprom9 = sext i32 %12 to i64, !dbg !263
  %arrayidx10 = getelementptr inbounds double, double* %11, i64 %idxprom9, !dbg !263
  %13 = load double, double* %arrayidx10, align 8, !dbg !265
  %14 = call double @llvm.fmuladd.f64(double %7, double %10, double %13), !dbg !265
  store double %14, double* %arrayidx10, align 8, !dbg !265
  br label %for.inc, !dbg !266

for.inc:                                          ; preds = %for.body3
  %15 = load i32, i32* %j, align 4, !dbg !267
  %inc = add nsw i32 %15, 1, !dbg !267
  store i32 %inc, i32* %j, align 4, !dbg !267
  br label %for.cond1, !dbg !268, !llvm.loop !269

for.end:                                          ; preds = %for.cond1
  br label %for.inc11, !dbg !271

for.inc11:                                        ; preds = %for.end
  %16 = load i32, i32* %i, align 4, !dbg !272
  %inc12 = add nsw i32 %16, 1, !dbg !272
  store i32 %inc12, i32* %i, align 4, !dbg !272
  br label %for.cond, !dbg !273, !llvm.loop !274

for.end13:                                        ; preds = %for.cond
  %17 = load double*, double** %biases.addr, align 8, !dbg !276
  %18 = load double*, double** %activations.addr, align 8, !dbg !277
  call void @add_bias_to_activations(double* noundef %17, double* noundef %18, i32 noundef 64), !dbg !278
  ret void, !dbg !279
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @matrix_vector_product_with_bias_output_layer(double* noundef %biases, double* noundef %weights, double* noundef %activations, double* noundef %input_activations) #0 !dbg !280 {
entry:
  %biases.addr = alloca double*, align 8
  %weights.addr = alloca double*, align 8
  %activations.addr = alloca double*, align 8
  %input_activations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %biases, double** %biases.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases.addr, metadata !281, metadata !DIExpression()), !dbg !282
  store double* %weights, double** %weights.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights.addr, metadata !283, metadata !DIExpression()), !dbg !284
  store double* %activations, double** %activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %activations.addr, metadata !285, metadata !DIExpression()), !dbg !286
  store double* %input_activations, double** %input_activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %input_activations.addr, metadata !287, metadata !DIExpression()), !dbg !288
  call void @llvm.dbg.declare(metadata i32* %i, metadata !289, metadata !DIExpression()), !dbg !290
  call void @llvm.dbg.declare(metadata i32* %j, metadata !291, metadata !DIExpression()), !dbg !292
  br label %matrix_vector_product_with_bias_output_layer_loop1, !dbg !293

matrix_vector_product_with_bias_output_layer_loop1: ; preds = %entry
  call void @llvm.dbg.label(metadata !294), !dbg !295
  store i32 0, i32* %j, align 4, !dbg !296
  br label %for.cond, !dbg !298

for.cond:                                         ; preds = %for.inc11, %matrix_vector_product_with_bias_output_layer_loop1
  %0 = load i32, i32* %j, align 4, !dbg !299
  %cmp = icmp slt i32 %0, 3, !dbg !301
  br i1 %cmp, label %for.body, label %for.end13, !dbg !302

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %activations.addr, align 8, !dbg !303
  %2 = load i32, i32* %j, align 4, !dbg !305
  %idxprom = sext i32 %2 to i64, !dbg !303
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !303
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !306
  br label %matrix_vector_product_with_bias_output_layer_loop1_1, !dbg !303

matrix_vector_product_with_bias_output_layer_loop1_1: ; preds = %for.body
  call void @llvm.dbg.label(metadata !307), !dbg !308
  store i32 0, i32* %i, align 4, !dbg !309
  br label %for.cond1, !dbg !311

for.cond1:                                        ; preds = %for.inc, %matrix_vector_product_with_bias_output_layer_loop1_1
  %3 = load i32, i32* %i, align 4, !dbg !312
  %cmp2 = icmp slt i32 %3, 64, !dbg !314
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !315

for.body3:                                        ; preds = %for.cond1
  %4 = load double*, double** %weights.addr, align 8, !dbg !316
  %5 = load i32, i32* %j, align 4, !dbg !318
  %mul = mul nsw i32 %5, 64, !dbg !319
  %6 = load i32, i32* %i, align 4, !dbg !320
  %add = add nsw i32 %mul, %6, !dbg !321
  %idxprom4 = sext i32 %add to i64, !dbg !316
  %arrayidx5 = getelementptr inbounds double, double* %4, i64 %idxprom4, !dbg !316
  %7 = load double, double* %arrayidx5, align 8, !dbg !316
  %8 = load double*, double** %input_activations.addr, align 8, !dbg !322
  %9 = load i32, i32* %i, align 4, !dbg !323
  %idxprom6 = sext i32 %9 to i64, !dbg !322
  %arrayidx7 = getelementptr inbounds double, double* %8, i64 %idxprom6, !dbg !322
  %10 = load double, double* %arrayidx7, align 8, !dbg !322
  %11 = load double*, double** %activations.addr, align 8, !dbg !324
  %12 = load i32, i32* %j, align 4, !dbg !325
  %idxprom9 = sext i32 %12 to i64, !dbg !324
  %arrayidx10 = getelementptr inbounds double, double* %11, i64 %idxprom9, !dbg !324
  %13 = load double, double* %arrayidx10, align 8, !dbg !326
  %14 = call double @llvm.fmuladd.f64(double %7, double %10, double %13), !dbg !326
  store double %14, double* %arrayidx10, align 8, !dbg !326
  br label %for.inc, !dbg !327

for.inc:                                          ; preds = %for.body3
  %15 = load i32, i32* %i, align 4, !dbg !328
  %inc = add nsw i32 %15, 1, !dbg !328
  store i32 %inc, i32* %i, align 4, !dbg !328
  br label %for.cond1, !dbg !329, !llvm.loop !330

for.end:                                          ; preds = %for.cond1
  br label %for.inc11, !dbg !332

for.inc11:                                        ; preds = %for.end
  %16 = load i32, i32* %j, align 4, !dbg !333
  %inc12 = add nsw i32 %16, 1, !dbg !333
  store i32 %inc12, i32* %j, align 4, !dbg !333
  br label %for.cond, !dbg !334, !llvm.loop !335

for.end13:                                        ; preds = %for.cond
  %17 = load double*, double** %biases.addr, align 8, !dbg !337
  %18 = load double*, double** %activations.addr, align 8, !dbg !338
  call void @add_bias_to_activations(double* noundef %17, double* noundef %18, i32 noundef 3), !dbg !339
  ret void, !dbg !340
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @take_difference(double* noundef %net_outputs, double* noundef %solutions, double* noundef %output_difference, double* noundef %dactivations) #0 !dbg !341 {
entry:
  %net_outputs.addr = alloca double*, align 8
  %solutions.addr = alloca double*, align 8
  %output_difference.addr = alloca double*, align 8
  %dactivations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  store double* %net_outputs, double** %net_outputs.addr, align 8
  call void @llvm.dbg.declare(metadata double** %net_outputs.addr, metadata !342, metadata !DIExpression()), !dbg !343
  store double* %solutions, double** %solutions.addr, align 8
  call void @llvm.dbg.declare(metadata double** %solutions.addr, metadata !344, metadata !DIExpression()), !dbg !345
  store double* %output_difference, double** %output_difference.addr, align 8
  call void @llvm.dbg.declare(metadata double** %output_difference.addr, metadata !346, metadata !DIExpression()), !dbg !347
  store double* %dactivations, double** %dactivations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %dactivations.addr, metadata !348, metadata !DIExpression()), !dbg !349
  call void @llvm.dbg.declare(metadata i32* %i, metadata !350, metadata !DIExpression()), !dbg !351
  br label %take_difference_loop1, !dbg !352

take_difference_loop1:                            ; preds = %entry
  call void @llvm.dbg.label(metadata !353), !dbg !354
  store i32 0, i32* %i, align 4, !dbg !355
  br label %for.cond, !dbg !357

for.cond:                                         ; preds = %for.inc, %take_difference_loop1
  %0 = load i32, i32* %i, align 4, !dbg !358
  %cmp = icmp slt i32 %0, 3, !dbg !360
  br i1 %cmp, label %for.body, label %for.end, !dbg !361

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %net_outputs.addr, align 8, !dbg !362
  %2 = load i32, i32* %i, align 4, !dbg !364
  %idxprom = sext i32 %2 to i64, !dbg !362
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !362
  %3 = load double, double* %arrayidx, align 8, !dbg !362
  %4 = load double*, double** %solutions.addr, align 8, !dbg !365
  %5 = load i32, i32* %i, align 4, !dbg !366
  %idxprom1 = sext i32 %5 to i64, !dbg !365
  %arrayidx2 = getelementptr inbounds double, double* %4, i64 %idxprom1, !dbg !365
  %6 = load double, double* %arrayidx2, align 8, !dbg !365
  %sub = fsub double %3, %6, !dbg !367
  %mul = fmul double %sub, -1.000000e+00, !dbg !368
  %7 = load double*, double** %dactivations.addr, align 8, !dbg !369
  %8 = load i32, i32* %i, align 4, !dbg !370
  %idxprom3 = sext i32 %8 to i64, !dbg !369
  %arrayidx4 = getelementptr inbounds double, double* %7, i64 %idxprom3, !dbg !369
  %9 = load double, double* %arrayidx4, align 8, !dbg !369
  %mul5 = fmul double %mul, %9, !dbg !371
  %10 = load double*, double** %output_difference.addr, align 8, !dbg !372
  %11 = load i32, i32* %i, align 4, !dbg !373
  %idxprom6 = sext i32 %11 to i64, !dbg !372
  %arrayidx7 = getelementptr inbounds double, double* %10, i64 %idxprom6, !dbg !372
  store double %mul5, double* %arrayidx7, align 8, !dbg !374
  br label %for.inc, !dbg !375

for.inc:                                          ; preds = %for.body
  %12 = load i32, i32* %i, align 4, !dbg !376
  %inc = add nsw i32 %12, 1, !dbg !376
  store i32 %inc, i32* %i, align 4, !dbg !376
  br label %for.cond, !dbg !377, !llvm.loop !378

for.end:                                          ; preds = %for.cond
  ret void, !dbg !380
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @get_delta_matrix_weights3(double* noundef %delta_weights3, double* noundef %output_difference, double* noundef %last_activations) #0 !dbg !381 {
entry:
  %delta_weights3.addr = alloca double*, align 8
  %output_difference.addr = alloca double*, align 8
  %last_activations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %delta_weights3, double** %delta_weights3.addr, align 8
  call void @llvm.dbg.declare(metadata double** %delta_weights3.addr, metadata !384, metadata !DIExpression()), !dbg !385
  store double* %output_difference, double** %output_difference.addr, align 8
  call void @llvm.dbg.declare(metadata double** %output_difference.addr, metadata !386, metadata !DIExpression()), !dbg !387
  store double* %last_activations, double** %last_activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %last_activations.addr, metadata !388, metadata !DIExpression()), !dbg !389
  call void @llvm.dbg.declare(metadata i32* %i, metadata !390, metadata !DIExpression()), !dbg !391
  call void @llvm.dbg.declare(metadata i32* %j, metadata !392, metadata !DIExpression()), !dbg !393
  br label %get_delta_matrix_weights3_loop1, !dbg !394

get_delta_matrix_weights3_loop1:                  ; preds = %entry
  call void @llvm.dbg.label(metadata !395), !dbg !396
  store i32 0, i32* %i, align 4, !dbg !397
  br label %for.cond, !dbg !399

for.cond:                                         ; preds = %for.inc9, %get_delta_matrix_weights3_loop1
  %0 = load i32, i32* %i, align 4, !dbg !400
  %cmp = icmp slt i32 %0, 64, !dbg !402
  br i1 %cmp, label %for.body, label %for.end11, !dbg !403

for.body:                                         ; preds = %for.cond
  br label %get_delta_matrix_weights3_loop1_1, !dbg !404

get_delta_matrix_weights3_loop1_1:                ; preds = %for.body
  call void @llvm.dbg.label(metadata !405), !dbg !407
  store i32 0, i32* %j, align 4, !dbg !408
  br label %for.cond1, !dbg !410

for.cond1:                                        ; preds = %for.inc, %get_delta_matrix_weights3_loop1_1
  %1 = load i32, i32* %j, align 4, !dbg !411
  %cmp2 = icmp slt i32 %1, 3, !dbg !413
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !414

for.body3:                                        ; preds = %for.cond1
  %2 = load double*, double** %last_activations.addr, align 8, !dbg !415
  %3 = load i32, i32* %i, align 4, !dbg !417
  %idxprom = sext i32 %3 to i64, !dbg !415
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom, !dbg !415
  %4 = load double, double* %arrayidx, align 8, !dbg !415
  %5 = load double*, double** %output_difference.addr, align 8, !dbg !418
  %6 = load i32, i32* %j, align 4, !dbg !419
  %idxprom4 = sext i32 %6 to i64, !dbg !418
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !418
  %7 = load double, double* %arrayidx5, align 8, !dbg !418
  %mul = fmul double %4, %7, !dbg !420
  %8 = load double*, double** %delta_weights3.addr, align 8, !dbg !421
  %9 = load i32, i32* %i, align 4, !dbg !422
  %mul6 = mul nsw i32 %9, 3, !dbg !423
  %10 = load i32, i32* %j, align 4, !dbg !424
  %add = add nsw i32 %mul6, %10, !dbg !425
  %idxprom7 = sext i32 %add to i64, !dbg !421
  %arrayidx8 = getelementptr inbounds double, double* %8, i64 %idxprom7, !dbg !421
  store double %mul, double* %arrayidx8, align 8, !dbg !426
  br label %for.inc, !dbg !427

for.inc:                                          ; preds = %for.body3
  %11 = load i32, i32* %j, align 4, !dbg !428
  %inc = add nsw i32 %11, 1, !dbg !428
  store i32 %inc, i32* %j, align 4, !dbg !428
  br label %for.cond1, !dbg !429, !llvm.loop !430

for.end:                                          ; preds = %for.cond1
  br label %for.inc9, !dbg !432

for.inc9:                                         ; preds = %for.end
  %12 = load i32, i32* %i, align 4, !dbg !433
  %inc10 = add nsw i32 %12, 1, !dbg !433
  store i32 %inc10, i32* %i, align 4, !dbg !433
  br label %for.cond, !dbg !434, !llvm.loop !435

for.end11:                                        ; preds = %for.cond
  ret void, !dbg !437
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @get_oracle_activations2(double* noundef %weights3, double* noundef %output_differences, double* noundef %oracle_activations, double* noundef %dactivations) #0 !dbg !438 {
entry:
  %weights3.addr = alloca double*, align 8
  %output_differences.addr = alloca double*, align 8
  %oracle_activations.addr = alloca double*, align 8
  %dactivations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %weights3, double** %weights3.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights3.addr, metadata !439, metadata !DIExpression()), !dbg !440
  store double* %output_differences, double** %output_differences.addr, align 8
  call void @llvm.dbg.declare(metadata double** %output_differences.addr, metadata !441, metadata !DIExpression()), !dbg !442
  store double* %oracle_activations, double** %oracle_activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %oracle_activations.addr, metadata !443, metadata !DIExpression()), !dbg !444
  store double* %dactivations, double** %dactivations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %dactivations.addr, metadata !445, metadata !DIExpression()), !dbg !446
  call void @llvm.dbg.declare(metadata i32* %i, metadata !447, metadata !DIExpression()), !dbg !448
  call void @llvm.dbg.declare(metadata i32* %j, metadata !449, metadata !DIExpression()), !dbg !450
  br label %get_oracle_activations2_loop1, !dbg !451

get_oracle_activations2_loop1:                    ; preds = %entry
  call void @llvm.dbg.label(metadata !452), !dbg !453
  store i32 0, i32* %i, align 4, !dbg !454
  br label %for.cond, !dbg !456

for.cond:                                         ; preds = %for.inc18, %get_oracle_activations2_loop1
  %0 = load i32, i32* %i, align 4, !dbg !457
  %cmp = icmp slt i32 %0, 64, !dbg !459
  br i1 %cmp, label %for.body, label %for.end20, !dbg !460

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %oracle_activations.addr, align 8, !dbg !461
  %2 = load i32, i32* %i, align 4, !dbg !463
  %idxprom = sext i32 %2 to i64, !dbg !461
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !461
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !464
  br label %get_oracle_activations2_loop1_1, !dbg !461

get_oracle_activations2_loop1_1:                  ; preds = %for.body
  call void @llvm.dbg.label(metadata !465), !dbg !466
  store i32 0, i32* %j, align 4, !dbg !467
  br label %for.cond1, !dbg !469

for.cond1:                                        ; preds = %for.inc, %get_oracle_activations2_loop1_1
  %3 = load i32, i32* %j, align 4, !dbg !470
  %cmp2 = icmp slt i32 %3, 3, !dbg !472
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !473

for.body3:                                        ; preds = %for.cond1
  %4 = load double*, double** %output_differences.addr, align 8, !dbg !474
  %5 = load i32, i32* %j, align 4, !dbg !476
  %idxprom4 = sext i32 %5 to i64, !dbg !474
  %arrayidx5 = getelementptr inbounds double, double* %4, i64 %idxprom4, !dbg !474
  %6 = load double, double* %arrayidx5, align 8, !dbg !474
  %7 = load double*, double** %weights3.addr, align 8, !dbg !477
  %8 = load i32, i32* %i, align 4, !dbg !478
  %mul = mul nsw i32 %8, 3, !dbg !479
  %9 = load i32, i32* %j, align 4, !dbg !480
  %add = add nsw i32 %mul, %9, !dbg !481
  %idxprom6 = sext i32 %add to i64, !dbg !477
  %arrayidx7 = getelementptr inbounds double, double* %7, i64 %idxprom6, !dbg !477
  %10 = load double, double* %arrayidx7, align 8, !dbg !477
  %11 = load double*, double** %oracle_activations.addr, align 8, !dbg !482
  %12 = load i32, i32* %i, align 4, !dbg !483
  %idxprom9 = sext i32 %12 to i64, !dbg !482
  %arrayidx10 = getelementptr inbounds double, double* %11, i64 %idxprom9, !dbg !482
  %13 = load double, double* %arrayidx10, align 8, !dbg !484
  %14 = call double @llvm.fmuladd.f64(double %6, double %10, double %13), !dbg !484
  store double %14, double* %arrayidx10, align 8, !dbg !484
  br label %for.inc, !dbg !485

for.inc:                                          ; preds = %for.body3
  %15 = load i32, i32* %j, align 4, !dbg !486
  %inc = add nsw i32 %15, 1, !dbg !486
  store i32 %inc, i32* %j, align 4, !dbg !486
  br label %for.cond1, !dbg !487, !llvm.loop !488

for.end:                                          ; preds = %for.cond1
  %16 = load double*, double** %oracle_activations.addr, align 8, !dbg !490
  %17 = load i32, i32* %i, align 4, !dbg !491
  %idxprom11 = sext i32 %17 to i64, !dbg !490
  %arrayidx12 = getelementptr inbounds double, double* %16, i64 %idxprom11, !dbg !490
  %18 = load double, double* %arrayidx12, align 8, !dbg !490
  %19 = load double*, double** %dactivations.addr, align 8, !dbg !492
  %20 = load i32, i32* %i, align 4, !dbg !493
  %idxprom13 = sext i32 %20 to i64, !dbg !492
  %arrayidx14 = getelementptr inbounds double, double* %19, i64 %idxprom13, !dbg !492
  %21 = load double, double* %arrayidx14, align 8, !dbg !492
  %mul15 = fmul double %18, %21, !dbg !494
  %22 = load double*, double** %oracle_activations.addr, align 8, !dbg !495
  %23 = load i32, i32* %i, align 4, !dbg !496
  %idxprom16 = sext i32 %23 to i64, !dbg !495
  %arrayidx17 = getelementptr inbounds double, double* %22, i64 %idxprom16, !dbg !495
  store double %mul15, double* %arrayidx17, align 8, !dbg !497
  br label %for.inc18, !dbg !498

for.inc18:                                        ; preds = %for.end
  %24 = load i32, i32* %i, align 4, !dbg !499
  %inc19 = add nsw i32 %24, 1, !dbg !499
  store i32 %inc19, i32* %i, align 4, !dbg !499
  br label %for.cond, !dbg !500, !llvm.loop !501

for.end20:                                        ; preds = %for.cond
  ret void, !dbg !503
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @get_delta_matrix_weights2(double* noundef %delta_weights2, double* noundef %output_difference, double* noundef %last_activations) #0 !dbg !504 {
entry:
  %delta_weights2.addr = alloca double*, align 8
  %output_difference.addr = alloca double*, align 8
  %last_activations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %delta_weights2, double** %delta_weights2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %delta_weights2.addr, metadata !505, metadata !DIExpression()), !dbg !506
  store double* %output_difference, double** %output_difference.addr, align 8
  call void @llvm.dbg.declare(metadata double** %output_difference.addr, metadata !507, metadata !DIExpression()), !dbg !508
  store double* %last_activations, double** %last_activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %last_activations.addr, metadata !509, metadata !DIExpression()), !dbg !510
  call void @llvm.dbg.declare(metadata i32* %i, metadata !511, metadata !DIExpression()), !dbg !512
  call void @llvm.dbg.declare(metadata i32* %j, metadata !513, metadata !DIExpression()), !dbg !514
  br label %get_delta_matrix_weights2_loop1, !dbg !515

get_delta_matrix_weights2_loop1:                  ; preds = %entry
  call void @llvm.dbg.label(metadata !516), !dbg !517
  store i32 0, i32* %i, align 4, !dbg !518
  br label %for.cond, !dbg !520

for.cond:                                         ; preds = %for.inc9, %get_delta_matrix_weights2_loop1
  %0 = load i32, i32* %i, align 4, !dbg !521
  %cmp = icmp slt i32 %0, 64, !dbg !523
  br i1 %cmp, label %for.body, label %for.end11, !dbg !524

for.body:                                         ; preds = %for.cond
  br label %get_delta_matrix_weights2_loop1_1, !dbg !525

get_delta_matrix_weights2_loop1_1:                ; preds = %for.body
  call void @llvm.dbg.label(metadata !526), !dbg !528
  store i32 0, i32* %j, align 4, !dbg !529
  br label %for.cond1, !dbg !531

for.cond1:                                        ; preds = %for.inc, %get_delta_matrix_weights2_loop1_1
  %1 = load i32, i32* %j, align 4, !dbg !532
  %cmp2 = icmp slt i32 %1, 64, !dbg !534
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !535

for.body3:                                        ; preds = %for.cond1
  %2 = load double*, double** %last_activations.addr, align 8, !dbg !536
  %3 = load i32, i32* %i, align 4, !dbg !538
  %idxprom = sext i32 %3 to i64, !dbg !536
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom, !dbg !536
  %4 = load double, double* %arrayidx, align 8, !dbg !536
  %5 = load double*, double** %output_difference.addr, align 8, !dbg !539
  %6 = load i32, i32* %j, align 4, !dbg !540
  %idxprom4 = sext i32 %6 to i64, !dbg !539
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !539
  %7 = load double, double* %arrayidx5, align 8, !dbg !539
  %mul = fmul double %4, %7, !dbg !541
  %8 = load double*, double** %delta_weights2.addr, align 8, !dbg !542
  %9 = load i32, i32* %i, align 4, !dbg !543
  %mul6 = mul nsw i32 %9, 64, !dbg !544
  %10 = load i32, i32* %j, align 4, !dbg !545
  %add = add nsw i32 %mul6, %10, !dbg !546
  %idxprom7 = sext i32 %add to i64, !dbg !542
  %arrayidx8 = getelementptr inbounds double, double* %8, i64 %idxprom7, !dbg !542
  store double %mul, double* %arrayidx8, align 8, !dbg !547
  br label %for.inc, !dbg !548

for.inc:                                          ; preds = %for.body3
  %11 = load i32, i32* %j, align 4, !dbg !549
  %inc = add nsw i32 %11, 1, !dbg !549
  store i32 %inc, i32* %j, align 4, !dbg !549
  br label %for.cond1, !dbg !550, !llvm.loop !551

for.end:                                          ; preds = %for.cond1
  br label %for.inc9, !dbg !553

for.inc9:                                         ; preds = %for.end
  %12 = load i32, i32* %i, align 4, !dbg !554
  %inc10 = add nsw i32 %12, 1, !dbg !554
  store i32 %inc10, i32* %i, align 4, !dbg !554
  br label %for.cond, !dbg !555, !llvm.loop !556

for.end11:                                        ; preds = %for.cond
  ret void, !dbg !558
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @get_oracle_activations1(double* noundef %weights2, double* noundef %output_differences, double* noundef %oracle_activations, double* noundef %dactivations) #0 !dbg !559 {
entry:
  %weights2.addr = alloca double*, align 8
  %output_differences.addr = alloca double*, align 8
  %oracle_activations.addr = alloca double*, align 8
  %dactivations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %weights2, double** %weights2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights2.addr, metadata !560, metadata !DIExpression()), !dbg !561
  store double* %output_differences, double** %output_differences.addr, align 8
  call void @llvm.dbg.declare(metadata double** %output_differences.addr, metadata !562, metadata !DIExpression()), !dbg !563
  store double* %oracle_activations, double** %oracle_activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %oracle_activations.addr, metadata !564, metadata !DIExpression()), !dbg !565
  store double* %dactivations, double** %dactivations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %dactivations.addr, metadata !566, metadata !DIExpression()), !dbg !567
  call void @llvm.dbg.declare(metadata i32* %i, metadata !568, metadata !DIExpression()), !dbg !569
  call void @llvm.dbg.declare(metadata i32* %j, metadata !570, metadata !DIExpression()), !dbg !571
  br label %get_oracle_activations1_loop1, !dbg !572

get_oracle_activations1_loop1:                    ; preds = %entry
  call void @llvm.dbg.label(metadata !573), !dbg !574
  store i32 0, i32* %i, align 4, !dbg !575
  br label %for.cond, !dbg !577

for.cond:                                         ; preds = %for.inc18, %get_oracle_activations1_loop1
  %0 = load i32, i32* %i, align 4, !dbg !578
  %cmp = icmp slt i32 %0, 64, !dbg !580
  br i1 %cmp, label %for.body, label %for.end20, !dbg !581

for.body:                                         ; preds = %for.cond
  %1 = load double*, double** %oracle_activations.addr, align 8, !dbg !582
  %2 = load i32, i32* %i, align 4, !dbg !584
  %idxprom = sext i32 %2 to i64, !dbg !582
  %arrayidx = getelementptr inbounds double, double* %1, i64 %idxprom, !dbg !582
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !585
  br label %get_oracle_activations1_loop1_1, !dbg !582

get_oracle_activations1_loop1_1:                  ; preds = %for.body
  call void @llvm.dbg.label(metadata !586), !dbg !587
  store i32 0, i32* %j, align 4, !dbg !588
  br label %for.cond1, !dbg !590

for.cond1:                                        ; preds = %for.inc, %get_oracle_activations1_loop1_1
  %3 = load i32, i32* %j, align 4, !dbg !591
  %cmp2 = icmp slt i32 %3, 64, !dbg !593
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !594

for.body3:                                        ; preds = %for.cond1
  %4 = load double*, double** %output_differences.addr, align 8, !dbg !595
  %5 = load i32, i32* %j, align 4, !dbg !597
  %idxprom4 = sext i32 %5 to i64, !dbg !595
  %arrayidx5 = getelementptr inbounds double, double* %4, i64 %idxprom4, !dbg !595
  %6 = load double, double* %arrayidx5, align 8, !dbg !595
  %7 = load double*, double** %weights2.addr, align 8, !dbg !598
  %8 = load i32, i32* %i, align 4, !dbg !599
  %mul = mul nsw i32 %8, 64, !dbg !600
  %9 = load i32, i32* %j, align 4, !dbg !601
  %add = add nsw i32 %mul, %9, !dbg !602
  %idxprom6 = sext i32 %add to i64, !dbg !598
  %arrayidx7 = getelementptr inbounds double, double* %7, i64 %idxprom6, !dbg !598
  %10 = load double, double* %arrayidx7, align 8, !dbg !598
  %11 = load double*, double** %oracle_activations.addr, align 8, !dbg !603
  %12 = load i32, i32* %i, align 4, !dbg !604
  %idxprom9 = sext i32 %12 to i64, !dbg !603
  %arrayidx10 = getelementptr inbounds double, double* %11, i64 %idxprom9, !dbg !603
  %13 = load double, double* %arrayidx10, align 8, !dbg !605
  %14 = call double @llvm.fmuladd.f64(double %6, double %10, double %13), !dbg !605
  store double %14, double* %arrayidx10, align 8, !dbg !605
  br label %for.inc, !dbg !606

for.inc:                                          ; preds = %for.body3
  %15 = load i32, i32* %j, align 4, !dbg !607
  %inc = add nsw i32 %15, 1, !dbg !607
  store i32 %inc, i32* %j, align 4, !dbg !607
  br label %for.cond1, !dbg !608, !llvm.loop !609

for.end:                                          ; preds = %for.cond1
  %16 = load double*, double** %oracle_activations.addr, align 8, !dbg !611
  %17 = load i32, i32* %i, align 4, !dbg !612
  %idxprom11 = sext i32 %17 to i64, !dbg !611
  %arrayidx12 = getelementptr inbounds double, double* %16, i64 %idxprom11, !dbg !611
  %18 = load double, double* %arrayidx12, align 8, !dbg !611
  %19 = load double*, double** %dactivations.addr, align 8, !dbg !613
  %20 = load i32, i32* %i, align 4, !dbg !614
  %idxprom13 = sext i32 %20 to i64, !dbg !613
  %arrayidx14 = getelementptr inbounds double, double* %19, i64 %idxprom13, !dbg !613
  %21 = load double, double* %arrayidx14, align 8, !dbg !613
  %mul15 = fmul double %18, %21, !dbg !615
  %22 = load double*, double** %oracle_activations.addr, align 8, !dbg !616
  %23 = load i32, i32* %i, align 4, !dbg !617
  %idxprom16 = sext i32 %23 to i64, !dbg !616
  %arrayidx17 = getelementptr inbounds double, double* %22, i64 %idxprom16, !dbg !616
  store double %mul15, double* %arrayidx17, align 8, !dbg !618
  br label %for.inc18, !dbg !619

for.inc18:                                        ; preds = %for.end
  %24 = load i32, i32* %i, align 4, !dbg !620
  %inc19 = add nsw i32 %24, 1, !dbg !620
  store i32 %inc19, i32* %i, align 4, !dbg !620
  br label %for.cond, !dbg !621, !llvm.loop !622

for.end20:                                        ; preds = %for.cond
  ret void, !dbg !624
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @get_delta_matrix_weights1(double* noundef %delta_weights1, double* noundef %output_difference, double* noundef %last_activations) #0 !dbg !625 {
entry:
  %delta_weights1.addr = alloca double*, align 8
  %output_difference.addr = alloca double*, align 8
  %last_activations.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store double* %delta_weights1, double** %delta_weights1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %delta_weights1.addr, metadata !626, metadata !DIExpression()), !dbg !627
  store double* %output_difference, double** %output_difference.addr, align 8
  call void @llvm.dbg.declare(metadata double** %output_difference.addr, metadata !628, metadata !DIExpression()), !dbg !629
  store double* %last_activations, double** %last_activations.addr, align 8
  call void @llvm.dbg.declare(metadata double** %last_activations.addr, metadata !630, metadata !DIExpression()), !dbg !631
  call void @llvm.dbg.declare(metadata i32* %i, metadata !632, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.declare(metadata i32* %j, metadata !634, metadata !DIExpression()), !dbg !635
  br label %get_delta_matrix_weights1_loop1, !dbg !636

get_delta_matrix_weights1_loop1:                  ; preds = %entry
  call void @llvm.dbg.label(metadata !637), !dbg !638
  store i32 0, i32* %i, align 4, !dbg !639
  br label %for.cond, !dbg !641

for.cond:                                         ; preds = %for.inc9, %get_delta_matrix_weights1_loop1
  %0 = load i32, i32* %i, align 4, !dbg !642
  %cmp = icmp slt i32 %0, 13, !dbg !644
  br i1 %cmp, label %for.body, label %for.end11, !dbg !645

for.body:                                         ; preds = %for.cond
  br label %get_delta_matrix_weights1_loop1_1, !dbg !646

get_delta_matrix_weights1_loop1_1:                ; preds = %for.body
  call void @llvm.dbg.label(metadata !647), !dbg !649
  store i32 0, i32* %j, align 4, !dbg !650
  br label %for.cond1, !dbg !652

for.cond1:                                        ; preds = %for.inc, %get_delta_matrix_weights1_loop1_1
  %1 = load i32, i32* %j, align 4, !dbg !653
  %cmp2 = icmp slt i32 %1, 64, !dbg !655
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !656

for.body3:                                        ; preds = %for.cond1
  %2 = load double*, double** %last_activations.addr, align 8, !dbg !657
  %3 = load i32, i32* %i, align 4, !dbg !659
  %idxprom = sext i32 %3 to i64, !dbg !657
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom, !dbg !657
  %4 = load double, double* %arrayidx, align 8, !dbg !657
  %5 = load double*, double** %output_difference.addr, align 8, !dbg !660
  %6 = load i32, i32* %j, align 4, !dbg !661
  %idxprom4 = sext i32 %6 to i64, !dbg !660
  %arrayidx5 = getelementptr inbounds double, double* %5, i64 %idxprom4, !dbg !660
  %7 = load double, double* %arrayidx5, align 8, !dbg !660
  %mul = fmul double %4, %7, !dbg !662
  %8 = load double*, double** %delta_weights1.addr, align 8, !dbg !663
  %9 = load i32, i32* %i, align 4, !dbg !664
  %mul6 = mul nsw i32 %9, 64, !dbg !665
  %10 = load i32, i32* %j, align 4, !dbg !666
  %add = add nsw i32 %mul6, %10, !dbg !667
  %idxprom7 = sext i32 %add to i64, !dbg !663
  %arrayidx8 = getelementptr inbounds double, double* %8, i64 %idxprom7, !dbg !663
  store double %mul, double* %arrayidx8, align 8, !dbg !668
  br label %for.inc, !dbg !669

for.inc:                                          ; preds = %for.body3
  %11 = load i32, i32* %j, align 4, !dbg !670
  %inc = add nsw i32 %11, 1, !dbg !670
  store i32 %inc, i32* %j, align 4, !dbg !670
  br label %for.cond1, !dbg !671, !llvm.loop !672

for.end:                                          ; preds = %for.cond1
  br label %for.inc9, !dbg !674

for.inc9:                                         ; preds = %for.end
  %12 = load i32, i32* %i, align 4, !dbg !675
  %inc10 = add nsw i32 %12, 1, !dbg !675
  store i32 %inc10, i32* %i, align 4, !dbg !675
  br label %for.cond, !dbg !676, !llvm.loop !677

for.end11:                                        ; preds = %for.cond
  ret void, !dbg !679
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @update_weights(double* noundef %weights1, double* noundef %weights2, double* noundef %weights3, double* noundef %d_weights1, double* noundef %d_weights2, double* noundef %d_weights3, double* noundef %biases1, double* noundef %biases2, double* noundef %biases3, double* noundef %d_biases1, double* noundef %d_biases2, double* noundef %d_biases3) #0 !dbg !680 {
entry:
  %weights1.addr = alloca double*, align 8
  %weights2.addr = alloca double*, align 8
  %weights3.addr = alloca double*, align 8
  %d_weights1.addr = alloca double*, align 8
  %d_weights2.addr = alloca double*, align 8
  %d_weights3.addr = alloca double*, align 8
  %biases1.addr = alloca double*, align 8
  %biases2.addr = alloca double*, align 8
  %biases3.addr = alloca double*, align 8
  %d_biases1.addr = alloca double*, align 8
  %d_biases2.addr = alloca double*, align 8
  %d_biases3.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %norm = alloca double, align 8
  %bias_norm = alloca double, align 8
  store double* %weights1, double** %weights1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights1.addr, metadata !683, metadata !DIExpression()), !dbg !684
  store double* %weights2, double** %weights2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights2.addr, metadata !685, metadata !DIExpression()), !dbg !686
  store double* %weights3, double** %weights3.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights3.addr, metadata !687, metadata !DIExpression()), !dbg !688
  store double* %d_weights1, double** %d_weights1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %d_weights1.addr, metadata !689, metadata !DIExpression()), !dbg !690
  store double* %d_weights2, double** %d_weights2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %d_weights2.addr, metadata !691, metadata !DIExpression()), !dbg !692
  store double* %d_weights3, double** %d_weights3.addr, align 8
  call void @llvm.dbg.declare(metadata double** %d_weights3.addr, metadata !693, metadata !DIExpression()), !dbg !694
  store double* %biases1, double** %biases1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases1.addr, metadata !695, metadata !DIExpression()), !dbg !696
  store double* %biases2, double** %biases2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases2.addr, metadata !697, metadata !DIExpression()), !dbg !698
  store double* %biases3, double** %biases3.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases3.addr, metadata !699, metadata !DIExpression()), !dbg !700
  store double* %d_biases1, double** %d_biases1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %d_biases1.addr, metadata !701, metadata !DIExpression()), !dbg !702
  store double* %d_biases2, double** %d_biases2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %d_biases2.addr, metadata !703, metadata !DIExpression()), !dbg !704
  store double* %d_biases3, double** %d_biases3.addr, align 8
  call void @llvm.dbg.declare(metadata double** %d_biases3.addr, metadata !705, metadata !DIExpression()), !dbg !706
  call void @llvm.dbg.declare(metadata i32* %i, metadata !707, metadata !DIExpression()), !dbg !708
  call void @llvm.dbg.declare(metadata i32* %j, metadata !709, metadata !DIExpression()), !dbg !710
  call void @llvm.dbg.declare(metadata double* %norm, metadata !711, metadata !DIExpression()), !dbg !712
  call void @llvm.dbg.declare(metadata double* %bias_norm, metadata !713, metadata !DIExpression()), !dbg !714
  store double 0.000000e+00, double* %norm, align 8, !dbg !715
  store double 0.000000e+00, double* %bias_norm, align 8, !dbg !716
  br label %update_weights_loop1, !dbg !717

update_weights_loop1:                             ; preds = %entry
  call void @llvm.dbg.label(metadata !718), !dbg !719
  store i32 0, i32* %i, align 4, !dbg !720
  br label %for.cond, !dbg !722

for.cond:                                         ; preds = %for.inc18, %update_weights_loop1
  %0 = load i32, i32* %i, align 4, !dbg !723
  %cmp = icmp slt i32 %0, 13, !dbg !725
  br i1 %cmp, label %for.body, label %for.end20, !dbg !726

for.body:                                         ; preds = %for.cond
  br label %update_weights_loop1_1, !dbg !727

update_weights_loop1_1:                           ; preds = %for.body
  call void @llvm.dbg.label(metadata !728), !dbg !730
  store i32 0, i32* %j, align 4, !dbg !731
  br label %for.cond1, !dbg !733

for.cond1:                                        ; preds = %for.inc, %update_weights_loop1_1
  %1 = load i32, i32* %j, align 4, !dbg !734
  %cmp2 = icmp slt i32 %1, 64, !dbg !736
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !737

for.body3:                                        ; preds = %for.cond1
  %2 = load double*, double** %d_weights1.addr, align 8, !dbg !738
  %3 = load i32, i32* %i, align 4, !dbg !740
  %mul = mul nsw i32 %3, 64, !dbg !741
  %4 = load i32, i32* %j, align 4, !dbg !742
  %add = add nsw i32 %mul, %4, !dbg !743
  %idxprom = sext i32 %add to i64, !dbg !738
  %arrayidx = getelementptr inbounds double, double* %2, i64 %idxprom, !dbg !738
  %5 = load double, double* %arrayidx, align 8, !dbg !738
  %6 = load double*, double** %weights1.addr, align 8, !dbg !744
  %7 = load i32, i32* %i, align 4, !dbg !745
  %mul5 = mul nsw i32 %7, 64, !dbg !746
  %8 = load i32, i32* %j, align 4, !dbg !747
  %add6 = add nsw i32 %mul5, %8, !dbg !748
  %idxprom7 = sext i32 %add6 to i64, !dbg !744
  %arrayidx8 = getelementptr inbounds double, double* %6, i64 %idxprom7, !dbg !744
  %9 = load double, double* %arrayidx8, align 8, !dbg !749
  %neg = fneg double %5, !dbg !749
  %10 = call double @llvm.fmuladd.f64(double %neg, double 1.000000e-02, double %9), !dbg !749
  store double %10, double* %arrayidx8, align 8, !dbg !749
  %11 = load double*, double** %weights1.addr, align 8, !dbg !750
  %12 = load i32, i32* %i, align 4, !dbg !751
  %mul9 = mul nsw i32 %12, 64, !dbg !752
  %13 = load i32, i32* %j, align 4, !dbg !753
  %add10 = add nsw i32 %mul9, %13, !dbg !754
  %idxprom11 = sext i32 %add10 to i64, !dbg !750
  %arrayidx12 = getelementptr inbounds double, double* %11, i64 %idxprom11, !dbg !750
  %14 = load double, double* %arrayidx12, align 8, !dbg !750
  %15 = load double*, double** %weights1.addr, align 8, !dbg !755
  %16 = load i32, i32* %i, align 4, !dbg !756
  %mul13 = mul nsw i32 %16, 64, !dbg !757
  %17 = load i32, i32* %j, align 4, !dbg !758
  %add14 = add nsw i32 %mul13, %17, !dbg !759
  %idxprom15 = sext i32 %add14 to i64, !dbg !755
  %arrayidx16 = getelementptr inbounds double, double* %15, i64 %idxprom15, !dbg !755
  %18 = load double, double* %arrayidx16, align 8, !dbg !755
  %19 = load double, double* %norm, align 8, !dbg !760
  %20 = call double @llvm.fmuladd.f64(double %14, double %18, double %19), !dbg !760
  store double %20, double* %norm, align 8, !dbg !760
  br label %for.inc, !dbg !761

for.inc:                                          ; preds = %for.body3
  %21 = load i32, i32* %j, align 4, !dbg !762
  %inc = add nsw i32 %21, 1, !dbg !762
  store i32 %inc, i32* %j, align 4, !dbg !762
  br label %for.cond1, !dbg !763, !llvm.loop !764

for.end:                                          ; preds = %for.cond1
  br label %for.inc18, !dbg !766

for.inc18:                                        ; preds = %for.end
  %22 = load i32, i32* %i, align 4, !dbg !767
  %inc19 = add nsw i32 %22, 1, !dbg !767
  store i32 %inc19, i32* %i, align 4, !dbg !767
  br label %for.cond, !dbg !768, !llvm.loop !769

for.end20:                                        ; preds = %for.cond
  br label %update_weights_loop2, !dbg !770

update_weights_loop2:                             ; preds = %for.end20
  call void @llvm.dbg.label(metadata !771), !dbg !772
  store i32 0, i32* %i, align 4, !dbg !773
  br label %for.cond21, !dbg !775

for.cond21:                                       ; preds = %for.inc35, %update_weights_loop2
  %23 = load i32, i32* %i, align 4, !dbg !776
  %cmp22 = icmp slt i32 %23, 64, !dbg !778
  br i1 %cmp22, label %for.body23, label %for.end37, !dbg !779

for.body23:                                       ; preds = %for.cond21
  %24 = load double*, double** %d_biases1.addr, align 8, !dbg !780
  %25 = load i32, i32* %i, align 4, !dbg !782
  %idxprom24 = sext i32 %25 to i64, !dbg !780
  %arrayidx25 = getelementptr inbounds double, double* %24, i64 %idxprom24, !dbg !780
  %26 = load double, double* %arrayidx25, align 8, !dbg !780
  %27 = load double*, double** %biases1.addr, align 8, !dbg !783
  %28 = load i32, i32* %i, align 4, !dbg !784
  %idxprom27 = sext i32 %28 to i64, !dbg !783
  %arrayidx28 = getelementptr inbounds double, double* %27, i64 %idxprom27, !dbg !783
  %29 = load double, double* %arrayidx28, align 8, !dbg !785
  %neg29 = fneg double %26, !dbg !785
  %30 = call double @llvm.fmuladd.f64(double %neg29, double 1.000000e-02, double %29), !dbg !785
  store double %30, double* %arrayidx28, align 8, !dbg !785
  %31 = load double*, double** %biases1.addr, align 8, !dbg !786
  %32 = load i32, i32* %i, align 4, !dbg !787
  %idxprom30 = sext i32 %32 to i64, !dbg !786
  %arrayidx31 = getelementptr inbounds double, double* %31, i64 %idxprom30, !dbg !786
  %33 = load double, double* %arrayidx31, align 8, !dbg !786
  %34 = load double*, double** %biases1.addr, align 8, !dbg !788
  %35 = load i32, i32* %i, align 4, !dbg !789
  %idxprom32 = sext i32 %35 to i64, !dbg !788
  %arrayidx33 = getelementptr inbounds double, double* %34, i64 %idxprom32, !dbg !788
  %36 = load double, double* %arrayidx33, align 8, !dbg !788
  %37 = load double, double* %bias_norm, align 8, !dbg !790
  %38 = call double @llvm.fmuladd.f64(double %33, double %36, double %37), !dbg !790
  store double %38, double* %bias_norm, align 8, !dbg !790
  br label %for.inc35, !dbg !791

for.inc35:                                        ; preds = %for.body23
  %39 = load i32, i32* %i, align 4, !dbg !792
  %inc36 = add nsw i32 %39, 1, !dbg !792
  store i32 %inc36, i32* %i, align 4, !dbg !792
  br label %for.cond21, !dbg !793, !llvm.loop !794

for.end37:                                        ; preds = %for.cond21
  %40 = load double, double* %norm, align 8, !dbg !796
  %call = call double @sqrt(double noundef %40) #3, !dbg !797
  store double %call, double* %norm, align 8, !dbg !798
  %41 = load double, double* %bias_norm, align 8, !dbg !799
  %call38 = call double @sqrt(double noundef %41) #3, !dbg !800
  store double %call38, double* %bias_norm, align 8, !dbg !801
  br label %update_weights_loop3, !dbg !802

update_weights_loop3:                             ; preds = %for.end37
  call void @llvm.dbg.label(metadata !803), !dbg !804
  store i32 0, i32* %i, align 4, !dbg !805
  br label %for.cond39, !dbg !807

for.cond39:                                       ; preds = %for.inc56, %update_weights_loop3
  %42 = load i32, i32* %i, align 4, !dbg !808
  %cmp40 = icmp slt i32 %42, 13, !dbg !810
  br i1 %cmp40, label %for.body41, label %for.end58, !dbg !811

for.body41:                                       ; preds = %for.cond39
  br label %update_weights_loop3_1, !dbg !812

update_weights_loop3_1:                           ; preds = %for.body41
  call void @llvm.dbg.label(metadata !813), !dbg !815
  store i32 0, i32* %j, align 4, !dbg !816
  br label %for.cond42, !dbg !818

for.cond42:                                       ; preds = %for.inc53, %update_weights_loop3_1
  %43 = load i32, i32* %j, align 4, !dbg !819
  %cmp43 = icmp slt i32 %43, 64, !dbg !821
  br i1 %cmp43, label %for.body44, label %for.end55, !dbg !822

for.body44:                                       ; preds = %for.cond42
  %44 = load double*, double** %weights1.addr, align 8, !dbg !823
  %45 = load i32, i32* %i, align 4, !dbg !825
  %mul45 = mul nsw i32 %45, 64, !dbg !826
  %46 = load i32, i32* %j, align 4, !dbg !827
  %add46 = add nsw i32 %mul45, %46, !dbg !828
  %idxprom47 = sext i32 %add46 to i64, !dbg !823
  %arrayidx48 = getelementptr inbounds double, double* %44, i64 %idxprom47, !dbg !823
  %47 = load double, double* %arrayidx48, align 8, !dbg !823
  %48 = load double, double* %norm, align 8, !dbg !829
  %div = fdiv double %47, %48, !dbg !830
  %49 = load double*, double** %weights1.addr, align 8, !dbg !831
  %50 = load i32, i32* %i, align 4, !dbg !832
  %mul49 = mul nsw i32 %50, 64, !dbg !833
  %51 = load i32, i32* %j, align 4, !dbg !834
  %add50 = add nsw i32 %mul49, %51, !dbg !835
  %idxprom51 = sext i32 %add50 to i64, !dbg !831
  %arrayidx52 = getelementptr inbounds double, double* %49, i64 %idxprom51, !dbg !831
  store double %div, double* %arrayidx52, align 8, !dbg !836
  br label %for.inc53, !dbg !837

for.inc53:                                        ; preds = %for.body44
  %52 = load i32, i32* %j, align 4, !dbg !838
  %inc54 = add nsw i32 %52, 1, !dbg !838
  store i32 %inc54, i32* %j, align 4, !dbg !838
  br label %for.cond42, !dbg !839, !llvm.loop !840

for.end55:                                        ; preds = %for.cond42
  br label %for.inc56, !dbg !842

for.inc56:                                        ; preds = %for.end55
  %53 = load i32, i32* %i, align 4, !dbg !843
  %inc57 = add nsw i32 %53, 1, !dbg !843
  store i32 %inc57, i32* %i, align 4, !dbg !843
  br label %for.cond39, !dbg !844, !llvm.loop !845

for.end58:                                        ; preds = %for.cond39
  br label %update_weights_loop4, !dbg !846

update_weights_loop4:                             ; preds = %for.end58
  call void @llvm.dbg.label(metadata !847), !dbg !848
  store i32 0, i32* %i, align 4, !dbg !849
  br label %for.cond59, !dbg !851

for.cond59:                                       ; preds = %for.inc67, %update_weights_loop4
  %54 = load i32, i32* %i, align 4, !dbg !852
  %cmp60 = icmp slt i32 %54, 64, !dbg !854
  br i1 %cmp60, label %for.body61, label %for.end69, !dbg !855

for.body61:                                       ; preds = %for.cond59
  %55 = load double*, double** %biases1.addr, align 8, !dbg !856
  %56 = load i32, i32* %i, align 4, !dbg !858
  %idxprom62 = sext i32 %56 to i64, !dbg !856
  %arrayidx63 = getelementptr inbounds double, double* %55, i64 %idxprom62, !dbg !856
  %57 = load double, double* %arrayidx63, align 8, !dbg !856
  %58 = load double, double* %bias_norm, align 8, !dbg !859
  %div64 = fdiv double %57, %58, !dbg !860
  %59 = load double*, double** %biases1.addr, align 8, !dbg !861
  %60 = load i32, i32* %i, align 4, !dbg !862
  %idxprom65 = sext i32 %60 to i64, !dbg !861
  %arrayidx66 = getelementptr inbounds double, double* %59, i64 %idxprom65, !dbg !861
  store double %div64, double* %arrayidx66, align 8, !dbg !863
  br label %for.inc67, !dbg !864

for.inc67:                                        ; preds = %for.body61
  %61 = load i32, i32* %i, align 4, !dbg !865
  %inc68 = add nsw i32 %61, 1, !dbg !865
  store i32 %inc68, i32* %i, align 4, !dbg !865
  br label %for.cond59, !dbg !866, !llvm.loop !867

for.end69:                                        ; preds = %for.cond59
  store double 0.000000e+00, double* %norm, align 8, !dbg !869
  store double 0.000000e+00, double* %bias_norm, align 8, !dbg !870
  br label %update_weights_loop5, !dbg !871

update_weights_loop5:                             ; preds = %for.end69
  call void @llvm.dbg.label(metadata !872), !dbg !873
  store i32 0, i32* %i, align 4, !dbg !874
  br label %for.cond70, !dbg !876

for.cond70:                                       ; preds = %for.inc98, %update_weights_loop5
  %62 = load i32, i32* %i, align 4, !dbg !877
  %cmp71 = icmp slt i32 %62, 64, !dbg !879
  br i1 %cmp71, label %for.body72, label %for.end100, !dbg !880

for.body72:                                       ; preds = %for.cond70
  br label %update_weights_loop5_1, !dbg !881

update_weights_loop5_1:                           ; preds = %for.body72
  call void @llvm.dbg.label(metadata !882), !dbg !884
  store i32 0, i32* %j, align 4, !dbg !885
  br label %for.cond73, !dbg !887

for.cond73:                                       ; preds = %for.inc95, %update_weights_loop5_1
  %63 = load i32, i32* %j, align 4, !dbg !888
  %cmp74 = icmp slt i32 %63, 64, !dbg !890
  br i1 %cmp74, label %for.body75, label %for.end97, !dbg !891

for.body75:                                       ; preds = %for.cond73
  %64 = load double*, double** %d_weights2.addr, align 8, !dbg !892
  %65 = load i32, i32* %i, align 4, !dbg !894
  %mul76 = mul nsw i32 %65, 64, !dbg !895
  %66 = load i32, i32* %j, align 4, !dbg !896
  %add77 = add nsw i32 %mul76, %66, !dbg !897
  %idxprom78 = sext i32 %add77 to i64, !dbg !892
  %arrayidx79 = getelementptr inbounds double, double* %64, i64 %idxprom78, !dbg !892
  %67 = load double, double* %arrayidx79, align 8, !dbg !892
  %68 = load double*, double** %weights2.addr, align 8, !dbg !898
  %69 = load i32, i32* %i, align 4, !dbg !899
  %mul81 = mul nsw i32 %69, 64, !dbg !900
  %70 = load i32, i32* %j, align 4, !dbg !901
  %add82 = add nsw i32 %mul81, %70, !dbg !902
  %idxprom83 = sext i32 %add82 to i64, !dbg !898
  %arrayidx84 = getelementptr inbounds double, double* %68, i64 %idxprom83, !dbg !898
  %71 = load double, double* %arrayidx84, align 8, !dbg !903
  %neg85 = fneg double %67, !dbg !903
  %72 = call double @llvm.fmuladd.f64(double %neg85, double 1.000000e-02, double %71), !dbg !903
  store double %72, double* %arrayidx84, align 8, !dbg !903
  %73 = load double*, double** %weights2.addr, align 8, !dbg !904
  %74 = load i32, i32* %i, align 4, !dbg !905
  %mul86 = mul nsw i32 %74, 64, !dbg !906
  %75 = load i32, i32* %j, align 4, !dbg !907
  %add87 = add nsw i32 %mul86, %75, !dbg !908
  %idxprom88 = sext i32 %add87 to i64, !dbg !904
  %arrayidx89 = getelementptr inbounds double, double* %73, i64 %idxprom88, !dbg !904
  %76 = load double, double* %arrayidx89, align 8, !dbg !904
  %77 = load double*, double** %weights2.addr, align 8, !dbg !909
  %78 = load i32, i32* %i, align 4, !dbg !910
  %mul90 = mul nsw i32 %78, 64, !dbg !911
  %79 = load i32, i32* %j, align 4, !dbg !912
  %add91 = add nsw i32 %mul90, %79, !dbg !913
  %idxprom92 = sext i32 %add91 to i64, !dbg !909
  %arrayidx93 = getelementptr inbounds double, double* %77, i64 %idxprom92, !dbg !909
  %80 = load double, double* %arrayidx93, align 8, !dbg !909
  %81 = load double, double* %norm, align 8, !dbg !914
  %82 = call double @llvm.fmuladd.f64(double %76, double %80, double %81), !dbg !914
  store double %82, double* %norm, align 8, !dbg !914
  br label %for.inc95, !dbg !915

for.inc95:                                        ; preds = %for.body75
  %83 = load i32, i32* %j, align 4, !dbg !916
  %inc96 = add nsw i32 %83, 1, !dbg !916
  store i32 %inc96, i32* %j, align 4, !dbg !916
  br label %for.cond73, !dbg !917, !llvm.loop !918

for.end97:                                        ; preds = %for.cond73
  br label %for.inc98, !dbg !920

for.inc98:                                        ; preds = %for.end97
  %84 = load i32, i32* %i, align 4, !dbg !921
  %inc99 = add nsw i32 %84, 1, !dbg !921
  store i32 %inc99, i32* %i, align 4, !dbg !921
  br label %for.cond70, !dbg !922, !llvm.loop !923

for.end100:                                       ; preds = %for.cond70
  br label %update_weights_loop6, !dbg !924

update_weights_loop6:                             ; preds = %for.end100
  call void @llvm.dbg.label(metadata !925), !dbg !926
  store i32 0, i32* %i, align 4, !dbg !927
  br label %for.cond101, !dbg !929

for.cond101:                                      ; preds = %for.inc115, %update_weights_loop6
  %85 = load i32, i32* %i, align 4, !dbg !930
  %cmp102 = icmp slt i32 %85, 64, !dbg !932
  br i1 %cmp102, label %for.body103, label %for.end117, !dbg !933

for.body103:                                      ; preds = %for.cond101
  %86 = load double*, double** %d_biases2.addr, align 8, !dbg !934
  %87 = load i32, i32* %i, align 4, !dbg !936
  %idxprom104 = sext i32 %87 to i64, !dbg !934
  %arrayidx105 = getelementptr inbounds double, double* %86, i64 %idxprom104, !dbg !934
  %88 = load double, double* %arrayidx105, align 8, !dbg !934
  %89 = load double*, double** %biases2.addr, align 8, !dbg !937
  %90 = load i32, i32* %i, align 4, !dbg !938
  %idxprom107 = sext i32 %90 to i64, !dbg !937
  %arrayidx108 = getelementptr inbounds double, double* %89, i64 %idxprom107, !dbg !937
  %91 = load double, double* %arrayidx108, align 8, !dbg !939
  %neg109 = fneg double %88, !dbg !939
  %92 = call double @llvm.fmuladd.f64(double %neg109, double 1.000000e-02, double %91), !dbg !939
  store double %92, double* %arrayidx108, align 8, !dbg !939
  %93 = load double*, double** %biases2.addr, align 8, !dbg !940
  %94 = load i32, i32* %i, align 4, !dbg !941
  %idxprom110 = sext i32 %94 to i64, !dbg !940
  %arrayidx111 = getelementptr inbounds double, double* %93, i64 %idxprom110, !dbg !940
  %95 = load double, double* %arrayidx111, align 8, !dbg !940
  %96 = load double*, double** %biases2.addr, align 8, !dbg !942
  %97 = load i32, i32* %i, align 4, !dbg !943
  %idxprom112 = sext i32 %97 to i64, !dbg !942
  %arrayidx113 = getelementptr inbounds double, double* %96, i64 %idxprom112, !dbg !942
  %98 = load double, double* %arrayidx113, align 8, !dbg !942
  %99 = load double, double* %bias_norm, align 8, !dbg !944
  %100 = call double @llvm.fmuladd.f64(double %95, double %98, double %99), !dbg !944
  store double %100, double* %bias_norm, align 8, !dbg !944
  br label %for.inc115, !dbg !945

for.inc115:                                       ; preds = %for.body103
  %101 = load i32, i32* %i, align 4, !dbg !946
  %inc116 = add nsw i32 %101, 1, !dbg !946
  store i32 %inc116, i32* %i, align 4, !dbg !946
  br label %for.cond101, !dbg !947, !llvm.loop !948

for.end117:                                       ; preds = %for.cond101
  %102 = load double, double* %norm, align 8, !dbg !950
  %call118 = call double @sqrt(double noundef %102) #3, !dbg !951
  store double %call118, double* %norm, align 8, !dbg !952
  %103 = load double, double* %bias_norm, align 8, !dbg !953
  %call119 = call double @sqrt(double noundef %103) #3, !dbg !954
  store double %call119, double* %bias_norm, align 8, !dbg !955
  br label %update_weights_loop7, !dbg !956

update_weights_loop7:                             ; preds = %for.end117
  call void @llvm.dbg.label(metadata !957), !dbg !958
  store i32 0, i32* %i, align 4, !dbg !959
  br label %for.cond120, !dbg !961

for.cond120:                                      ; preds = %for.inc138, %update_weights_loop7
  %104 = load i32, i32* %i, align 4, !dbg !962
  %cmp121 = icmp slt i32 %104, 64, !dbg !964
  br i1 %cmp121, label %for.body122, label %for.end140, !dbg !965

for.body122:                                      ; preds = %for.cond120
  br label %update_weights_loop7_1, !dbg !966

update_weights_loop7_1:                           ; preds = %for.body122
  call void @llvm.dbg.label(metadata !967), !dbg !969
  store i32 0, i32* %j, align 4, !dbg !970
  br label %for.cond123, !dbg !972

for.cond123:                                      ; preds = %for.inc135, %update_weights_loop7_1
  %105 = load i32, i32* %j, align 4, !dbg !973
  %cmp124 = icmp slt i32 %105, 64, !dbg !975
  br i1 %cmp124, label %for.body125, label %for.end137, !dbg !976

for.body125:                                      ; preds = %for.cond123
  %106 = load double*, double** %weights2.addr, align 8, !dbg !977
  %107 = load i32, i32* %i, align 4, !dbg !979
  %mul126 = mul nsw i32 %107, 64, !dbg !980
  %108 = load i32, i32* %j, align 4, !dbg !981
  %add127 = add nsw i32 %mul126, %108, !dbg !982
  %idxprom128 = sext i32 %add127 to i64, !dbg !977
  %arrayidx129 = getelementptr inbounds double, double* %106, i64 %idxprom128, !dbg !977
  %109 = load double, double* %arrayidx129, align 8, !dbg !977
  %110 = load double, double* %norm, align 8, !dbg !983
  %div130 = fdiv double %109, %110, !dbg !984
  %111 = load double*, double** %weights2.addr, align 8, !dbg !985
  %112 = load i32, i32* %i, align 4, !dbg !986
  %mul131 = mul nsw i32 %112, 64, !dbg !987
  %113 = load i32, i32* %j, align 4, !dbg !988
  %add132 = add nsw i32 %mul131, %113, !dbg !989
  %idxprom133 = sext i32 %add132 to i64, !dbg !985
  %arrayidx134 = getelementptr inbounds double, double* %111, i64 %idxprom133, !dbg !985
  store double %div130, double* %arrayidx134, align 8, !dbg !990
  br label %for.inc135, !dbg !991

for.inc135:                                       ; preds = %for.body125
  %114 = load i32, i32* %j, align 4, !dbg !992
  %inc136 = add nsw i32 %114, 1, !dbg !992
  store i32 %inc136, i32* %j, align 4, !dbg !992
  br label %for.cond123, !dbg !993, !llvm.loop !994

for.end137:                                       ; preds = %for.cond123
  br label %for.inc138, !dbg !996

for.inc138:                                       ; preds = %for.end137
  %115 = load i32, i32* %i, align 4, !dbg !997
  %inc139 = add nsw i32 %115, 1, !dbg !997
  store i32 %inc139, i32* %i, align 4, !dbg !997
  br label %for.cond120, !dbg !998, !llvm.loop !999

for.end140:                                       ; preds = %for.cond120
  br label %update_weights_loop8, !dbg !1000

update_weights_loop8:                             ; preds = %for.end140
  call void @llvm.dbg.label(metadata !1001), !dbg !1002
  store i32 0, i32* %i, align 4, !dbg !1003
  br label %for.cond141, !dbg !1005

for.cond141:                                      ; preds = %for.inc149, %update_weights_loop8
  %116 = load i32, i32* %i, align 4, !dbg !1006
  %cmp142 = icmp slt i32 %116, 64, !dbg !1008
  br i1 %cmp142, label %for.body143, label %for.end151, !dbg !1009

for.body143:                                      ; preds = %for.cond141
  %117 = load double*, double** %biases2.addr, align 8, !dbg !1010
  %118 = load i32, i32* %i, align 4, !dbg !1012
  %idxprom144 = sext i32 %118 to i64, !dbg !1010
  %arrayidx145 = getelementptr inbounds double, double* %117, i64 %idxprom144, !dbg !1010
  %119 = load double, double* %arrayidx145, align 8, !dbg !1010
  %120 = load double, double* %bias_norm, align 8, !dbg !1013
  %div146 = fdiv double %119, %120, !dbg !1014
  %121 = load double*, double** %biases2.addr, align 8, !dbg !1015
  %122 = load i32, i32* %i, align 4, !dbg !1016
  %idxprom147 = sext i32 %122 to i64, !dbg !1015
  %arrayidx148 = getelementptr inbounds double, double* %121, i64 %idxprom147, !dbg !1015
  store double %div146, double* %arrayidx148, align 8, !dbg !1017
  br label %for.inc149, !dbg !1018

for.inc149:                                       ; preds = %for.body143
  %123 = load i32, i32* %i, align 4, !dbg !1019
  %inc150 = add nsw i32 %123, 1, !dbg !1019
  store i32 %inc150, i32* %i, align 4, !dbg !1019
  br label %for.cond141, !dbg !1020, !llvm.loop !1021

for.end151:                                       ; preds = %for.cond141
  store double 0.000000e+00, double* %norm, align 8, !dbg !1023
  store double 0.000000e+00, double* %bias_norm, align 8, !dbg !1024
  br label %update_weights_loop9, !dbg !1025

update_weights_loop9:                             ; preds = %for.end151
  call void @llvm.dbg.label(metadata !1026), !dbg !1027
  store i32 0, i32* %i, align 4, !dbg !1028
  br label %for.cond152, !dbg !1030

for.cond152:                                      ; preds = %for.inc180, %update_weights_loop9
  %124 = load i32, i32* %i, align 4, !dbg !1031
  %cmp153 = icmp slt i32 %124, 64, !dbg !1033
  br i1 %cmp153, label %for.body154, label %for.end182, !dbg !1034

for.body154:                                      ; preds = %for.cond152
  br label %update_weights_loop9_1, !dbg !1035

update_weights_loop9_1:                           ; preds = %for.body154
  call void @llvm.dbg.label(metadata !1036), !dbg !1038
  store i32 0, i32* %j, align 4, !dbg !1039
  br label %for.cond155, !dbg !1041

for.cond155:                                      ; preds = %for.inc177, %update_weights_loop9_1
  %125 = load i32, i32* %j, align 4, !dbg !1042
  %cmp156 = icmp slt i32 %125, 3, !dbg !1044
  br i1 %cmp156, label %for.body157, label %for.end179, !dbg !1045

for.body157:                                      ; preds = %for.cond155
  %126 = load double*, double** %d_weights3.addr, align 8, !dbg !1046
  %127 = load i32, i32* %i, align 4, !dbg !1048
  %mul158 = mul nsw i32 %127, 3, !dbg !1049
  %128 = load i32, i32* %j, align 4, !dbg !1050
  %add159 = add nsw i32 %mul158, %128, !dbg !1051
  %idxprom160 = sext i32 %add159 to i64, !dbg !1046
  %arrayidx161 = getelementptr inbounds double, double* %126, i64 %idxprom160, !dbg !1046
  %129 = load double, double* %arrayidx161, align 8, !dbg !1046
  %130 = load double*, double** %weights3.addr, align 8, !dbg !1052
  %131 = load i32, i32* %i, align 4, !dbg !1053
  %mul163 = mul nsw i32 %131, 3, !dbg !1054
  %132 = load i32, i32* %j, align 4, !dbg !1055
  %add164 = add nsw i32 %mul163, %132, !dbg !1056
  %idxprom165 = sext i32 %add164 to i64, !dbg !1052
  %arrayidx166 = getelementptr inbounds double, double* %130, i64 %idxprom165, !dbg !1052
  %133 = load double, double* %arrayidx166, align 8, !dbg !1057
  %neg167 = fneg double %129, !dbg !1057
  %134 = call double @llvm.fmuladd.f64(double %neg167, double 1.000000e-02, double %133), !dbg !1057
  store double %134, double* %arrayidx166, align 8, !dbg !1057
  %135 = load double*, double** %weights3.addr, align 8, !dbg !1058
  %136 = load i32, i32* %i, align 4, !dbg !1059
  %mul168 = mul nsw i32 %136, 3, !dbg !1060
  %137 = load i32, i32* %j, align 4, !dbg !1061
  %add169 = add nsw i32 %mul168, %137, !dbg !1062
  %idxprom170 = sext i32 %add169 to i64, !dbg !1058
  %arrayidx171 = getelementptr inbounds double, double* %135, i64 %idxprom170, !dbg !1058
  %138 = load double, double* %arrayidx171, align 8, !dbg !1058
  %139 = load double*, double** %weights3.addr, align 8, !dbg !1063
  %140 = load i32, i32* %i, align 4, !dbg !1064
  %mul172 = mul nsw i32 %140, 3, !dbg !1065
  %141 = load i32, i32* %j, align 4, !dbg !1066
  %add173 = add nsw i32 %mul172, %141, !dbg !1067
  %idxprom174 = sext i32 %add173 to i64, !dbg !1063
  %arrayidx175 = getelementptr inbounds double, double* %139, i64 %idxprom174, !dbg !1063
  %142 = load double, double* %arrayidx175, align 8, !dbg !1063
  %143 = load double, double* %norm, align 8, !dbg !1068
  %144 = call double @llvm.fmuladd.f64(double %138, double %142, double %143), !dbg !1068
  store double %144, double* %norm, align 8, !dbg !1068
  br label %for.inc177, !dbg !1069

for.inc177:                                       ; preds = %for.body157
  %145 = load i32, i32* %j, align 4, !dbg !1070
  %inc178 = add nsw i32 %145, 1, !dbg !1070
  store i32 %inc178, i32* %j, align 4, !dbg !1070
  br label %for.cond155, !dbg !1071, !llvm.loop !1072

for.end179:                                       ; preds = %for.cond155
  br label %for.inc180, !dbg !1074

for.inc180:                                       ; preds = %for.end179
  %146 = load i32, i32* %i, align 4, !dbg !1075
  %inc181 = add nsw i32 %146, 1, !dbg !1075
  store i32 %inc181, i32* %i, align 4, !dbg !1075
  br label %for.cond152, !dbg !1076, !llvm.loop !1077

for.end182:                                       ; preds = %for.cond152
  br label %update_weights_loop10, !dbg !1078

update_weights_loop10:                            ; preds = %for.end182
  call void @llvm.dbg.label(metadata !1079), !dbg !1080
  store i32 0, i32* %i, align 4, !dbg !1081
  br label %for.cond183, !dbg !1083

for.cond183:                                      ; preds = %for.inc197, %update_weights_loop10
  %147 = load i32, i32* %i, align 4, !dbg !1084
  %cmp184 = icmp slt i32 %147, 3, !dbg !1086
  br i1 %cmp184, label %for.body185, label %for.end199, !dbg !1087

for.body185:                                      ; preds = %for.cond183
  %148 = load double*, double** %d_biases3.addr, align 8, !dbg !1088
  %149 = load i32, i32* %i, align 4, !dbg !1090
  %idxprom186 = sext i32 %149 to i64, !dbg !1088
  %arrayidx187 = getelementptr inbounds double, double* %148, i64 %idxprom186, !dbg !1088
  %150 = load double, double* %arrayidx187, align 8, !dbg !1088
  %151 = load double*, double** %biases3.addr, align 8, !dbg !1091
  %152 = load i32, i32* %i, align 4, !dbg !1092
  %idxprom189 = sext i32 %152 to i64, !dbg !1091
  %arrayidx190 = getelementptr inbounds double, double* %151, i64 %idxprom189, !dbg !1091
  %153 = load double, double* %arrayidx190, align 8, !dbg !1093
  %neg191 = fneg double %150, !dbg !1093
  %154 = call double @llvm.fmuladd.f64(double %neg191, double 1.000000e-02, double %153), !dbg !1093
  store double %154, double* %arrayidx190, align 8, !dbg !1093
  %155 = load double*, double** %biases3.addr, align 8, !dbg !1094
  %156 = load i32, i32* %i, align 4, !dbg !1095
  %idxprom192 = sext i32 %156 to i64, !dbg !1094
  %arrayidx193 = getelementptr inbounds double, double* %155, i64 %idxprom192, !dbg !1094
  %157 = load double, double* %arrayidx193, align 8, !dbg !1094
  %158 = load double*, double** %biases3.addr, align 8, !dbg !1096
  %159 = load i32, i32* %i, align 4, !dbg !1097
  %idxprom194 = sext i32 %159 to i64, !dbg !1096
  %arrayidx195 = getelementptr inbounds double, double* %158, i64 %idxprom194, !dbg !1096
  %160 = load double, double* %arrayidx195, align 8, !dbg !1096
  %161 = load double, double* %bias_norm, align 8, !dbg !1098
  %162 = call double @llvm.fmuladd.f64(double %157, double %160, double %161), !dbg !1098
  store double %162, double* %bias_norm, align 8, !dbg !1098
  br label %for.inc197, !dbg !1099

for.inc197:                                       ; preds = %for.body185
  %163 = load i32, i32* %i, align 4, !dbg !1100
  %inc198 = add nsw i32 %163, 1, !dbg !1100
  store i32 %inc198, i32* %i, align 4, !dbg !1100
  br label %for.cond183, !dbg !1101, !llvm.loop !1102

for.end199:                                       ; preds = %for.cond183
  %164 = load double, double* %norm, align 8, !dbg !1104
  %call200 = call double @sqrt(double noundef %164) #3, !dbg !1105
  store double %call200, double* %norm, align 8, !dbg !1106
  %165 = load double, double* %bias_norm, align 8, !dbg !1107
  %call201 = call double @sqrt(double noundef %165) #3, !dbg !1108
  store double %call201, double* %bias_norm, align 8, !dbg !1109
  br label %update_weights_loop11, !dbg !1110

update_weights_loop11:                            ; preds = %for.end199
  call void @llvm.dbg.label(metadata !1111), !dbg !1112
  store i32 0, i32* %i, align 4, !dbg !1113
  br label %for.cond202, !dbg !1115

for.cond202:                                      ; preds = %for.inc220, %update_weights_loop11
  %166 = load i32, i32* %i, align 4, !dbg !1116
  %cmp203 = icmp slt i32 %166, 64, !dbg !1118
  br i1 %cmp203, label %for.body204, label %for.end222, !dbg !1119

for.body204:                                      ; preds = %for.cond202
  br label %update_weights_loop11_1, !dbg !1120

update_weights_loop11_1:                          ; preds = %for.body204
  call void @llvm.dbg.label(metadata !1121), !dbg !1123
  store i32 0, i32* %j, align 4, !dbg !1124
  br label %for.cond205, !dbg !1126

for.cond205:                                      ; preds = %for.inc217, %update_weights_loop11_1
  %167 = load i32, i32* %j, align 4, !dbg !1127
  %cmp206 = icmp slt i32 %167, 3, !dbg !1129
  br i1 %cmp206, label %for.body207, label %for.end219, !dbg !1130

for.body207:                                      ; preds = %for.cond205
  %168 = load double*, double** %weights3.addr, align 8, !dbg !1131
  %169 = load i32, i32* %i, align 4, !dbg !1133
  %mul208 = mul nsw i32 %169, 3, !dbg !1134
  %170 = load i32, i32* %j, align 4, !dbg !1135
  %add209 = add nsw i32 %mul208, %170, !dbg !1136
  %idxprom210 = sext i32 %add209 to i64, !dbg !1131
  %arrayidx211 = getelementptr inbounds double, double* %168, i64 %idxprom210, !dbg !1131
  %171 = load double, double* %arrayidx211, align 8, !dbg !1131
  %172 = load double, double* %norm, align 8, !dbg !1137
  %div212 = fdiv double %171, %172, !dbg !1138
  %173 = load double*, double** %weights3.addr, align 8, !dbg !1139
  %174 = load i32, i32* %i, align 4, !dbg !1140
  %mul213 = mul nsw i32 %174, 3, !dbg !1141
  %175 = load i32, i32* %j, align 4, !dbg !1142
  %add214 = add nsw i32 %mul213, %175, !dbg !1143
  %idxprom215 = sext i32 %add214 to i64, !dbg !1139
  %arrayidx216 = getelementptr inbounds double, double* %173, i64 %idxprom215, !dbg !1139
  store double %div212, double* %arrayidx216, align 8, !dbg !1144
  br label %for.inc217, !dbg !1145

for.inc217:                                       ; preds = %for.body207
  %176 = load i32, i32* %j, align 4, !dbg !1146
  %inc218 = add nsw i32 %176, 1, !dbg !1146
  store i32 %inc218, i32* %j, align 4, !dbg !1146
  br label %for.cond205, !dbg !1147, !llvm.loop !1148

for.end219:                                       ; preds = %for.cond205
  br label %for.inc220, !dbg !1150

for.inc220:                                       ; preds = %for.end219
  %177 = load i32, i32* %i, align 4, !dbg !1151
  %inc221 = add nsw i32 %177, 1, !dbg !1151
  store i32 %inc221, i32* %i, align 4, !dbg !1151
  br label %for.cond202, !dbg !1152, !llvm.loop !1153

for.end222:                                       ; preds = %for.cond202
  br label %update_weights_loop12, !dbg !1154

update_weights_loop12:                            ; preds = %for.end222
  call void @llvm.dbg.label(metadata !1155), !dbg !1156
  store i32 0, i32* %i, align 4, !dbg !1157
  br label %for.cond223, !dbg !1159

for.cond223:                                      ; preds = %for.inc231, %update_weights_loop12
  %178 = load i32, i32* %i, align 4, !dbg !1160
  %cmp224 = icmp slt i32 %178, 3, !dbg !1162
  br i1 %cmp224, label %for.body225, label %for.end233, !dbg !1163

for.body225:                                      ; preds = %for.cond223
  %179 = load double*, double** %biases3.addr, align 8, !dbg !1164
  %180 = load i32, i32* %i, align 4, !dbg !1166
  %idxprom226 = sext i32 %180 to i64, !dbg !1164
  %arrayidx227 = getelementptr inbounds double, double* %179, i64 %idxprom226, !dbg !1164
  %181 = load double, double* %arrayidx227, align 8, !dbg !1164
  %182 = load double, double* %bias_norm, align 8, !dbg !1167
  %div228 = fdiv double %181, %182, !dbg !1168
  %183 = load double*, double** %biases3.addr, align 8, !dbg !1169
  %184 = load i32, i32* %i, align 4, !dbg !1170
  %idxprom229 = sext i32 %184 to i64, !dbg !1169
  %arrayidx230 = getelementptr inbounds double, double* %183, i64 %idxprom229, !dbg !1169
  store double %div228, double* %arrayidx230, align 8, !dbg !1171
  br label %for.inc231, !dbg !1172

for.inc231:                                       ; preds = %for.body225
  %185 = load i32, i32* %i, align 4, !dbg !1173
  %inc232 = add nsw i32 %185, 1, !dbg !1173
  store i32 %inc232, i32* %i, align 4, !dbg !1173
  br label %for.cond223, !dbg !1174, !llvm.loop !1175

for.end233:                                       ; preds = %for.cond223
  ret void, !dbg !1177
}

; Function Attrs: nounwind
declare double @sqrt(double noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @backprop(double* noundef %weights1, double* noundef %weights2, double* noundef %weights3, double* noundef %biases1, double* noundef %biases2, double* noundef %biases3, double* noundef %training_data, double* noundef %training_targets) #0 !dbg !1178 {
entry:
  %weights1.addr = alloca double*, align 8
  %weights2.addr = alloca double*, align 8
  %weights3.addr = alloca double*, align 8
  %biases1.addr = alloca double*, align 8
  %biases2.addr = alloca double*, align 8
  %biases3.addr = alloca double*, align 8
  %training_data.addr = alloca double*, align 8
  %training_targets.addr = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %activations1 = alloca [64 x double], align 16
  %activations2 = alloca [64 x double], align 16
  %activations3 = alloca [3 x double], align 16
  %dactivations1 = alloca [64 x double], align 16
  %dactivations2 = alloca [64 x double], align 16
  %dactivations3 = alloca [3 x double], align 16
  %net_outputs = alloca [3 x double], align 16
  %output_difference = alloca [3 x double], align 16
  %delta_weights1 = alloca [832 x double], align 16
  %delta_weights2 = alloca [4096 x double], align 16
  %delta_weights3 = alloca [192 x double], align 16
  %oracle_activations1 = alloca [64 x double], align 16
  %oracle_activations2 = alloca [64 x double], align 16
  store double* %weights1, double** %weights1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights1.addr, metadata !1181, metadata !DIExpression()), !dbg !1182
  store double* %weights2, double** %weights2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights2.addr, metadata !1183, metadata !DIExpression()), !dbg !1184
  store double* %weights3, double** %weights3.addr, align 8
  call void @llvm.dbg.declare(metadata double** %weights3.addr, metadata !1185, metadata !DIExpression()), !dbg !1186
  store double* %biases1, double** %biases1.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases1.addr, metadata !1187, metadata !DIExpression()), !dbg !1188
  store double* %biases2, double** %biases2.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases2.addr, metadata !1189, metadata !DIExpression()), !dbg !1190
  store double* %biases3, double** %biases3.addr, align 8
  call void @llvm.dbg.declare(metadata double** %biases3.addr, metadata !1191, metadata !DIExpression()), !dbg !1192
  store double* %training_data, double** %training_data.addr, align 8
  call void @llvm.dbg.declare(metadata double** %training_data.addr, metadata !1193, metadata !DIExpression()), !dbg !1194
  store double* %training_targets, double** %training_targets.addr, align 8
  call void @llvm.dbg.declare(metadata double** %training_targets.addr, metadata !1195, metadata !DIExpression()), !dbg !1196
  call void @llvm.dbg.declare(metadata i32* %i, metadata !1197, metadata !DIExpression()), !dbg !1198
  call void @llvm.dbg.declare(metadata i32* %j, metadata !1199, metadata !DIExpression()), !dbg !1200
  call void @llvm.dbg.declare(metadata [64 x double]* %activations1, metadata !1201, metadata !DIExpression()), !dbg !1205
  call void @llvm.dbg.declare(metadata [64 x double]* %activations2, metadata !1206, metadata !DIExpression()), !dbg !1207
  call void @llvm.dbg.declare(metadata [3 x double]* %activations3, metadata !1208, metadata !DIExpression()), !dbg !1212
  call void @llvm.dbg.declare(metadata [64 x double]* %dactivations1, metadata !1213, metadata !DIExpression()), !dbg !1214
  call void @llvm.dbg.declare(metadata [64 x double]* %dactivations2, metadata !1215, metadata !DIExpression()), !dbg !1216
  call void @llvm.dbg.declare(metadata [3 x double]* %dactivations3, metadata !1217, metadata !DIExpression()), !dbg !1218
  call void @llvm.dbg.declare(metadata [3 x double]* %net_outputs, metadata !1219, metadata !DIExpression()), !dbg !1220
  call void @llvm.dbg.declare(metadata [3 x double]* %output_difference, metadata !1221, metadata !DIExpression()), !dbg !1222
  call void @llvm.dbg.declare(metadata [832 x double]* %delta_weights1, metadata !1223, metadata !DIExpression()), !dbg !1227
  call void @llvm.dbg.declare(metadata [4096 x double]* %delta_weights2, metadata !1228, metadata !DIExpression()), !dbg !1232
  call void @llvm.dbg.declare(metadata [192 x double]* %delta_weights3, metadata !1233, metadata !DIExpression()), !dbg !1237
  call void @llvm.dbg.declare(metadata [64 x double]* %oracle_activations1, metadata !1238, metadata !DIExpression()), !dbg !1239
  call void @llvm.dbg.declare(metadata [64 x double]* %oracle_activations2, metadata !1240, metadata !DIExpression()), !dbg !1241
  br label %backprop_loop1, !dbg !1242

backprop_loop1:                                   ; preds = %entry
  call void @llvm.dbg.label(metadata !1243), !dbg !1244
  store i32 0, i32* %i, align 4, !dbg !1245
  br label %for.cond, !dbg !1247

for.cond:                                         ; preds = %for.inc52, %backprop_loop1
  %0 = load i32, i32* %i, align 4, !dbg !1248
  %cmp = icmp slt i32 %0, 163, !dbg !1250
  br i1 %cmp, label %for.body, label %for.end54, !dbg !1251

for.body:                                         ; preds = %for.cond
  br label %backprop_loop1_1, !dbg !1252

backprop_loop1_1:                                 ; preds = %for.body
  call void @llvm.dbg.label(metadata !1253), !dbg !1255
  store i32 0, i32* %j, align 4, !dbg !1256
  br label %for.cond1, !dbg !1258

for.cond1:                                        ; preds = %for.inc, %backprop_loop1_1
  %1 = load i32, i32* %j, align 4, !dbg !1259
  %cmp2 = icmp slt i32 %1, 64, !dbg !1261
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !1262

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %j, align 4, !dbg !1263
  %idxprom = sext i32 %2 to i64, !dbg !1265
  %arrayidx = getelementptr inbounds [64 x double], [64 x double]* %activations1, i64 0, i64 %idxprom, !dbg !1265
  store double 0.000000e+00, double* %arrayidx, align 8, !dbg !1266
  %3 = load i32, i32* %j, align 4, !dbg !1267
  %idxprom4 = sext i32 %3 to i64, !dbg !1268
  %arrayidx5 = getelementptr inbounds [64 x double], [64 x double]* %activations2, i64 0, i64 %idxprom4, !dbg !1268
  store double 0.000000e+00, double* %arrayidx5, align 8, !dbg !1269
  %4 = load i32, i32* %j, align 4, !dbg !1270
  %cmp6 = icmp slt i32 %4, 3, !dbg !1272
  br i1 %cmp6, label %if.then, label %if.end, !dbg !1273

if.then:                                          ; preds = %for.body3
  %5 = load i32, i32* %j, align 4, !dbg !1274
  %idxprom7 = sext i32 %5 to i64, !dbg !1276
  %arrayidx8 = getelementptr inbounds [3 x double], [3 x double]* %activations3, i64 0, i64 %idxprom7, !dbg !1276
  store double 0.000000e+00, double* %arrayidx8, align 8, !dbg !1277
  br label %if.end, !dbg !1278

if.end:                                           ; preds = %if.then, %for.body3
  br label %for.inc, !dbg !1279

for.inc:                                          ; preds = %if.end
  %6 = load i32, i32* %j, align 4, !dbg !1280
  %inc = add nsw i32 %6, 1, !dbg !1280
  store i32 %inc, i32* %j, align 4, !dbg !1280
  br label %for.cond1, !dbg !1281, !llvm.loop !1282

for.end:                                          ; preds = %for.cond1
  %7 = load double*, double** %biases1.addr, align 8, !dbg !1284
  %8 = load double*, double** %weights1.addr, align 8, !dbg !1285
  %arraydecay = getelementptr inbounds [64 x double], [64 x double]* %activations1, i64 0, i64 0, !dbg !1286
  %9 = load double*, double** %training_data.addr, align 8, !dbg !1287
  %10 = load i32, i32* %i, align 4, !dbg !1288
  %mul = mul nsw i32 %10, 13, !dbg !1289
  %idxprom9 = sext i32 %mul to i64, !dbg !1287
  %arrayidx10 = getelementptr inbounds double, double* %9, i64 %idxprom9, !dbg !1287
  call void @matrix_vector_product_with_bias_input_layer(double* noundef %7, double* noundef %8, double* noundef %arraydecay, double* noundef %arrayidx10), !dbg !1290
  %arraydecay11 = getelementptr inbounds [64 x double], [64 x double]* %activations1, i64 0, i64 0, !dbg !1291
  %arraydecay12 = getelementptr inbounds [64 x double], [64 x double]* %dactivations1, i64 0, i64 0, !dbg !1292
  call void @RELU(double* noundef %arraydecay11, double* noundef %arraydecay12, i32 noundef 64), !dbg !1293
  %11 = load double*, double** %biases2.addr, align 8, !dbg !1294
  %12 = load double*, double** %weights2.addr, align 8, !dbg !1295
  %arraydecay13 = getelementptr inbounds [64 x double], [64 x double]* %activations2, i64 0, i64 0, !dbg !1296
  %arraydecay14 = getelementptr inbounds [64 x double], [64 x double]* %activations1, i64 0, i64 0, !dbg !1297
  call void @matrix_vector_product_with_bias_second_layer(double* noundef %11, double* noundef %12, double* noundef %arraydecay13, double* noundef %arraydecay14), !dbg !1298
  %arraydecay15 = getelementptr inbounds [64 x double], [64 x double]* %activations2, i64 0, i64 0, !dbg !1299
  %arraydecay16 = getelementptr inbounds [64 x double], [64 x double]* %dactivations2, i64 0, i64 0, !dbg !1300
  call void @RELU(double* noundef %arraydecay15, double* noundef %arraydecay16, i32 noundef 64), !dbg !1301
  %13 = load double*, double** %biases3.addr, align 8, !dbg !1302
  %14 = load double*, double** %weights3.addr, align 8, !dbg !1303
  %arraydecay17 = getelementptr inbounds [3 x double], [3 x double]* %activations3, i64 0, i64 0, !dbg !1304
  %arraydecay18 = getelementptr inbounds [64 x double], [64 x double]* %activations2, i64 0, i64 0, !dbg !1305
  call void @matrix_vector_product_with_bias_output_layer(double* noundef %13, double* noundef %14, double* noundef %arraydecay17, double* noundef %arraydecay18), !dbg !1306
  %arraydecay19 = getelementptr inbounds [3 x double], [3 x double]* %activations3, i64 0, i64 0, !dbg !1307
  %arraydecay20 = getelementptr inbounds [3 x double], [3 x double]* %dactivations3, i64 0, i64 0, !dbg !1308
  call void @RELU(double* noundef %arraydecay19, double* noundef %arraydecay20, i32 noundef 3), !dbg !1309
  %arraydecay21 = getelementptr inbounds [3 x double], [3 x double]* %net_outputs, i64 0, i64 0, !dbg !1310
  %arraydecay22 = getelementptr inbounds [3 x double], [3 x double]* %activations3, i64 0, i64 0, !dbg !1311
  call void @soft_max(double* noundef %arraydecay21, double* noundef %arraydecay22), !dbg !1312
  %arraydecay23 = getelementptr inbounds [3 x double], [3 x double]* %net_outputs, i64 0, i64 0, !dbg !1313
  %15 = load double*, double** %training_targets.addr, align 8, !dbg !1314
  %16 = load i32, i32* %i, align 4, !dbg !1315
  %mul24 = mul nsw i32 %16, 3, !dbg !1316
  %idxprom25 = sext i32 %mul24 to i64, !dbg !1314
  %arrayidx26 = getelementptr inbounds double, double* %15, i64 %idxprom25, !dbg !1314
  %arraydecay27 = getelementptr inbounds [3 x double], [3 x double]* %output_difference, i64 0, i64 0, !dbg !1317
  %arraydecay28 = getelementptr inbounds [3 x double], [3 x double]* %dactivations3, i64 0, i64 0, !dbg !1318
  call void @take_difference(double* noundef %arraydecay23, double* noundef %arrayidx26, double* noundef %arraydecay27, double* noundef %arraydecay28), !dbg !1319
  %arraydecay29 = getelementptr inbounds [192 x double], [192 x double]* %delta_weights3, i64 0, i64 0, !dbg !1320
  %arraydecay30 = getelementptr inbounds [3 x double], [3 x double]* %output_difference, i64 0, i64 0, !dbg !1321
  %arraydecay31 = getelementptr inbounds [64 x double], [64 x double]* %activations2, i64 0, i64 0, !dbg !1322
  call void @get_delta_matrix_weights3(double* noundef %arraydecay29, double* noundef %arraydecay30, double* noundef %arraydecay31), !dbg !1323
  %17 = load double*, double** %weights3.addr, align 8, !dbg !1324
  %arraydecay32 = getelementptr inbounds [3 x double], [3 x double]* %output_difference, i64 0, i64 0, !dbg !1325
  %arraydecay33 = getelementptr inbounds [64 x double], [64 x double]* %oracle_activations2, i64 0, i64 0, !dbg !1326
  %arraydecay34 = getelementptr inbounds [64 x double], [64 x double]* %dactivations2, i64 0, i64 0, !dbg !1327
  call void @get_oracle_activations2(double* noundef %17, double* noundef %arraydecay32, double* noundef %arraydecay33, double* noundef %arraydecay34), !dbg !1328
  %arraydecay35 = getelementptr inbounds [4096 x double], [4096 x double]* %delta_weights2, i64 0, i64 0, !dbg !1329
  %arraydecay36 = getelementptr inbounds [64 x double], [64 x double]* %oracle_activations2, i64 0, i64 0, !dbg !1330
  %arraydecay37 = getelementptr inbounds [64 x double], [64 x double]* %activations1, i64 0, i64 0, !dbg !1331
  call void @get_delta_matrix_weights2(double* noundef %arraydecay35, double* noundef %arraydecay36, double* noundef %arraydecay37), !dbg !1332
  %18 = load double*, double** %weights2.addr, align 8, !dbg !1333
  %arraydecay38 = getelementptr inbounds [64 x double], [64 x double]* %oracle_activations2, i64 0, i64 0, !dbg !1334
  %arraydecay39 = getelementptr inbounds [64 x double], [64 x double]* %oracle_activations1, i64 0, i64 0, !dbg !1335
  %arraydecay40 = getelementptr inbounds [64 x double], [64 x double]* %dactivations1, i64 0, i64 0, !dbg !1336
  call void @get_oracle_activations1(double* noundef %18, double* noundef %arraydecay38, double* noundef %arraydecay39, double* noundef %arraydecay40), !dbg !1337
  %arraydecay41 = getelementptr inbounds [832 x double], [832 x double]* %delta_weights1, i64 0, i64 0, !dbg !1338
  %arraydecay42 = getelementptr inbounds [64 x double], [64 x double]* %oracle_activations1, i64 0, i64 0, !dbg !1339
  %19 = load double*, double** %training_data.addr, align 8, !dbg !1340
  %20 = load i32, i32* %i, align 4, !dbg !1341
  %mul43 = mul nsw i32 %20, 13, !dbg !1342
  %idxprom44 = sext i32 %mul43 to i64, !dbg !1340
  %arrayidx45 = getelementptr inbounds double, double* %19, i64 %idxprom44, !dbg !1340
  call void @get_delta_matrix_weights1(double* noundef %arraydecay41, double* noundef %arraydecay42, double* noundef %arrayidx45), !dbg !1343
  %21 = load double*, double** %weights1.addr, align 8, !dbg !1344
  %22 = load double*, double** %weights2.addr, align 8, !dbg !1345
  %23 = load double*, double** %weights3.addr, align 8, !dbg !1346
  %arraydecay46 = getelementptr inbounds [832 x double], [832 x double]* %delta_weights1, i64 0, i64 0, !dbg !1347
  %arraydecay47 = getelementptr inbounds [4096 x double], [4096 x double]* %delta_weights2, i64 0, i64 0, !dbg !1348
  %arraydecay48 = getelementptr inbounds [192 x double], [192 x double]* %delta_weights3, i64 0, i64 0, !dbg !1349
  %24 = load double*, double** %biases1.addr, align 8, !dbg !1350
  %25 = load double*, double** %biases2.addr, align 8, !dbg !1351
  %26 = load double*, double** %biases3.addr, align 8, !dbg !1352
  %arraydecay49 = getelementptr inbounds [64 x double], [64 x double]* %oracle_activations1, i64 0, i64 0, !dbg !1353
  %arraydecay50 = getelementptr inbounds [64 x double], [64 x double]* %oracle_activations2, i64 0, i64 0, !dbg !1354
  %arraydecay51 = getelementptr inbounds [3 x double], [3 x double]* %output_difference, i64 0, i64 0, !dbg !1355
  call void @update_weights(double* noundef %21, double* noundef %22, double* noundef %23, double* noundef %arraydecay46, double* noundef %arraydecay47, double* noundef %arraydecay48, double* noundef %24, double* noundef %25, double* noundef %26, double* noundef %arraydecay49, double* noundef %arraydecay50, double* noundef %arraydecay51), !dbg !1356
  br label %for.inc52, !dbg !1357

for.inc52:                                        ; preds = %for.end
  %27 = load i32, i32* %i, align 4, !dbg !1358
  %inc53 = add nsw i32 %27, 1, !dbg !1358
  store i32 %inc53, i32* %i, align 4, !dbg !1358
  br label %for.cond, !dbg !1359, !llvm.loop !1360

for.end54:                                        ; preds = %for.cond
  ret void, !dbg !1362
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!4, !5, !6, !7, !8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "data/benchmarks/real/backprop/backprop.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "c2748026788d4bb85b82f08fe078b792")
!2 = !{!3}
!3 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!4 = !{i32 7, !"Dwarf Version", i32 5}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 7, !"PIC Level", i32 2}
!8 = !{i32 7, !"PIE Level", i32 2}
!9 = !{i32 7, !"uwtable", i32 1}
!10 = !{i32 7, !"frame-pointer", i32 2}
!11 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!12 = distinct !DISubprogram(name: "soft_max", scope: !1, file: !1, line: 16, type: !13, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!13 = !DISubroutineType(types: !14)
!14 = !{null, !15, !15}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !3, size: 64)
!16 = !{}
!17 = !DILocalVariable(name: "net_outputs", arg: 1, scope: !12, file: !1, line: 16, type: !15)
!18 = !DILocation(line: 16, column: 20, scope: !12)
!19 = !DILocalVariable(name: "activations", arg: 2, scope: !12, file: !1, line: 16, type: !15)
!20 = !DILocation(line: 16, column: 56, scope: !12)
!21 = !DILocalVariable(name: "i", scope: !12, file: !1, line: 17, type: !22)
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DILocation(line: 17, column: 9, scope: !12)
!24 = !DILocalVariable(name: "sum", scope: !12, file: !1, line: 18, type: !3)
!25 = !DILocation(line: 18, column: 10, scope: !12)
!26 = !DILocation(line: 19, column: 9, scope: !12)
!27 = !DILocation(line: 19, column: 5, scope: !12)
!28 = !DILabel(scope: !12, name: "soft_max_loop1", file: !1, line: 21)
!29 = !DILocation(line: 21, column: 5, scope: !12)
!30 = !DILocation(line: 22, column: 10, scope: !31)
!31 = distinct !DILexicalBlock(scope: !12, file: !1, line: 22, column: 5)
!32 = !DILocation(line: 22, column: 9, scope: !31)
!33 = !DILocation(line: 22, column: 14, scope: !34)
!34 = distinct !DILexicalBlock(scope: !31, file: !1, line: 22, column: 5)
!35 = !DILocation(line: 22, column: 16, scope: !34)
!36 = !DILocation(line: 22, column: 5, scope: !31)
!37 = !DILocation(line: 24, column: 21, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !1, line: 22, column: 41)
!39 = !DILocation(line: 24, column: 33, scope: !38)
!40 = !DILocation(line: 24, column: 20, scope: !38)
!41 = !DILocation(line: 24, column: 16, scope: !38)
!42 = !DILocation(line: 24, column: 13, scope: !38)
!43 = !DILocation(line: 25, column: 5, scope: !38)
!44 = !DILocation(line: 22, column: 37, scope: !34)
!45 = !DILocation(line: 22, column: 5, scope: !34)
!46 = distinct !{!46, !36, !47, !48}
!47 = !DILocation(line: 25, column: 5, scope: !31)
!48 = !{!"llvm.loop.mustprogress"}
!49 = !DILabel(scope: !12, name: "soft_max_loop2", file: !1, line: 26)
!50 = !DILocation(line: 26, column: 5, scope: !12)
!51 = !DILocation(line: 27, column: 10, scope: !52)
!52 = distinct !DILexicalBlock(scope: !12, file: !1, line: 27, column: 5)
!53 = !DILocation(line: 27, column: 9, scope: !52)
!54 = !DILocation(line: 27, column: 14, scope: !55)
!55 = distinct !DILexicalBlock(scope: !52, file: !1, line: 27, column: 5)
!56 = !DILocation(line: 27, column: 16, scope: !55)
!57 = !DILocation(line: 27, column: 5, scope: !52)
!58 = !DILocation(line: 29, column: 31, scope: !59)
!59 = distinct !DILexicalBlock(scope: !55, file: !1, line: 27, column: 41)
!60 = !DILocation(line: 29, column: 43, scope: !59)
!61 = !DILocation(line: 29, column: 30, scope: !59)
!62 = !DILocation(line: 29, column: 26, scope: !59)
!63 = !DILocation(line: 29, column: 47, scope: !59)
!64 = !DILocation(line: 29, column: 46, scope: !59)
!65 = !DILocation(line: 29, column: 9, scope: !59)
!66 = !DILocation(line: 29, column: 21, scope: !59)
!67 = !DILocation(line: 29, column: 24, scope: !59)
!68 = !DILocation(line: 30, column: 5, scope: !59)
!69 = !DILocation(line: 27, column: 37, scope: !55)
!70 = !DILocation(line: 27, column: 5, scope: !55)
!71 = distinct !{!71, !57, !72, !48}
!72 = !DILocation(line: 30, column: 5, scope: !52)
!73 = !DILocation(line: 31, column: 1, scope: !12)
!74 = distinct !DISubprogram(name: "RELU", scope: !1, file: !1, line: 33, type: !75, scopeLine: 33, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!75 = !DISubroutineType(types: !76)
!76 = !{null, !15, !15, !22}
!77 = !DILocalVariable(name: "activations", arg: 1, scope: !74, file: !1, line: 33, type: !15)
!78 = !DILocation(line: 33, column: 16, scope: !74)
!79 = !DILocalVariable(name: "dactivations", arg: 2, scope: !74, file: !1, line: 33, type: !15)
!80 = !DILocation(line: 33, column: 51, scope: !74)
!81 = !DILocalVariable(name: "size", arg: 3, scope: !74, file: !1, line: 33, type: !22)
!82 = !DILocation(line: 33, column: 86, scope: !74)
!83 = !DILocalVariable(name: "i", scope: !74, file: !1, line: 34, type: !22)
!84 = !DILocation(line: 34, column: 9, scope: !74)
!85 = !DILocation(line: 34, column: 5, scope: !74)
!86 = !DILabel(scope: !74, name: "RELU_loop1", file: !1, line: 35)
!87 = !DILocation(line: 35, column: 5, scope: !74)
!88 = !DILocation(line: 36, column: 12, scope: !89)
!89 = distinct !DILexicalBlock(scope: !74, file: !1, line: 36, column: 5)
!90 = !DILocation(line: 36, column: 10, scope: !89)
!91 = !DILocation(line: 36, column: 17, scope: !92)
!92 = distinct !DILexicalBlock(scope: !89, file: !1, line: 36, column: 5)
!93 = !DILocation(line: 36, column: 21, scope: !92)
!94 = !DILocation(line: 36, column: 19, scope: !92)
!95 = !DILocation(line: 36, column: 5, scope: !89)
!96 = !DILocation(line: 38, column: 27, scope: !97)
!97 = distinct !DILexicalBlock(scope: !92, file: !1, line: 36, column: 32)
!98 = !DILocation(line: 38, column: 39, scope: !97)
!99 = !DILocation(line: 38, column: 47, scope: !97)
!100 = !DILocation(line: 38, column: 59, scope: !97)
!101 = !DILocation(line: 38, column: 46, scope: !97)
!102 = !DILocation(line: 38, column: 41, scope: !97)
!103 = !DILocation(line: 38, column: 9, scope: !97)
!104 = !DILocation(line: 38, column: 22, scope: !97)
!105 = !DILocation(line: 38, column: 25, scope: !97)
!106 = !DILocation(line: 39, column: 40, scope: !97)
!107 = !DILocation(line: 39, column: 52, scope: !97)
!108 = !DILocation(line: 39, column: 39, scope: !97)
!109 = !DILocation(line: 39, column: 35, scope: !97)
!110 = !DILocation(line: 39, column: 34, scope: !97)
!111 = !DILocation(line: 39, column: 29, scope: !97)
!112 = !DILocation(line: 39, column: 9, scope: !97)
!113 = !DILocation(line: 39, column: 21, scope: !97)
!114 = !DILocation(line: 39, column: 24, scope: !97)
!115 = !DILocation(line: 40, column: 5, scope: !97)
!116 = !DILocation(line: 36, column: 28, scope: !92)
!117 = !DILocation(line: 36, column: 5, scope: !92)
!118 = distinct !{!118, !95, !119, !48}
!119 = !DILocation(line: 40, column: 5, scope: !89)
!120 = !DILocation(line: 41, column: 1, scope: !74)
!121 = distinct !DISubprogram(name: "add_bias_to_activations", scope: !1, file: !1, line: 43, type: !75, scopeLine: 45, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!122 = !DILocalVariable(name: "biases", arg: 1, scope: !121, file: !1, line: 43, type: !15)
!123 = !DILocation(line: 43, column: 35, scope: !121)
!124 = !DILocalVariable(name: "activations", arg: 2, scope: !121, file: !1, line: 44, type: !15)
!125 = !DILocation(line: 44, column: 35, scope: !121)
!126 = !DILocalVariable(name: "size", arg: 3, scope: !121, file: !1, line: 45, type: !22)
!127 = !DILocation(line: 45, column: 34, scope: !121)
!128 = !DILocalVariable(name: "i", scope: !121, file: !1, line: 46, type: !22)
!129 = !DILocation(line: 46, column: 9, scope: !121)
!130 = !DILocation(line: 46, column: 5, scope: !121)
!131 = !DILabel(scope: !121, name: "add_bias_to_activations_loop1", file: !1, line: 47)
!132 = !DILocation(line: 47, column: 5, scope: !121)
!133 = !DILocation(line: 48, column: 12, scope: !134)
!134 = distinct !DILexicalBlock(scope: !121, file: !1, line: 48, column: 5)
!135 = !DILocation(line: 48, column: 10, scope: !134)
!136 = !DILocation(line: 48, column: 17, scope: !137)
!137 = distinct !DILexicalBlock(scope: !134, file: !1, line: 48, column: 5)
!138 = !DILocation(line: 48, column: 21, scope: !137)
!139 = !DILocation(line: 48, column: 19, scope: !137)
!140 = !DILocation(line: 48, column: 5, scope: !134)
!141 = !DILocation(line: 50, column: 26, scope: !142)
!142 = distinct !DILexicalBlock(scope: !137, file: !1, line: 48, column: 31)
!143 = !DILocation(line: 50, column: 38, scope: !142)
!144 = !DILocation(line: 50, column: 43, scope: !142)
!145 = !DILocation(line: 50, column: 50, scope: !142)
!146 = !DILocation(line: 50, column: 41, scope: !142)
!147 = !DILocation(line: 50, column: 9, scope: !142)
!148 = !DILocation(line: 50, column: 21, scope: !142)
!149 = !DILocation(line: 50, column: 24, scope: !142)
!150 = !DILocation(line: 51, column: 5, scope: !142)
!151 = !DILocation(line: 48, column: 28, scope: !137)
!152 = !DILocation(line: 48, column: 5, scope: !137)
!153 = distinct !{!153, !140, !154, !48}
!154 = !DILocation(line: 51, column: 5, scope: !134)
!155 = !DILocation(line: 52, column: 1, scope: !121)
!156 = distinct !DISubprogram(name: "matrix_vector_product_with_bias_input_layer", scope: !1, file: !1, line: 54, type: !157, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!157 = !DISubroutineType(types: !158)
!158 = !{null, !15, !15, !15, !15}
!159 = !DILocalVariable(name: "biases", arg: 1, scope: !156, file: !1, line: 54, type: !15)
!160 = !DILocation(line: 54, column: 55, scope: !156)
!161 = !DILocalVariable(name: "weights", arg: 2, scope: !156, file: !1, line: 55, type: !15)
!162 = !DILocation(line: 55, column: 55, scope: !156)
!163 = !DILocalVariable(name: "activations", arg: 3, scope: !156, file: !1, line: 56, type: !15)
!164 = !DILocation(line: 56, column: 55, scope: !156)
!165 = !DILocalVariable(name: "input_sample", arg: 4, scope: !156, file: !1, line: 57, type: !15)
!166 = !DILocation(line: 57, column: 55, scope: !156)
!167 = !DILocalVariable(name: "i", scope: !156, file: !1, line: 58, type: !22)
!168 = !DILocation(line: 58, column: 9, scope: !156)
!169 = !DILocalVariable(name: "j", scope: !156, file: !1, line: 58, type: !22)
!170 = !DILocation(line: 58, column: 11, scope: !156)
!171 = !DILocation(line: 58, column: 5, scope: !156)
!172 = !DILabel(scope: !156, name: "matrix_vector_product_with_bias_input_layer_loop1", file: !1, line: 59)
!173 = !DILocation(line: 59, column: 5, scope: !156)
!174 = !DILocation(line: 60, column: 11, scope: !175)
!175 = distinct !DILexicalBlock(scope: !156, file: !1, line: 60, column: 5)
!176 = !DILocation(line: 60, column: 9, scope: !175)
!177 = !DILocation(line: 60, column: 16, scope: !178)
!178 = distinct !DILexicalBlock(scope: !175, file: !1, line: 60, column: 5)
!179 = !DILocation(line: 60, column: 18, scope: !178)
!180 = !DILocation(line: 60, column: 5, scope: !175)
!181 = !DILocation(line: 62, column: 9, scope: !182)
!182 = distinct !DILexicalBlock(scope: !178, file: !1, line: 60, column: 41)
!183 = !DILocation(line: 62, column: 21, scope: !182)
!184 = !DILocation(line: 62, column: 24, scope: !182)
!185 = !DILabel(scope: !182, name: "matrix_vector_product_with_bias_input_layer_loop1_1", file: !1, line: 63)
!186 = !DILocation(line: 63, column: 9, scope: !182)
!187 = !DILocation(line: 64, column: 16, scope: !188)
!188 = distinct !DILexicalBlock(scope: !182, file: !1, line: 64, column: 9)
!189 = !DILocation(line: 64, column: 14, scope: !188)
!190 = !DILocation(line: 64, column: 21, scope: !191)
!191 = distinct !DILexicalBlock(scope: !188, file: !1, line: 64, column: 9)
!192 = !DILocation(line: 64, column: 23, scope: !191)
!193 = !DILocation(line: 64, column: 9, scope: !188)
!194 = !DILocation(line: 66, column: 31, scope: !195)
!195 = distinct !DILexicalBlock(scope: !191, file: !1, line: 64, column: 46)
!196 = !DILocation(line: 66, column: 39, scope: !195)
!197 = !DILocation(line: 66, column: 40, scope: !195)
!198 = !DILocation(line: 66, column: 59, scope: !195)
!199 = !DILocation(line: 66, column: 57, scope: !195)
!200 = !DILocation(line: 66, column: 64, scope: !195)
!201 = !DILocation(line: 66, column: 77, scope: !195)
!202 = !DILocation(line: 66, column: 13, scope: !195)
!203 = !DILocation(line: 66, column: 25, scope: !195)
!204 = !DILocation(line: 66, column: 28, scope: !195)
!205 = !DILocation(line: 67, column: 9, scope: !195)
!206 = !DILocation(line: 64, column: 43, scope: !191)
!207 = !DILocation(line: 64, column: 9, scope: !191)
!208 = distinct !{!208, !193, !209, !48}
!209 = !DILocation(line: 67, column: 9, scope: !188)
!210 = !DILocation(line: 68, column: 5, scope: !182)
!211 = !DILocation(line: 60, column: 38, scope: !178)
!212 = !DILocation(line: 60, column: 5, scope: !178)
!213 = distinct !{!213, !180, !214, !48}
!214 = !DILocation(line: 68, column: 5, scope: !175)
!215 = !DILocation(line: 69, column: 29, scope: !156)
!216 = !DILocation(line: 69, column: 37, scope: !156)
!217 = !DILocation(line: 69, column: 5, scope: !156)
!218 = !DILocation(line: 70, column: 1, scope: !156)
!219 = distinct !DISubprogram(name: "matrix_vector_product_with_bias_second_layer", scope: !1, file: !1, line: 72, type: !157, scopeLine: 75, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!220 = !DILocalVariable(name: "biases", arg: 1, scope: !219, file: !1, line: 72, type: !15)
!221 = !DILocation(line: 72, column: 56, scope: !219)
!222 = !DILocalVariable(name: "weights", arg: 2, scope: !219, file: !1, line: 73, type: !15)
!223 = !DILocation(line: 73, column: 56, scope: !219)
!224 = !DILocalVariable(name: "activations", arg: 3, scope: !219, file: !1, line: 74, type: !15)
!225 = !DILocation(line: 74, column: 56, scope: !219)
!226 = !DILocalVariable(name: "input_activations", arg: 4, scope: !219, file: !1, line: 75, type: !15)
!227 = !DILocation(line: 75, column: 56, scope: !219)
!228 = !DILocalVariable(name: "i", scope: !219, file: !1, line: 76, type: !22)
!229 = !DILocation(line: 76, column: 9, scope: !219)
!230 = !DILocalVariable(name: "j", scope: !219, file: !1, line: 76, type: !22)
!231 = !DILocation(line: 76, column: 11, scope: !219)
!232 = !DILocation(line: 76, column: 5, scope: !219)
!233 = !DILabel(scope: !219, name: "matrix_vector_product_with_bias_second_layer_loop1", file: !1, line: 77)
!234 = !DILocation(line: 77, column: 5, scope: !219)
!235 = !DILocation(line: 78, column: 12, scope: !236)
!236 = distinct !DILexicalBlock(scope: !219, file: !1, line: 78, column: 5)
!237 = !DILocation(line: 78, column: 10, scope: !236)
!238 = !DILocation(line: 78, column: 17, scope: !239)
!239 = distinct !DILexicalBlock(scope: !236, file: !1, line: 78, column: 5)
!240 = !DILocation(line: 78, column: 19, scope: !239)
!241 = !DILocation(line: 78, column: 5, scope: !236)
!242 = !DILocation(line: 80, column: 9, scope: !243)
!243 = distinct !DILexicalBlock(scope: !239, file: !1, line: 78, column: 42)
!244 = !DILocation(line: 80, column: 21, scope: !243)
!245 = !DILocation(line: 80, column: 24, scope: !243)
!246 = !DILabel(scope: !243, name: "matrix_vector_product_with_bias_second_layer_loop1_1", file: !1, line: 81)
!247 = !DILocation(line: 81, column: 9, scope: !243)
!248 = !DILocation(line: 82, column: 15, scope: !249)
!249 = distinct !DILexicalBlock(scope: !243, file: !1, line: 82, column: 9)
!250 = !DILocation(line: 82, column: 13, scope: !249)
!251 = !DILocation(line: 82, column: 20, scope: !252)
!252 = distinct !DILexicalBlock(scope: !249, file: !1, line: 82, column: 9)
!253 = !DILocation(line: 82, column: 22, scope: !252)
!254 = !DILocation(line: 82, column: 9, scope: !249)
!255 = !DILocation(line: 84, column: 31, scope: !256)
!256 = distinct !DILexicalBlock(scope: !252, file: !1, line: 82, column: 45)
!257 = !DILocation(line: 84, column: 39, scope: !256)
!258 = !DILocation(line: 84, column: 40, scope: !256)
!259 = !DILocation(line: 84, column: 59, scope: !256)
!260 = !DILocation(line: 84, column: 57, scope: !256)
!261 = !DILocation(line: 84, column: 64, scope: !256)
!262 = !DILocation(line: 84, column: 82, scope: !256)
!263 = !DILocation(line: 84, column: 13, scope: !256)
!264 = !DILocation(line: 84, column: 25, scope: !256)
!265 = !DILocation(line: 84, column: 28, scope: !256)
!266 = !DILocation(line: 85, column: 9, scope: !256)
!267 = !DILocation(line: 82, column: 42, scope: !252)
!268 = !DILocation(line: 82, column: 9, scope: !252)
!269 = distinct !{!269, !254, !270, !48}
!270 = !DILocation(line: 85, column: 9, scope: !249)
!271 = !DILocation(line: 86, column: 5, scope: !243)
!272 = !DILocation(line: 78, column: 39, scope: !239)
!273 = !DILocation(line: 78, column: 5, scope: !239)
!274 = distinct !{!274, !241, !275, !48}
!275 = !DILocation(line: 86, column: 5, scope: !236)
!276 = !DILocation(line: 87, column: 29, scope: !219)
!277 = !DILocation(line: 87, column: 37, scope: !219)
!278 = !DILocation(line: 87, column: 5, scope: !219)
!279 = !DILocation(line: 88, column: 1, scope: !219)
!280 = distinct !DISubprogram(name: "matrix_vector_product_with_bias_output_layer", scope: !1, file: !1, line: 90, type: !157, scopeLine: 93, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!281 = !DILocalVariable(name: "biases", arg: 1, scope: !280, file: !1, line: 90, type: !15)
!282 = !DILocation(line: 90, column: 56, scope: !280)
!283 = !DILocalVariable(name: "weights", arg: 2, scope: !280, file: !1, line: 91, type: !15)
!284 = !DILocation(line: 91, column: 56, scope: !280)
!285 = !DILocalVariable(name: "activations", arg: 3, scope: !280, file: !1, line: 92, type: !15)
!286 = !DILocation(line: 92, column: 56, scope: !280)
!287 = !DILocalVariable(name: "input_activations", arg: 4, scope: !280, file: !1, line: 93, type: !15)
!288 = !DILocation(line: 93, column: 56, scope: !280)
!289 = !DILocalVariable(name: "i", scope: !280, file: !1, line: 94, type: !22)
!290 = !DILocation(line: 94, column: 9, scope: !280)
!291 = !DILocalVariable(name: "j", scope: !280, file: !1, line: 94, type: !22)
!292 = !DILocation(line: 94, column: 12, scope: !280)
!293 = !DILocation(line: 94, column: 5, scope: !280)
!294 = !DILabel(scope: !280, name: "matrix_vector_product_with_bias_output_layer_loop1", file: !1, line: 95)
!295 = !DILocation(line: 95, column: 5, scope: !280)
!296 = !DILocation(line: 96, column: 11, scope: !297)
!297 = distinct !DILexicalBlock(scope: !280, file: !1, line: 96, column: 5)
!298 = !DILocation(line: 96, column: 9, scope: !297)
!299 = !DILocation(line: 96, column: 16, scope: !300)
!300 = distinct !DILexicalBlock(scope: !297, file: !1, line: 96, column: 5)
!301 = !DILocation(line: 96, column: 18, scope: !300)
!302 = !DILocation(line: 96, column: 5, scope: !297)
!303 = !DILocation(line: 98, column: 9, scope: !304)
!304 = distinct !DILexicalBlock(scope: !300, file: !1, line: 96, column: 42)
!305 = !DILocation(line: 98, column: 21, scope: !304)
!306 = !DILocation(line: 98, column: 24, scope: !304)
!307 = !DILabel(scope: !304, name: "matrix_vector_product_with_bias_output_layer_loop1_1", file: !1, line: 99)
!308 = !DILocation(line: 99, column: 9, scope: !304)
!309 = !DILocation(line: 100, column: 16, scope: !310)
!310 = distinct !DILexicalBlock(scope: !304, file: !1, line: 100, column: 9)
!311 = !DILocation(line: 100, column: 14, scope: !310)
!312 = !DILocation(line: 100, column: 21, scope: !313)
!313 = distinct !DILexicalBlock(scope: !310, file: !1, line: 100, column: 9)
!314 = !DILocation(line: 100, column: 23, scope: !313)
!315 = !DILocation(line: 100, column: 9, scope: !310)
!316 = !DILocation(line: 102, column: 31, scope: !317)
!317 = distinct !DILexicalBlock(scope: !313, file: !1, line: 100, column: 46)
!318 = !DILocation(line: 102, column: 39, scope: !317)
!319 = !DILocation(line: 102, column: 40, scope: !317)
!320 = !DILocation(line: 102, column: 59, scope: !317)
!321 = !DILocation(line: 102, column: 57, scope: !317)
!322 = !DILocation(line: 102, column: 64, scope: !317)
!323 = !DILocation(line: 102, column: 82, scope: !317)
!324 = !DILocation(line: 102, column: 13, scope: !317)
!325 = !DILocation(line: 102, column: 25, scope: !317)
!326 = !DILocation(line: 102, column: 28, scope: !317)
!327 = !DILocation(line: 103, column: 9, scope: !317)
!328 = !DILocation(line: 100, column: 43, scope: !313)
!329 = !DILocation(line: 100, column: 9, scope: !313)
!330 = distinct !{!330, !315, !331, !48}
!331 = !DILocation(line: 103, column: 9, scope: !310)
!332 = !DILocation(line: 104, column: 5, scope: !304)
!333 = !DILocation(line: 96, column: 39, scope: !300)
!334 = !DILocation(line: 96, column: 5, scope: !300)
!335 = distinct !{!335, !302, !336, !48}
!336 = !DILocation(line: 104, column: 5, scope: !297)
!337 = !DILocation(line: 105, column: 29, scope: !280)
!338 = !DILocation(line: 105, column: 37, scope: !280)
!339 = !DILocation(line: 105, column: 5, scope: !280)
!340 = !DILocation(line: 106, column: 1, scope: !280)
!341 = distinct !DISubprogram(name: "take_difference", scope: !1, file: !1, line: 108, type: !157, scopeLine: 111, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!342 = !DILocalVariable(name: "net_outputs", arg: 1, scope: !341, file: !1, line: 108, type: !15)
!343 = !DILocation(line: 108, column: 27, scope: !341)
!344 = !DILocalVariable(name: "solutions", arg: 2, scope: !341, file: !1, line: 109, type: !15)
!345 = !DILocation(line: 109, column: 27, scope: !341)
!346 = !DILocalVariable(name: "output_difference", arg: 3, scope: !341, file: !1, line: 110, type: !15)
!347 = !DILocation(line: 110, column: 27, scope: !341)
!348 = !DILocalVariable(name: "dactivations", arg: 4, scope: !341, file: !1, line: 111, type: !15)
!349 = !DILocation(line: 111, column: 27, scope: !341)
!350 = !DILocalVariable(name: "i", scope: !341, file: !1, line: 112, type: !22)
!351 = !DILocation(line: 112, column: 9, scope: !341)
!352 = !DILocation(line: 112, column: 5, scope: !341)
!353 = !DILabel(scope: !341, name: "take_difference_loop1", file: !1, line: 113)
!354 = !DILocation(line: 113, column: 5, scope: !341)
!355 = !DILocation(line: 114, column: 12, scope: !356)
!356 = distinct !DILexicalBlock(scope: !341, file: !1, line: 114, column: 5)
!357 = !DILocation(line: 114, column: 10, scope: !356)
!358 = !DILocation(line: 114, column: 17, scope: !359)
!359 = distinct !DILexicalBlock(scope: !356, file: !1, line: 114, column: 5)
!360 = !DILocation(line: 114, column: 19, scope: !359)
!361 = !DILocation(line: 114, column: 5, scope: !356)
!362 = !DILocation(line: 116, column: 35, scope: !363)
!363 = distinct !DILexicalBlock(scope: !359, file: !1, line: 114, column: 43)
!364 = !DILocation(line: 116, column: 47, scope: !363)
!365 = !DILocation(line: 116, column: 53, scope: !363)
!366 = !DILocation(line: 116, column: 63, scope: !363)
!367 = !DILocation(line: 116, column: 51, scope: !363)
!368 = !DILocation(line: 116, column: 67, scope: !363)
!369 = !DILocation(line: 116, column: 77, scope: !363)
!370 = !DILocation(line: 116, column: 90, scope: !363)
!371 = !DILocation(line: 116, column: 75, scope: !363)
!372 = !DILocation(line: 116, column: 9, scope: !363)
!373 = !DILocation(line: 116, column: 27, scope: !363)
!374 = !DILocation(line: 116, column: 30, scope: !363)
!375 = !DILocation(line: 117, column: 5, scope: !363)
!376 = !DILocation(line: 114, column: 40, scope: !359)
!377 = !DILocation(line: 114, column: 5, scope: !359)
!378 = distinct !{!378, !361, !379, !48}
!379 = !DILocation(line: 117, column: 5, scope: !356)
!380 = !DILocation(line: 118, column: 1, scope: !341)
!381 = distinct !DISubprogram(name: "get_delta_matrix_weights3", scope: !1, file: !1, line: 120, type: !382, scopeLine: 122, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!382 = !DISubroutineType(types: !383)
!383 = !{null, !15, !15, !15}
!384 = !DILocalVariable(name: "delta_weights3", arg: 1, scope: !381, file: !1, line: 120, type: !15)
!385 = !DILocation(line: 120, column: 37, scope: !381)
!386 = !DILocalVariable(name: "output_difference", arg: 2, scope: !381, file: !1, line: 121, type: !15)
!387 = !DILocation(line: 121, column: 37, scope: !381)
!388 = !DILocalVariable(name: "last_activations", arg: 3, scope: !381, file: !1, line: 122, type: !15)
!389 = !DILocation(line: 122, column: 37, scope: !381)
!390 = !DILocalVariable(name: "i", scope: !381, file: !1, line: 123, type: !22)
!391 = !DILocation(line: 123, column: 9, scope: !381)
!392 = !DILocalVariable(name: "j", scope: !381, file: !1, line: 123, type: !22)
!393 = !DILocation(line: 123, column: 12, scope: !381)
!394 = !DILocation(line: 123, column: 5, scope: !381)
!395 = !DILabel(scope: !381, name: "get_delta_matrix_weights3_loop1", file: !1, line: 124)
!396 = !DILocation(line: 124, column: 5, scope: !381)
!397 = !DILocation(line: 125, column: 12, scope: !398)
!398 = distinct !DILexicalBlock(scope: !381, file: !1, line: 125, column: 5)
!399 = !DILocation(line: 125, column: 10, scope: !398)
!400 = !DILocation(line: 125, column: 17, scope: !401)
!401 = distinct !DILexicalBlock(scope: !398, file: !1, line: 125, column: 5)
!402 = !DILocation(line: 125, column: 19, scope: !401)
!403 = !DILocation(line: 125, column: 5, scope: !398)
!404 = !DILocation(line: 125, column: 43, scope: !401)
!405 = !DILabel(scope: !406, name: "get_delta_matrix_weights3_loop1_1", file: !1, line: 127)
!406 = distinct !DILexicalBlock(scope: !401, file: !1, line: 125, column: 43)
!407 = !DILocation(line: 127, column: 9, scope: !406)
!408 = !DILocation(line: 128, column: 16, scope: !409)
!409 = distinct !DILexicalBlock(scope: !406, file: !1, line: 128, column: 9)
!410 = !DILocation(line: 128, column: 14, scope: !409)
!411 = !DILocation(line: 128, column: 21, scope: !412)
!412 = distinct !DILexicalBlock(scope: !409, file: !1, line: 128, column: 9)
!413 = !DILocation(line: 128, column: 23, scope: !412)
!414 = !DILocation(line: 128, column: 9, scope: !409)
!415 = !DILocation(line: 130, column: 54, scope: !416)
!416 = distinct !DILexicalBlock(scope: !412, file: !1, line: 128, column: 48)
!417 = !DILocation(line: 130, column: 71, scope: !416)
!418 = !DILocation(line: 130, column: 76, scope: !416)
!419 = !DILocation(line: 130, column: 94, scope: !416)
!420 = !DILocation(line: 130, column: 74, scope: !416)
!421 = !DILocation(line: 130, column: 13, scope: !416)
!422 = !DILocation(line: 130, column: 28, scope: !416)
!423 = !DILocation(line: 130, column: 29, scope: !416)
!424 = !DILocation(line: 130, column: 49, scope: !416)
!425 = !DILocation(line: 130, column: 47, scope: !416)
!426 = !DILocation(line: 130, column: 52, scope: !416)
!427 = !DILocation(line: 131, column: 9, scope: !416)
!428 = !DILocation(line: 128, column: 44, scope: !412)
!429 = !DILocation(line: 128, column: 9, scope: !412)
!430 = distinct !{!430, !414, !431, !48}
!431 = !DILocation(line: 131, column: 9, scope: !409)
!432 = !DILocation(line: 132, column: 5, scope: !406)
!433 = !DILocation(line: 125, column: 39, scope: !401)
!434 = !DILocation(line: 125, column: 5, scope: !401)
!435 = distinct !{!435, !403, !436, !48}
!436 = !DILocation(line: 132, column: 5, scope: !398)
!437 = !DILocation(line: 133, column: 1, scope: !381)
!438 = distinct !DISubprogram(name: "get_oracle_activations2", scope: !1, file: !1, line: 135, type: !157, scopeLine: 138, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!439 = !DILocalVariable(name: "weights3", arg: 1, scope: !438, file: !1, line: 135, type: !15)
!440 = !DILocation(line: 135, column: 35, scope: !438)
!441 = !DILocalVariable(name: "output_differences", arg: 2, scope: !438, file: !1, line: 136, type: !15)
!442 = !DILocation(line: 136, column: 35, scope: !438)
!443 = !DILocalVariable(name: "oracle_activations", arg: 3, scope: !438, file: !1, line: 137, type: !15)
!444 = !DILocation(line: 137, column: 35, scope: !438)
!445 = !DILocalVariable(name: "dactivations", arg: 4, scope: !438, file: !1, line: 138, type: !15)
!446 = !DILocation(line: 138, column: 35, scope: !438)
!447 = !DILocalVariable(name: "i", scope: !438, file: !1, line: 139, type: !22)
!448 = !DILocation(line: 139, column: 9, scope: !438)
!449 = !DILocalVariable(name: "j", scope: !438, file: !1, line: 139, type: !22)
!450 = !DILocation(line: 139, column: 12, scope: !438)
!451 = !DILocation(line: 139, column: 5, scope: !438)
!452 = !DILabel(scope: !438, name: "get_oracle_activations2_loop1", file: !1, line: 140)
!453 = !DILocation(line: 140, column: 5, scope: !438)
!454 = !DILocation(line: 141, column: 12, scope: !455)
!455 = distinct !DILexicalBlock(scope: !438, file: !1, line: 141, column: 5)
!456 = !DILocation(line: 141, column: 10, scope: !455)
!457 = !DILocation(line: 141, column: 17, scope: !458)
!458 = distinct !DILexicalBlock(scope: !455, file: !1, line: 141, column: 5)
!459 = !DILocation(line: 141, column: 19, scope: !458)
!460 = !DILocation(line: 141, column: 5, scope: !455)
!461 = !DILocation(line: 143, column: 9, scope: !462)
!462 = distinct !DILexicalBlock(scope: !458, file: !1, line: 141, column: 43)
!463 = !DILocation(line: 143, column: 28, scope: !462)
!464 = !DILocation(line: 143, column: 31, scope: !462)
!465 = !DILabel(scope: !462, name: "get_oracle_activations2_loop1_1", file: !1, line: 144)
!466 = !DILocation(line: 144, column: 9, scope: !462)
!467 = !DILocation(line: 145, column: 16, scope: !468)
!468 = distinct !DILexicalBlock(scope: !462, file: !1, line: 145, column: 9)
!469 = !DILocation(line: 145, column: 14, scope: !468)
!470 = !DILocation(line: 145, column: 21, scope: !471)
!471 = distinct !DILexicalBlock(scope: !468, file: !1, line: 145, column: 9)
!472 = !DILocation(line: 145, column: 23, scope: !471)
!473 = !DILocation(line: 145, column: 9, scope: !468)
!474 = !DILocation(line: 147, column: 38, scope: !475)
!475 = distinct !DILexicalBlock(scope: !471, file: !1, line: 145, column: 48)
!476 = !DILocation(line: 147, column: 57, scope: !475)
!477 = !DILocation(line: 147, column: 62, scope: !475)
!478 = !DILocation(line: 147, column: 71, scope: !475)
!479 = !DILocation(line: 147, column: 72, scope: !475)
!480 = !DILocation(line: 147, column: 92, scope: !475)
!481 = !DILocation(line: 147, column: 90, scope: !475)
!482 = !DILocation(line: 147, column: 13, scope: !475)
!483 = !DILocation(line: 147, column: 32, scope: !475)
!484 = !DILocation(line: 147, column: 35, scope: !475)
!485 = !DILocation(line: 148, column: 9, scope: !475)
!486 = !DILocation(line: 145, column: 44, scope: !471)
!487 = !DILocation(line: 145, column: 9, scope: !471)
!488 = distinct !{!488, !473, !489, !48}
!489 = !DILocation(line: 148, column: 9, scope: !468)
!490 = !DILocation(line: 149, column: 33, scope: !462)
!491 = !DILocation(line: 149, column: 52, scope: !462)
!492 = !DILocation(line: 149, column: 57, scope: !462)
!493 = !DILocation(line: 149, column: 70, scope: !462)
!494 = !DILocation(line: 149, column: 55, scope: !462)
!495 = !DILocation(line: 149, column: 9, scope: !462)
!496 = !DILocation(line: 149, column: 28, scope: !462)
!497 = !DILocation(line: 149, column: 31, scope: !462)
!498 = !DILocation(line: 150, column: 5, scope: !462)
!499 = !DILocation(line: 141, column: 39, scope: !458)
!500 = !DILocation(line: 141, column: 5, scope: !458)
!501 = distinct !{!501, !460, !502, !48}
!502 = !DILocation(line: 150, column: 5, scope: !455)
!503 = !DILocation(line: 151, column: 1, scope: !438)
!504 = distinct !DISubprogram(name: "get_delta_matrix_weights2", scope: !1, file: !1, line: 153, type: !382, scopeLine: 155, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!505 = !DILocalVariable(name: "delta_weights2", arg: 1, scope: !504, file: !1, line: 153, type: !15)
!506 = !DILocation(line: 153, column: 37, scope: !504)
!507 = !DILocalVariable(name: "output_difference", arg: 2, scope: !504, file: !1, line: 154, type: !15)
!508 = !DILocation(line: 154, column: 37, scope: !504)
!509 = !DILocalVariable(name: "last_activations", arg: 3, scope: !504, file: !1, line: 155, type: !15)
!510 = !DILocation(line: 155, column: 37, scope: !504)
!511 = !DILocalVariable(name: "i", scope: !504, file: !1, line: 156, type: !22)
!512 = !DILocation(line: 156, column: 9, scope: !504)
!513 = !DILocalVariable(name: "j", scope: !504, file: !1, line: 156, type: !22)
!514 = !DILocation(line: 156, column: 12, scope: !504)
!515 = !DILocation(line: 156, column: 5, scope: !504)
!516 = !DILabel(scope: !504, name: "get_delta_matrix_weights2_loop1", file: !1, line: 157)
!517 = !DILocation(line: 157, column: 5, scope: !504)
!518 = !DILocation(line: 158, column: 12, scope: !519)
!519 = distinct !DILexicalBlock(scope: !504, file: !1, line: 158, column: 5)
!520 = !DILocation(line: 158, column: 10, scope: !519)
!521 = !DILocation(line: 158, column: 17, scope: !522)
!522 = distinct !DILexicalBlock(scope: !519, file: !1, line: 158, column: 5)
!523 = !DILocation(line: 158, column: 19, scope: !522)
!524 = !DILocation(line: 158, column: 5, scope: !519)
!525 = !DILocation(line: 158, column: 43, scope: !522)
!526 = !DILabel(scope: !527, name: "get_delta_matrix_weights2_loop1_1", file: !1, line: 160)
!527 = distinct !DILexicalBlock(scope: !522, file: !1, line: 158, column: 43)
!528 = !DILocation(line: 160, column: 9, scope: !527)
!529 = !DILocation(line: 161, column: 16, scope: !530)
!530 = distinct !DILexicalBlock(scope: !527, file: !1, line: 161, column: 9)
!531 = !DILocation(line: 161, column: 14, scope: !530)
!532 = !DILocation(line: 161, column: 21, scope: !533)
!533 = distinct !DILexicalBlock(scope: !530, file: !1, line: 161, column: 9)
!534 = !DILocation(line: 161, column: 23, scope: !533)
!535 = !DILocation(line: 161, column: 9, scope: !530)
!536 = !DILocation(line: 163, column: 53, scope: !537)
!537 = distinct !DILexicalBlock(scope: !533, file: !1, line: 161, column: 47)
!538 = !DILocation(line: 163, column: 70, scope: !537)
!539 = !DILocation(line: 163, column: 75, scope: !537)
!540 = !DILocation(line: 163, column: 93, scope: !537)
!541 = !DILocation(line: 163, column: 73, scope: !537)
!542 = !DILocation(line: 163, column: 13, scope: !537)
!543 = !DILocation(line: 163, column: 28, scope: !537)
!544 = !DILocation(line: 163, column: 29, scope: !537)
!545 = !DILocation(line: 163, column: 48, scope: !537)
!546 = !DILocation(line: 163, column: 46, scope: !537)
!547 = !DILocation(line: 163, column: 51, scope: !537)
!548 = !DILocation(line: 164, column: 9, scope: !537)
!549 = !DILocation(line: 161, column: 43, scope: !533)
!550 = !DILocation(line: 161, column: 9, scope: !533)
!551 = distinct !{!551, !535, !552, !48}
!552 = !DILocation(line: 164, column: 9, scope: !530)
!553 = !DILocation(line: 165, column: 5, scope: !527)
!554 = !DILocation(line: 158, column: 39, scope: !522)
!555 = !DILocation(line: 158, column: 5, scope: !522)
!556 = distinct !{!556, !524, !557, !48}
!557 = !DILocation(line: 165, column: 5, scope: !519)
!558 = !DILocation(line: 166, column: 1, scope: !504)
!559 = distinct !DISubprogram(name: "get_oracle_activations1", scope: !1, file: !1, line: 168, type: !157, scopeLine: 171, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!560 = !DILocalVariable(name: "weights2", arg: 1, scope: !559, file: !1, line: 168, type: !15)
!561 = !DILocation(line: 168, column: 35, scope: !559)
!562 = !DILocalVariable(name: "output_differences", arg: 2, scope: !559, file: !1, line: 169, type: !15)
!563 = !DILocation(line: 169, column: 35, scope: !559)
!564 = !DILocalVariable(name: "oracle_activations", arg: 3, scope: !559, file: !1, line: 170, type: !15)
!565 = !DILocation(line: 170, column: 35, scope: !559)
!566 = !DILocalVariable(name: "dactivations", arg: 4, scope: !559, file: !1, line: 171, type: !15)
!567 = !DILocation(line: 171, column: 35, scope: !559)
!568 = !DILocalVariable(name: "i", scope: !559, file: !1, line: 172, type: !22)
!569 = !DILocation(line: 172, column: 9, scope: !559)
!570 = !DILocalVariable(name: "j", scope: !559, file: !1, line: 172, type: !22)
!571 = !DILocation(line: 172, column: 12, scope: !559)
!572 = !DILocation(line: 172, column: 5, scope: !559)
!573 = !DILabel(scope: !559, name: "get_oracle_activations1_loop1", file: !1, line: 173)
!574 = !DILocation(line: 173, column: 5, scope: !559)
!575 = !DILocation(line: 174, column: 12, scope: !576)
!576 = distinct !DILexicalBlock(scope: !559, file: !1, line: 174, column: 5)
!577 = !DILocation(line: 174, column: 10, scope: !576)
!578 = !DILocation(line: 174, column: 17, scope: !579)
!579 = distinct !DILexicalBlock(scope: !576, file: !1, line: 174, column: 5)
!580 = !DILocation(line: 174, column: 19, scope: !579)
!581 = !DILocation(line: 174, column: 5, scope: !576)
!582 = !DILocation(line: 176, column: 9, scope: !583)
!583 = distinct !DILexicalBlock(scope: !579, file: !1, line: 174, column: 43)
!584 = !DILocation(line: 176, column: 28, scope: !583)
!585 = !DILocation(line: 176, column: 31, scope: !583)
!586 = !DILabel(scope: !583, name: "get_oracle_activations1_loop1_1", file: !1, line: 177)
!587 = !DILocation(line: 177, column: 9, scope: !583)
!588 = !DILocation(line: 178, column: 16, scope: !589)
!589 = distinct !DILexicalBlock(scope: !583, file: !1, line: 178, column: 9)
!590 = !DILocation(line: 178, column: 14, scope: !589)
!591 = !DILocation(line: 178, column: 21, scope: !592)
!592 = distinct !DILexicalBlock(scope: !589, file: !1, line: 178, column: 9)
!593 = !DILocation(line: 178, column: 23, scope: !592)
!594 = !DILocation(line: 178, column: 9, scope: !589)
!595 = !DILocation(line: 180, column: 38, scope: !596)
!596 = distinct !DILexicalBlock(scope: !592, file: !1, line: 178, column: 47)
!597 = !DILocation(line: 180, column: 57, scope: !596)
!598 = !DILocation(line: 180, column: 62, scope: !596)
!599 = !DILocation(line: 180, column: 71, scope: !596)
!600 = !DILocation(line: 180, column: 72, scope: !596)
!601 = !DILocation(line: 180, column: 91, scope: !596)
!602 = !DILocation(line: 180, column: 89, scope: !596)
!603 = !DILocation(line: 180, column: 13, scope: !596)
!604 = !DILocation(line: 180, column: 32, scope: !596)
!605 = !DILocation(line: 180, column: 35, scope: !596)
!606 = !DILocation(line: 181, column: 9, scope: !596)
!607 = !DILocation(line: 178, column: 43, scope: !592)
!608 = !DILocation(line: 178, column: 9, scope: !592)
!609 = distinct !{!609, !594, !610, !48}
!610 = !DILocation(line: 181, column: 9, scope: !589)
!611 = !DILocation(line: 182, column: 33, scope: !583)
!612 = !DILocation(line: 182, column: 52, scope: !583)
!613 = !DILocation(line: 182, column: 57, scope: !583)
!614 = !DILocation(line: 182, column: 70, scope: !583)
!615 = !DILocation(line: 182, column: 55, scope: !583)
!616 = !DILocation(line: 182, column: 9, scope: !583)
!617 = !DILocation(line: 182, column: 28, scope: !583)
!618 = !DILocation(line: 182, column: 31, scope: !583)
!619 = !DILocation(line: 183, column: 5, scope: !583)
!620 = !DILocation(line: 174, column: 39, scope: !579)
!621 = !DILocation(line: 174, column: 5, scope: !579)
!622 = distinct !{!622, !581, !623, !48}
!623 = !DILocation(line: 183, column: 5, scope: !576)
!624 = !DILocation(line: 184, column: 1, scope: !559)
!625 = distinct !DISubprogram(name: "get_delta_matrix_weights1", scope: !1, file: !1, line: 186, type: !382, scopeLine: 188, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!626 = !DILocalVariable(name: "delta_weights1", arg: 1, scope: !625, file: !1, line: 186, type: !15)
!627 = !DILocation(line: 186, column: 37, scope: !625)
!628 = !DILocalVariable(name: "output_difference", arg: 2, scope: !625, file: !1, line: 187, type: !15)
!629 = !DILocation(line: 187, column: 37, scope: !625)
!630 = !DILocalVariable(name: "last_activations", arg: 3, scope: !625, file: !1, line: 188, type: !15)
!631 = !DILocation(line: 188, column: 37, scope: !625)
!632 = !DILocalVariable(name: "i", scope: !625, file: !1, line: 189, type: !22)
!633 = !DILocation(line: 189, column: 9, scope: !625)
!634 = !DILocalVariable(name: "j", scope: !625, file: !1, line: 189, type: !22)
!635 = !DILocation(line: 189, column: 12, scope: !625)
!636 = !DILocation(line: 189, column: 5, scope: !625)
!637 = !DILabel(scope: !625, name: "get_delta_matrix_weights1_loop1", file: !1, line: 190)
!638 = !DILocation(line: 190, column: 5, scope: !625)
!639 = !DILocation(line: 191, column: 12, scope: !640)
!640 = distinct !DILexicalBlock(scope: !625, file: !1, line: 191, column: 5)
!641 = !DILocation(line: 191, column: 10, scope: !640)
!642 = !DILocation(line: 191, column: 17, scope: !643)
!643 = distinct !DILexicalBlock(scope: !640, file: !1, line: 191, column: 5)
!644 = !DILocation(line: 191, column: 19, scope: !643)
!645 = !DILocation(line: 191, column: 5, scope: !640)
!646 = !DILocation(line: 191, column: 43, scope: !643)
!647 = !DILabel(scope: !648, name: "get_delta_matrix_weights1_loop1_1", file: !1, line: 193)
!648 = distinct !DILexicalBlock(scope: !643, file: !1, line: 191, column: 43)
!649 = !DILocation(line: 193, column: 9, scope: !648)
!650 = !DILocation(line: 194, column: 16, scope: !651)
!651 = distinct !DILexicalBlock(scope: !648, file: !1, line: 194, column: 9)
!652 = !DILocation(line: 194, column: 14, scope: !651)
!653 = !DILocation(line: 194, column: 21, scope: !654)
!654 = distinct !DILexicalBlock(scope: !651, file: !1, line: 194, column: 9)
!655 = !DILocation(line: 194, column: 23, scope: !654)
!656 = !DILocation(line: 194, column: 9, scope: !651)
!657 = !DILocation(line: 196, column: 53, scope: !658)
!658 = distinct !DILexicalBlock(scope: !654, file: !1, line: 194, column: 47)
!659 = !DILocation(line: 196, column: 70, scope: !658)
!660 = !DILocation(line: 196, column: 75, scope: !658)
!661 = !DILocation(line: 196, column: 93, scope: !658)
!662 = !DILocation(line: 196, column: 73, scope: !658)
!663 = !DILocation(line: 196, column: 13, scope: !658)
!664 = !DILocation(line: 196, column: 28, scope: !658)
!665 = !DILocation(line: 196, column: 29, scope: !658)
!666 = !DILocation(line: 196, column: 48, scope: !658)
!667 = !DILocation(line: 196, column: 46, scope: !658)
!668 = !DILocation(line: 196, column: 51, scope: !658)
!669 = !DILocation(line: 197, column: 9, scope: !658)
!670 = !DILocation(line: 194, column: 43, scope: !654)
!671 = !DILocation(line: 194, column: 9, scope: !654)
!672 = distinct !{!672, !656, !673, !48}
!673 = !DILocation(line: 197, column: 9, scope: !651)
!674 = !DILocation(line: 198, column: 5, scope: !648)
!675 = !DILocation(line: 191, column: 39, scope: !643)
!676 = !DILocation(line: 191, column: 5, scope: !643)
!677 = distinct !{!677, !645, !678, !48}
!678 = !DILocation(line: 198, column: 5, scope: !640)
!679 = !DILocation(line: 199, column: 1, scope: !625)
!680 = distinct !DISubprogram(name: "update_weights", scope: !1, file: !1, line: 201, type: !681, scopeLine: 212, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!681 = !DISubroutineType(types: !682)
!682 = !{null, !15, !15, !15, !15, !15, !15, !15, !15, !15, !15, !15, !15}
!683 = !DILocalVariable(name: "weights1", arg: 1, scope: !680, file: !1, line: 201, type: !15)
!684 = !DILocation(line: 201, column: 26, scope: !680)
!685 = !DILocalVariable(name: "weights2", arg: 2, scope: !680, file: !1, line: 202, type: !15)
!686 = !DILocation(line: 202, column: 26, scope: !680)
!687 = !DILocalVariable(name: "weights3", arg: 3, scope: !680, file: !1, line: 203, type: !15)
!688 = !DILocation(line: 203, column: 26, scope: !680)
!689 = !DILocalVariable(name: "d_weights1", arg: 4, scope: !680, file: !1, line: 204, type: !15)
!690 = !DILocation(line: 204, column: 26, scope: !680)
!691 = !DILocalVariable(name: "d_weights2", arg: 5, scope: !680, file: !1, line: 205, type: !15)
!692 = !DILocation(line: 205, column: 26, scope: !680)
!693 = !DILocalVariable(name: "d_weights3", arg: 6, scope: !680, file: !1, line: 206, type: !15)
!694 = !DILocation(line: 206, column: 26, scope: !680)
!695 = !DILocalVariable(name: "biases1", arg: 7, scope: !680, file: !1, line: 207, type: !15)
!696 = !DILocation(line: 207, column: 26, scope: !680)
!697 = !DILocalVariable(name: "biases2", arg: 8, scope: !680, file: !1, line: 208, type: !15)
!698 = !DILocation(line: 208, column: 26, scope: !680)
!699 = !DILocalVariable(name: "biases3", arg: 9, scope: !680, file: !1, line: 209, type: !15)
!700 = !DILocation(line: 209, column: 26, scope: !680)
!701 = !DILocalVariable(name: "d_biases1", arg: 10, scope: !680, file: !1, line: 210, type: !15)
!702 = !DILocation(line: 210, column: 26, scope: !680)
!703 = !DILocalVariable(name: "d_biases2", arg: 11, scope: !680, file: !1, line: 211, type: !15)
!704 = !DILocation(line: 211, column: 26, scope: !680)
!705 = !DILocalVariable(name: "d_biases3", arg: 12, scope: !680, file: !1, line: 212, type: !15)
!706 = !DILocation(line: 212, column: 26, scope: !680)
!707 = !DILocalVariable(name: "i", scope: !680, file: !1, line: 213, type: !22)
!708 = !DILocation(line: 213, column: 9, scope: !680)
!709 = !DILocalVariable(name: "j", scope: !680, file: !1, line: 213, type: !22)
!710 = !DILocation(line: 213, column: 12, scope: !680)
!711 = !DILocalVariable(name: "norm", scope: !680, file: !1, line: 214, type: !3)
!712 = !DILocation(line: 214, column: 12, scope: !680)
!713 = !DILocalVariable(name: "bias_norm", scope: !680, file: !1, line: 214, type: !3)
!714 = !DILocation(line: 214, column: 18, scope: !680)
!715 = !DILocation(line: 215, column: 10, scope: !680)
!716 = !DILocation(line: 216, column: 15, scope: !680)
!717 = !DILocation(line: 216, column: 5, scope: !680)
!718 = !DILabel(scope: !680, name: "update_weights_loop1", file: !1, line: 218)
!719 = !DILocation(line: 218, column: 5, scope: !680)
!720 = !DILocation(line: 219, column: 10, scope: !721)
!721 = distinct !DILexicalBlock(scope: !680, file: !1, line: 219, column: 5)
!722 = !DILocation(line: 219, column: 9, scope: !721)
!723 = !DILocation(line: 219, column: 14, scope: !724)
!724 = distinct !DILexicalBlock(scope: !721, file: !1, line: 219, column: 5)
!725 = !DILocation(line: 219, column: 16, scope: !724)
!726 = !DILocation(line: 219, column: 5, scope: !721)
!727 = !DILocation(line: 219, column: 39, scope: !724)
!728 = !DILabel(scope: !729, name: "update_weights_loop1_1", file: !1, line: 221)
!729 = distinct !DILexicalBlock(scope: !724, file: !1, line: 219, column: 39)
!730 = !DILocation(line: 221, column: 9, scope: !729)
!731 = !DILocation(line: 222, column: 15, scope: !732)
!732 = distinct !DILexicalBlock(scope: !729, file: !1, line: 222, column: 9)
!733 = !DILocation(line: 222, column: 13, scope: !732)
!734 = !DILocation(line: 222, column: 20, scope: !735)
!735 = distinct !DILexicalBlock(scope: !732, file: !1, line: 222, column: 9)
!736 = !DILocation(line: 222, column: 22, scope: !735)
!737 = !DILocation(line: 222, column: 9, scope: !732)
!738 = !DILocation(line: 224, column: 49, scope: !739)
!739 = distinct !DILexicalBlock(scope: !735, file: !1, line: 222, column: 45)
!740 = !DILocation(line: 224, column: 60, scope: !739)
!741 = !DILocation(line: 224, column: 61, scope: !739)
!742 = !DILocation(line: 224, column: 80, scope: !739)
!743 = !DILocation(line: 224, column: 78, scope: !739)
!744 = !DILocation(line: 224, column: 13, scope: !739)
!745 = !DILocation(line: 224, column: 22, scope: !739)
!746 = !DILocation(line: 224, column: 23, scope: !739)
!747 = !DILocation(line: 224, column: 42, scope: !739)
!748 = !DILocation(line: 224, column: 40, scope: !739)
!749 = !DILocation(line: 224, column: 45, scope: !739)
!750 = !DILocation(line: 225, column: 21, scope: !739)
!751 = !DILocation(line: 225, column: 30, scope: !739)
!752 = !DILocation(line: 225, column: 31, scope: !739)
!753 = !DILocation(line: 225, column: 50, scope: !739)
!754 = !DILocation(line: 225, column: 48, scope: !739)
!755 = !DILocation(line: 225, column: 53, scope: !739)
!756 = !DILocation(line: 225, column: 62, scope: !739)
!757 = !DILocation(line: 225, column: 63, scope: !739)
!758 = !DILocation(line: 225, column: 82, scope: !739)
!759 = !DILocation(line: 225, column: 80, scope: !739)
!760 = !DILocation(line: 225, column: 18, scope: !739)
!761 = !DILocation(line: 226, column: 9, scope: !739)
!762 = !DILocation(line: 222, column: 42, scope: !735)
!763 = !DILocation(line: 222, column: 9, scope: !735)
!764 = distinct !{!764, !737, !765, !48}
!765 = !DILocation(line: 226, column: 9, scope: !732)
!766 = !DILocation(line: 227, column: 5, scope: !729)
!767 = !DILocation(line: 219, column: 36, scope: !724)
!768 = !DILocation(line: 219, column: 5, scope: !724)
!769 = distinct !{!769, !726, !770, !48}
!770 = !DILocation(line: 227, column: 5, scope: !721)
!771 = !DILabel(scope: !680, name: "update_weights_loop2", file: !1, line: 228)
!772 = !DILocation(line: 228, column: 5, scope: !680)
!773 = !DILocation(line: 229, column: 10, scope: !774)
!774 = distinct !DILexicalBlock(scope: !680, file: !1, line: 229, column: 5)
!775 = !DILocation(line: 229, column: 9, scope: !774)
!776 = !DILocation(line: 229, column: 14, scope: !777)
!777 = distinct !DILexicalBlock(scope: !774, file: !1, line: 229, column: 5)
!778 = !DILocation(line: 229, column: 16, scope: !777)
!779 = !DILocation(line: 229, column: 5, scope: !774)
!780 = !DILocation(line: 231, column: 24, scope: !781)
!781 = distinct !DILexicalBlock(scope: !777, file: !1, line: 229, column: 39)
!782 = !DILocation(line: 231, column: 34, scope: !781)
!783 = !DILocation(line: 231, column: 9, scope: !781)
!784 = !DILocation(line: 231, column: 17, scope: !781)
!785 = !DILocation(line: 231, column: 20, scope: !781)
!786 = !DILocation(line: 232, column: 22, scope: !781)
!787 = !DILocation(line: 232, column: 30, scope: !781)
!788 = !DILocation(line: 232, column: 33, scope: !781)
!789 = !DILocation(line: 232, column: 41, scope: !781)
!790 = !DILocation(line: 232, column: 19, scope: !781)
!791 = !DILocation(line: 233, column: 5, scope: !781)
!792 = !DILocation(line: 229, column: 36, scope: !777)
!793 = !DILocation(line: 229, column: 5, scope: !777)
!794 = distinct !{!794, !779, !795, !48}
!795 = !DILocation(line: 233, column: 5, scope: !774)
!796 = !DILocation(line: 235, column: 17, scope: !680)
!797 = !DILocation(line: 235, column: 12, scope: !680)
!798 = !DILocation(line: 235, column: 10, scope: !680)
!799 = !DILocation(line: 236, column: 22, scope: !680)
!800 = !DILocation(line: 236, column: 17, scope: !680)
!801 = !DILocation(line: 236, column: 15, scope: !680)
!802 = !DILocation(line: 236, column: 5, scope: !680)
!803 = !DILabel(scope: !680, name: "update_weights_loop3", file: !1, line: 238)
!804 = !DILocation(line: 238, column: 5, scope: !680)
!805 = !DILocation(line: 239, column: 10, scope: !806)
!806 = distinct !DILexicalBlock(scope: !680, file: !1, line: 239, column: 5)
!807 = !DILocation(line: 239, column: 9, scope: !806)
!808 = !DILocation(line: 239, column: 14, scope: !809)
!809 = distinct !DILexicalBlock(scope: !806, file: !1, line: 239, column: 5)
!810 = !DILocation(line: 239, column: 16, scope: !809)
!811 = !DILocation(line: 239, column: 5, scope: !806)
!812 = !DILocation(line: 239, column: 39, scope: !809)
!813 = !DILabel(scope: !814, name: "update_weights_loop3_1", file: !1, line: 241)
!814 = distinct !DILexicalBlock(scope: !809, file: !1, line: 239, column: 39)
!815 = !DILocation(line: 241, column: 9, scope: !814)
!816 = !DILocation(line: 242, column: 15, scope: !817)
!817 = distinct !DILexicalBlock(scope: !814, file: !1, line: 242, column: 9)
!818 = !DILocation(line: 242, column: 13, scope: !817)
!819 = !DILocation(line: 242, column: 20, scope: !820)
!820 = distinct !DILexicalBlock(scope: !817, file: !1, line: 242, column: 9)
!821 = !DILocation(line: 242, column: 22, scope: !820)
!822 = !DILocation(line: 242, column: 9, scope: !817)
!823 = !DILocation(line: 244, column: 48, scope: !824)
!824 = distinct !DILexicalBlock(scope: !820, file: !1, line: 242, column: 45)
!825 = !DILocation(line: 244, column: 57, scope: !824)
!826 = !DILocation(line: 244, column: 58, scope: !824)
!827 = !DILocation(line: 244, column: 77, scope: !824)
!828 = !DILocation(line: 244, column: 75, scope: !824)
!829 = !DILocation(line: 244, column: 80, scope: !824)
!830 = !DILocation(line: 244, column: 79, scope: !824)
!831 = !DILocation(line: 244, column: 13, scope: !824)
!832 = !DILocation(line: 244, column: 22, scope: !824)
!833 = !DILocation(line: 244, column: 23, scope: !824)
!834 = !DILocation(line: 244, column: 42, scope: !824)
!835 = !DILocation(line: 244, column: 40, scope: !824)
!836 = !DILocation(line: 244, column: 45, scope: !824)
!837 = !DILocation(line: 245, column: 9, scope: !824)
!838 = !DILocation(line: 242, column: 42, scope: !820)
!839 = !DILocation(line: 242, column: 9, scope: !820)
!840 = distinct !{!840, !822, !841, !48}
!841 = !DILocation(line: 245, column: 9, scope: !817)
!842 = !DILocation(line: 246, column: 5, scope: !814)
!843 = !DILocation(line: 239, column: 36, scope: !809)
!844 = !DILocation(line: 239, column: 5, scope: !809)
!845 = distinct !{!845, !811, !846, !48}
!846 = !DILocation(line: 246, column: 5, scope: !806)
!847 = !DILabel(scope: !680, name: "update_weights_loop4", file: !1, line: 247)
!848 = !DILocation(line: 247, column: 5, scope: !680)
!849 = !DILocation(line: 248, column: 10, scope: !850)
!850 = distinct !DILexicalBlock(scope: !680, file: !1, line: 248, column: 5)
!851 = !DILocation(line: 248, column: 9, scope: !850)
!852 = !DILocation(line: 248, column: 14, scope: !853)
!853 = distinct !DILexicalBlock(scope: !850, file: !1, line: 248, column: 5)
!854 = !DILocation(line: 248, column: 16, scope: !853)
!855 = !DILocation(line: 248, column: 5, scope: !850)
!856 = !DILocation(line: 250, column: 23, scope: !857)
!857 = distinct !DILexicalBlock(scope: !853, file: !1, line: 248, column: 39)
!858 = !DILocation(line: 250, column: 31, scope: !857)
!859 = !DILocation(line: 250, column: 34, scope: !857)
!860 = !DILocation(line: 250, column: 33, scope: !857)
!861 = !DILocation(line: 250, column: 9, scope: !857)
!862 = !DILocation(line: 250, column: 17, scope: !857)
!863 = !DILocation(line: 250, column: 20, scope: !857)
!864 = !DILocation(line: 251, column: 5, scope: !857)
!865 = !DILocation(line: 248, column: 36, scope: !853)
!866 = !DILocation(line: 248, column: 5, scope: !853)
!867 = distinct !{!867, !855, !868, !48}
!868 = !DILocation(line: 251, column: 5, scope: !850)
!869 = !DILocation(line: 253, column: 10, scope: !680)
!870 = !DILocation(line: 254, column: 15, scope: !680)
!871 = !DILocation(line: 254, column: 5, scope: !680)
!872 = !DILabel(scope: !680, name: "update_weights_loop5", file: !1, line: 256)
!873 = !DILocation(line: 256, column: 5, scope: !680)
!874 = !DILocation(line: 257, column: 10, scope: !875)
!875 = distinct !DILexicalBlock(scope: !680, file: !1, line: 257, column: 5)
!876 = !DILocation(line: 257, column: 9, scope: !875)
!877 = !DILocation(line: 257, column: 14, scope: !878)
!878 = distinct !DILexicalBlock(scope: !875, file: !1, line: 257, column: 5)
!879 = !DILocation(line: 257, column: 16, scope: !878)
!880 = !DILocation(line: 257, column: 5, scope: !875)
!881 = !DILocation(line: 257, column: 39, scope: !878)
!882 = !DILabel(scope: !883, name: "update_weights_loop5_1", file: !1, line: 259)
!883 = distinct !DILexicalBlock(scope: !878, file: !1, line: 257, column: 39)
!884 = !DILocation(line: 259, column: 9, scope: !883)
!885 = !DILocation(line: 260, column: 15, scope: !886)
!886 = distinct !DILexicalBlock(scope: !883, file: !1, line: 260, column: 9)
!887 = !DILocation(line: 260, column: 13, scope: !886)
!888 = !DILocation(line: 260, column: 20, scope: !889)
!889 = distinct !DILexicalBlock(scope: !886, file: !1, line: 260, column: 9)
!890 = !DILocation(line: 260, column: 22, scope: !889)
!891 = !DILocation(line: 260, column: 9, scope: !886)
!892 = !DILocation(line: 262, column: 49, scope: !893)
!893 = distinct !DILexicalBlock(scope: !889, file: !1, line: 260, column: 45)
!894 = !DILocation(line: 262, column: 60, scope: !893)
!895 = !DILocation(line: 262, column: 61, scope: !893)
!896 = !DILocation(line: 262, column: 80, scope: !893)
!897 = !DILocation(line: 262, column: 78, scope: !893)
!898 = !DILocation(line: 262, column: 13, scope: !893)
!899 = !DILocation(line: 262, column: 22, scope: !893)
!900 = !DILocation(line: 262, column: 23, scope: !893)
!901 = !DILocation(line: 262, column: 42, scope: !893)
!902 = !DILocation(line: 262, column: 40, scope: !893)
!903 = !DILocation(line: 262, column: 45, scope: !893)
!904 = !DILocation(line: 263, column: 21, scope: !893)
!905 = !DILocation(line: 263, column: 30, scope: !893)
!906 = !DILocation(line: 263, column: 31, scope: !893)
!907 = !DILocation(line: 263, column: 50, scope: !893)
!908 = !DILocation(line: 263, column: 48, scope: !893)
!909 = !DILocation(line: 263, column: 53, scope: !893)
!910 = !DILocation(line: 263, column: 62, scope: !893)
!911 = !DILocation(line: 263, column: 63, scope: !893)
!912 = !DILocation(line: 263, column: 82, scope: !893)
!913 = !DILocation(line: 263, column: 80, scope: !893)
!914 = !DILocation(line: 263, column: 18, scope: !893)
!915 = !DILocation(line: 264, column: 9, scope: !893)
!916 = !DILocation(line: 260, column: 42, scope: !889)
!917 = !DILocation(line: 260, column: 9, scope: !889)
!918 = distinct !{!918, !891, !919, !48}
!919 = !DILocation(line: 264, column: 9, scope: !886)
!920 = !DILocation(line: 265, column: 5, scope: !883)
!921 = !DILocation(line: 257, column: 36, scope: !878)
!922 = !DILocation(line: 257, column: 5, scope: !878)
!923 = distinct !{!923, !880, !924, !48}
!924 = !DILocation(line: 265, column: 5, scope: !875)
!925 = !DILabel(scope: !680, name: "update_weights_loop6", file: !1, line: 266)
!926 = !DILocation(line: 266, column: 5, scope: !680)
!927 = !DILocation(line: 267, column: 10, scope: !928)
!928 = distinct !DILexicalBlock(scope: !680, file: !1, line: 267, column: 5)
!929 = !DILocation(line: 267, column: 9, scope: !928)
!930 = !DILocation(line: 267, column: 14, scope: !931)
!931 = distinct !DILexicalBlock(scope: !928, file: !1, line: 267, column: 5)
!932 = !DILocation(line: 267, column: 16, scope: !931)
!933 = !DILocation(line: 267, column: 5, scope: !928)
!934 = !DILocation(line: 269, column: 24, scope: !935)
!935 = distinct !DILexicalBlock(scope: !931, file: !1, line: 267, column: 39)
!936 = !DILocation(line: 269, column: 34, scope: !935)
!937 = !DILocation(line: 269, column: 9, scope: !935)
!938 = !DILocation(line: 269, column: 17, scope: !935)
!939 = !DILocation(line: 269, column: 20, scope: !935)
!940 = !DILocation(line: 270, column: 22, scope: !935)
!941 = !DILocation(line: 270, column: 30, scope: !935)
!942 = !DILocation(line: 270, column: 33, scope: !935)
!943 = !DILocation(line: 270, column: 41, scope: !935)
!944 = !DILocation(line: 270, column: 19, scope: !935)
!945 = !DILocation(line: 271, column: 5, scope: !935)
!946 = !DILocation(line: 267, column: 36, scope: !931)
!947 = !DILocation(line: 267, column: 5, scope: !931)
!948 = distinct !{!948, !933, !949, !48}
!949 = !DILocation(line: 271, column: 5, scope: !928)
!950 = !DILocation(line: 273, column: 17, scope: !680)
!951 = !DILocation(line: 273, column: 12, scope: !680)
!952 = !DILocation(line: 273, column: 10, scope: !680)
!953 = !DILocation(line: 274, column: 22, scope: !680)
!954 = !DILocation(line: 274, column: 17, scope: !680)
!955 = !DILocation(line: 274, column: 15, scope: !680)
!956 = !DILocation(line: 274, column: 5, scope: !680)
!957 = !DILabel(scope: !680, name: "update_weights_loop7", file: !1, line: 276)
!958 = !DILocation(line: 276, column: 5, scope: !680)
!959 = !DILocation(line: 277, column: 10, scope: !960)
!960 = distinct !DILexicalBlock(scope: !680, file: !1, line: 277, column: 5)
!961 = !DILocation(line: 277, column: 9, scope: !960)
!962 = !DILocation(line: 277, column: 14, scope: !963)
!963 = distinct !DILexicalBlock(scope: !960, file: !1, line: 277, column: 5)
!964 = !DILocation(line: 277, column: 16, scope: !963)
!965 = !DILocation(line: 277, column: 5, scope: !960)
!966 = !DILocation(line: 277, column: 39, scope: !963)
!967 = !DILabel(scope: !968, name: "update_weights_loop7_1", file: !1, line: 279)
!968 = distinct !DILexicalBlock(scope: !963, file: !1, line: 277, column: 39)
!969 = !DILocation(line: 279, column: 9, scope: !968)
!970 = !DILocation(line: 280, column: 15, scope: !971)
!971 = distinct !DILexicalBlock(scope: !968, file: !1, line: 280, column: 9)
!972 = !DILocation(line: 280, column: 13, scope: !971)
!973 = !DILocation(line: 280, column: 20, scope: !974)
!974 = distinct !DILexicalBlock(scope: !971, file: !1, line: 280, column: 9)
!975 = !DILocation(line: 280, column: 22, scope: !974)
!976 = !DILocation(line: 280, column: 9, scope: !971)
!977 = !DILocation(line: 282, column: 48, scope: !978)
!978 = distinct !DILexicalBlock(scope: !974, file: !1, line: 280, column: 45)
!979 = !DILocation(line: 282, column: 57, scope: !978)
!980 = !DILocation(line: 282, column: 58, scope: !978)
!981 = !DILocation(line: 282, column: 77, scope: !978)
!982 = !DILocation(line: 282, column: 75, scope: !978)
!983 = !DILocation(line: 282, column: 80, scope: !978)
!984 = !DILocation(line: 282, column: 79, scope: !978)
!985 = !DILocation(line: 282, column: 13, scope: !978)
!986 = !DILocation(line: 282, column: 22, scope: !978)
!987 = !DILocation(line: 282, column: 23, scope: !978)
!988 = !DILocation(line: 282, column: 42, scope: !978)
!989 = !DILocation(line: 282, column: 40, scope: !978)
!990 = !DILocation(line: 282, column: 45, scope: !978)
!991 = !DILocation(line: 283, column: 9, scope: !978)
!992 = !DILocation(line: 280, column: 42, scope: !974)
!993 = !DILocation(line: 280, column: 9, scope: !974)
!994 = distinct !{!994, !976, !995, !48}
!995 = !DILocation(line: 283, column: 9, scope: !971)
!996 = !DILocation(line: 284, column: 5, scope: !968)
!997 = !DILocation(line: 277, column: 36, scope: !963)
!998 = !DILocation(line: 277, column: 5, scope: !963)
!999 = distinct !{!999, !965, !1000, !48}
!1000 = !DILocation(line: 284, column: 5, scope: !960)
!1001 = !DILabel(scope: !680, name: "update_weights_loop8", file: !1, line: 285)
!1002 = !DILocation(line: 285, column: 5, scope: !680)
!1003 = !DILocation(line: 286, column: 10, scope: !1004)
!1004 = distinct !DILexicalBlock(scope: !680, file: !1, line: 286, column: 5)
!1005 = !DILocation(line: 286, column: 9, scope: !1004)
!1006 = !DILocation(line: 286, column: 14, scope: !1007)
!1007 = distinct !DILexicalBlock(scope: !1004, file: !1, line: 286, column: 5)
!1008 = !DILocation(line: 286, column: 16, scope: !1007)
!1009 = !DILocation(line: 286, column: 5, scope: !1004)
!1010 = !DILocation(line: 288, column: 23, scope: !1011)
!1011 = distinct !DILexicalBlock(scope: !1007, file: !1, line: 286, column: 39)
!1012 = !DILocation(line: 288, column: 31, scope: !1011)
!1013 = !DILocation(line: 288, column: 34, scope: !1011)
!1014 = !DILocation(line: 288, column: 33, scope: !1011)
!1015 = !DILocation(line: 288, column: 9, scope: !1011)
!1016 = !DILocation(line: 288, column: 17, scope: !1011)
!1017 = !DILocation(line: 288, column: 20, scope: !1011)
!1018 = !DILocation(line: 289, column: 5, scope: !1011)
!1019 = !DILocation(line: 286, column: 36, scope: !1007)
!1020 = !DILocation(line: 286, column: 5, scope: !1007)
!1021 = distinct !{!1021, !1009, !1022, !48}
!1022 = !DILocation(line: 289, column: 5, scope: !1004)
!1023 = !DILocation(line: 291, column: 10, scope: !680)
!1024 = !DILocation(line: 292, column: 15, scope: !680)
!1025 = !DILocation(line: 292, column: 5, scope: !680)
!1026 = !DILabel(scope: !680, name: "update_weights_loop9", file: !1, line: 294)
!1027 = !DILocation(line: 294, column: 5, scope: !680)
!1028 = !DILocation(line: 295, column: 10, scope: !1029)
!1029 = distinct !DILexicalBlock(scope: !680, file: !1, line: 295, column: 5)
!1030 = !DILocation(line: 295, column: 9, scope: !1029)
!1031 = !DILocation(line: 295, column: 14, scope: !1032)
!1032 = distinct !DILexicalBlock(scope: !1029, file: !1, line: 295, column: 5)
!1033 = !DILocation(line: 295, column: 16, scope: !1032)
!1034 = !DILocation(line: 295, column: 5, scope: !1029)
!1035 = !DILocation(line: 295, column: 39, scope: !1032)
!1036 = !DILabel(scope: !1037, name: "update_weights_loop9_1", file: !1, line: 297)
!1037 = distinct !DILexicalBlock(scope: !1032, file: !1, line: 295, column: 39)
!1038 = !DILocation(line: 297, column: 9, scope: !1037)
!1039 = !DILocation(line: 298, column: 15, scope: !1040)
!1040 = distinct !DILexicalBlock(scope: !1037, file: !1, line: 298, column: 9)
!1041 = !DILocation(line: 298, column: 13, scope: !1040)
!1042 = !DILocation(line: 298, column: 20, scope: !1043)
!1043 = distinct !DILexicalBlock(scope: !1040, file: !1, line: 298, column: 9)
!1044 = !DILocation(line: 298, column: 22, scope: !1043)
!1045 = !DILocation(line: 298, column: 9, scope: !1040)
!1046 = !DILocation(line: 300, column: 50, scope: !1047)
!1047 = distinct !DILexicalBlock(scope: !1043, file: !1, line: 298, column: 46)
!1048 = !DILocation(line: 300, column: 61, scope: !1047)
!1049 = !DILocation(line: 300, column: 62, scope: !1047)
!1050 = !DILocation(line: 300, column: 82, scope: !1047)
!1051 = !DILocation(line: 300, column: 80, scope: !1047)
!1052 = !DILocation(line: 300, column: 13, scope: !1047)
!1053 = !DILocation(line: 300, column: 22, scope: !1047)
!1054 = !DILocation(line: 300, column: 23, scope: !1047)
!1055 = !DILocation(line: 300, column: 43, scope: !1047)
!1056 = !DILocation(line: 300, column: 41, scope: !1047)
!1057 = !DILocation(line: 300, column: 46, scope: !1047)
!1058 = !DILocation(line: 301, column: 21, scope: !1047)
!1059 = !DILocation(line: 301, column: 30, scope: !1047)
!1060 = !DILocation(line: 301, column: 31, scope: !1047)
!1061 = !DILocation(line: 301, column: 51, scope: !1047)
!1062 = !DILocation(line: 301, column: 49, scope: !1047)
!1063 = !DILocation(line: 301, column: 54, scope: !1047)
!1064 = !DILocation(line: 301, column: 63, scope: !1047)
!1065 = !DILocation(line: 301, column: 64, scope: !1047)
!1066 = !DILocation(line: 301, column: 84, scope: !1047)
!1067 = !DILocation(line: 301, column: 82, scope: !1047)
!1068 = !DILocation(line: 301, column: 18, scope: !1047)
!1069 = !DILocation(line: 302, column: 9, scope: !1047)
!1070 = !DILocation(line: 298, column: 43, scope: !1043)
!1071 = !DILocation(line: 298, column: 9, scope: !1043)
!1072 = distinct !{!1072, !1045, !1073, !48}
!1073 = !DILocation(line: 302, column: 9, scope: !1040)
!1074 = !DILocation(line: 303, column: 5, scope: !1037)
!1075 = !DILocation(line: 295, column: 36, scope: !1032)
!1076 = !DILocation(line: 295, column: 5, scope: !1032)
!1077 = distinct !{!1077, !1034, !1078, !48}
!1078 = !DILocation(line: 303, column: 5, scope: !1029)
!1079 = !DILabel(scope: !680, name: "update_weights_loop10", file: !1, line: 304)
!1080 = !DILocation(line: 304, column: 5, scope: !680)
!1081 = !DILocation(line: 305, column: 10, scope: !1082)
!1082 = distinct !DILexicalBlock(scope: !680, file: !1, line: 305, column: 5)
!1083 = !DILocation(line: 305, column: 9, scope: !1082)
!1084 = !DILocation(line: 305, column: 14, scope: !1085)
!1085 = distinct !DILexicalBlock(scope: !1082, file: !1, line: 305, column: 5)
!1086 = !DILocation(line: 305, column: 15, scope: !1085)
!1087 = !DILocation(line: 305, column: 5, scope: !1082)
!1088 = !DILocation(line: 307, column: 23, scope: !1089)
!1089 = distinct !DILexicalBlock(scope: !1085, file: !1, line: 305, column: 37)
!1090 = !DILocation(line: 307, column: 33, scope: !1089)
!1091 = !DILocation(line: 307, column: 9, scope: !1089)
!1092 = !DILocation(line: 307, column: 17, scope: !1089)
!1093 = !DILocation(line: 307, column: 20, scope: !1089)
!1094 = !DILocation(line: 308, column: 22, scope: !1089)
!1095 = !DILocation(line: 308, column: 30, scope: !1089)
!1096 = !DILocation(line: 308, column: 33, scope: !1089)
!1097 = !DILocation(line: 308, column: 41, scope: !1089)
!1098 = !DILocation(line: 308, column: 19, scope: !1089)
!1099 = !DILocation(line: 309, column: 5, scope: !1089)
!1100 = !DILocation(line: 305, column: 34, scope: !1085)
!1101 = !DILocation(line: 305, column: 5, scope: !1085)
!1102 = distinct !{!1102, !1087, !1103, !48}
!1103 = !DILocation(line: 309, column: 5, scope: !1082)
!1104 = !DILocation(line: 311, column: 17, scope: !680)
!1105 = !DILocation(line: 311, column: 12, scope: !680)
!1106 = !DILocation(line: 311, column: 10, scope: !680)
!1107 = !DILocation(line: 312, column: 22, scope: !680)
!1108 = !DILocation(line: 312, column: 17, scope: !680)
!1109 = !DILocation(line: 312, column: 15, scope: !680)
!1110 = !DILocation(line: 312, column: 5, scope: !680)
!1111 = !DILabel(scope: !680, name: "update_weights_loop11", file: !1, line: 314)
!1112 = !DILocation(line: 314, column: 5, scope: !680)
!1113 = !DILocation(line: 315, column: 10, scope: !1114)
!1114 = distinct !DILexicalBlock(scope: !680, file: !1, line: 315, column: 5)
!1115 = !DILocation(line: 315, column: 9, scope: !1114)
!1116 = !DILocation(line: 315, column: 14, scope: !1117)
!1117 = distinct !DILexicalBlock(scope: !1114, file: !1, line: 315, column: 5)
!1118 = !DILocation(line: 315, column: 16, scope: !1117)
!1119 = !DILocation(line: 315, column: 5, scope: !1114)
!1120 = !DILocation(line: 315, column: 39, scope: !1117)
!1121 = !DILabel(scope: !1122, name: "update_weights_loop11_1", file: !1, line: 317)
!1122 = distinct !DILexicalBlock(scope: !1117, file: !1, line: 315, column: 39)
!1123 = !DILocation(line: 317, column: 9, scope: !1122)
!1124 = !DILocation(line: 318, column: 15, scope: !1125)
!1125 = distinct !DILexicalBlock(scope: !1122, file: !1, line: 318, column: 9)
!1126 = !DILocation(line: 318, column: 13, scope: !1125)
!1127 = !DILocation(line: 318, column: 20, scope: !1128)
!1128 = distinct !DILexicalBlock(scope: !1125, file: !1, line: 318, column: 9)
!1129 = !DILocation(line: 318, column: 22, scope: !1128)
!1130 = !DILocation(line: 318, column: 9, scope: !1125)
!1131 = !DILocation(line: 320, column: 49, scope: !1132)
!1132 = distinct !DILexicalBlock(scope: !1128, file: !1, line: 318, column: 46)
!1133 = !DILocation(line: 320, column: 58, scope: !1132)
!1134 = !DILocation(line: 320, column: 59, scope: !1132)
!1135 = !DILocation(line: 320, column: 79, scope: !1132)
!1136 = !DILocation(line: 320, column: 77, scope: !1132)
!1137 = !DILocation(line: 320, column: 82, scope: !1132)
!1138 = !DILocation(line: 320, column: 81, scope: !1132)
!1139 = !DILocation(line: 320, column: 13, scope: !1132)
!1140 = !DILocation(line: 320, column: 22, scope: !1132)
!1141 = !DILocation(line: 320, column: 23, scope: !1132)
!1142 = !DILocation(line: 320, column: 43, scope: !1132)
!1143 = !DILocation(line: 320, column: 41, scope: !1132)
!1144 = !DILocation(line: 320, column: 46, scope: !1132)
!1145 = !DILocation(line: 321, column: 9, scope: !1132)
!1146 = !DILocation(line: 318, column: 43, scope: !1128)
!1147 = !DILocation(line: 318, column: 9, scope: !1128)
!1148 = distinct !{!1148, !1130, !1149, !48}
!1149 = !DILocation(line: 321, column: 9, scope: !1125)
!1150 = !DILocation(line: 322, column: 5, scope: !1122)
!1151 = !DILocation(line: 315, column: 36, scope: !1117)
!1152 = !DILocation(line: 315, column: 5, scope: !1117)
!1153 = distinct !{!1153, !1119, !1154, !48}
!1154 = !DILocation(line: 322, column: 5, scope: !1114)
!1155 = !DILabel(scope: !680, name: "update_weights_loop12", file: !1, line: 323)
!1156 = !DILocation(line: 323, column: 5, scope: !680)
!1157 = !DILocation(line: 324, column: 10, scope: !1158)
!1158 = distinct !DILexicalBlock(scope: !680, file: !1, line: 324, column: 5)
!1159 = !DILocation(line: 324, column: 9, scope: !1158)
!1160 = !DILocation(line: 324, column: 14, scope: !1161)
!1161 = distinct !DILexicalBlock(scope: !1158, file: !1, line: 324, column: 5)
!1162 = !DILocation(line: 324, column: 16, scope: !1161)
!1163 = !DILocation(line: 324, column: 5, scope: !1158)
!1164 = !DILocation(line: 326, column: 23, scope: !1165)
!1165 = distinct !DILexicalBlock(scope: !1161, file: !1, line: 324, column: 40)
!1166 = !DILocation(line: 326, column: 31, scope: !1165)
!1167 = !DILocation(line: 326, column: 34, scope: !1165)
!1168 = !DILocation(line: 326, column: 33, scope: !1165)
!1169 = !DILocation(line: 326, column: 9, scope: !1165)
!1170 = !DILocation(line: 326, column: 17, scope: !1165)
!1171 = !DILocation(line: 326, column: 20, scope: !1165)
!1172 = !DILocation(line: 327, column: 5, scope: !1165)
!1173 = !DILocation(line: 324, column: 37, scope: !1161)
!1174 = !DILocation(line: 324, column: 5, scope: !1161)
!1175 = distinct !{!1175, !1163, !1176, !48}
!1176 = !DILocation(line: 327, column: 5, scope: !1158)
!1177 = !DILocation(line: 328, column: 1, scope: !680)
!1178 = distinct !DISubprogram(name: "backprop", scope: !1, file: !1, line: 330, type: !1179, scopeLine: 337, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!1179 = !DISubroutineType(types: !1180)
!1180 = !{null, !15, !15, !15, !15, !15, !15, !15, !15}
!1181 = !DILocalVariable(name: "weights1", arg: 1, scope: !1178, file: !1, line: 330, type: !15)
!1182 = !DILocation(line: 330, column: 20, scope: !1178)
!1183 = !DILocalVariable(name: "weights2", arg: 2, scope: !1178, file: !1, line: 331, type: !15)
!1184 = !DILocation(line: 331, column: 20, scope: !1178)
!1185 = !DILocalVariable(name: "weights3", arg: 3, scope: !1178, file: !1, line: 332, type: !15)
!1186 = !DILocation(line: 332, column: 20, scope: !1178)
!1187 = !DILocalVariable(name: "biases1", arg: 4, scope: !1178, file: !1, line: 333, type: !15)
!1188 = !DILocation(line: 333, column: 20, scope: !1178)
!1189 = !DILocalVariable(name: "biases2", arg: 5, scope: !1178, file: !1, line: 334, type: !15)
!1190 = !DILocation(line: 334, column: 20, scope: !1178)
!1191 = !DILocalVariable(name: "biases3", arg: 6, scope: !1178, file: !1, line: 335, type: !15)
!1192 = !DILocation(line: 335, column: 20, scope: !1178)
!1193 = !DILocalVariable(name: "training_data", arg: 7, scope: !1178, file: !1, line: 336, type: !15)
!1194 = !DILocation(line: 336, column: 20, scope: !1178)
!1195 = !DILocalVariable(name: "training_targets", arg: 8, scope: !1178, file: !1, line: 337, type: !15)
!1196 = !DILocation(line: 337, column: 20, scope: !1178)
!1197 = !DILocalVariable(name: "i", scope: !1178, file: !1, line: 338, type: !22)
!1198 = !DILocation(line: 338, column: 9, scope: !1178)
!1199 = !DILocalVariable(name: "j", scope: !1178, file: !1, line: 338, type: !22)
!1200 = !DILocation(line: 338, column: 11, scope: !1178)
!1201 = !DILocalVariable(name: "activations1", scope: !1178, file: !1, line: 340, type: !1202)
!1202 = !DICompositeType(tag: DW_TAG_array_type, baseType: !3, size: 4096, elements: !1203)
!1203 = !{!1204}
!1204 = !DISubrange(count: 64)
!1205 = !DILocation(line: 340, column: 10, scope: !1178)
!1206 = !DILocalVariable(name: "activations2", scope: !1178, file: !1, line: 341, type: !1202)
!1207 = !DILocation(line: 341, column: 10, scope: !1178)
!1208 = !DILocalVariable(name: "activations3", scope: !1178, file: !1, line: 342, type: !1209)
!1209 = !DICompositeType(tag: DW_TAG_array_type, baseType: !3, size: 192, elements: !1210)
!1210 = !{!1211}
!1211 = !DISubrange(count: 3)
!1212 = !DILocation(line: 342, column: 10, scope: !1178)
!1213 = !DILocalVariable(name: "dactivations1", scope: !1178, file: !1, line: 343, type: !1202)
!1214 = !DILocation(line: 343, column: 10, scope: !1178)
!1215 = !DILocalVariable(name: "dactivations2", scope: !1178, file: !1, line: 344, type: !1202)
!1216 = !DILocation(line: 344, column: 10, scope: !1178)
!1217 = !DILocalVariable(name: "dactivations3", scope: !1178, file: !1, line: 345, type: !1209)
!1218 = !DILocation(line: 345, column: 10, scope: !1178)
!1219 = !DILocalVariable(name: "net_outputs", scope: !1178, file: !1, line: 346, type: !1209)
!1220 = !DILocation(line: 346, column: 10, scope: !1178)
!1221 = !DILocalVariable(name: "output_difference", scope: !1178, file: !1, line: 348, type: !1209)
!1222 = !DILocation(line: 348, column: 10, scope: !1178)
!1223 = !DILocalVariable(name: "delta_weights1", scope: !1178, file: !1, line: 349, type: !1224)
!1224 = !DICompositeType(tag: DW_TAG_array_type, baseType: !3, size: 53248, elements: !1225)
!1225 = !{!1226}
!1226 = !DISubrange(count: 832)
!1227 = !DILocation(line: 349, column: 10, scope: !1178)
!1228 = !DILocalVariable(name: "delta_weights2", scope: !1178, file: !1, line: 350, type: !1229)
!1229 = !DICompositeType(tag: DW_TAG_array_type, baseType: !3, size: 262144, elements: !1230)
!1230 = !{!1231}
!1231 = !DISubrange(count: 4096)
!1232 = !DILocation(line: 350, column: 10, scope: !1178)
!1233 = !DILocalVariable(name: "delta_weights3", scope: !1178, file: !1, line: 351, type: !1234)
!1234 = !DICompositeType(tag: DW_TAG_array_type, baseType: !3, size: 12288, elements: !1235)
!1235 = !{!1236}
!1236 = !DISubrange(count: 192)
!1237 = !DILocation(line: 351, column: 10, scope: !1178)
!1238 = !DILocalVariable(name: "oracle_activations1", scope: !1178, file: !1, line: 352, type: !1202)
!1239 = !DILocation(line: 352, column: 10, scope: !1178)
!1240 = !DILocalVariable(name: "oracle_activations2", scope: !1178, file: !1, line: 353, type: !1202)
!1241 = !DILocation(line: 353, column: 10, scope: !1178)
!1242 = !DILocation(line: 353, column: 5, scope: !1178)
!1243 = !DILabel(scope: !1178, name: "backprop_loop1", file: !1, line: 355)
!1244 = !DILocation(line: 355, column: 5, scope: !1178)
!1245 = !DILocation(line: 356, column: 10, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1178, file: !1, line: 356, column: 5)
!1247 = !DILocation(line: 356, column: 9, scope: !1246)
!1248 = !DILocation(line: 356, column: 14, scope: !1249)
!1249 = distinct !DILexicalBlock(scope: !1246, file: !1, line: 356, column: 5)
!1250 = !DILocation(line: 356, column: 15, scope: !1249)
!1251 = !DILocation(line: 356, column: 5, scope: !1246)
!1252 = !DILocation(line: 356, column: 35, scope: !1249)
!1253 = !DILabel(scope: !1254, name: "backprop_loop1_1", file: !1, line: 358)
!1254 = distinct !DILexicalBlock(scope: !1249, file: !1, line: 356, column: 35)
!1255 = !DILocation(line: 358, column: 9, scope: !1254)
!1256 = !DILocation(line: 359, column: 14, scope: !1257)
!1257 = distinct !DILexicalBlock(scope: !1254, file: !1, line: 359, column: 9)
!1258 = !DILocation(line: 359, column: 13, scope: !1257)
!1259 = !DILocation(line: 359, column: 17, scope: !1260)
!1260 = distinct !DILexicalBlock(scope: !1257, file: !1, line: 359, column: 9)
!1261 = !DILocation(line: 359, column: 18, scope: !1260)
!1262 = !DILocation(line: 359, column: 9, scope: !1257)
!1263 = !DILocation(line: 361, column: 26, scope: !1264)
!1264 = distinct !DILexicalBlock(scope: !1260, file: !1, line: 359, column: 39)
!1265 = !DILocation(line: 361, column: 13, scope: !1264)
!1266 = !DILocation(line: 361, column: 29, scope: !1264)
!1267 = !DILocation(line: 362, column: 26, scope: !1264)
!1268 = !DILocation(line: 362, column: 13, scope: !1264)
!1269 = !DILocation(line: 362, column: 29, scope: !1264)
!1270 = !DILocation(line: 363, column: 16, scope: !1271)
!1271 = distinct !DILexicalBlock(scope: !1264, file: !1, line: 363, column: 16)
!1272 = !DILocation(line: 363, column: 17, scope: !1271)
!1273 = !DILocation(line: 363, column: 16, scope: !1264)
!1274 = !DILocation(line: 364, column: 30, scope: !1275)
!1275 = distinct !DILexicalBlock(scope: !1271, file: !1, line: 363, column: 35)
!1276 = !DILocation(line: 364, column: 17, scope: !1275)
!1277 = !DILocation(line: 364, column: 33, scope: !1275)
!1278 = !DILocation(line: 365, column: 13, scope: !1275)
!1279 = !DILocation(line: 366, column: 9, scope: !1264)
!1280 = !DILocation(line: 359, column: 36, scope: !1260)
!1281 = !DILocation(line: 359, column: 9, scope: !1260)
!1282 = distinct !{!1282, !1262, !1283, !48}
!1283 = !DILocation(line: 366, column: 9, scope: !1257)
!1284 = !DILocation(line: 367, column: 53, scope: !1254)
!1285 = !DILocation(line: 367, column: 62, scope: !1254)
!1286 = !DILocation(line: 367, column: 72, scope: !1254)
!1287 = !DILocation(line: 367, column: 87, scope: !1254)
!1288 = !DILocation(line: 367, column: 101, scope: !1254)
!1289 = !DILocation(line: 367, column: 102, scope: !1254)
!1290 = !DILocation(line: 367, column: 9, scope: !1254)
!1291 = !DILocation(line: 368, column: 14, scope: !1254)
!1292 = !DILocation(line: 368, column: 28, scope: !1254)
!1293 = !DILocation(line: 368, column: 9, scope: !1254)
!1294 = !DILocation(line: 369, column: 54, scope: !1254)
!1295 = !DILocation(line: 369, column: 63, scope: !1254)
!1296 = !DILocation(line: 369, column: 73, scope: !1254)
!1297 = !DILocation(line: 369, column: 87, scope: !1254)
!1298 = !DILocation(line: 369, column: 9, scope: !1254)
!1299 = !DILocation(line: 370, column: 14, scope: !1254)
!1300 = !DILocation(line: 370, column: 28, scope: !1254)
!1301 = !DILocation(line: 370, column: 9, scope: !1254)
!1302 = !DILocation(line: 371, column: 54, scope: !1254)
!1303 = !DILocation(line: 371, column: 63, scope: !1254)
!1304 = !DILocation(line: 371, column: 73, scope: !1254)
!1305 = !DILocation(line: 371, column: 87, scope: !1254)
!1306 = !DILocation(line: 371, column: 9, scope: !1254)
!1307 = !DILocation(line: 372, column: 14, scope: !1254)
!1308 = !DILocation(line: 372, column: 28, scope: !1254)
!1309 = !DILocation(line: 372, column: 9, scope: !1254)
!1310 = !DILocation(line: 373, column: 18, scope: !1254)
!1311 = !DILocation(line: 373, column: 31, scope: !1254)
!1312 = !DILocation(line: 373, column: 9, scope: !1254)
!1313 = !DILocation(line: 374, column: 25, scope: !1254)
!1314 = !DILocation(line: 374, column: 39, scope: !1254)
!1315 = !DILocation(line: 374, column: 56, scope: !1254)
!1316 = !DILocation(line: 374, column: 57, scope: !1254)
!1317 = !DILocation(line: 374, column: 77, scope: !1254)
!1318 = !DILocation(line: 374, column: 96, scope: !1254)
!1319 = !DILocation(line: 374, column: 9, scope: !1254)
!1320 = !DILocation(line: 375, column: 35, scope: !1254)
!1321 = !DILocation(line: 375, column: 51, scope: !1254)
!1322 = !DILocation(line: 375, column: 70, scope: !1254)
!1323 = !DILocation(line: 375, column: 9, scope: !1254)
!1324 = !DILocation(line: 376, column: 33, scope: !1254)
!1325 = !DILocation(line: 376, column: 43, scope: !1254)
!1326 = !DILocation(line: 376, column: 62, scope: !1254)
!1327 = !DILocation(line: 376, column: 83, scope: !1254)
!1328 = !DILocation(line: 376, column: 9, scope: !1254)
!1329 = !DILocation(line: 377, column: 35, scope: !1254)
!1330 = !DILocation(line: 377, column: 51, scope: !1254)
!1331 = !DILocation(line: 377, column: 72, scope: !1254)
!1332 = !DILocation(line: 377, column: 9, scope: !1254)
!1333 = !DILocation(line: 378, column: 33, scope: !1254)
!1334 = !DILocation(line: 378, column: 43, scope: !1254)
!1335 = !DILocation(line: 378, column: 64, scope: !1254)
!1336 = !DILocation(line: 378, column: 85, scope: !1254)
!1337 = !DILocation(line: 378, column: 9, scope: !1254)
!1338 = !DILocation(line: 379, column: 35, scope: !1254)
!1339 = !DILocation(line: 379, column: 51, scope: !1254)
!1340 = !DILocation(line: 379, column: 73, scope: !1254)
!1341 = !DILocation(line: 379, column: 87, scope: !1254)
!1342 = !DILocation(line: 379, column: 88, scope: !1254)
!1343 = !DILocation(line: 379, column: 9, scope: !1254)
!1344 = !DILocation(line: 380, column: 24, scope: !1254)
!1345 = !DILocation(line: 380, column: 34, scope: !1254)
!1346 = !DILocation(line: 380, column: 44, scope: !1254)
!1347 = !DILocation(line: 380, column: 54, scope: !1254)
!1348 = !DILocation(line: 380, column: 70, scope: !1254)
!1349 = !DILocation(line: 380, column: 86, scope: !1254)
!1350 = !DILocation(line: 381, column: 24, scope: !1254)
!1351 = !DILocation(line: 381, column: 33, scope: !1254)
!1352 = !DILocation(line: 381, column: 42, scope: !1254)
!1353 = !DILocation(line: 381, column: 51, scope: !1254)
!1354 = !DILocation(line: 381, column: 72, scope: !1254)
!1355 = !DILocation(line: 381, column: 93, scope: !1254)
!1356 = !DILocation(line: 380, column: 9, scope: !1254)
!1357 = !DILocation(line: 382, column: 5, scope: !1254)
!1358 = !DILocation(line: 356, column: 32, scope: !1249)
!1359 = !DILocation(line: 356, column: 5, scope: !1249)
!1360 = distinct !{!1360, !1251, !1361, !48}
!1361 = !DILocation(line: 382, column: 5, scope: !1246)
!1362 = !DILocation(line: 383, column: 1, scope: !1178)
