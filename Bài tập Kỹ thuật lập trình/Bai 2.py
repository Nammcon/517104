file = open('Bai2.txt', 'r', encoding = 'Latin-1')

str = file.read()
# print(str)
# print()

list_word = []

for word in str.split():
    #Đổi toàn bộ thành chữ thường
    word = word.lower()
    # Nếu word là chữ (không gồm số và ký tự đặc biệt)
    if word.isalpha():
        list_word.append(word)
    #Nếu không chữ phải thì bỏ qua
    else:
        pass
print(list_word)

def countWord(arr, a):
    count = 0
    for i in range(len(arr)):
        if arr[i] == a:
            count += 1
    return count

a = input('Nhập từ cần tìm: ')
#charge - 6
print('Số lần xuất hiện của \'{0}\' trong file là: {1}'.format(a ,countWord(list_word, a)))