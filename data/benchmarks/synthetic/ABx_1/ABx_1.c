
#define N 64

// y = ABx
void ABx_1(double A[N][N], double B[N][N] ,double x[N], double y_out[N]) 
{
    int i, j,k;
    double buff_A[N][N];
    double buff_B[N][N]; 
    double buff_x[N];
    double buff_y_out[N];
    double tmp1[N][N];

    lprd_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        buff_x[i] = x[i];
        buff_y_out[i] = 0;
        lprd_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A[i][j] = A[i][j];
            buff_B[i][j] = B[i][j];
            tmp1[i][j] = 0;
        }
    }

    lp1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            lp3: for (k = 0; k < N; k++) {
                #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
	            tmp1[i][j] +=  buff_A[i][k] * buff_B[k][j];
            }
        }
    }

    lp4: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp5: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_y_out[i] = tmp1[i][j] * buff_x[j] + buff_y_out[i];
        } 
    }

    lpwr: for (i = 0; i < N; i++){
        y_out[i] = buff_y_out[i];
    }
}
