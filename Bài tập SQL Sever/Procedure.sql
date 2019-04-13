CREATE DATABASE ThuTuc
GO
USE ThuTuc

-- 1. Tạo bảng Học sinh(Mã học sinh, họ tên, ngày sinh, nơi sinh, điểm đầu vào)
CREATE TABLE HocSinh(
	MaHS VARCHAR(10) PRIMARY KEY,
	HoTen NVARCHAR(50),
	NgaySinh DATETIME,
	NoiSinh NVARCHAR(50),
	DiemDauVao FLOAT	
)
INSERT INTO HocSinh VALUES('001', N'Nguyễn A', '1999/02/12', N'Hà Nội', 22)
INSERT INTO HocSinh VALUES('002', N'Nguyễn B', '1999/02/12', N'Hà Nội', 18)
INSERT INTO HocSinh VALUES('003', N'Nguyễn C', '1999/02/12', N'Hà Nội', 30)
INSERT INTO HocSinh VALUES('004', N'Nguyễn D', '1999/02/12', N'Hà Nội', 14)
GO
SELECT * FROM HocSinh

-- 2. Tạo thủ tục để nhập dữ liệu vào bảng trên
CREATE PROCEDURE ThemHocSinh(@mahs VARCHAR(10), @hoten NVARCHAR(50), @ngaysinh DATETIME, @noisinh NVARCHAR(50), @diem FLOAT)
AS
INSERT INTO HocSinh VALUES(@mahs, @hoten, @ngaysinh, @noisinh, @diem)

EXEC ThemHocSinh '005', N'Nguyễn E', '1999/12/13', N'Hà Nội', 26

-- 3. Viết thủ tục đưa ra thông tin về những học sinh có điểm đầu vào lớn hơn hoặc bằng số điểm đầu vào của người dùng đưa ra
CREATE PROCEDURE ThongTinHocSinh(@diem FLOAT)
AS
SELECT * FROM HocSinh
WHERE DiemDauVao >= @diem

EXEC ThongTinHocSinh 20

-- 4. Xóa những học sinh có điểm đầu vào nhỏ hơn điểm do người dùng đưa ra
CREATE PROCEDURE XoaHocSinh(@diem FLOAT)
AS
DELETE FROM HocSinh
WHERE DiemDauVao < @diem

EXEC XoaHocSinh 15

-- 5. Viết thủ tục sửa lại nơi sinh theo yêu cầu của người dùng cho học sinh có mã 003
CREATE PROCEDURE SuaNoiSinh003(@noisinh NVARCHAR(50))
AS
UPDATE HocSinh
SET NoiSinh = @noisinh
WHERE MaHS = '003'

EXEC SuaNoiSinh003 N'Hòa Bình'

-- 6. Viết thủ tục sửa lại nơi sinh theo yêu cầu của người dùng cho học sinh có mã theo yêu cầu của người dùng
CREATE PROCEDURE SuaNoiSinh(@mahs VARCHAR(10), @noisinh NVARCHAR(50))
AS
UPDATE HocSinh
SET NoiSinh = @noisinh
WHERE MaHS = @mahs

EXEC SuaNoiSinh '001', N'Hà Nội'

-- 7. Tìm ước chung lớn nhất của 2 số nhập vào
CREATE PROCEDURE UCLN(@a INT, @b INT)
AS
	IF @a = 0 or @b = 0
		RETURN @a + @b
	WHILE @a != @b
		BEGIN
			IF @a > @b
				SET @a = @a - @b
			ELSE
				SET @b = @b - @a
		END
	RETURN @a

DECLARE @ucln INT
EXEC @ucln = UCLN 42, 56
PRINT 'UCLN = ' + CAST(@ucln AS VARCHAR(10))

