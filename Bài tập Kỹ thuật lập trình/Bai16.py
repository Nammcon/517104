# Bài 16. Một số được gọi là số Mersen nếu nó là số nguyên tố được biểu diễn dưới dạng 2^P - 1 
#     trong đó P cũng là một số nguyên tố. 
#     Cho số tự nhiên n, tìm tất cả các số Mersen nhỏ hơn n

import math

n = int(input("n = "))
print('Các số Mersen nhỏ hơn {} là: '.format(n))

# Hàm kiểm tra số nguyên tố
def isPrime(n):
    if n < 2:
        return False
    else:
        for i in range(2, n):
            if n % i == 0:
                return False
        return True

# Duyệt từ 0 đến n
for i in range(n):
    # Kiếm tra i có là số nguyên tố không
    if isPrime(i):
        # Mersen = 2^n - 1
        # -> Tìm n = log2(Mersen + 1)
        p = math.log2(i + 1)
        # Kiểm tra n là số nguyên và n là số nguyên tố
        if p == int(p) and isPrime(int(p)):
            # Mersen = 2^n - 1
           mersen = math.pow(2, p) - 1
           print("{0} = 2^{1} - 1".format(mersen, p))
