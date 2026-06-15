
#define N 64

// A_out=aA
void aA(double alpha, double A[N][N], double A_out[N][N]) 
{
    int i, j, k;

    double buff_A[N][N]; 
    double buff_A_out[N][N];

    lprd_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lprd_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A[i][j] = A[i][j];
        }
    }

    lp1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A_out[i][j] = alpha * buff_A[i][j];
        }
    }

    lpwr_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lpwr_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            A_out[i][j] =  buff_A_out[i][j];
        }
    }
}