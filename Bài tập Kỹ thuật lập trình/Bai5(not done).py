# Bài 5. Viết chương trình đổi các ký tự đầu của các chữ thành các chữ in, các ký tự còn lại thành chữ thường

string = 'kHa bAnH'
# Biến thành một mảng gồm các từ trong câu
string = string.split()

# Duyệt từng từ trong mảng vừa tách 
for word in string:
    # Duyệt từng ký tự trong từ (word)
    for char in word:
        # Nếu chỉ số của ký tự trong từ là 0 (chữ cái đầu tiên trong từ) thì chuyển thành chữ in hoa 
        # Ngược lại thì chuyển thành chữ thường
        if (word.index(char) == 0):
            print(word[word.index(char)].upper(), end = '')
        else:
            print(word[word.index(char)].lower(), end = '')