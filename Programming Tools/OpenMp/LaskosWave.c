#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <omp.h>

#define pi 3.14159265359

int main()
{

	int N = 200,
		M,
		i,
		j;
		
	double **u,
		   avgold,
		   avgnew,
		   dx,
		   dt,
		   accuracy = 1e-4,
		   a = sqrt(2/(pi*pi)),
		   c;
	
	// grid spacings
    dx = (12.0-0.0)/(N-1);
    dt = 0.5*dx/a;	  
	M = ((5.0*pi)/dt)+1;
	c = a*dt/dx;


	// allocate memory
	u = (double**) malloc(N*sizeof(double*));
	for (i = 0; i < N; i++)
		u[i] = (double*) malloc(M*sizeof(double));


	// initial conditions    
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
	
	for(i=0;i<M;i++)
	{
		u[0][i] = 0;
		u[N-1][i] = 0;
	}
	
	
	// numerical integrations
	j = 0;
	do
	{
		for(i=1;i<N-1;i++)
		{
			u[i][j+1] = u[i][j] - c*(u[i+1][j]-u[i-1][j])/2 + c*c*(u[i+1][j] - 2*u[i][j] + u[i-1][j])/2;
		}
		
		j++;
	}while(j<M-1);
		
		
    FILE * fp;
    // open file and set directory
    fp = fopen ("C:\\Users\\User\\Master\\ProgrammingTools\\OpenMp\\Set\\LaskosWave.txt","w");
    for(j=0;j<M;j++)
	{
		for(i=0;i<N;i++)
		{		
			fprintf(fp,"%f   %f   %f\n",i*dx,j*dt,u[i][j]);
			printf("%f   %f   %f\n",i*dx,j*dt,u[i][j]);
			
		}
	}
  	fclose (fp);
  	
  	
  	// free memory
  	for (i = 0; i < N; i++)
	{
        free(u[i]);
    }
  	free(u);
	
	return 0;
		
}
