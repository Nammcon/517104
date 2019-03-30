# Bài 54. Viết chương trình tính:

def choice():
    print('a. 1 + 2 + … + n') 
    print('b. 1 + 3 + 5 + … + 2n - 1')
    print('c. 2 + 4 + 6 + … + 2n')
    print('d. 12 + 22 + 32 + … + n2')
    print('e. 1/1 + ½ + ⅓ + … + 1/n')
    print('f. 2 + 4 + 8 + … + 2n')
    print('g. 1 + 1/22 + 1/32 + … + 1/n2')

# a. 1 + 2 + … + n
def a(n):
    s = 0
    for i in range (1, n + 1):
        print(i, end =' ')
        s += i
    return s

# b. 1 + 3 + 5 + … + 2n - 1
def b(n):
    s = 0
    for i in range (1, 2*n, 2): # số 2 là bước nhảy
        print(i, end = ' ')
        s += i
    return s
    
# c. 2 + 4 + 6 + … + 2n
def c(n):
    s = 0
    for i in range (2, 2*n + 1, 2):
        print(i, end = ' ')
        s += i
    return s

# d. 12 + 22 + 32 + … + n2
def d(n):
    s = 0
    for i in range(1, n + 1):
        j = (12 * i) - (2 * i - 2)
        print( j, end = ' ' )
        s += j
    return s

# e. 1/1 + 1/2 + 1/3 + … + 1/n
def e(n):
    s = 0    
    for i in range(1, n + 1):
        print(1 / i, end = ' ')
        s += 1 / i
    return s

# f. 2 + 4 + 8 + … + 2n
def f(n):
    s = 0 
    for i in range(1, n + 1):
        print(i * 2, end = ' ' )
        s += i * 2
    return s

# g. 1 + 1/22 + 1/32 + … + 1/n2
def g(n):
    s = 0 
    for i in range(1, n + 1):
        if (i == 1):
            j = 1
        else:
            j = (12 * i) - (2 * i - 2) 
        print(1 / j, end = ' ')
        s += 1 / j
    return s


def main():
    choice()
    choice_ip = str(input('\nEnter your choice (a - g): '))
    if choice_ip == 'a':
        print("You choose a. 1 + 2 + ... + n")
        n = int( input('Enter n: ') )
        S = a(n) 
    elif choice_ip == 'b':
        print("You choose b. 1 + 3 + ... + 2n - 1")
        n = int( input('Enter n: ') )    
        S = b(n)
    if choice_ip == 'c':
        print("You choose c. 2 + 4 + 6 + ... + 2n")
        n = int( input('Enter n: ') )
        S = c(n)
    if choice_ip == 'd':
        print("You choose d. 12 + 22 + 32 + ... + n2")
        n = int( input('Enter n: ') )
        S = d(n)
    if choice_ip == 'e':
        print("You choose e. 1/1 + 1/2 + 1/3 + ... + 1/n")
        n = int( input('Enter n: ') )
        S = e(n)
    if choice_ip == 'f':
        print("You choose f. 2 + 4 + 8 + ... + 2n")
        n = int( input('Enter n: ') )
        S = f(n)
    if choice_ip == 'g':
        print("You choose g. 1 + 1/22 + 1/32 + ... + 1/n2")
        n = int( input('Enter n: ') )
        S = g(n)   
    
    print()
    print('S = {}'.format(S))


if __name__ == "__main__":
    main()    