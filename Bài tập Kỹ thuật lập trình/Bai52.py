# Bài 52. Người ta muốn lập hóa đơn cho khách hàng của Công ty điện lực. 
#     Chỉ số đầu và chỉ số cuối sẽ được cho biết. 
#     Biết rằng biểu giá được tình tùy theo điện năng tiêu thụ
#     Nếu điện năng tiêu thụ nhỏ hơn 100Kwh thì giá mỗi Kwh là 1000đ
#     Nếu điện năng tiêu thự từ 100Kwh trở lên thì mỗi Kwh thừa ra sẽ được tính giá 2000đ
#     Phí khu vực là 5000đ cho mỗi khách hàng. Viết chương trình tính tiền phải trả tổng cộng gồm tiền điện và phí khu vực

n = int(input('Nhập số điện tiêu thụ: '))
fee = 5000

if (n < 100):
    total = 1000 * n
else:
    total = 100 * 1000 + (n - 100) * 2000

print('Tiền điện: ' + str(total))
print('Phí dịch vụ: ' + str(fee))