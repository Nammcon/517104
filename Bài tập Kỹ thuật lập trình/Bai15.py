# Bài 15. Hãy liệt kê tất cả các số nguyên tố có 5 chữ số sao cho tổng số các chữ số trong số nguyên tố đó đúng bằng S cho trước  1<= S <= 45

# Hàm kiểm tra số nguyên tố
def isPrime(n):
    if (n < 2):
        return False
    else:
        for i in range(2, n):
            if (n % i == 0):
                return False
        return True

# Hàm tính tổng các chữ số trong một số
def sum_number(n): # n là str
    sum = 0
    for i in range(len(n)):
        # Cộng dồn các số trong chuỗi
        sum += int(n[i])
    return sum

# Tìm số nguyên tố trong khoảng [a, b]
# Mà tổng các chữ số trong số đó >= 1 và <= 45
def find_number(a, b):
    # Duyệt từ số một
    for number in range(a, b):
        # Ép kiểu về str để tính tổng các chữ số trong số đó
        number = str(number)
        sum = sum_number(number)
        # Nếu số đó là số nguyên tố
        # và tổng các chữ số trong khoảng theo yêu cầu thì xuất ra
        if (isPrime(int(number)) and sum >= 1 and sum <= 45):
            print('i:{} , sum:{}'.format(number, sum)) 

def main():
    find_number(10000, 99999)
    
if __name__ == "__main__":
    main()