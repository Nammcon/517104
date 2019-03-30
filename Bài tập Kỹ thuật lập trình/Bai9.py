# Bài 9. Viết chương trình giải hệ phương trình

# a = int(input('a: '))
# b = int(input('b: '))
# e = int(input('e: '))
# c = int(input('c: '))
# d = int(input('d: '))
# f = int(input('f: '))
# print('Hệ phương trình vừa nhập có dạng: ')
# print('{0}x + {1}y = {2}'.format(a, b, e))
# print('{0}x + {1}y = {2}'.format(c, d, f))
# detA = a*d - b*c
# if (detA == 0):
#     if (e == f):
#         print('Hệ phương trình có vô số nghiệm')
#     else:
#         print('Hệ vô nghiệm')
# else (detA != 0):
#     x = (e * d - b * f) / detA
#     y = (a * f - c * e) / detA
#     print('Hệ có nghiệm duy nhất x = {0} và y = {1}'.format(x, y))

# 1. Giải phương trình bậc nhất 2 ẩn:
#       a1*x + b1*y = c1
#       a2*x + b2*y = c2
def equation1():
    equation = [['a1', 'b1', 'c1'] , 
                ['a2', 'b2', 'c2']]
    matrix = [[ ] , [ ]]
    print('a1*x + b1*y = c1')
    print('a2*x + b2*y = c2')
    print('Nhập hệ phương trình: ')
    for i in range(2):
        for j in range(3):
            n = int(input('{0} = '.format(equation[i][j])))
            matrix[i].append(n)
    a1 = matrix[0][0]
    b1 = matrix[0][1]
    c1 = matrix[0][2]
    a2 = matrix[1][0]
    b2 = matrix[1][1]
    c2 = matrix[1][2]
    print('Hệ phương trình vừa nhập có dạng: ')
    print('{0}x + {1}y = {2}'.format(a1, b1, c1))
    print('{0}x + {1}y = {2}'.format(a2, b2, c2))

    detA = a1 * b2 - a2 * b1
    if (detA ==0):
        if (c1 == c2):
            print('Hệ phương trình có vô số nghiệm')
        else:
            print('Hệ vô nghiệm')
    else:
        dX = c1 * b2 - c2 * b1
        dY = a1 * c2 - a2 * c1
        x = dX / detA
        y = dY / detA
        print('Hệ có nghiệm duy nhất x = {0} và y = {1}'.format(x, y))


# 2.Giải hệ phương trình bậc nhất 3 ẩn
#   a1*x + b1*y + c1*z = d1
#   a2*x + b2*y + c2*z = d2
#   a3*x + b3*y + c3*z = d3

# Hàm tính định thức
def determinant(matrix):
    det1 = matrix[0][0]*matrix[1][1]*matrix[2][2] + matrix[0][1]*matrix[1][2]*matrix[2][0] + matrix[0][2]*matrix[1][0]*matrix[2][1]
    det2 = matrix[0][2]*matrix[1][1]*matrix[2][0] + matrix[0][1]*matrix[1][0]*matrix[2][2] + matrix[0][0]*matrix[1][2]*matrix[2][1]
    det = det1 - det2
    return det

def equation2():
    equation = [['a1', 'b1', 'c1', 'd1'], 
                ['a2', 'b2', 'c2', 'd2'],
                ['a3', 'b3', 'c3', 'd3']]
    #matrix =[ [1, 1, -2, 6],
    #          [2, 3, -7, 16], 
    #          [5, 2, 1, 16] ]
    matrix = [ [ ] , [ ], [ ] ]
    print('a1*x + b1*y + c1*z = d1')
    print('a2*x + b2*y + c2*z = d2')
    print('a3*x + b3*y + c3*z = d3')
    print('Nhập hệ phương trình: ')
    for i in range(3):
        for j in range(4):
            n = int(input('{0} = '.format(equation[i][j]) ) )
            matrix[i].append(n)
    a1 = matrix[0][0]
    b1 = matrix[0][1]
    c1 = matrix[0][2]
    d1 = matrix[0][3]
    a2 = matrix[1][0]
    b2 = matrix[1][1]
    c2 = matrix[1][2]
    d2 = matrix[1][3]
    a3 = matrix[2][0]
    b3 = matrix[2][1]
    c3 = matrix[2][2]
    d3 = matrix[2][3]
    print('Hệ phương trình vừa nhập có dạng: ')
    print('{0}x + {1}y +{2}z= {3}'.format(a1, b1, c1, d1))
    print('{0}x + {1}y +{2}z= {3}'.format(a2, b2, c2, d2))
    print('{0}x + {1}y +{2}z= {3}'.format(a3, b3, c3, d3))
    
    A = [[a1, b1, c1], [a2, b2, c2], [a3, b3, c3]]
    detA = determinant(A)
    if (detA != 0):
        Dx = [[d1, b1, c1], [d2, b2, c2], [d3, b3, c3]]
        detDx = determinant(Dx)
        x = detDx / detA
        Dy = [[a1, d1, c1], [a2, d2, c2], [a3, d3, c3]]
        detDy = determinant(Dy)
        y = detDy / detA
        Dz = [[a1, b1, d1], [a2, b2, d2], [a3, b3, d3]]
        detDz = determinant(Dz)    
        z = detDz / detA
        print('Hệ đã cho là hệ Cramer nên có nghiệm duy nhất: \nx = {0}, y = {1}, z = {2}'.format(x, y, z))
    else:
        print('Ahihi')

def main():
    print('1. Giải hệ phương trình bậc nhất 2 ẩn')
    print('2. Giải hệ phương trình bậc nhất 3 ẩn')
    choice = input("1 - 2: ")
    print()
    if (choice == '1'):
        equation1()
    elif (choice == '2'):
        equation2()

if __name__ == '__main__':
    main()