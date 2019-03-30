# Bài 49. Trong một kỳ thi cuối khóa, các học viên phải thi 4 môn: 
#     môn I hệ số 2, 
#     môn II hệ số 4, 
#     môn III hệ số 1, 
#     môn IV hệ số 2. 
#     Điểm các môn cho tối đa là 10 điểm. 
#     Viết chương trình nhập điểm của 4 môn và tính điểm trung bình

a = int(input('Nhập điểm môn I: '))
b = int(input('Nhập điểm môn II: '))
c = int(input('Nhập điểm môn III: '))
d = int(input('Nhập điểm môn IV: '))
dtb = ( (a * 2) + (b * 4) + (c * 1) + (d * 2) ) / 9

print('Điểm trung bình: {0}'.format(dtb))