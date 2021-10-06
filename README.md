# Matrix

The purpose of this project is to write a program that finds the transpose and the multiplication of a matrix with the inputs that we get from the user. In the beginning, the program will ask the user to enter the size (rows and columns) for the two Matrices.

The two matrices will have the elements :
- mat: 1,2,3,4,5,6,7,8,9,10,11,12 (first Matrix)
- MATA: 9,8,7,6,5,4,3,2,1,0 (second Matrix)

After entering the size, the program will compute the transpose of the second matrix and print it on the screen.

The transpose of a matrix is a new matrix that is obtained by changing the rows to columns and columns to the row. In other words, transpose of A[ ][ ] is obtained by changing A[ i ][ j ] to A[ j ][ i ]. 
After we print the Transpose of the second matrix, the program will multiply it with the first matrix. Then, the result is displayed on the screen.

Besides multiplying a matrix with a transposed matrix, the column number of the first matrix and the column number of the transposed matrix should be equal.
If  multiplication is not possible, an error message will display to the user.

- main() Invoke the matrix_transpose procedure to transpose a given matrix. Then multiply the transposed matrix with another given matrix using the matrix_multiply procedure. Finally, the program will print out the product matrix.

- Matrix_multiply (r1, c1, A, r2, c2, B, C) This procedure computes the product of two matrices A and B and stores the result in matrix C.

Matrix A has r1 rows and c1 columns and matrix B has r2 rows and c2 columns. Here A, B, and C are the memory addresses at which the matrices A, B, and C are stored. 
Assume that matrices are stored in memory in a row-major fashion. Matrix C will have r1 rows and c2 columns.

- num_columns1 is the number of columns in each row of M, whereas num_rows is the number of rows in each column of N and num_columns2 is the number of columns in N.
- If num_rows is not equal to num_columns1, this program should print an error message and exit. This procedure returns an integer (the inner product) to the calling procedure.
