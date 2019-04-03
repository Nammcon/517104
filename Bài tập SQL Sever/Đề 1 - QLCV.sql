CREATE DATABASE QLCV
GO
USE QLCV

CREATE TABLE PhongBan(
	MaPhong VARCHAR(10) PRIMARY KEY,
	TenPhong NVARCHAR(50),
	DienThoai VARCHAR(15)
)
INSERT INTO PhongBan VALUES('P001', N'Phòng 1', '0123456789')
INSERT INTO PhongBan VALUES('P002', N'Phòng 2', '010111213')
INSERT INTO PhongBan VALUES('P003', N'Phòng 3', '1213141516')
INSERT INTO PhongBan VALUES('P004', N'Phòng 4', '9897969594')
INSERT INTO PhongBan VALUES('P005', N'Phòng 5', '102033040')
GO
SELECT * FROM PhongBan

CREATE TABLE NhanVien(
	MaNhanVien VARCHAR(10) PRIMARY KEY,
	HoTen NVARCHAR(50),
	GioiTinh BIT,
	NgaySinh DATETIME,
	MaPhong VARCHAR(10) FOREIGN KEY (MaPhong) REFERENCES PhongBan (MaPhong),
	Luong MONEY
)
INSERT INTO NhanVien VALUES('NV01', N'Trịnh Đình Chiến', 1, '19941203', 'P001', 30000000)
INSERT INTO NhanVien VALUES('NV02', N'Vũ Thị Thủy', 0, '19941021', 'P002', 40000000)
INSERT INTO NhanVien VALUES('NV03', N'Lê Quỳnh Anh', 0, '19940702', 'P003', 100000000)
INSERT INTO NhanVien VALUES('NV04', N'Lương Hùng Thanh', 1, '19940403', 'P001', 60000000)
INSERT INTO NhanVien VALUES('NV05', N'Nguyễn Văn Minh', 1, '19991004', 'P004', 90000000)
GO
SELECT * FROM NhanVien

CREATE TABLE CongVan(
	SoCV VARCHAR(10) PRIMARY KEY,
	Ngay DATETIME,
	MaNhanVien VARCHAR(10) FOREIGN KEY (MaNhanVien) REFERENCES NhanVien (MaNhanVien),
	NoiDung NVARCHAR(100)
)
INSERT INTO CongVan VALUES('CV001', '20180210', 'NV01', N'Công Văn 001')
INSERT INTO CongVan VALUES('CV002', '20180310', 'NV02', N'Công Văn 002')
INSERT INTO CongVan VALUES('CV003', '20141012', 'NV03', N'Công Văn 003')
INSERT INTO CongVan VALUES('CV004', '20140212', 'NV04', N'Công Văn 004')
INSERT INTO CongVan VALUES('CV005', '20140610', 'NV05', N'Công Văn 005')
INSERT INTO CongVan VALUES('CV006', '20150726', 'NV05', N'Công Văn 006')
INSERT INTO CongVan VALUES('CV007', '20140806', 'NV03', N'Công Văn 007')
INSERT INTO CongVan VALUES('CV008', '20141020', 'NV05', N'Công Văn 008')
INSERT INTO CongVan VALUES('CV009', '20190320', 'NV02', N'Công Văn liên quan đến học phí')
GO
SELECT * FROM CongVan 

-- 3. Đưa ra tên nhân viên có mức lương lớn hơn mức lương trung bình
SELECT HoTen, Luong
FROM NhanVien
WHERE Luong > (
	SELECT AVG(Luong) 
	FROM NhanVien
)

-- 4. Đưa ra tên người ký,  tuổi, số công văn, ngày của những công văn do phòng có tên Phòng 2 phát hành. Mà nhân viên ký sinh vào quý II
SELECT HoTen, YEAR(GETDATE()) - YEAR(NgaySinh)  AS N'Tuổi', SoCV, Ngay
FROM NhanVien INNER JOIN CongVan ON NhanVien.MaNhanVien = CongVan.MaNhanVien INNER JOIN PhongBan ON NhanVien.MaPhong = PhongBan.MaPhong
WHERE TenPhong = 'Phòng 2'
	  AND MONTH(NgaySinh) IN (4, 5, 6)

-- 5. Đưa ra tên phòng, số công văn, tên người ký của những công văn được phát hành vào tháng 10 năm 2014 do nhân viên nam ký
SELECT PhongBan.TenPhong, CongVan.SoCV, NhanVien.HoTen
FROM NhanVien INNER JOIN PhongBan ON NhanVien.MaPhong = PhongBan.MaPhong INNER JOIN CongVan ON NhanVien.MaNhanVien = CongVan.MaNhanVien
WHERE MONTH(Ngay) = 10
	  AND YEAR(Ngay) = 2014
	  AND NhanVien.GioiTinh = 1

-- 6. Đưa ra số công văn, họ tên nhân viên ký, tên phòng, ngày ký, nội dung những công văn có nội dung liên quan đến học phí và được ký trong vòng 30 ngày trở lại đây
SELECT CongVan.SoCV, NhanVien.HoTen, PhongBan.TenPhong, CongVan.Ngay, CongVan.NoiDung
FROM NhanVien INNER JOIN PhongBan ON NhanVien.MaPhong = PhongBan.MaPhong INNER JOIN CongVan ON NhanVien.MaNhanVien = CongVan.MaNhanVien
WHERE CongVan.NoiDung LIKE N'%học phí%'
	  AND DATEDIFF(DAY, CongVan.Ngay, GETDATE()) < 30

-- 7. Xóa những công văn do nhân viên có họ tên là Nguyễn Văn Minh ký
DELETE FROM CongVan
WHERE CongVan.MaNhanVien = (
	SELECT MaNhanVien
	FROM NhanVien
	WHERE HoTen = N'Nguyễn Văn Minh'
)

-- 8. Đưa ra mã phòng và tổng lương tương ứng
SELECT PhongBan.MaPhong, SUM(NhanVien.Luong) AS N'Tổng lương của phòng'
FROM PhongBan INNER JOIN NhanVien ON PhongBan.MaPhong = NhanVien.MaPhong
GROUP BY PhongBan.MaPhong

-- 9. Viết thủ tục sửa lại lương theo người dùng đưa ra cho nhân viên có mã theo người dùng đưa ra
CREATE PROCEDURE SuaLuong(@maNV VARCHAR(10), @luong MONEY)
AS
UPDATE NhanVien
SET Luong = @luong
WHERE MaNhanVien = @maNV

EXEC SuaLuong 'NV05', 0