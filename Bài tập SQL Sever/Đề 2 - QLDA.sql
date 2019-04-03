CREATE DATABASE QLDA
GO
USE QLDA 

CREATE TABLE NhanVien(
	MaNV VARCHAR(10) PRIMARY KEY,
	HoTen NVARCHAR(50),
	NgaySinh DATETIME,
	GioiTinh BIT,
	Luong MONEY,
	MaPhong VARCHAR(10) FOREIGN KEY (MaPhong) REFERENCES Phong (MaPhong)
)
INSERT INTO NhanVien VALUES('NV01', N'Trịnh Đình Chiến', '19941203', 1, 30000000, 'P001')
INSERT INTO NhanVien VALUES('NV02', N'Vũ Thị Thủy', '19941021', 0, 40000000, 'P002')
INSERT INTO NhanVien VALUES('NV03', N'Lê Quỳnh Anh', '19940702', 0, 100000000, 'P003')
INSERT INTO NhanVien VALUES('NV04', N'Lương Hùng Thanh', '19940403', 1, 60000000, 'P001')
INSERT INTO NhanVien VALUES('NV05', N'Nguyễn Văn Minh', '19991004', 1, 90000000, 'P004')
GO
SELECT * FROM NhanVien

CREATE TABLE Phong(
	MaPhong VARCHAR(10) PRIMARY KEY,
	TenPhong NVARCHAR(50)
)
INSERT INTO Phong VALUES('P001', N'Phòng 001')
INSERT INTO Phong VALUES('P002', N'Phòng 002')
INSERT INTO Phong VALUES('P003', N'Phòng tổng hợp')
INSERT INTO Phong VALUES('P004', N'Phòng 004')
GO
SELECT * FROM Phong

CREATE TABLE DuAn(
	MaDA VARCHAR(10) PRIMARY KEY,
	TenDA NVARCHAR(50),
	DiaDiem NVARCHAR(50)
) 
INSERT INTO DuAn VALUES('DA01', N'Dự án 1', N'Hà Nội')
INSERT INTO DuAn VALUES('DA02', N'Dự án 2', N'Hà Nội')
INSERT INTO DuAn VALUES('DA03', N'Dự án 3', N'Hà Nội')
INSERT INTO DuAn VALUES('DA04', N'Dự án 4', N'Hà Nội')
INSERT INTO DuAn VALUES('DA05', N'Dự án 5', N'Hà Nội')
GO
SELECT * FROM DuAn

CREATE TABLE NhanVienDuAn(
	Ma VARCHAR(10) PRIMARY KEY,
	MaNV VARCHAR(10) FOREIGN KEY (MaNV) REFERENCES NhanVien (MaNV),
	MaDA VARCHAR(10) FOREIGN KEY (MaDA) REFERENCES DuAn (MaDA),
	SoGioCong INT
)
INSERT INTO NhanVienDuAn VALUES('#001', 'NV01', 'DA01', 26)
INSERT INTO NhanVienDuAn VALUES('#002', 'NV01', 'DA02', 45)
INSERT INTO NhanVienDuAn VALUES('#003', 'NV02', 'DA03', 34)
INSERT INTO NhanVienDuAn VALUES('#004', 'NV02', 'DA04', 26)
INSERT INTO NhanVienDuAn VALUES('#005', 'NV03', 'DA05', 45)
INSERT INTO NhanVienDuAn VALUES('#006', 'NV04', 'DA01', 16)
INSERT INTO NhanVienDuAn VALUES('#007', 'NV05', 'DA02', 79)
INSERT INTO NhanVienDuAn VALUES('#008', 'NV05', 'DA03', 20)
GO
SELECT * FROM NhanVienDuAn

-- 3. Đưa ra mã phòng và số lượng nhân viên tương ứng
SELECT MaPhong, COUNT(MaNV)
FROM NhanVien
GROUP BY MaPhong

-- 4. Đưa ra họ tên nhân viên có mức lương cao nhất
SELECT HoTen
FROM NhanVien
WHERE Luong = (
	SELECT MAX(Luong) FROM NhanVien
)

-- 5. Đưa ra mã nhân viên, họ tên, giới tính, ngày sinh, tuổi, lương, tên dự án của những nhân viên có họ là Phùng là nhân viên nam có lương trong khoảng từ 7 triệu đến 12 triệu
SELECT NhanVien.MaNV, HoTen, GioiTinh, NgaySinh, YEAR(GETDATE()) - YEAR(NgaySinh) AS N'Tuổi', Luong, DuAn.TenDA
FROM NhanVien INNER JOIN NhanVienDuAn ON NhanVien.MaNV = NhanVienDuAn.MaNV INNER JOIN DuAn ON NhanVienDuAn.MaDA = DuAn.MaDA
WHERE NhanVien.HoTen LIKE N'Phùng%'
	  AND NhanVien.GioiTinh = 1
	  AND NhanVien.Luong BETWEEN 7000000 AND 12000000

-- 6. Đưa ra họ tên, tuổi, giới tính, mã phòng của những nhân viên thuộc phòng có tên là phòng tổng hợp và có tuổi nhỏ hơn 25 hoặc lớn hơn 50
SELECT HoTen, YEAR(GETDATE()) - YEAR(NgaySinh) AS N'Tuổi', GioiTinh, Phong.MaPhong
FROM NhanVien INNER JOIN Phong ON NhanVien.MaPhong = Phong.MaPhong
WHERE TenPhong = N'Phòng tổng hợp'
	  AND YEAR(GETDATE()) - YEAR(NgaySinh) <= 25
	  OR YEAR(GETDATE()) - YEAR(NgaySinh) > 50

-- 7. Viết lệnh sửa mã phòng là P002 và sửa lại lương tăng thêm 1 triệu cho nhân viên có họ tên là Trần Thanh Hằng và mức lương hiện tại đang nhỏ hơn 4tr
UPDATE NhanVien
SET Luong = Luong + 1000000
WHERE MaPhong = 'P002'
      AND HoTen = N'Trần Thanh Hằng'
	  AND Luong < 4000000

-- 8. Đưa ra Họ tên, giới tính, ngày sinh, lương, địa điểm dự án, số giờ công của những nhân viên sinh vào quý IV năm 1994 mà địa điểm của dự án nhân viên tham gia không thuộc Nam Định và số giờ công mà nhân viên từng tham gia vào dự án nằm trong khoảng 20 đến 35
SELECT HoTen, GioiTinh, NgaySinh, Luong, DuAn.DiaDiem, NhanVienDuAn.SoGioCong
FROM NhanVien INNER JOIN NhanVienDuAn ON NhanVien.MaNV = NhanVienDuAn.MaNV INNER JOIN DuAn ON NhanVienDuAn.MaDA = DuAn.MaDA
WHERE YEAR(NhanVien.NgaySinh) = 1994
	  AND MONTH(NhanVien.NgaySinh) IN (9, 10, 11, 12)
	  AND DuAn.DiaDiem != N'Nam Định'
	  AND NhanVienDuAn.SoGioCong BETWEEN 20 AND 35

-- 9. Viết thủ tục đưa ra họ tên nhân viên có lương nằm giữa 2 mức lương người dùng đưa ra
CREATE PROCEDURE printHoTen(@a INT, @b INT)
AS
SELECT HoTen, Luong
FROM NhanVien
WHERE Luong BETWEEN @a AND @b

EXEC printHoTen 10000000, 50000000