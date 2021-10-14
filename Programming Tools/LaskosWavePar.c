#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <omp.h>



int main(void)
{

	// number of threads
	int nThreads = 4;
	
	// printing number of threads used
	printf("Number of Threads = %d\n",nThreads);
	
	// variable declaration
	int N = 20000,
		M,
		i,
		j;
		
	double **u,
		   dx,
		   dt,
		   pi = 3.14159265359,
		   a = sqrt(2/(pi*pi)),
		   c,
		   fTimeStart, 
           fTimeEnd;
	

	
	// grid spacings
    dx = (12.0-0.0)/(N-1);
    dt = 0.5*dx/a;	  
	M = ((5.0*pi)/dt)+1;
	c = a*dt/dx;
	
	
	// allocate memory	
	u = (double**) malloc(N*sizeof(double*));
	for (i = 0; i < N; i++)
		u[i] = (double*) malloc(M*sizeof(double));


	// starting the clock
    fTimeStart = omp_get_wtime();
	
	omp_set_num_threads(nThreads);
    #pragma omp parallel private(i) shared(j,c,dx,dt,u,N,M,pi) default(none) 
    {
    
 
		
		#pragma omp for
		for(i=0;i<N;i++)
		{
			if(i*dx<=4.0 && i*dx>=2.0)
			{
				u[i][0] = sin(pi*i*dx);
	
			}
			else
			{
				u[i][0] = 0;
			}
		}

		#pragma omp for
		for(i=0;i<M;i++)
		{
			u[0][i] = 0;
			u[N-1][i] = 0;
		}
	
	
		#pragma omp single
		j = 0;

		do
		{	
			#pragma omp for
			for(i=1;i<N-1;i++)
			{
				u[i][j+1] = u[i][j] - c*(u[i+1][j]-u[i-1][j])/2 + c*c*(u[i+1][j] - 2*u[i][j] + u[i-1][j])/2;
			}
		
			#pragma omp single
			j++;
		
		}while(j<M-1);
	}

	// record end time
  	fTimeEnd = omp_get_wtime();

	// print elapsed time
  	printf("wall clock time = %.20f\n", fTimeEnd - fTimeStart);
	

	// free memory
  	for (i = 0; i < N; i++)
	{
        free(u[i]);
    }
  	free(u);
	
	return 0;		
}
