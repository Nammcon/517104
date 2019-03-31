#Bài 1. Viết chương trình nhập số thập lục phân in ra số nhị phân, cứ 4 số cách nhau một khoảng trắng

n = str(input('N = ')).upper()

for i in n:
    if i == 'A':
        i = 10
    elif i == 'B':
        i = 11
    elif i == 'C':
        i = 12
    elif i == 'D':
        i = 13
    elif i == 'E':
        i = 14
    elif i == 'F':
        i = 15
    else:
        print('Error')
        break
    for j in range(4):
        i = int(i)
        j = i % 2
        i = i // 2
        print(j, end = '')
    print(end = ' ')