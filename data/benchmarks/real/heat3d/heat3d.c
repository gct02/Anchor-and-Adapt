/**
 * This version is stamped on May 10, 2016
 *
 * Contact:
 *   Louis-Noel Pouchet <pouchet.ohio-state.edu>
 *   Tomofumi Yuki <tomofumi.yuki.fr>
 *
 * Web address: http://polybench.sourceforge.net
 */
/* heat-3d.c: this file is part of PolyBench/C */

#include "heat3d.h"

/* Main computational kernel. */
void kernel_heat_3d(DATA_TYPE A[N][N][N], DATA_TYPE B[N][N][N])
{
    int t, i, j, k;

    outer_loop: for (t = 1; t <= TSTEPS; t++) {
        #pragma HLS LOOP_TRIPCOUNT min=TSTEPS avg=TSTEPS max=TSTEPS
        loop1: for (i = 1; i < N-1; i++) {
            #pragma HLS LOOP_TRIPCOUNT min=N-2 avg=N-2 max=N-2
            loop1_1: for (j = 1; j < N-1; j++) {
                #pragma HLS LOOP_TRIPCOUNT min=N-2 avg=N-2 max=N-2
                loop1_1_1: for (k = 1; k < N-1; k++) {
                    #pragma HLS LOOP_TRIPCOUNT min=N-2 avg=N-2 max=N-2
                    B[i][j][k] =   0.125 * (A[i+1][j][k] - 2.0 * A[i][j][k] + A[i-1][j][k])
                                 + 0.125 * (A[i][j+1][k] - 2.0 * A[i][j][k] + A[i][j-1][k])
                                 + 0.125 * (A[i][j][k+1] - 2.0 * A[i][j][k] + A[i][j][k-1])
                                 + A[i][j][k];
                }
            }
        }
        loop2: for (i = 1; i < N-1; i++) {
            #pragma HLS LOOP_TRIPCOUNT min=N-2 avg=N-2 max=N-2
            loop2_1: for (j = 1; j < N-1; j++) {
                #pragma HLS LOOP_TRIPCOUNT min=N-2 avg=N-2 max=N-2
                loop2_1_1: for (k = 1; k < N-1; k++) {
                    #pragma HLS LOOP_TRIPCOUNT min=N-2 avg=N-2 max=N-2
                    A[i][j][k] =   0.125 * (B[i+1][j][k] - 2.0 * B[i][j][k] + B[i-1][j][k])
                                 + 0.125 * (B[i][j+1][k] - 2.0 * B[i][j][k] + B[i][j-1][k])
                                 + 0.125 * (B[i][j][k+1] - 2.0 * B[i][j][k] + B[i][j][k-1])
                                 + B[i][j][k];
               }
           }
       }
    }
}
