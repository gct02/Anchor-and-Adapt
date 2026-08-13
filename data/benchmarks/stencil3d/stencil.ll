; ModuleID = 'data/benchmarks/real/stencil3d/stencil.c'
source_filename = "data/benchmarks/real/stencil3d/stencil.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @stencil3d(i32* noundef %C, i32* noundef %orig, i32* noundef %sol) #0 !dbg !10 {
entry:
  %C.addr = alloca i32*, align 8
  %orig.addr = alloca i32*, align 8
  %sol.addr = alloca i32*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %sum0 = alloca i32, align 4
  %sum1 = alloca i32, align 4
  %mul0 = alloca i32, align 4
  %mul1 = alloca i32, align 4
  store i32* %C, i32** %C.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %C.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store i32* %orig, i32** %orig.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %orig.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store i32* %sol, i32** %sol.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %sol.addr, metadata !24, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %i, metadata !26, metadata !DIExpression()), !dbg !27
  call void @llvm.dbg.declare(metadata i32* %j, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %k, metadata !30, metadata !DIExpression()), !dbg !31
  call void @llvm.dbg.declare(metadata i32* %sum0, metadata !32, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.declare(metadata i32* %sum1, metadata !34, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.declare(metadata i32* %mul0, metadata !36, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.declare(metadata i32* %mul1, metadata !38, metadata !DIExpression()), !dbg !39
  br label %height_bound_col, !dbg !40

height_bound_col:                                 ; preds = %entry
  call void @llvm.dbg.label(metadata !41), !dbg !42
  store i32 0, i32* %j, align 4, !dbg !43
  br label %for.cond, !dbg !45

for.cond:                                         ; preds = %for.inc20, %height_bound_col
  %0 = load i32, i32* %j, align 4, !dbg !46
  %cmp = icmp slt i32 %0, 16, !dbg !48
  br i1 %cmp, label %for.body, label %for.end22, !dbg !49

for.body:                                         ; preds = %for.cond
  br label %height_bound_row, !dbg !50

height_bound_row:                                 ; preds = %for.body
  call void @llvm.dbg.label(metadata !51), !dbg !53
  store i32 0, i32* %k, align 4, !dbg !54
  br label %for.cond1, !dbg !56

for.cond1:                                        ; preds = %for.inc, %height_bound_row
  %1 = load i32, i32* %k, align 4, !dbg !57
  %cmp2 = icmp slt i32 %1, 8, !dbg !59
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !60

for.body3:                                        ; preds = %for.cond1
  %2 = load i32*, i32** %orig.addr, align 8, !dbg !61
  %3 = load i32, i32* %k, align 4, !dbg !63
  %4 = load i32, i32* %j, align 4, !dbg !63
  %add = add nsw i32 %4, 0, !dbg !63
  %mul = mul nsw i32 8, %add, !dbg !63
  %add4 = add nsw i32 %3, %mul, !dbg !63
  %idxprom = sext i32 %add4 to i64, !dbg !61
  %arrayidx = getelementptr inbounds i32, i32* %2, i64 %idxprom, !dbg !61
  %5 = load i32, i32* %arrayidx, align 4, !dbg !61
  %6 = load i32*, i32** %sol.addr, align 8, !dbg !64
  %7 = load i32, i32* %k, align 4, !dbg !65
  %8 = load i32, i32* %j, align 4, !dbg !65
  %add5 = add nsw i32 %8, 0, !dbg !65
  %mul6 = mul nsw i32 8, %add5, !dbg !65
  %add7 = add nsw i32 %7, %mul6, !dbg !65
  %idxprom8 = sext i32 %add7 to i64, !dbg !64
  %arrayidx9 = getelementptr inbounds i32, i32* %6, i64 %idxprom8, !dbg !64
  store i32 %5, i32* %arrayidx9, align 4, !dbg !66
  %9 = load i32*, i32** %orig.addr, align 8, !dbg !67
  %10 = load i32, i32* %k, align 4, !dbg !68
  %11 = load i32, i32* %j, align 4, !dbg !68
  %add10 = add nsw i32 %11, 240, !dbg !68
  %mul11 = mul nsw i32 8, %add10, !dbg !68
  %add12 = add nsw i32 %10, %mul11, !dbg !68
  %idxprom13 = sext i32 %add12 to i64, !dbg !67
  %arrayidx14 = getelementptr inbounds i32, i32* %9, i64 %idxprom13, !dbg !67
  %12 = load i32, i32* %arrayidx14, align 4, !dbg !67
  %13 = load i32*, i32** %sol.addr, align 8, !dbg !69
  %14 = load i32, i32* %k, align 4, !dbg !70
  %15 = load i32, i32* %j, align 4, !dbg !70
  %add15 = add nsw i32 %15, 240, !dbg !70
  %mul16 = mul nsw i32 8, %add15, !dbg !70
  %add17 = add nsw i32 %14, %mul16, !dbg !70
  %idxprom18 = sext i32 %add17 to i64, !dbg !69
  %arrayidx19 = getelementptr inbounds i32, i32* %13, i64 %idxprom18, !dbg !69
  store i32 %12, i32* %arrayidx19, align 4, !dbg !71
  br label %for.inc, !dbg !72

for.inc:                                          ; preds = %for.body3
  %16 = load i32, i32* %k, align 4, !dbg !73
  %inc = add nsw i32 %16, 1, !dbg !73
  store i32 %inc, i32* %k, align 4, !dbg !73
  br label %for.cond1, !dbg !74, !llvm.loop !75

for.end:                                          ; preds = %for.cond1
  br label %for.inc20, !dbg !78

for.inc20:                                        ; preds = %for.end
  %17 = load i32, i32* %j, align 4, !dbg !79
  %inc21 = add nsw i32 %17, 1, !dbg !79
  store i32 %inc21, i32* %j, align 4, !dbg !79
  br label %for.cond, !dbg !80, !llvm.loop !81

for.end22:                                        ; preds = %for.cond
  br label %col_bound_height, !dbg !82

col_bound_height:                                 ; preds = %for.end22
  call void @llvm.dbg.label(metadata !83), !dbg !84
  store i32 1, i32* %i, align 4, !dbg !85
  br label %for.cond23, !dbg !87

for.cond23:                                       ; preds = %for.inc56, %col_bound_height
  %18 = load i32, i32* %i, align 4, !dbg !88
  %cmp24 = icmp slt i32 %18, 15, !dbg !90
  br i1 %cmp24, label %for.body25, label %for.end58, !dbg !91

for.body25:                                       ; preds = %for.cond23
  br label %col_bound_row, !dbg !92

col_bound_row:                                    ; preds = %for.body25
  call void @llvm.dbg.label(metadata !93), !dbg !95
  store i32 0, i32* %k, align 4, !dbg !96
  br label %for.cond26, !dbg !98

for.cond26:                                       ; preds = %for.inc53, %col_bound_row
  %19 = load i32, i32* %k, align 4, !dbg !99
  %cmp27 = icmp slt i32 %19, 8, !dbg !101
  br i1 %cmp27, label %for.body28, label %for.end55, !dbg !102

for.body28:                                       ; preds = %for.cond26
  %20 = load i32*, i32** %orig.addr, align 8, !dbg !103
  %21 = load i32, i32* %k, align 4, !dbg !105
  %22 = load i32, i32* %i, align 4, !dbg !105
  %mul29 = mul nsw i32 16, %22, !dbg !105
  %add30 = add nsw i32 0, %mul29, !dbg !105
  %mul31 = mul nsw i32 8, %add30, !dbg !105
  %add32 = add nsw i32 %21, %mul31, !dbg !105
  %idxprom33 = sext i32 %add32 to i64, !dbg !103
  %arrayidx34 = getelementptr inbounds i32, i32* %20, i64 %idxprom33, !dbg !103
  %23 = load i32, i32* %arrayidx34, align 4, !dbg !103
  %24 = load i32*, i32** %sol.addr, align 8, !dbg !106
  %25 = load i32, i32* %k, align 4, !dbg !107
  %26 = load i32, i32* %i, align 4, !dbg !107
  %mul35 = mul nsw i32 16, %26, !dbg !107
  %add36 = add nsw i32 0, %mul35, !dbg !107
  %mul37 = mul nsw i32 8, %add36, !dbg !107
  %add38 = add nsw i32 %25, %mul37, !dbg !107
  %idxprom39 = sext i32 %add38 to i64, !dbg !106
  %arrayidx40 = getelementptr inbounds i32, i32* %24, i64 %idxprom39, !dbg !106
  store i32 %23, i32* %arrayidx40, align 4, !dbg !108
  %27 = load i32*, i32** %orig.addr, align 8, !dbg !109
  %28 = load i32, i32* %k, align 4, !dbg !110
  %29 = load i32, i32* %i, align 4, !dbg !110
  %mul41 = mul nsw i32 16, %29, !dbg !110
  %add42 = add nsw i32 15, %mul41, !dbg !110
  %mul43 = mul nsw i32 8, %add42, !dbg !110
  %add44 = add nsw i32 %28, %mul43, !dbg !110
  %idxprom45 = sext i32 %add44 to i64, !dbg !109
  %arrayidx46 = getelementptr inbounds i32, i32* %27, i64 %idxprom45, !dbg !109
  %30 = load i32, i32* %arrayidx46, align 4, !dbg !109
  %31 = load i32*, i32** %sol.addr, align 8, !dbg !111
  %32 = load i32, i32* %k, align 4, !dbg !112
  %33 = load i32, i32* %i, align 4, !dbg !112
  %mul47 = mul nsw i32 16, %33, !dbg !112
  %add48 = add nsw i32 15, %mul47, !dbg !112
  %mul49 = mul nsw i32 8, %add48, !dbg !112
  %add50 = add nsw i32 %32, %mul49, !dbg !112
  %idxprom51 = sext i32 %add50 to i64, !dbg !111
  %arrayidx52 = getelementptr inbounds i32, i32* %31, i64 %idxprom51, !dbg !111
  store i32 %30, i32* %arrayidx52, align 4, !dbg !113
  br label %for.inc53, !dbg !114

for.inc53:                                        ; preds = %for.body28
  %34 = load i32, i32* %k, align 4, !dbg !115
  %inc54 = add nsw i32 %34, 1, !dbg !115
  store i32 %inc54, i32* %k, align 4, !dbg !115
  br label %for.cond26, !dbg !116, !llvm.loop !117

for.end55:                                        ; preds = %for.cond26
  br label %for.inc56, !dbg !119

for.inc56:                                        ; preds = %for.end55
  %35 = load i32, i32* %i, align 4, !dbg !120
  %inc57 = add nsw i32 %35, 1, !dbg !120
  store i32 %inc57, i32* %i, align 4, !dbg !120
  br label %for.cond23, !dbg !121, !llvm.loop !122

for.end58:                                        ; preds = %for.cond23
  br label %row_bound_height, !dbg !123

row_bound_height:                                 ; preds = %for.end58
  call void @llvm.dbg.label(metadata !124), !dbg !125
  store i32 1, i32* %i, align 4, !dbg !126
  br label %for.cond59, !dbg !128

for.cond59:                                       ; preds = %for.inc92, %row_bound_height
  %36 = load i32, i32* %i, align 4, !dbg !129
  %cmp60 = icmp slt i32 %36, 15, !dbg !131
  br i1 %cmp60, label %for.body61, label %for.end94, !dbg !132

for.body61:                                       ; preds = %for.cond59
  br label %row_bound_col, !dbg !133

row_bound_col:                                    ; preds = %for.body61
  call void @llvm.dbg.label(metadata !134), !dbg !136
  store i32 1, i32* %j, align 4, !dbg !137
  br label %for.cond62, !dbg !139

for.cond62:                                       ; preds = %for.inc89, %row_bound_col
  %37 = load i32, i32* %j, align 4, !dbg !140
  %cmp63 = icmp slt i32 %37, 15, !dbg !142
  br i1 %cmp63, label %for.body64, label %for.end91, !dbg !143

for.body64:                                       ; preds = %for.cond62
  %38 = load i32*, i32** %orig.addr, align 8, !dbg !144
  %39 = load i32, i32* %j, align 4, !dbg !146
  %40 = load i32, i32* %i, align 4, !dbg !146
  %mul65 = mul nsw i32 16, %40, !dbg !146
  %add66 = add nsw i32 %39, %mul65, !dbg !146
  %mul67 = mul nsw i32 8, %add66, !dbg !146
  %add68 = add nsw i32 0, %mul67, !dbg !146
  %idxprom69 = sext i32 %add68 to i64, !dbg !144
  %arrayidx70 = getelementptr inbounds i32, i32* %38, i64 %idxprom69, !dbg !144
  %41 = load i32, i32* %arrayidx70, align 4, !dbg !144
  %42 = load i32*, i32** %sol.addr, align 8, !dbg !147
  %43 = load i32, i32* %j, align 4, !dbg !148
  %44 = load i32, i32* %i, align 4, !dbg !148
  %mul71 = mul nsw i32 16, %44, !dbg !148
  %add72 = add nsw i32 %43, %mul71, !dbg !148
  %mul73 = mul nsw i32 8, %add72, !dbg !148
  %add74 = add nsw i32 0, %mul73, !dbg !148
  %idxprom75 = sext i32 %add74 to i64, !dbg !147
  %arrayidx76 = getelementptr inbounds i32, i32* %42, i64 %idxprom75, !dbg !147
  store i32 %41, i32* %arrayidx76, align 4, !dbg !149
  %45 = load i32*, i32** %orig.addr, align 8, !dbg !150
  %46 = load i32, i32* %j, align 4, !dbg !151
  %47 = load i32, i32* %i, align 4, !dbg !151
  %mul77 = mul nsw i32 16, %47, !dbg !151
  %add78 = add nsw i32 %46, %mul77, !dbg !151
  %mul79 = mul nsw i32 8, %add78, !dbg !151
  %add80 = add nsw i32 7, %mul79, !dbg !151
  %idxprom81 = sext i32 %add80 to i64, !dbg !150
  %arrayidx82 = getelementptr inbounds i32, i32* %45, i64 %idxprom81, !dbg !150
  %48 = load i32, i32* %arrayidx82, align 4, !dbg !150
  %49 = load i32*, i32** %sol.addr, align 8, !dbg !152
  %50 = load i32, i32* %j, align 4, !dbg !153
  %51 = load i32, i32* %i, align 4, !dbg !153
  %mul83 = mul nsw i32 16, %51, !dbg !153
  %add84 = add nsw i32 %50, %mul83, !dbg !153
  %mul85 = mul nsw i32 8, %add84, !dbg !153
  %add86 = add nsw i32 7, %mul85, !dbg !153
  %idxprom87 = sext i32 %add86 to i64, !dbg !152
  %arrayidx88 = getelementptr inbounds i32, i32* %49, i64 %idxprom87, !dbg !152
  store i32 %48, i32* %arrayidx88, align 4, !dbg !154
  br label %for.inc89, !dbg !155

for.inc89:                                        ; preds = %for.body64
  %52 = load i32, i32* %j, align 4, !dbg !156
  %inc90 = add nsw i32 %52, 1, !dbg !156
  store i32 %inc90, i32* %j, align 4, !dbg !156
  br label %for.cond62, !dbg !157, !llvm.loop !158

for.end91:                                        ; preds = %for.cond62
  br label %for.inc92, !dbg !160

for.inc92:                                        ; preds = %for.end91
  %53 = load i32, i32* %i, align 4, !dbg !161
  %inc93 = add nsw i32 %53, 1, !dbg !161
  store i32 %inc93, i32* %i, align 4, !dbg !161
  br label %for.cond59, !dbg !162, !llvm.loop !163

for.end94:                                        ; preds = %for.cond59
  br label %loop_height, !dbg !164

loop_height:                                      ; preds = %for.end94
  call void @llvm.dbg.label(metadata !165), !dbg !166
  store i32 1, i32* %i, align 4, !dbg !167
  br label %for.cond95, !dbg !169

for.cond95:                                       ; preds = %for.inc173, %loop_height
  %54 = load i32, i32* %i, align 4, !dbg !170
  %cmp96 = icmp slt i32 %54, 15, !dbg !172
  br i1 %cmp96, label %for.body97, label %for.end175, !dbg !173

for.body97:                                       ; preds = %for.cond95
  br label %loop_col, !dbg !174

loop_col:                                         ; preds = %for.body97
  call void @llvm.dbg.label(metadata !175), !dbg !177
  store i32 1, i32* %j, align 4, !dbg !178
  br label %for.cond98, !dbg !180

for.cond98:                                       ; preds = %for.inc170, %loop_col
  %55 = load i32, i32* %j, align 4, !dbg !181
  %cmp99 = icmp slt i32 %55, 15, !dbg !183
  br i1 %cmp99, label %for.body100, label %for.end172, !dbg !184

for.body100:                                      ; preds = %for.cond98
  br label %loop_row, !dbg !185

loop_row:                                         ; preds = %for.body100
  call void @llvm.dbg.label(metadata !186), !dbg !188
  store i32 1, i32* %k, align 4, !dbg !189
  br label %for.cond101, !dbg !191

for.cond101:                                      ; preds = %for.inc167, %loop_row
  %56 = load i32, i32* %k, align 4, !dbg !192
  %cmp102 = icmp slt i32 %56, 7, !dbg !194
  br i1 %cmp102, label %for.body103, label %for.end169, !dbg !195

for.body103:                                      ; preds = %for.cond101
  %57 = load i32*, i32** %orig.addr, align 8, !dbg !196
  %58 = load i32, i32* %k, align 4, !dbg !198
  %59 = load i32, i32* %j, align 4, !dbg !198
  %60 = load i32, i32* %i, align 4, !dbg !198
  %mul104 = mul nsw i32 16, %60, !dbg !198
  %add105 = add nsw i32 %59, %mul104, !dbg !198
  %mul106 = mul nsw i32 8, %add105, !dbg !198
  %add107 = add nsw i32 %58, %mul106, !dbg !198
  %idxprom108 = sext i32 %add107 to i64, !dbg !196
  %arrayidx109 = getelementptr inbounds i32, i32* %57, i64 %idxprom108, !dbg !196
  %61 = load i32, i32* %arrayidx109, align 4, !dbg !196
  store i32 %61, i32* %sum0, align 4, !dbg !199
  %62 = load i32*, i32** %orig.addr, align 8, !dbg !200
  %63 = load i32, i32* %k, align 4, !dbg !201
  %64 = load i32, i32* %j, align 4, !dbg !201
  %65 = load i32, i32* %i, align 4, !dbg !201
  %add110 = add nsw i32 %65, 1, !dbg !201
  %mul111 = mul nsw i32 16, %add110, !dbg !201
  %add112 = add nsw i32 %64, %mul111, !dbg !201
  %mul113 = mul nsw i32 8, %add112, !dbg !201
  %add114 = add nsw i32 %63, %mul113, !dbg !201
  %idxprom115 = sext i32 %add114 to i64, !dbg !200
  %arrayidx116 = getelementptr inbounds i32, i32* %62, i64 %idxprom115, !dbg !200
  %66 = load i32, i32* %arrayidx116, align 4, !dbg !200
  %67 = load i32*, i32** %orig.addr, align 8, !dbg !202
  %68 = load i32, i32* %k, align 4, !dbg !203
  %69 = load i32, i32* %j, align 4, !dbg !203
  %70 = load i32, i32* %i, align 4, !dbg !203
  %sub = sub nsw i32 %70, 1, !dbg !203
  %mul117 = mul nsw i32 16, %sub, !dbg !203
  %add118 = add nsw i32 %69, %mul117, !dbg !203
  %mul119 = mul nsw i32 8, %add118, !dbg !203
  %add120 = add nsw i32 %68, %mul119, !dbg !203
  %idxprom121 = sext i32 %add120 to i64, !dbg !202
  %arrayidx122 = getelementptr inbounds i32, i32* %67, i64 %idxprom121, !dbg !202
  %71 = load i32, i32* %arrayidx122, align 4, !dbg !202
  %add123 = add nsw i32 %66, %71, !dbg !204
  %72 = load i32*, i32** %orig.addr, align 8, !dbg !205
  %73 = load i32, i32* %k, align 4, !dbg !206
  %74 = load i32, i32* %j, align 4, !dbg !206
  %add124 = add nsw i32 %74, 1, !dbg !206
  %75 = load i32, i32* %i, align 4, !dbg !206
  %mul125 = mul nsw i32 16, %75, !dbg !206
  %add126 = add nsw i32 %add124, %mul125, !dbg !206
  %mul127 = mul nsw i32 8, %add126, !dbg !206
  %add128 = add nsw i32 %73, %mul127, !dbg !206
  %idxprom129 = sext i32 %add128 to i64, !dbg !205
  %arrayidx130 = getelementptr inbounds i32, i32* %72, i64 %idxprom129, !dbg !205
  %76 = load i32, i32* %arrayidx130, align 4, !dbg !205
  %add131 = add nsw i32 %add123, %76, !dbg !207
  %77 = load i32*, i32** %orig.addr, align 8, !dbg !208
  %78 = load i32, i32* %k, align 4, !dbg !209
  %79 = load i32, i32* %j, align 4, !dbg !209
  %sub132 = sub nsw i32 %79, 1, !dbg !209
  %80 = load i32, i32* %i, align 4, !dbg !209
  %mul133 = mul nsw i32 16, %80, !dbg !209
  %add134 = add nsw i32 %sub132, %mul133, !dbg !209
  %mul135 = mul nsw i32 8, %add134, !dbg !209
  %add136 = add nsw i32 %78, %mul135, !dbg !209
  %idxprom137 = sext i32 %add136 to i64, !dbg !208
  %arrayidx138 = getelementptr inbounds i32, i32* %77, i64 %idxprom137, !dbg !208
  %81 = load i32, i32* %arrayidx138, align 4, !dbg !208
  %add139 = add nsw i32 %add131, %81, !dbg !210
  %82 = load i32*, i32** %orig.addr, align 8, !dbg !211
  %83 = load i32, i32* %k, align 4, !dbg !212
  %add140 = add nsw i32 %83, 1, !dbg !212
  %84 = load i32, i32* %j, align 4, !dbg !212
  %85 = load i32, i32* %i, align 4, !dbg !212
  %mul141 = mul nsw i32 16, %85, !dbg !212
  %add142 = add nsw i32 %84, %mul141, !dbg !212
  %mul143 = mul nsw i32 8, %add142, !dbg !212
  %add144 = add nsw i32 %add140, %mul143, !dbg !212
  %idxprom145 = sext i32 %add144 to i64, !dbg !211
  %arrayidx146 = getelementptr inbounds i32, i32* %82, i64 %idxprom145, !dbg !211
  %86 = load i32, i32* %arrayidx146, align 4, !dbg !211
  %add147 = add nsw i32 %add139, %86, !dbg !213
  %87 = load i32*, i32** %orig.addr, align 8, !dbg !214
  %88 = load i32, i32* %k, align 4, !dbg !215
  %sub148 = sub nsw i32 %88, 1, !dbg !215
  %89 = load i32, i32* %j, align 4, !dbg !215
  %90 = load i32, i32* %i, align 4, !dbg !215
  %mul149 = mul nsw i32 16, %90, !dbg !215
  %add150 = add nsw i32 %89, %mul149, !dbg !215
  %mul151 = mul nsw i32 8, %add150, !dbg !215
  %add152 = add nsw i32 %sub148, %mul151, !dbg !215
  %idxprom153 = sext i32 %add152 to i64, !dbg !214
  %arrayidx154 = getelementptr inbounds i32, i32* %87, i64 %idxprom153, !dbg !214
  %91 = load i32, i32* %arrayidx154, align 4, !dbg !214
  %add155 = add nsw i32 %add147, %91, !dbg !216
  store i32 %add155, i32* %sum1, align 4, !dbg !217
  %92 = load i32, i32* %sum0, align 4, !dbg !218
  %93 = load i32*, i32** %C.addr, align 8, !dbg !219
  %arrayidx156 = getelementptr inbounds i32, i32* %93, i64 0, !dbg !219
  %94 = load i32, i32* %arrayidx156, align 4, !dbg !219
  %mul157 = mul nsw i32 %92, %94, !dbg !220
  store i32 %mul157, i32* %mul0, align 4, !dbg !221
  %95 = load i32, i32* %sum1, align 4, !dbg !222
  %96 = load i32*, i32** %C.addr, align 8, !dbg !223
  %arrayidx158 = getelementptr inbounds i32, i32* %96, i64 1, !dbg !223
  %97 = load i32, i32* %arrayidx158, align 4, !dbg !223
  %mul159 = mul nsw i32 %95, %97, !dbg !224
  store i32 %mul159, i32* %mul1, align 4, !dbg !225
  %98 = load i32, i32* %mul0, align 4, !dbg !226
  %99 = load i32, i32* %mul1, align 4, !dbg !227
  %add160 = add nsw i32 %98, %99, !dbg !228
  %100 = load i32*, i32** %sol.addr, align 8, !dbg !229
  %101 = load i32, i32* %k, align 4, !dbg !230
  %102 = load i32, i32* %j, align 4, !dbg !230
  %103 = load i32, i32* %i, align 4, !dbg !230
  %mul161 = mul nsw i32 16, %103, !dbg !230
  %add162 = add nsw i32 %102, %mul161, !dbg !230
  %mul163 = mul nsw i32 8, %add162, !dbg !230
  %add164 = add nsw i32 %101, %mul163, !dbg !230
  %idxprom165 = sext i32 %add164 to i64, !dbg !229
  %arrayidx166 = getelementptr inbounds i32, i32* %100, i64 %idxprom165, !dbg !229
  store i32 %add160, i32* %arrayidx166, align 4, !dbg !231
  br label %for.inc167, !dbg !232

for.inc167:                                       ; preds = %for.body103
  %104 = load i32, i32* %k, align 4, !dbg !233
  %inc168 = add nsw i32 %104, 1, !dbg !233
  store i32 %inc168, i32* %k, align 4, !dbg !233
  br label %for.cond101, !dbg !234, !llvm.loop !235

for.end169:                                       ; preds = %for.cond101
  br label %for.inc170, !dbg !237

for.inc170:                                       ; preds = %for.end169
  %105 = load i32, i32* %j, align 4, !dbg !238
  %inc171 = add nsw i32 %105, 1, !dbg !238
  store i32 %inc171, i32* %j, align 4, !dbg !238
  br label %for.cond98, !dbg !239, !llvm.loop !240

for.end172:                                       ; preds = %for.cond98
  br label %for.inc173, !dbg !242

for.inc173:                                       ; preds = %for.end172
  %106 = load i32, i32* %i, align 4, !dbg !243
  %inc174 = add nsw i32 %106, 1, !dbg !243
  store i32 %inc174, i32* %i, align 4, !dbg !243
  br label %for.cond95, !dbg !244, !llvm.loop !245

for.end175:                                       ; preds = %for.cond95
  ret void, !dbg !247
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
!1 = !DIFile(filename: "data/benchmarks/real/stencil3d/stencil.c", directory: "/home/gabriel/Documents/UFRGS/RAISE/AHLS/AHLS", checksumkind: CSK_MD5, checksum: "3988ebc2dcc1af9f56759ee7a3b413d1")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!10 = distinct !DISubprogram(name: "stencil3d", scope: !1, file: !1, line: 10, type: !11, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !19)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !13, !13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !15, line: 26, baseType: !16)
!15 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "", checksumkind: CSK_MD5, checksum: "55bcbdc3159515ebd91d351a70d505f4")
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !17, line: 41, baseType: !18)
!17 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "d108b5f93a74c50510d7d9bc0ab36df9")
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !{}
!20 = !DILocalVariable(name: "C", arg: 1, scope: !10, file: !1, line: 10, type: !13)
!21 = !DILocation(line: 10, column: 21, scope: !10)
!22 = !DILocalVariable(name: "orig", arg: 2, scope: !10, file: !1, line: 10, type: !13)
!23 = !DILocation(line: 10, column: 32, scope: !10)
!24 = !DILocalVariable(name: "sol", arg: 3, scope: !10, file: !1, line: 10, type: !13)
!25 = !DILocation(line: 10, column: 49, scope: !10)
!26 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 11, type: !18)
!27 = !DILocation(line: 11, column: 9, scope: !10)
!28 = !DILocalVariable(name: "j", scope: !10, file: !1, line: 11, type: !18)
!29 = !DILocation(line: 11, column: 12, scope: !10)
!30 = !DILocalVariable(name: "k", scope: !10, file: !1, line: 11, type: !18)
!31 = !DILocation(line: 11, column: 15, scope: !10)
!32 = !DILocalVariable(name: "sum0", scope: !10, file: !1, line: 12, type: !14)
!33 = !DILocation(line: 12, column: 10, scope: !10)
!34 = !DILocalVariable(name: "sum1", scope: !10, file: !1, line: 12, type: !14)
!35 = !DILocation(line: 12, column: 16, scope: !10)
!36 = !DILocalVariable(name: "mul0", scope: !10, file: !1, line: 12, type: !14)
!37 = !DILocation(line: 12, column: 22, scope: !10)
!38 = !DILocalVariable(name: "mul1", scope: !10, file: !1, line: 12, type: !14)
!39 = !DILocation(line: 12, column: 28, scope: !10)
!40 = !DILocation(line: 12, column: 5, scope: !10)
!41 = !DILabel(scope: !10, name: "height_bound_col", file: !1, line: 15)
!42 = !DILocation(line: 15, column: 5, scope: !10)
!43 = !DILocation(line: 15, column: 29, scope: !44)
!44 = distinct !DILexicalBlock(scope: !10, file: !1, line: 15, column: 24)
!45 = !DILocation(line: 15, column: 28, scope: !44)
!46 = !DILocation(line: 15, column: 33, scope: !47)
!47 = distinct !DILexicalBlock(scope: !44, file: !1, line: 15, column: 24)
!48 = !DILocation(line: 15, column: 34, scope: !47)
!49 = !DILocation(line: 15, column: 24, scope: !44)
!50 = !DILocation(line: 15, column: 50, scope: !47)
!51 = !DILabel(scope: !52, name: "height_bound_row", file: !1, line: 17)
!52 = distinct !DILexicalBlock(scope: !47, file: !1, line: 15, column: 50)
!53 = !DILocation(line: 17, column: 9, scope: !52)
!54 = !DILocation(line: 17, column: 33, scope: !55)
!55 = distinct !DILexicalBlock(scope: !52, file: !1, line: 17, column: 28)
!56 = !DILocation(line: 17, column: 32, scope: !55)
!57 = !DILocation(line: 17, column: 37, scope: !58)
!58 = distinct !DILexicalBlock(scope: !55, file: !1, line: 17, column: 28)
!59 = !DILocation(line: 17, column: 38, scope: !58)
!60 = !DILocation(line: 17, column: 28, scope: !55)
!61 = !DILocation(line: 19, column: 54, scope: !62)
!62 = distinct !DILexicalBlock(scope: !58, file: !1, line: 17, column: 54)
!63 = !DILocation(line: 19, column: 59, scope: !62)
!64 = !DILocation(line: 19, column: 13, scope: !62)
!65 = !DILocation(line: 19, column: 17, scope: !62)
!66 = !DILocation(line: 19, column: 52, scope: !62)
!67 = !DILocation(line: 20, column: 66, scope: !62)
!68 = !DILocation(line: 20, column: 71, scope: !62)
!69 = !DILocation(line: 20, column: 13, scope: !62)
!70 = !DILocation(line: 20, column: 17, scope: !62)
!71 = !DILocation(line: 20, column: 64, scope: !62)
!72 = !DILocation(line: 21, column: 9, scope: !62)
!73 = !DILocation(line: 17, column: 50, scope: !58)
!74 = !DILocation(line: 17, column: 28, scope: !58)
!75 = distinct !{!75, !60, !76, !77}
!76 = !DILocation(line: 21, column: 9, scope: !55)
!77 = !{!"llvm.loop.mustprogress"}
!78 = !DILocation(line: 22, column: 5, scope: !52)
!79 = !DILocation(line: 15, column: 46, scope: !47)
!80 = !DILocation(line: 15, column: 24, scope: !47)
!81 = distinct !{!81, !49, !82, !77}
!82 = !DILocation(line: 22, column: 5, scope: !44)
!83 = !DILabel(scope: !10, name: "col_bound_height", file: !1, line: 23)
!84 = !DILocation(line: 23, column: 5, scope: !10)
!85 = !DILocation(line: 23, column: 29, scope: !86)
!86 = distinct !DILexicalBlock(scope: !10, file: !1, line: 23, column: 24)
!87 = !DILocation(line: 23, column: 28, scope: !86)
!88 = !DILocation(line: 23, column: 33, scope: !89)
!89 = distinct !DILexicalBlock(scope: !86, file: !1, line: 23, column: 24)
!90 = !DILocation(line: 23, column: 34, scope: !89)
!91 = !DILocation(line: 23, column: 24, scope: !86)
!92 = !DILocation(line: 23, column: 55, scope: !89)
!93 = !DILabel(scope: !94, name: "col_bound_row", file: !1, line: 25)
!94 = distinct !DILexicalBlock(scope: !89, file: !1, line: 23, column: 55)
!95 = !DILocation(line: 25, column: 9, scope: !94)
!96 = !DILocation(line: 25, column: 30, scope: !97)
!97 = distinct !DILexicalBlock(scope: !94, file: !1, line: 25, column: 25)
!98 = !DILocation(line: 25, column: 29, scope: !97)
!99 = !DILocation(line: 25, column: 34, scope: !100)
!100 = distinct !DILexicalBlock(scope: !97, file: !1, line: 25, column: 25)
!101 = !DILocation(line: 25, column: 35, scope: !100)
!102 = !DILocation(line: 25, column: 25, scope: !97)
!103 = !DILocation(line: 27, column: 54, scope: !104)
!104 = distinct !DILexicalBlock(scope: !100, file: !1, line: 25, column: 51)
!105 = !DILocation(line: 27, column: 59, scope: !104)
!106 = !DILocation(line: 27, column: 13, scope: !104)
!107 = !DILocation(line: 27, column: 17, scope: !104)
!108 = !DILocation(line: 27, column: 52, scope: !104)
!109 = !DILocation(line: 28, column: 63, scope: !104)
!110 = !DILocation(line: 28, column: 68, scope: !104)
!111 = !DILocation(line: 28, column: 13, scope: !104)
!112 = !DILocation(line: 28, column: 17, scope: !104)
!113 = !DILocation(line: 28, column: 61, scope: !104)
!114 = !DILocation(line: 29, column: 9, scope: !104)
!115 = !DILocation(line: 25, column: 47, scope: !100)
!116 = !DILocation(line: 25, column: 25, scope: !100)
!117 = distinct !{!117, !102, !118, !77}
!118 = !DILocation(line: 29, column: 9, scope: !97)
!119 = !DILocation(line: 30, column: 5, scope: !94)
!120 = !DILocation(line: 23, column: 51, scope: !89)
!121 = !DILocation(line: 23, column: 24, scope: !89)
!122 = distinct !{!122, !91, !123, !77}
!123 = !DILocation(line: 30, column: 5, scope: !86)
!124 = !DILabel(scope: !10, name: "row_bound_height", file: !1, line: 31)
!125 = !DILocation(line: 31, column: 5, scope: !10)
!126 = !DILocation(line: 31, column: 29, scope: !127)
!127 = distinct !DILexicalBlock(scope: !10, file: !1, line: 31, column: 24)
!128 = !DILocation(line: 31, column: 28, scope: !127)
!129 = !DILocation(line: 31, column: 33, scope: !130)
!130 = distinct !DILexicalBlock(scope: !127, file: !1, line: 31, column: 24)
!131 = !DILocation(line: 31, column: 34, scope: !130)
!132 = !DILocation(line: 31, column: 24, scope: !127)
!133 = !DILocation(line: 31, column: 55, scope: !130)
!134 = !DILabel(scope: !135, name: "row_bound_col", file: !1, line: 33)
!135 = distinct !DILexicalBlock(scope: !130, file: !1, line: 31, column: 55)
!136 = !DILocation(line: 33, column: 9, scope: !135)
!137 = !DILocation(line: 33, column: 30, scope: !138)
!138 = distinct !DILexicalBlock(scope: !135, file: !1, line: 33, column: 25)
!139 = !DILocation(line: 33, column: 29, scope: !138)
!140 = !DILocation(line: 33, column: 34, scope: !141)
!141 = distinct !DILexicalBlock(scope: !138, file: !1, line: 33, column: 25)
!142 = !DILocation(line: 33, column: 35, scope: !141)
!143 = !DILocation(line: 33, column: 25, scope: !138)
!144 = !DILocation(line: 35, column: 54, scope: !145)
!145 = distinct !DILexicalBlock(scope: !141, file: !1, line: 33, column: 53)
!146 = !DILocation(line: 35, column: 59, scope: !145)
!147 = !DILocation(line: 35, column: 13, scope: !145)
!148 = !DILocation(line: 35, column: 17, scope: !145)
!149 = !DILocation(line: 35, column: 52, scope: !145)
!150 = !DILocation(line: 36, column: 63, scope: !145)
!151 = !DILocation(line: 36, column: 68, scope: !145)
!152 = !DILocation(line: 36, column: 13, scope: !145)
!153 = !DILocation(line: 36, column: 17, scope: !145)
!154 = !DILocation(line: 36, column: 61, scope: !145)
!155 = !DILocation(line: 37, column: 9, scope: !145)
!156 = !DILocation(line: 33, column: 49, scope: !141)
!157 = !DILocation(line: 33, column: 25, scope: !141)
!158 = distinct !{!158, !143, !159, !77}
!159 = !DILocation(line: 37, column: 9, scope: !138)
!160 = !DILocation(line: 38, column: 5, scope: !135)
!161 = !DILocation(line: 31, column: 51, scope: !130)
!162 = !DILocation(line: 31, column: 24, scope: !130)
!163 = distinct !{!163, !132, !164, !77}
!164 = !DILocation(line: 38, column: 5, scope: !127)
!165 = !DILabel(scope: !10, name: "loop_height", file: !1, line: 42)
!166 = !DILocation(line: 42, column: 5, scope: !10)
!167 = !DILocation(line: 42, column: 25, scope: !168)
!168 = distinct !DILexicalBlock(scope: !10, file: !1, line: 42, column: 19)
!169 = !DILocation(line: 42, column: 23, scope: !168)
!170 = !DILocation(line: 42, column: 30, scope: !171)
!171 = distinct !DILexicalBlock(scope: !168, file: !1, line: 42, column: 19)
!172 = !DILocation(line: 42, column: 32, scope: !171)
!173 = !DILocation(line: 42, column: 19, scope: !168)
!174 = !DILocation(line: 42, column: 55, scope: !171)
!175 = !DILabel(scope: !176, name: "loop_col", file: !1, line: 44)
!176 = distinct !DILexicalBlock(scope: !171, file: !1, line: 42, column: 55)
!177 = !DILocation(line: 44, column: 9, scope: !176)
!178 = !DILocation(line: 44, column: 26, scope: !179)
!179 = distinct !DILexicalBlock(scope: !176, file: !1, line: 44, column: 20)
!180 = !DILocation(line: 44, column: 24, scope: !179)
!181 = !DILocation(line: 44, column: 31, scope: !182)
!182 = distinct !DILexicalBlock(scope: !179, file: !1, line: 44, column: 20)
!183 = !DILocation(line: 44, column: 33, scope: !182)
!184 = !DILocation(line: 44, column: 20, scope: !179)
!185 = !DILocation(line: 44, column: 53, scope: !182)
!186 = !DILabel(scope: !187, name: "loop_row", file: !1, line: 46)
!187 = distinct !DILexicalBlock(scope: !182, file: !1, line: 44, column: 53)
!188 = !DILocation(line: 46, column: 13, scope: !187)
!189 = !DILocation(line: 46, column: 30, scope: !190)
!190 = distinct !DILexicalBlock(scope: !187, file: !1, line: 46, column: 24)
!191 = !DILocation(line: 46, column: 28, scope: !190)
!192 = !DILocation(line: 46, column: 35, scope: !193)
!193 = distinct !DILexicalBlock(scope: !190, file: !1, line: 46, column: 24)
!194 = !DILocation(line: 46, column: 37, scope: !193)
!195 = !DILocation(line: 46, column: 24, scope: !190)
!196 = !DILocation(line: 48, column: 24, scope: !197)
!197 = distinct !DILexicalBlock(scope: !193, file: !1, line: 46, column: 57)
!198 = !DILocation(line: 48, column: 29, scope: !197)
!199 = !DILocation(line: 48, column: 22, scope: !197)
!200 = !DILocation(line: 49, column: 24, scope: !197)
!201 = !DILocation(line: 49, column: 29, scope: !197)
!202 = !DILocation(line: 50, column: 24, scope: !197)
!203 = !DILocation(line: 50, column: 29, scope: !197)
!204 = !DILocation(line: 49, column: 68, scope: !197)
!205 = !DILocation(line: 51, column: 24, scope: !197)
!206 = !DILocation(line: 51, column: 29, scope: !197)
!207 = !DILocation(line: 50, column: 68, scope: !197)
!208 = !DILocation(line: 52, column: 24, scope: !197)
!209 = !DILocation(line: 52, column: 29, scope: !197)
!210 = !DILocation(line: 51, column: 68, scope: !197)
!211 = !DILocation(line: 53, column: 24, scope: !197)
!212 = !DILocation(line: 53, column: 29, scope: !197)
!213 = !DILocation(line: 52, column: 68, scope: !197)
!214 = !DILocation(line: 54, column: 24, scope: !197)
!215 = !DILocation(line: 54, column: 29, scope: !197)
!216 = !DILocation(line: 53, column: 68, scope: !197)
!217 = !DILocation(line: 49, column: 22, scope: !197)
!218 = !DILocation(line: 55, column: 24, scope: !197)
!219 = !DILocation(line: 55, column: 31, scope: !197)
!220 = !DILocation(line: 55, column: 29, scope: !197)
!221 = !DILocation(line: 55, column: 22, scope: !197)
!222 = !DILocation(line: 56, column: 24, scope: !197)
!223 = !DILocation(line: 56, column: 31, scope: !197)
!224 = !DILocation(line: 56, column: 29, scope: !197)
!225 = !DILocation(line: 56, column: 22, scope: !197)
!226 = !DILocation(line: 57, column: 58, scope: !197)
!227 = !DILocation(line: 57, column: 65, scope: !197)
!228 = !DILocation(line: 57, column: 63, scope: !197)
!229 = !DILocation(line: 57, column: 17, scope: !197)
!230 = !DILocation(line: 57, column: 21, scope: !197)
!231 = !DILocation(line: 57, column: 56, scope: !197)
!232 = !DILocation(line: 58, column: 13, scope: !197)
!233 = !DILocation(line: 46, column: 54, scope: !193)
!234 = !DILocation(line: 46, column: 24, scope: !193)
!235 = distinct !{!235, !195, !236, !77}
!236 = !DILocation(line: 58, column: 13, scope: !190)
!237 = !DILocation(line: 59, column: 9, scope: !187)
!238 = !DILocation(line: 44, column: 50, scope: !182)
!239 = !DILocation(line: 44, column: 20, scope: !182)
!240 = distinct !{!240, !184, !241, !77}
!241 = !DILocation(line: 59, column: 9, scope: !179)
!242 = !DILocation(line: 60, column: 5, scope: !176)
!243 = !DILocation(line: 42, column: 52, scope: !171)
!244 = !DILocation(line: 42, column: 19, scope: !171)
!245 = distinct !{!245, !173, !246, !77}
!246 = !DILocation(line: 60, column: 5, scope: !168)
!247 = !DILocation(line: 61, column: 1, scope: !10)
