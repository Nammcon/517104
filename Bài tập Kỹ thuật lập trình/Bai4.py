#Bài 4. Nhập họ tên, tách họ tên thành 2 phần họ và tên riêng

name = str(input('Nhập họ tên: '))
list_name = []

# Thêm các chữ trong họ tên vào một mảng
for word in name.split():
    if word.isalpha():
        list_name.append(word)

# Tên sẽ là chữ có vị trí cuối cùng trong mảng vừa tạo
print('Họ: ', end = '')
for i in range(len(list_name)):
    if i != len(list_name) - 1:
        print(list_name[i], end = ' ')
    else:
        print()
        print('Tên riêng: {}'.format(list_name[i]))