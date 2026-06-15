
#define N 64

// y = aAx
void aAx(double alpha, double A[N][N] ,double x[N], double y_out[N]) 
{
    int i, j, k;
    double buff_A[N][N];
    double buff_x[N];
    double buff_y_out[N];

    lprd_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        buff_x[i] = x[i];
        buff_y_out[i] = 0;
        lprd_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A[i][j] = A[i][j];
        }
    }
    
    lp1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_y_out[i] = alpha * buff_A[i][j] * buff_x[j] + buff_y_out[i];
        }
    }

    lpwr: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        y_out[i] = buff_y_out[i];
    }
}
