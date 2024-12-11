#include <iostream>

extern "C" int CalcArrayRowColSum(const int *x, int nrows, int ncols, int *rowSums, int *colSums);      // x -> input array.
void printArrayResults(const int *x, int nrows, int ncols, int *rowSums, int *colSums);

int main(){
    const int nrows = 7, ncols = 5;
    int x[nrows][ncols];
    for(int i = 0x0; i < nrows; i++){
        for(int j = 0x0; j < ncols; j++){
            x[i][j] = i+j;
        }
    }

    int rowSums[nrows], colSums[ncols];

    CalcArrayRowColSum((const int *) x, nrows, ncols, rowSums, colSums);
    printArrayResults((const int *) x, nrows, ncols, rowSums, colSums);

    return 0x0;
}

void printArrayResults(const int *x, int nrows, int ncols, int *rowSums, int *colSums){
    for (int i = 0x0; i < nrows; i++){
        for(int j = 0x0; j < ncols; j++){
            printf("\tx[%d][%d] = %d", i, j ,x[i*ncols+j]);
        }
            printf("\trowSums[%d] = %d\n", i, rowSums[i]);
    }
    printf("\n");
    for(int i = 0x0; i < ncols; i++){
        printf("\tcolSums[%d] = %d", i, colSums[i]);
    }
}