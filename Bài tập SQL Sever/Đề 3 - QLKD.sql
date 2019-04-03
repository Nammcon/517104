CREATE DATABASE QLKD
GO
USE QLKD

CREATE TABLE KhachHang(
	MaKH VARCHAR(10) PRIMARY KEY,
	HoTen NVARCHAR(50),
	GioiTinh BIT,
	DiaChi NVARCHAR(50)
)
INSERT INTO KhachHang VALUES('KH001',  N'Trịnh Đình Chiến', 1, N'Hà Nội')
INSERT INTO KhachHang VALUES('KH002',  N'Vũ Thị Thủy', 0, N'Hà Nội')
INSERT INTO KhachHang VALUES('KH003',  N'Lê Quỳnh Anh', 0, N'Hà Nội')
INSERT INTO KhachHang VALUES('KH004',  N'Lương Hùng Thanh', 1, N'Hà Nội')
INSERT INTO KhachHang VALUES('KH005',  N'Nguyễn Văn Minh', 1, N'Hà Nội')
GO
SELECT * FROM KhachHang

CREATE TABLE HangHoa(
	MaHH VARCHAR(10) PRIMARY KEY,
	TenHH NVARCHAR(50),
	ChungLoai NVARCHAR(50),
	DonGia INT,
	SoLuong INT
)
INSERT INTO HangHoa VALUES('HH001', N'Hàng hóa 1', N'Loại 1', 5000, 10)
INSERT INTO HangHoa VALUES('HH002', N'Hàng hóa 2', N'Loại 1', 5000, 30)
INSERT INTO HangHoa VALUES('HH003', N'Hàng hóa 3', N'Loại 2', 6000, 20)
INSERT INTO HangHoa VALUES('HH004', N'Hàng hóa 4', N'Loại 3', 7000, 50)
INSERT INTO HangHoa VALUES('HH005', N'Hàng hóa 5', N'Loại 2', 6000, 20)
GO
SELECT * FROM HangHoa

CREATE TABLE ChungTu(
	Ma VARCHAR(10) PRIMARY KEY,
	SoHieuCT NVARCHAR(10),
	Ngay DATETIME,
	MaKH VARCHAR(10) FOREIGN KEY (MaKH) REFERENCES KhachHang (MaKH),
	MaHH VARCHAR(10) FOREIGN KEY (MaHH) REFERENCES HangHoa (MaHH),
	SoLuong INT
)
INSERT INTO ChungTu VALUES('#001', N'Số 1', '20140308', 'KH001', 'HH001', 2)
INSERT INTO ChungTu VALUES('#002', N'Số 2', '20140608', 'KH002', 'HH001', 3)
INSERT INTO ChungTu VALUES('#003', N'Số 3', '20140320', 'KH003', 'HH002', 5)
INSERT INTO ChungTu VALUES('#004', N'Số 4', '20140708', 'KH001', 'HH003', 2)
INSERT INTO ChungTu VALUES('#005', N'Số 5', '20140608', 'KH002', 'HH004', 10)
INSERT INTO ChungTu VALUES('#006', N'Số 6', '20141208', 'KH003', 'HH005', 9)
INSERT INTO ChungTu VALUES('#007', N'Số 7', '20140308', 'KH002', 'HH001', 1)
INSERT INTO ChungTu VALUES('#008', N'Số 8', '20140308', 'KH003', 'HH004', 3)
GO
SELECT * FROM ChungTu

-- 3. Đưa ra tên hàng hóa, mã khách hàng, tên khách hàng đã mua hàng trong quý I của năm 2014 và sắp xếp theo thứ tự giảm dần của số lượng
SELECT TenHH, KhachHang.MaKH, HoTen, ChungTu.SoLuong
FROM KhachHang INNER JOIN ChungTu ON KhachHang.MaKH = ChungTu.MaKH INNER JOIN HangHoa ON ChungTu.MaHH = HangHoa.MaHH
WHERE YEAR(ChungTu.Ngay) = 2014
	  AND MONTH(ChungTu.Ngay) IN (1, 2, 3, 4)
ORDER BY ChungTu.SoLuong DESC 

-- 4. Sửa lại đơn giá cho hàng hóa có mã HH002 để hàng hóa này có cùng đơn giá với hàng hóa có mã HH005
UPDATE HangHoa
SET DonGia = (
	SELECT DonGia FROM HangHoa WHERE MaHH = 'HH005'
)
WHERE MaHH = 'HH002'

-- 5. Đưa ra mã khách hàng, tên khách hàng, tên hàng, đơn giá, số lượng, thành tiền đã giảm đi 20% những hàng hóa mà khách nữ mua vào ngày 8 tháng 3
SELECT KhachHang.MaKH, KhachHang.HoTen, HangHoa.TenHH, HangHoa.DonGia, ChungTu.SoLuong, (HangHoa.DonGia * ChungTu.SoLuong - (HangHoa.DonGia * ChungTu.SoLuong) * 20 /100) AS N'Thành tiền'
FROM KhachHang INNER JOIN ChungTu ON KhachHang.MaKH = ChungTu.MaKH INNER JOIN HangHoa ON ChungTu.MaHH = HangHoa.MaHH
WHERE KhachHang.GioiTinh = 0
      AND DAY(ChungTu.Ngay) = 8
	  AND MONTH(ChungTu.Ngay) = 3

-- 6. Đưa ra tên hàng hóa, số lượng hàng hóa có giá nhỏ hơn 1000000đ và có tên bắt đầu bằng chữ máy, sắp xếp theo thứ tự giảm dần của giá
SELECT TenHH, SoLuong, DonGia
FROM HangHoa
WHERE DonGia < 1000000
	  AND TenHH LIKE N'máy%'
ORDER BY DonGia DESC

-- 7. Đưa ra đơn vị tính và tổng đơn giá tương ứng của đơn vị tính đó
SELECT ChungLoai, SUM(DonGia) AS N'Tổng đơn giá'
FROM HangHoa
GROUP BY ChungLoai

-- 8. Đưa ra tổng doanh thu của tháng 3 năm 2014
SELECT SUM(ChungTu.SoLuong * HangHoa.DonGia) AS 'Doanh thu tháng 3 năm 2014'
FROM ChungTu INNER JOIN HangHoa ON ChungTu.MaHH = HangHoa.MaHH
WHERE MONTH(ChungTu.Ngay) = 3
	  AND YEAR(ChungTu.Ngay) = 2014

-- 9. Viết thủ tục xóa hàng hóa có mức giá nằm giữa 2 mức giá người dùng đưa ra
 CREATE PROCEDURE xoaHangHoa(@a INT, @b INT)
 AS
 DELETE HangHoa
 WHERE DonGia BETWEEN @a AND @b

 EXEC xoaHangHoa 5000, 6000