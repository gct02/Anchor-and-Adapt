/*
Implementation based on algorithm described in:
"Stencil computation optimization and auto-tuning on state-of-the-art multicore architectures"
K. Datta, M. Murphy, V. Volkov, S. Williams, J. Carter, L. Oliker, D. Patterson, J. Shalf, K. Yelick
SC 2008
*/

#include "stencil.h"

void stencil3d(TYPE C[2], TYPE orig[SIZE], TYPE sol[SIZE]) {
    int i, j, k;
    TYPE sum0, sum1, mul0, mul1;

    // Handle boundary conditions by filling with original values
    height_bound_col : for(j=0; j<col_size; j++) {
        #pragma HLS LOOP_TRIPCOUNT min=16 max=16 avg=16
        height_bound_row : for(k=0; k<row_size; k++) {
            #pragma HLS LOOP_TRIPCOUNT min=8 max=8 avg=8
            sol[INDX(row_size, col_size, k, j, 0)] = orig[INDX(row_size, col_size, k, j, 0)];
            sol[INDX(row_size, col_size, k, j, height_size-1)] = orig[INDX(row_size, col_size, k, j, height_size-1)];
        }
    }
    col_bound_height : for(i=1; i<height_size-1; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=14 max=14 avg=14
        col_bound_row : for(k=0; k<row_size; k++) {
            #pragma HLS LOOP_TRIPCOUNT min=8 max=8 avg=8
            sol[INDX(row_size, col_size, k, 0, i)] = orig[INDX(row_size, col_size, k, 0, i)];
            sol[INDX(row_size, col_size, k, col_size-1, i)] = orig[INDX(row_size, col_size, k, col_size-1, i)];
        }
    }
    row_bound_height : for(i=1; i<height_size-1; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=14 max=14 avg=14
        row_bound_col : for(j=1; j<col_size-1; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=14 max=14 avg=14
            sol[INDX(row_size, col_size, 0, j, i)] = orig[INDX(row_size, col_size, 0, j, i)];
            sol[INDX(row_size, col_size, row_size-1, j, i)] = orig[INDX(row_size, col_size, row_size-1, j, i)];
        }
    }


    // Stencil computation
    loop_height : for(i = 1; i < height_size - 1; i++){
        #pragma HLS LOOP_TRIPCOUNT min=14 max=14 avg=14
        loop_col : for(j = 1; j < col_size - 1; j++){
            #pragma HLS LOOP_TRIPCOUNT min=14 max=14 avg=14
            loop_row : for(k = 1; k < row_size - 1; k++){
                #pragma HLS LOOP_TRIPCOUNT min=6 max=6 avg=6
                sum0 = orig[INDX(row_size, col_size, k, j, i)];
                sum1 = orig[INDX(row_size, col_size, k, j, i + 1)] +
                       orig[INDX(row_size, col_size, k, j, i - 1)] +
                       orig[INDX(row_size, col_size, k, j + 1, i)] +
                       orig[INDX(row_size, col_size, k, j - 1, i)] +
                       orig[INDX(row_size, col_size, k + 1, j, i)] +
                       orig[INDX(row_size, col_size, k - 1, j, i)];
                mul0 = sum0 * C[0];
                mul1 = sum1 * C[1];
                sol[INDX(row_size, col_size, k, j, i)] = mul0 + mul1;
            }
        }
    }
}