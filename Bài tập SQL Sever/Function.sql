CREATE DATABASE DB_Function
GO
USE DB_Function

CREATE TABLE Phong(
	MaPhong VARCHAR(10) PRIMARY KEY,
	TenPhong NVARCHAR(50),
	DienThoai VARCHAR(15)
)
INSERT INTO Phong VALUES('P001', N'Phòng 1', '0123456789')
INSERT INTO Phong VALUES('P002', N'Phòng 2', '0123456789')
INSERT INTO Phong VALUES('P003', N'Phòng 3', '0123456789')
INSERT INTO Phong VALUES('P004', N'Phòng 4', '0123456789')
GO
SELECT * FROM Phong

CREATE TABLE NhanVien(
	MaNV VARCHAR(10) PRIMARY KEY,
	HoTen NVARCHAR(50),
	NgaySinh DATETIME,
	Luong INT,
	MaPhong VARCHAR(10) FOREIGN KEY (MaPhong) REFERENCES Phong (MaPhong)
)
INSERT INTO NhanVien VALUES('#001', 'A', '19990312', 5000000, 'P001')
INSERT INTO NhanVien VALUES('#002', 'B', '19990312', 5000000, 'P002')
INSERT INTO NhanVien VALUES('#003', 'C', '19990312', 5000000, 'P001')
INSERT INTO NhanVien VALUES('#004', 'D', '19990312', 5000000, 'P003')
INSERT INTO NhanVien VALUES('#005', 'E', '19990312', 5000000, 'P004')
GO
SELECT * FROM NhanVien

-- 5. Tạo khung nhìn - View đưa ra mã nhân viên, họ tên, tuổi, tên phòng của những nhân viên có tuổi nhỏ hơn 30 hoặc lớn hơn 40
CREATE VIEW TuoiNhanVien_View AS
SELECT NhanVien.MaNV, NhanVien.HoTen, YEAR(GETDATE()) - YEAR(NhanVien.NgaySinh) AS N'Tuổi', Phong.TenPhong
FROM NhanVien INNER JOIN Phong ON NhanVien.MaPhong = Phong.MaPhong
WHERE YEAR(GETDATE()) - YEAR(NhanVien.NgaySinh) < 30 OR YEAR(GETDATE()) - YEAR(NhanVien.NgaySinh) > 40

SELECT * FROM TuoiNhanVien_View

-- 6. Viết hàm đưa ra họ tên nhân viên có lương nằm giữa 2 mức lương người dùng đưa ra
CREATE FUNCTION LuongNhanVien(@a INT, @b INT)
RETURNS TABLE
AS
RETURN(
	SELECT * FROM NhanVien
	WHERE NhanVien.Luong BETWEEN @a AND @b
)

SELECT * FROM LuongNhanVien(100000, 6000000)

-- 7. Viết hàm Nếu người dùng nhập vào là tết dương lịch đưa ra họ tên nhân viên, lĩnh = 30% của lương 
--    Nếu người dùng nhập vào là tết âm lịch thì đưa ra họ tên nhân viên, lĩnh = 50%
--    Còn lại thì đưa ra họ tên nhân viên, lĩnh = 10% của lương (Viết hàm trả về biến bảng)
CREATE FUNCTION Promotion(@x NVARCHAR(50))
RETURNS @ketQua TABLE(
	MaNV VARCHAR(10),
	TenNV NVARCHAR(50),
	Luong INT
)
AS
BEGIN
	IF @x = N'Tết dương lịch'
	BEGIN
		INSERT INTO @ketQua
		SELECT NhanVien.MaNV, NhanVien.HoTen, NhanVien.Luong + NhanVien.Luong * 30 / 100
		FROM NhanVien
	END

	ELSE IF @x = N'Tết âm lịch'
	BEGIN
		INSERT INTO @ketQua
		SELECT NhanVien.MaNV, NhanVien.HoTen, NhanVien.Luong + NhanVien.Luong * 50 / 100
		FROM NhanVien
	END

	ELSE
	BEGIN
		INSERT INTO @ketQua
		SELECT NhanVien.MaNV, NhanVien.HoTen, NhanVien.Luong + NhanVien.Luong * 10 / 100
		FROM NhanVien
	END
	RETURN
END

SELECT * FROM Promotion(N'Tết dương lịch')
SELECT * FROM Promotion(N'Tết âm lịch')
SELECT * FROM Promotion(N'Ngày bình thường')

