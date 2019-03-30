# Bài 44. Cho 2 ma trận vuông A(n, n) và B(n, n):
#   Tính ma trận tổng C = A + B 
#   Tính ma trận tích D = A * B

# Ma trận tổng A + B
def tong(arr_a, arr_b):
    n = len(arr_a) # len(arr_a) = len(arr_b)
    arr_c = [[], []]
    for i in range(n):
        for j in range(n):
            arr_c[i].append(A[i][j] + B[i][j])

    return arr_c

# Ma trận tích A * B
def tich(arr_a, arr_b):
    n = len(arr_a) # len(arr_a) = len(arr_b)
    arr_c = [[], []]
    for i in range(n):
        for j in range(n):
            a = 0
            for k in range(n):
                a += ( A[i][k] * B[k][j] )
            arr_c[i].append(a)
    return arr_c   

if __name__ == "__main__":
    A = [[1, 2], [3, 5]]
    B = [[6, 5], [2, 4]]

    print('A + B = ' + str(tong(A, B)))
    print('A * B = ' + str(tich(A, B)))