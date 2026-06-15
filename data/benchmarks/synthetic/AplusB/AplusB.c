
#define N 64

// y = A+B
void AplusB(double A[N][N], double B[N][N], double C_out[N][N]) 
{
    int i, j;
    double buff_A[N][N];
    double buff_B[N][N]; 
    double buff_C_out[N][N];

    lprd_1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lprd_2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A[i][j] = A[i][j];
            buff_B[i][j] = B[i][j];
        }
    }

    lp1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_C_out[i][j] = buff_A[i][j] + buff_B[i][j];
        }
    }

    lpwr_1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lpwr_2: for (j = 0; j<N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
             C_out[i][j] = buff_C_out[i][j];
        }
    }
}