-- 8. Viết hàm kiểm tra một số có phải số hoàn hảo hay không
CREATE FUNCTION KiemTraSoHoanHao(@n INT)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @i INT
	DECLARE @tongUoc INT
	DECLARE @kq NVARCHAR(50)
	SET @i = 1
	SET @tongUoc = 0
	WHILE @i < @n
		BEGIN
			IF @n % @i = 0
			BEGIN
				SET @tongUoc = @tongUoc + @i
			END
			SET @i = @i + 1
		END
	IF @tongUoc = @n
		SELECT @kq = N'Là số hoàn hảo'
	ELSE
		SELECT @kq = N'Không là số hoàn hảo'
	RETURN @kq
END

DECLARE @k NVARCHAR(50)
EXEC @k = KiemTraSoHoanHao 5
SELECT @k

-- 9. Viếm hàm tìm ước chung lớn nhất của hai số
CREATE FUNCTION UCLN(@a INT, @b INT)
RETURNS INT
AS
BEGIN
	DECLARE @kq INT
	IF @a = 0 or @b = 0
		SET @kq = @a + @b
	WHILE @a != @b
		BEGIN
			IF @a > @b
				SET @a = @a - @b
			ELSE
				SET @b = @b - @a
		END
	SET @kq = @a
	RETURN @kq
END

DECLARE @x INT
EXEC @x = UCLN 42, 56
SELECT @x AS N'Ước chung lớn nhất'

-- Bonus
-- 1. Viết hàm tìm bội chung nhỏ nhất của 2 số

-- 2. Viết hàm đưa ra ngày của tháng x, năm y
CREATE FUNCTION TinhSoNgay(@month INT, @year INT)
RETURNS INT
AS 
BEGIN
	DECLARE @day INT
	IF @month IN (1, 3, 5, 7, 8, 10, 12)
		SET @day = 31
	ELSE IF @month IN (4, 6, 9, 11)
		SET @day = 30
	ELSE
		BEGIN
			IF (@year % 4 = 0)
				SET @day = 29
			ELSE
				SET @day = 28
		END
	RETURN @day
END

SELECT dbo.TinhSoNgay(3, 2014)

-- 3. Viết hàm tìm ra số lớn nhất trong 4 số nhập vào
CREATE FUNCTION KiemTraSoLonNhat(@a INT, @b INT, @c INT, @d INT)
RETURNS INT
AS
BEGIN
	DECLARE @max INT
	SET @max = @a
	IF @b > @max
		SET @max = @b
	IF @c > @max
		SET @max = @c
	IF @d > @max
		SET @max = @d
	RETURN @max
END

SELECT dbo.KiemTraSoLonNhat(12, 7496, 23, 46679)

-- 4. Viết hàm tính tiền điện cho khách hàng:
--	  Nếu sử dụng dưới 100 số đơn giá là 500đ
--	  Từ 100 số đến dưới 200 số giá là 1000đ
--	  Từ số thứ 200 trở nên giá là 2000đ

-- 5. Viết hàm tính cước điện thoại dưới 201 phút giá là 200đ/p
--	  Từ phút thứ 201 trở đi giá là 100đ/p
--	  Thuê bao cố định là 27000đ/tháng

-- 6. Viết hàm kiểm tra một số có phải số nguyên tố không
CREATE FUNCTION KiemTraSoNguyenTo(@a INT)
RETURNS BIT
AS
BEGIN
	DECLARE @kq BIT
	SET @kq = 0
	IF @a < 2
		SET @kq = 0
	ELSE
		DECLARE @i INT
		SET @i = 2
		WHILE @i < @a
			BEGIN
				IF @a % @i = 0
					BEGIN
						SET @kq = 0
						BREAK
					END
				SET @i = @i + 1
				SET @kq = 1
			END
	RETURN @kq
END

SELECT dbo.KiemTraSoNguyenTo(5)

-- 7. Viết thủ tục tìm các số nguyên tố nằm giữa 2 và n
CREATE PROCEDURE SoNguyenTo(@a INT, @b INT)
AS

-- 8. Viết thủ tục tìm các số hoàn hảo nằm giữa 2 và n
--	  + Viết bình thường
--	  + Trong thủ tục có gọi đến hàm kiểm tra một số có phải số hoàn hảo không
