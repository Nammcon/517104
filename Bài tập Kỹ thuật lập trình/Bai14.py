# Bài 14. Một số tự nhiên là Palindrom nếu các chữ số của nó viết theo thứ tự ngược lại thì số tạo thành là chính số đó (VD: 4884, 393). 
# Hãy tìm: Tất cả các số tự nhiên nhỏ hơn 100 mà khi bình phương lên thì cho một Palindrom. 

import math

n = 100

# Hàm kiểm tra một chuỗi có đối xứng
def isPalindrom(n): # n là một chuỗi
    # Duyệt từ đầu đến len / 2
    for i in range(0, int(len(n) / 2), 1):
        # Nếu ký tự ở vị trí i khác len - i - 1 thì chuỗi đó không đối xứng
        if (n[i] != n[len(n) - i - 1]):
            return False
    return True

def main():
    # Tìm các số mà bình phương lên cho một Palindrom
    for i in range(n):
        # j = i^2
        j = pow(i, 2)
        # Ép kiểu j thành str để kiếm tra chuỗi j có đối xứng
        if(isPalindrom(str(j))):
            print(i, end = ' ')


if __name__ == "__main__":
    print('Các số tự nhiên nhỏ hơn {} mà bình phương lên cho một Palindrom: '.format(n))
    main()