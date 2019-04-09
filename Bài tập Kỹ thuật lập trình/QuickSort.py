
def QuickSort(arr, left, right):
    if arr is None or len(arr) == 0:
        return
    
    if left >= right:
        return
    
    mid = int( (left + right) / 2 ) 
    pivot = arr[mid]
    i = left
    j = right

    while i <= j:
        while arr[i] < pivot:
            i += 1
        
        while arr[j] > pivot:
            j -= 1

        if i <= j:
            temp = arr[i]
            arr[i] = arr[j]
            arr[j] = temp
            i += 1
            j -= 1
        
    if left < j:
        QuickSort(arr, left, j)
    
    if right > i:
        QuickSort(arr, i, right)

arr = [1, 3, 6, 2]
left = 0
right = len(arr) - 1
QuickSort(arr, left, right)
print(arr)