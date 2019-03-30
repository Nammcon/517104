# Bài 50. Một người bán rượu bán N chai rược có đơn giá là P. 
#     Nếu tổng số tiền vượt quá 50.000.000 thì việc phí chuyên chở là miễn phí, 
#     nếu không phí chuyên chở thường được tình bằng 1% tổng giá hàng. 
#     Viết chương trình nhập vào N, P. In ra các chi tiết Tổng giá trị hàng, tiền chuyên chở và tổng tiền phải trả

n = int(input('Nhập số chai rược đã bán: '))
p = int(input('Nhập đơn giá: '))
total = n * p
if (total < 50000000):
    ship = total * 1 / 100
else:
    ship = 0

print('Tổng giá trị hàng: {0}'.format(total))
print('Tiền chuyên chở: {0}'.format(ship))
print('Tổng tiền phải trả: {0}'.format(total + ship))