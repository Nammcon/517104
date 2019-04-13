CREATE DATABASE DB_Trigger
GO
USE DB_Trigger

CREATE TABLE Kho(
	MaHang VARCHAR(10) PRIMARY KEY,
	TenHang NVARCHAR(50),
	DonGia INT,
	SoLuong INT
)
INSERT INTO Kho VALUES('H001', 'Hàng 1', 5000, 100)
INSERT INTO Kho VALUES('H002', 'Hàng 2', 3000, 200)
INSERT INTO Kho VALUES('H003', 'Hàng 3', 8000, 800)
INSERT INTO Kho VALUES('H004', 'Hàng 4', 10000, 50)
INSERT INTO Kho VALUES('H005', 'Hàng 5', 15000, 30)
INSERT INTO Kho VALUES('H006', 'Hàng 6', 4000, 300)
INSERT INTO Kho VALUES('H007', 'Hàng 7', 30000, 20)
GO
SELECT * FROM Kho

CREATE TABLE Nhap(
	SoHieuCT VARCHAR(10) PRIMARY KEY,
	MaHang VARCHAR(10) FOREIGN KEY (MaHang) REFERENCES Kho (MaHang),
	SoLuong INT
)
INSERT INTO Nhap VALUES ('CT001', 'H007', 30)
INSERT INTO Nhap VALUES ('CT002', 'H007', -30)
GO
SELECT * FROM Nhap

CREATE TABLE Xuat(
	SoHieuCT VARCHAR(10) PRIMARY KEY,
	MaHang VARCHAR(10) FOREIGN KEY (MaHang) REFERENCES Kho (MaHang),
	SoLuong INT
)
INSERT INTO Xuat VALUES ('CT001', 'H007', 30)
INSERT INTO Xuat VALUES ('CT002', 'H007', 30)


-- 2. Viết trigger thực hiện tăng số lượng ở bảng kho nếu một mặt hàng nào đó được nhập
CREATE TRIGGER TangSoLuongHangHoa
ON Nhap
FOR INSERT
AS
UPDATE Kho
SET Kho.SoLuong = Kho.SoLuong + inserted.SoLuong
FROM Kho INNER JOIN inserted ON Kho.MaHang = inserted.MaHang

-- 3. Viết trigger thực hiện giảm số lượng ở bảng kho nếu một mặt hàng nào đó được xuất
ALTER TRIGGER GiamSoLuongHangHoa
ON Xuat
FOR INSERT
AS 
UPDATE Kho
SET Kho.SoLuong = Kho.SoLuong - inserted.SoLuong
FROM Kho INNER JOIN inserted ON Kho.MaHang = inserted.MaHang

-- 4. Nếu một mặt hàng nào đó sau khi được xuất và bị trả về (xóa dòng dữ liệu ở bảng xuất) thì số lượng ở bảng kho sẽ thay đổi như thế nào? Tăng hay giảm?
-- Viết trigger thực hiện việc đó
ALTER TRIGGER KiemTraNhap
ON Nhap
FOR INSERT
AS
IF (SELECT inserted.SoLuong FROM inserted) < 0
	BEGIN
		PRINT N'Không nhập được số lượng nhỏ hơn 0'
		ROLLBACK
	END

-- 5. Viết trigger không cho nhập dữ liệu vào bảng Nhập nếu số lượng < 0

-- 6. Nếu thực hiện sửa lại số lượng ở bảng Nhập (liên quan đến một dòng - 1 bản ghi) thì số lượng ở bảng kho thay đổi như thế nào?
-- Viết trigger thực hiện việc đó

-- 7. Nếu thực hiện sửa lại số lượng ở bảng Nhập (liên quan đến nhiều dòng) thì số lượng ở bảng Kho thay đổi như thế nào?
-- Viết trigger thực hiện việc đó