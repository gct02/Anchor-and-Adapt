
#define N 64

void xy(double x[N], double y[N], double A_out[N][N])
{
    int i, j;
    double buff_x[N];
    double buff_y[N];
    double buff_A_out[N][N];

    lprd_1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        buff_x[i] = x[i];
        buff_y[i] = y[i];
        lprd_2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A_out[i][j] = 0;
        }
    }

    lp1: for (i = 0; i < N; i++){
        #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
        lp2: for (j = 0; j < N; j++){
            #pragma HLS LOOP_TRIPCOUNT min=N max=N avg=N
            buff_A_out[i][j] = buff_A_out[i][j] + buff_x[i] * buff_y[j];
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