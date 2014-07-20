#include<stdio.h>

__global__ void VecCpy(float* A,float* C,int N)
{
	int i=blockDim.x*blockIdx.x+threadIdx.x;
	if(i<N)
		C[i]=A[i];
}


void RandomInit(float* data, int n)
{
    for (int i = 0; i < n; ++i)
        data[i] = rand() / (float)RAND_MAX;
}

int main(){
	int N=38400;
	size_t size=N*sizeof(float);

	float* h_A=(float*)malloc(size);
	float* h_C=(float*)malloc(size);
	
	RandomInit(h_A,N);

	float*d_A;
	cudaMalloc(&d_A,size);
	float*d_C;
	cudaMalloc(&d_C,size);
	
	cudaMemcpy(d_A,h_A,size,cudaMemcpyHostToDevice);
	int threadsPerBlock=320;
	int blocksPerGrid=(N+threadsPerBlock-1)/threadsPerBlock;
	VecCpy<<<blocksPerGrid, threadsPerBlock>>>(d_A,d_C,N);
	cudaMemcpy(h_C,d_C,size,cudaMemcpyDeviceToHost);

	for(int i=0; i<N; i++)
		printf("%f \n",h_C[i]);
	
	cudaFree(d_A);
	cudaFree(d_C);
	
	free(h_A);
	free(h_C);
	
}

