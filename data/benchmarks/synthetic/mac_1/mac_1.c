
#define N 64

void mac_1(double A[N][N], double B[N][N], double C[N][N], double A_out[N][N])
{
    int i, j;
    double buff_A[N][N];
    double buff_B[N][N];
    double buff_C[N][N];
    
    lprd_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
    	lprd_2: for(j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
    		buff_A[i][j] = A[i][j];
            buff_B[i][j] = B[i][j];
            buff_C[i][j] = C[i][j];
    	}
    }

    lp1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
	        buff_A[i][j] = buff_A[i][j] + buff_B[i][j] * buff_C[i][j];
        }
    }

    lpwr_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lpwr_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            A_out[i][j] = buff_A[i][j];
        }
    }
}
