#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <omp.h>

double func(double x);

int main(void)
{
	int nThreads = 4;
	
	int i,N = 100000001;
	double xstart = 0,
		   xstop = 3,
		   h,
		   integral,
		   sum1=0,
		   sum2=0,
		   tstart,
		   tstop;
	double *arr;
	

	arr = malloc(N*sizeof(double));
	
	h = (xstop-xstart)/(N-1);
	
	tstart = omp_get_wtime();
	
	omp_set_num_threads(nThreads);
	#pragma omp parallel private(i) shared(arr,h,N,xstart) reduction(+:sum1,sum2) default(none)
	{
	
		#pragma omp for
		for(i=0;i<N;i++)
		{
			arr[i] = func(i*h + xstart);
		}
	
		#pragma omp for
		for(i=1;i<N-1;i++)
		{
			if(i%2!=0) sum1 = sum1+arr[i];
        	else sum2 = sum2+arr[i];
		}
	}
	
	integral = h*(arr[0]+arr[N-1]+4*sum1+2*sum2)/3;
	tstop = omp_get_wtime();
	printf("%.10lf\n",integral);
	printf("Wall clock time = %lf\n",tstop-tstart);
	
	free(arr);
	return 0;
}


double func(double x)
{
	return x*exp(2*x);
}
