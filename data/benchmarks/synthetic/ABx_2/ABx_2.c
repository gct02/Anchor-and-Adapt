
#define N 64

// y = A(Bx)
void ABx_2(double A[N][N], double B[N][N] ,double x[N], double y_out[N]) 
{
    int i, j, k;
    double buff_A[N][N];
    double buff_B[N][N]; 
    double buff_x[N];
    double buff_y_out[N];
    double tmp1[N];

    lprd_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        buff_x[i] = x[i];
        buff_y_out[i] = 0;
        tmp1[i] = 0;
        lprd_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A[i][j] = A[i][j];
            buff_B[i][j] = B[i][j];
        }
    }

    lp1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            tmp1[i] = tmp1[i] + buff_B[i][j] * buff_x[j];
        }
    }

    lp3: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp4: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_y_out[i] = buff_y_out[i] + buff_A[i][j] * tmp1[j];
        } 
    }

    lpwr: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        y_out[i] = buff_y_out[i];
    }
}
