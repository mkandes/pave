/* ======================================================================
 * hx1
 * ------------------------------------------------------------------- */

#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[]) {

/* declare integer-valued variables that will be utilized to store:
 * loop indicies i, j; matrix and vector dimension n */
   long long int i, j, n;

/* declare real-valued variables that will store sum of y results to
 * validate output from matrix-vector multiplication */
   double ysum, ysum_true;

/* declare real-valued arrays that will be utilized to store vectors
 * x, y and matrix A */
   double *x, *y; 
   double **A;

/* read in matrix and vector dimension n from command-line */
   if (argc == 2) {
      n = atoll(argv[1]);
   }
   else {
      printf("matvec-omp: ERROR :: Expecting only one command-line argument -- the matrix/vector dimension, n.\n");
   }

/* allocate memory for one- and two-dimensional arrays used to store 
 * vectors x, y and matrix A */
   x = (double *) malloc(n*sizeof(double));
   if (x == NULL) {
      printf("Unable to allocate the vector x. Out of memory.\n");
      exit(1);
   }
   y = (double *) malloc(n*sizeof(double));
   if (y == NULL) {
      printf("Unable to allocat the vector y. Out of memory.\n");
      exit(1);
   }
   A = (double **) malloc(n*sizeof(double *));
   for (i = 0; i < n; i++) {
      A[i] = (double *) malloc(n*sizeof(double));
   }

/* initialize the one-dimensional array x as an all-ones vector of 
 * dimension n */
   for (i = 0; i < n; i++) {
      x[i] = 1.0;
   }

/* initialize the one-dimensional array y as an all-zeros vector of 
 * dimension n */
   for (i = 0; i < n; i++) {
      y[i] = 0.0;
   }

/* initialize the two-dimensional array A as the Hilbert matrix of 
 * dimension n */
   for (i = 0; i < n; i++){
      for (j = 0; j < n; j++) {
         A[i][j]=  1.0 / (double)(i+j+1);
      }
   }

/* perform matrix-vector multiplication y = Ax */
   for (i = 0; i < n; i++) {
      for (j = 0; j < n; j++) {
         y[i] = y[i] + A[i][j] * x[i];
      }
   }

/* compute sum of y to check result of matrix-vector multiplication */
   ysum = 0.0;
   for (i = 0; i < n; i++) {
      ysum = ysum + y[i];
   }

/* write sum of y to standard output */
   printf("ysum = %f\n", ysum);

/* compute the analytic result for the sum of y to compare against 
 * the result computed from matrix-vector multiplication */
   ysum_true = (double)(n);
   for (i = 1; i <= n - 1; i++) {
      ysum_true = ysum_true + (double)(n-i) / (double)(n+i);
   }

/* write analytic result for the sum of y to standard output */
   printf("ysum_true = %f\n", ysum_true);

/* deallocate memory utilized for the one- and two-dimensional arrays 
 * used to store vectors x, y and matrix A */
   for (i = 0; i < n; i++) {
      free(A[i]);
      A[i] = NULL; 
   }
   free(A);
   A = NULL;
   free(y);
   y = NULL;
   free(x);
   x = NULL;

   return 0;
}
/* ================================================================== */
