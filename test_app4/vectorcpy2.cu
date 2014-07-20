#include<stdio.h>

__global__ void VecCpy(float* A,float *B,float* C,int N)
{
	int i=blockDim.x*blockIdx.x+threadIdx.x;
	float c=0;
	float a=A[i];
	float b=B[i];
	if(i+10<N){
		for(int p=0;p<100;p++)
			c+=a*b;
		for(int t=0;t<10;t++)
			C[i+t] = A[i+t];
		// C[i]=A[i];
		// C[i+1]=A[i+1];
		// C[i+2]=A[i+2];
		// C[i+3]=A[i+3];
		// C[i+4]=A[i+4];
		// C[i+5]=A[i+5];
		// C[i+6]=A[i+6];
		// C[i+7]=A[i+7];
		// C[i+8]=A[i+8];
		// C[i+9]=A[i+9];
		C[i]=c;
	}
}


void RandomInit(float* data, int n)
{
    for (int i = 0; i < n; ++i)
        data[i] = rand() / (float)RAND_MAX;
}

int main(){
	int N=32*20;
	size_t size=N*sizeof(float);

	float* h_A=(float*)malloc(size);
	float* h_B=(float*)malloc(size);
	float* h_C=(float*)malloc(size);
	
	RandomInit(h_A,N);
	RandomInit(h_B,N);

	float*d_A;
	cudaMalloc(&d_A,size);
	float*d_B;
	cudaMalloc(&d_B,size);
	float*d_C;
	cudaMalloc(&d_C,size);
	
	cudaMemcpy(d_A,h_A,size,cudaMemcpyHostToDevice);
	cudaMemcpy(d_B,h_B,size,cudaMemcpyHostToDevice);	
	int threadsPerBlock=32*20;
	int blocksPerGrid=(N+threadsPerBlock-1)/threadsPerBlock;
	VecCpy<<<blocksPerGrid, threadsPerBlock>>>(d_A,d_B,d_C,N);
	cudaMemcpy(h_C,d_C,size,cudaMemcpyDeviceToHost);

	for(int i=0; i<N; i++)
		printf("%f \n",h_C[i]);
	
	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);
	
	free(h_A);
	free(h_B);
	free(h_C);
	
}

