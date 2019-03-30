# Bài 42. Cho một dãy n số thực A:
# Tìm phần tử nhỏ nhất của dãy số A
# Tìm phần tử lớn nhất của dãy số A
# Tính giá trị trung bình của dãy số A


A = [23, 65, 46, 3, 46, 64, 61, 74, 26, 95]

# Tìm phần tử nhỏ nhất 
minA = 9999
for i in range(len(A)):
    if (A[i] < minA):
        minA = A[i]
print('Min = ' + str(minA))

# Tìm phần tử lớn nhất
maxA = -9999
for i in range(len(A)):
    if (A[i] > maxA):
        maxA = A[i]
print('Max = ' + str(maxA))

# Tìm giá trị trung bình
avg = 0
for i in range(len(A)):
    avg += A[i]
print('Avg = ' + str(avg / len(A)))