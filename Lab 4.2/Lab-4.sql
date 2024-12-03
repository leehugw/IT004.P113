--Nguyễn Lê Hưng
--23520567
--IT004.P113.2

-- 76. Liệt kê top 3 chuyên gia có nhiều kỹ năng nhất và số lượng kỹ năng của họ.
SELECT TOP 3 ChuyenGia.HoTen, COUNT(*) AS 'SoKyNang'
FROM ChuyenGia INNER JOIN ChuyenGia_KyNang 
    ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
GROUP BY ChuyenGia.HoTen
ORDER BY SoKyNang DESC;

-- 77. Tìm các cặp chuyên gia có cùng chuyên ngành và số năm kinh nghiệm chênh lệch không quá 2 năm.
SELECT	A.Hoten AS CG1,
		B.HoTen AS CG2,
		A.ChuyenNganh,
		A.NamKinhNghiem AS CG1KN,
		B.NamKinhNghiem AS CG2KN,
		ABS (A.NamKinhNghiem - B.NamKinhNghiem) AS ChenhLech
FROM ChuyenGia A INNER JOIN ChuyenGia B 
    ON A.ChuyenNganh = B.ChuyenNganh AND A.MaChuyenGia < B.MaChuyenGia
WHERE ABS (A.NamKinhNghiem - B.NamKinhNghiem) <= 2;

-- 78. Hiển thị tên công ty, số lượng dự án và tổng số năm kinh nghiệm của các chuyên gia tham gia dự án của công ty đó.
SELECT CongTy.TenCongTy, COUNT(DISTINCT DuAn.MaDuAn) AS 'SoDuAn',
	SUM(ChuyenGia.NamKinhNghiem) AS 'TongNamKinhNghiem'
FROM CongTy
INNER JOIN DuAn 
    ON CongTy.MaCongTy = DuAn.MaCongTy
INNER JOIN ChuyenGia_DuAn 
    ON DuAn.MaDuAn = ChuyenGia_DuAn.MaDuAn
INNER JOIN ChuyenGia 
    ON ChuyenGia.MaChuyenGia = ChuyenGia_DuAn.MaChuyenGia
GROUP BY CongTy.TenCongTy;

-- 79. Tìm các chuyên gia có ít nhất một kỹ năng cấp độ 5 nhưng không có kỹ năng nào dưới cấp độ 3.
SELECT ChuyenGia.HoTen
FROM ChuyenGia INNER JOIN ChuyenGia_KyNang 
    ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
WHERE CapDo = 5
AND NOT EXISTS (
    SELECT 1
    FROM ChuyenGia_KyNang
    WHERE ChuyenGia_KyNang.MaChuyenGia = ChuyenGia.MaChuyenGia
    AND CapDo < 3
);

-- 80. Liệt kê các chuyên gia và số lượng dự án họ tham gia, bao gồm cả những chuyên gia không tham gia dự án nào.
SELECT ChuyenGia.HoTen, COUNT(*) AS 'SoDuAn'
FROM ChuyenGia
LEFT JOIN ChuyenGia_DuAn
    ON ChuyenGia.MaChuyenGia = ChuyenGia_DuAn.MaChuyenGia
LEFT JOIN DuAn
    ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn
GROUP BY ChuyenGia.HoTen;

-- 81. Tìm chuyên gia có kỹ năng ở cấp độ cao nhất trong mỗi loại kỹ năng.

-- 82. Tính tỷ lệ phần trăm của mỗi chuyên ngành trong tổng số chuyên gia.
SELECT ChuyenNganh, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ChuyenGia) AS TiLePhanTram
FROM ChuyenGia
GROUP BY ChuyenNganh;

-- 83. Tìm các cặp kỹ năng thường xuất hiện cùng nhau nhất trong hồ sơ của các chuyên gia.
SELECT TOP 1 kn1.TenKyNang AS KyNang1, kn2.TenKyNang AS KyNang2, COUNT(*) AS SoLanXuatHien
FROM ChuyenGia_KyNang cgk1
INNER JOIN ChuyenGia_KyNang cgk2 
    ON cgk1.MaChuyenGia = cgk2.MaChuyenGia AND cgk1.MaKyNang < cgk2.MaKyNang
INNER JOIN KyNang kn1 
    ON cgk1.MaKyNang = kn1.MaKyNang
INNER JOIN KyNang kn2 
    ON cgk2.MaKyNang = kn2.MaKyNang
GROUP BY kn1.TenKyNang, kn2.TenKyNang
ORDER BY SoLanXuatHien DESC;

-- 84. Tính số ngày trung bình giữa ngày bắt đầu và ngày kết thúc của các dự án cho mỗi công ty.
SELECT ct.TenCongTy, AVG(DATEDIFF(day, da.NgayBatDau, da.NgayKetThuc)) AS SoNgayTrungBinh
FROM DuAn da
INNER JOIN CongTy ct 
    ON da.MaCongTy = ct.MaCongTy
GROUP BY ct.TenCongTy;

-- 85. Tìm chuyên gia có sự kết hợp độc đáo nhất của các kỹ năng (kỹ năng mà chỉ họ có).
SELECT cg.HoTen, kn.TenKyNang
FROM ChuyenGia_KyNang cgk
INNER JOIN ChuyenGia cg 
    ON cgk.MaChuyenGia = cg.MaChuyenGia
INNER JOIN KyNang kn 
    ON cgk.MaKyNang = kn.MaKyNang
WHERE cgk.MaKyNang IN (
    SELECT MaKyNang
    FROM ChuyenGia_KyNang
    GROUP BY MaKyNang
    HAVING COUNT(DISTINCT MaChuyenGia) = 1
);

-- 86. Tạo một bảng xếp hạng các chuyên gia dựa trên số lượng dự án và tổng cấp độ kỹ năng.
SELECT cg.HoTen, COUNT(DISTINCT cgda.MaDuAn) AS SoDuAn, SUM(CapDo) AS TongCapDo
FROM ChuyenGia cg
INNER JOIN ChuyenGia_DuAn cgda 
    ON cg.MaChuyenGia = cgda.MaChuyenGia
INNER JOIN ChuyenGia_KyNang cgkn 
    ON cg.MaChuyenGia = cgkn.MaChuyenGia
GROUP BY cg.HoTen
ORDER BY SoDuAn DESC, TongCapDo DESC;

-- 87. Tìm các dự án có sự tham gia của chuyên gia từ tất cả các chuyên ngành.
SELECT da.MaDuAn, da.TenDuAn
FROM DuAn da
INNER JOIN ChuyenGia_DuAn cgda 
    ON da.MaDuAn = cgda.MaDuAn
INNER JOIN ChuyenGia cg 
    ON cgda.MaChuyenGia = cg.MaChuyenGia
GROUP BY da.MaDuAn, da.TenDuAn
HAVING COUNT(DISTINCT cg.ChuyenNganh) = (SELECT COUNT(DISTINCT ChuyenNganh) FROM ChuyenGia);

-- 88. Tính tỷ lệ thành công của mỗi công ty dựa trên số dự án hoàn thành so với tổng số dự án.
SELECT TenCongTy,
    (SELECT COUNT(*) 
     FROM DuAn 
     WHERE TrangThai = N'Hoàn thành' AND MaCongTy = ct.MaCongTy) / 
    (SELECT COUNT(*) 
     FROM DuAn 
     WHERE MaCongTy = ct.MaCongTy) AS TyLeThanhCong
FROM CongTy ct;

-- 89. Tìm các chuyên gia có kỹ năng "bù trừ" nhau (một người giỏi kỹ năng A nhưng yếu kỹ năng B, người kia ngược lại).
