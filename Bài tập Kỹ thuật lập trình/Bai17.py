#Bài 17. Cho số tự nhiên n. Hãy phân tích n thành tích các thừa số nguyên tố. VD: 12 = 2*2*3

n = int(input('Enter n (n > 1): '))
i = 2

print('{0} ='.format(n), end = ' ')
while (n != 1):
    if (n % i == 0):
        print(i, end = ' ')
        n /= i
    else:
        i += 1