
#define N 64

// C = alpha * AB
void aAB(double alpha, double A[N][N], double B[N][N], double C_out[N][N])
{
    int i, j, k;

    double buff_A[N][N];
    double buff_B[N][N];
    double buff_C_out[N][N];

    lprd_1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lprd_2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A[i][j] = A[i][j];
            buff_B[i][j] = B[i][j];  
            buff_C_out[i][j] = 0;
        }
    }

    lp1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++) { 
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            lp3: for (k = 0; k < N; k++) {
                #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            	buff_C_out[i][j] += alpha * buff_A[i][k] * buff_B[k][j];
            }
        }
    }

    lpwr_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lpwr_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            C_out[i][j] = buff_C_out[i][j];
        }
    }
}
