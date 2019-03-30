#Bài 6. Viết chương trình kiểm tra 1 password là đúng hay sai (nhập tối đa 3 lần)

password = 'ahihi'
i = 1

while i <= 3:
    password_input = str(input('Enter your password: '))
    if (password_input == password):
        print('Correct password')
        break
    else:
        print('Incorrect password')
        print('You have {} times'.format(3 - i))
        print()
        i += 1