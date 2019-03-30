#Bài 12. Cho các số tự nhiên n. Hãy liệt kê tất cả các số nguyên tố nhỏ hơn n

n = int(input('Enter n: '))

def isPrime(n):
    if (n < 2):
        return False
    else:
        for i in range (2, n):
            if (n % i == 0):
                return False
        return True

print('Các số nguyên tố nhỏ hơn {0}: '.format(n))
for i in range (1, n):
    if (isPrime(i)):
        print(i, end = ' ')      