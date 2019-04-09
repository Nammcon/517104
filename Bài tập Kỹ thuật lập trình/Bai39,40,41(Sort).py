# Bài 39. Cài đặt giải thuật Bubble Sort trên file
# Bài 40. Cài đặt giải thuật Insertion Sort trên file
# Bài 41. Cài đặt giải thuật Selection Sort trên file

def BubbleSort(arr):
    n = len(arr)
    # i chỉ chạy đến n - 1 vì bên dưới có j + 1
    for i in range(0, n - 1):
        for j in range(0, n - i - 1):
            if (arr[j] > arr[j + 1]):
                arr[j], arr[j + 1] = arr[j + 1], arr[j]

def InsertionSort(arr):
    n = len(arr)
    for i in range(1, n):
        key = arr[i]
        j = i - 1
        while (j >= 0 and key < arr[j]):
            arr[j + 1] = arr[j]
            j -= 1
        arr[j + 1] = key

def SelectionSort(arr):
    #n: Độ dài của mảng arr
    n = len(arr)
    #Duyệt từ đầu đến cuối mảng 
    for i in range(n):
        #Gán giá trị của i cho min_arr
        min_arr = i
        #Duyệt từ vị trí i + 1 đến cuối mảng
        for j in range (i + 1, n):
            #Nếu giá trị ở vị trí j nhỏ hơn giá trị ở vị trí min_arr
            #thì gán giá trị của j cho min_arr
            if (arr[j] < arr[min_arr]):
                min_arr = j
        #Swap (Đổi chỗ ví trị của i cho min_arr)
        # s1, s2 = s2, s1
        arr[i], arr[min_arr] = arr[min_arr], arr[i]

def main():
    arr = [1, 634, 13, 46, 79, 13]
    
    # n = int(input('Số phần tử trong mảng: '))
    # for i in range(0, n):
    #     data = int(input('a[{0}] = '.format(i)))
    #     arr.append(data)
    print('Mảng vừa nhập: {0}'.format(arr))

    print('1. Bubble Sort')
    print('2. Insertion Sort')
    print('3. Selection Sort')
    print('4. Exit')

    while True:
        choice = int(input('Hi: '))
        if choice == 1:
            BubbleSort(arr)
            print('Bubble Sort: {0}'.format(arr))
            break
        elif choice == 2:
            InsertionSort(arr)
            print('Insertion Sort: {0}'.format(arr))
            break
        elif choice == 3:
            SelectionSort(arr)
            print('Selection Sort: {0}'.format(arr))
            break
        elif choice == 4:
            break
        else:
            print('Nhập lại: ')
            continue


if __name__ == "__main__":
    main()