-- 8. Viết thủ tục đưa ra số ngày của tháng
CREATE PROCEDURE SoNgayTrongThang(@thang INT)
AS
	IF @thang IN (1, 3, 5, 7, 8, 10, 12)
		PRINT 'Tháng ' + CAST(@thang AS VARCHAR(5)) +  N' có 31 ngày'
	IF @thang IN (4, 6, 9, 11)
		PRINT 'Tháng ' + CAST(@thang AS VARCHAR(5)) +  N' có 30 ngày'
	IF @thang = 2
		PRINT 'Tháng ' + CAST(@thang AS VARCHAR(5)) +  N' có 29 ngày'

EXEC SoNgayTrongThang 3

-- Bonus
-- 1. Nhập vào 2 số đưa ra bội chung nhỏ nhất của 2 số đó
CREATE PROCEDURE BCNN(@a INT, @b INT)
AS
	DECLARE @bcnn INT
	DECLARE @max INT
	SET @max = @a
	IF @max < @b
		SET @max = @b
	DECLARE @i INT
	SET @i = @max
	WHILE @i <= (@a * @b)
		BEGIN
			IF @i % @a = 0 AND @i % @b = 0
			SET @bcnn = @i
			BREAK
		END
	RETURN @bcnn

DECLARE @bcnn1 INT
EXEC @bcnn1 = BCNN 5, 7
PRINT @bcnn1


-- 2. Viết thủ tục tính S = 2 + 4 + 6 + ... + n (nếu n chẵn)
--											+ n - 1 (nếu n lẻ)
CREATE PROCEDURE TinhTongS1(@n INT)
AS
	DECLARE @i INT
	DECLARE @s INT
	SET @i = 0
	SET @s = 0
	WHILE @i <= @n
		BEGIN
			SET @s = @s + @i
			SET @i = @i + 2
		END
	RETURN @s

DECLARE @S1 INT 
EXEC @S1 = TinhTongS1 7
PRINT @S1

-- 3. Viết thủ tục tính S = 1 + 3 + 5 + ... + n (nếu n chẵn)
--											+ n - 1 (nếu n lẻ)
CREATE PROCEDURE TinhTongS2(@n INT)
AS
	DECLARE @i INT
	DECLARE @s INT
	SET @i = 1
	SET @s = 0
	WHILE @i <= @n
		BEGIN
			SET @s = @s + @i
			SET @i = @i + 2
		END
	RETURN @s

DECLARE @S2 INT
EXEC @S2 = TinhTongS2 7
PRINT @S2

-- 4. Nhập vào số ngày công đã làm, tiền công. Tính lương, nếu số ngày công > 20 thì từ ngày 21 trở đi tiền công được tính hệ số 1.25
CREATE PROCEDURE TienCong(@ngayCong INT, @tienCong MONEY)
AS
	DECLARE @luong MONEY
	IF @ngayCong > 20
		SET @luong = @ngayCong * @tienCong * 1.25
	ELSE
		SET @luong = @ngayCong * @tienCong 
	PRINT N'Tiền lương = ' + CAST(@luong AS VARCHAR(50))

EXEC TienCong 40, 10000

-- 5. Viết chương trình tìm tất cả các số có 3 chữ số mà tổng các lập phương của những chữ số bằng chính số đó (Tìm các số dạng abc mà abc = a^3 + b^3 + c^3)
-- //Số tự mãn


-- 6. Viết thủ tục nhập vào 2 số ở dạng tử số và mẫu số sau đó đưa ra phân số tối giản


-- 7. Viết thủ tục tính giai thừa của n
CREATE PROCEDURE GiaiThua(@n INT)
AS
	DECLARE @i INT, @s INT
	SET @i = 1
	SET @s = 1
	WHILE @i <= @n
		BEGIN
			SET @s = @s * @i
			SET @i = @i + 1
		END
	PRINT '' + CAST(@n AS VARCHAR(10)) + '! = ' + CAST(@s AS VARCHAR(10))

EXEC GiaiThua 9

-- 8. Viết thủ tục đưa ra các ước của n 
CREATE PROCEDURE Uoc(@n INT)
AS
	DECLARE @i INT
	SET @i = 1
	WHILE @i <= @n
		BEGIN
			IF @n % @i = 0
				PRINT @i
			SET @i = @i + 1
		END

EXEC Uoc 12