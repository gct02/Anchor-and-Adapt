
#define N 64

// D = ABC
void ABC(double A[N][N], double B[N][N], double C[N][N],double D_out[N][N]) 
{
    int i, j, k;

    double buff_A[N][N]; 
    double buff_B[N][N]; 
    double buff_C[N][N];
    double buff_D_out[N][N];
    double tmp[N][N];

    lprd_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lprd_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A[i][j] = A[i][j];
            buff_B[i][j] = B[i][j];
            buff_C[i][j] = C[i][j];
            tmp[i][j] = 0;
            buff_D_out[i][j] = 0;
        }
    }
    lp1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            lp3: for (k = 0; k < N; k++) {
                #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
	            tmp[i][j] +=  buff_A[i][k] * buff_B[k][j];
            }
        }
    }

    lp4: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp5: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            lp6: for (k = 0; k < N; k++) {
                #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
	            buff_D_out[i][j] += tmp[i][k] * buff_C[k][j];
            }
        }
    }

    lpwr_1: for (i = 0; i < N; i++) {
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lpwr_2: for (j = 0; j < N; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            D_out[i][j] = buff_D_out[i][j];
        }
    }
}