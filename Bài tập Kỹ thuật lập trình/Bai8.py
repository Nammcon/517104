# Bài 8. Viết chương trình tính giá trị tổng cộng của 1 sản phẩm có kể cả thuế, biết rằng tỷ suất thuê là 13.6% tính trên giá gốc
# Giá gốc của sản phẩm được đọc vào và cần in ra:
# Tiền thuế
# Giá đã có thuế

n = int(input('Nhập giá của sản phẩm: '))
tax = n * 13.6 / 100
print('Giá gốc của sản phẩm: {0}'.format(n))
print('Tiền thuế: {0}'.format(tax))
print('Giá đã gồm thuế: {0}'.format(n + tax ))