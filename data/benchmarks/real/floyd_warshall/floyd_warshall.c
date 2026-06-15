/**
 * This version is stamped on May 10, 2016
 *
 * Contact:
 *   Louis-Noel Pouchet <pouchet.ohio-state.edu>
 *   Tomofumi Yuki <tomofumi.yuki.fr>
 *
 * Web address: http://polybench.sourceforge.net
 */

#include "floyd_warshall.h"

/* Main computational kernel. */
void kernel_floyd_warshall(DATA_TYPE path[N][N]) {
  int i, j, k;

  loop1: for (k = 0; k < N; k++) {
    #pragma HLS LOOP_TRIPCOUNT min=N avg=N max=N
    loop2: for(i = 0; i < N; i++) {
      #pragma HLS LOOP_TRIPCOUNT min=N avg=N max=N
      loop3: for (j = 0; j < N; j++) {
        #pragma HLS LOOP_TRIPCOUNT min=N avg=N max=N
        path[i][j] = path[i][j] < (path[i][k] + path[k][j]) ? path[i][j] : path[i][k] + path[k][j];
      }
    }
  }
}