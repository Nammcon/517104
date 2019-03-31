#Bài 13. Cho số tự nhiên n. 
# Hãy liệt kê tất cả các cặp số p, 4p - 1 đều là số nguyên tố nhỏ hơn n. 
# Trong đó p cũng là số nguyên tố nhỏ hơn n

n = int(input('N = '))
print('Các cặp số nguyên tố p và 4p - 1 nhỏ hơn {}: '.format(n))

def isPrime(n):
    if (n < 2):
        return False
    else:
        for i in range(2, n):
            if (n % i == 0):
                return False
        return True

for i in range(n):
    if(isPrime(i)):
        j = 4 * i - 1
        if(isPrime(j) and j < n):
            print('{} : {}'.format(i, j))