# Bài 53. Viết chương trình nhập một ma trận số nguyên có kích thước MxN. In ra:
# Tổng các phần tử của ma trận
# Số các phần tử dương, phần tử âm, phần tử 0 của ma trận
# Phần tử lớn nhất, nhỏ nhất của ma trận
# Các phần tử trên đường chéo chính của ma trận (M = N)
# Tổng các phần tử trên đường chéo chính của ma trận (M = N)


def scan_matrix():
    n = 2
    matrix = [ [] , [] ]
    for i in range(2):
        for j in range(2):
            n = int(input('[{}][{}] = '.format(i, j)))
            matrix[i].append(n)
    return matrix

# Tổng các phần tử của ma trận
def sum_element(matrix):
    sum = 0
    n = len(matrix)
    for i in range(n):
        for j in range(n):
            sum += matrix[i][j]
    return sum

# Số các phần tử dương, phần tử âm và phần tử 0 của ma trận
def count_element():
    am = 0
    duong = 0
    khong = 0
    n = len(matrix)
    for i in range(n):
        for j in range(n):
            if (matrix[i][j] > 0):
                duong += 1
            elif (matrix[i][j] < 0):
                am += 1
            else:
                khong += 1
    print('Số phần tử dương của ma trận: ' + str(duong))
    print('Số phần tử âm của ma trận: ' + str(am))
    print('Số phần 0 của ma trận: ' + str(khong))

# Phần tử lớn nhất, phần tử nhỏ nhất của ma trận
def find_element(matrix):
    min_matrix = 999999
    max_matrix = -999999
    n = len(matrix)
    for i in range(n):
        for j in range(n):
            if (matrix[i][j] < min_matrix):
                min_matrix = matrix[i][j]
            if (matrix[i][j] > max_matrix):
                max_matrix = matrix[i][j]
    print('Phần tử nhỏ nhất của ma trận: ' + str(min_matrix))
    print('Phần tử lớn nhất của ma trận: ' + str(max_matrix))


# Các phần tử trên đường chéo chính của ma trận (M = N)
# Tổng các phần tử trên đường chéo chính của ma trận (M = N)
def main_diagonal(matrix):
    print('Các phần tử trên đường chéo chính của ma trận: ')
    sum = 0
    n = len(matrix)
    for i in range(n):
        for j in range(n):
            if (i == j):
                print(matrix[i][j], end = ' ')
                sum +=matrix[i][j]
    print('\nTổng các phần tử trên đường chéo chính của ma trận: ' + str(sum))

if __name__ == "__main__":
    matrix = scan_matrix()
    print(matrix)
    main_diagonal(matrix)