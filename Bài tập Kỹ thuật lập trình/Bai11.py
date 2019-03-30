# Bài 11. Viết chương trình cho bài tập sau:
# Cho số tự nhiên n. Hãy tìm các Fibonacci nhỏ hơn n. 

n = int(input('Enter n: '))

def Fibonacci(n):
    if (n == 0):
        return 0
    elif (n == 1):
        return 1
    else:
        return Fibonacci(n - 2) + Fibonacci(n - 1)

print('Dãy Fibonacii nhỏ hơn {}: '.format(n))
for i in range(n):
    print(Fibonacci(i), end = ' ')
