--Nguyễn Lê Hưng
--23520567
--IT004.P113.2

--Lab 3.2 - Homework

-- 1. Hiển thị tên và cấp độ của tất cả các kỹ năng của chuyên gia có MaChuyenGia là 1, 
--đồng thời lọc ra những kỹ năng có cấp độ thấp hơn 3.
SELECT KyNang.TenKyNang, ChuyenGia_KyNang.CapDo
FROM ChuyenGia_KyNang INNER JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
WHERE ChuyenGia_KyNang.MaChuyenGia = 1
HAVING ChuyenGia_KyNang.CapDo < 3;

-- 2. Liệt kê tên các chuyên gia tham gia dự án có MaDuAn là 2 và có ít nhất 2 kỹ năng khác nhau.
SELECT CG.HoTen 
FROM ChuyenGia_DuAn CGDA INNER JOIN ChuyenGia CG ON CGDA.MaChuyenGia = CG.MaChuyenGia 
						 INNER JOIN ChuyenGia_KyNang CGKN ON CG.MaChuyenGia = CGKN.MaChuyenGia
WHERE CGDA.MaDuAn = 2
GROUP BY CG.HoTen
HAVING COUNT(DISTINCT CGKN.MaKyNang) > 1;

-- 3. Hiển thị tên công ty và tên dự án của tất cả các dự án, 
--sắp xếp theo tên công ty và số lượng chuyên gia tham gia dự án.
SELECT CT.TenCongTy, DA.TenDuAn, COUNT (CGDA.MaChuyenGia) AS SoLuongChuyenGia
FROM DuAn DA INNER JOIN CongTy CT ON DA.MaCongTy = CT.MaCongTy
			 LEFT JOIN ChuyenGia_DuAn CGDA ON DA.MaDuAn = CGDA.MaDuAn
GROUP BY CT.TenCongTy, DA.TenDuAn
ORDER BY CT.TenCongTy, SoLuongChuyenGia DESC;

-- 4. Đếm số lượng chuyên gia trong mỗi chuyên ngành và hiển thị chỉ những chuyên ngành có hơn 5 chuyên gia.
SELECT ChuyenNganh, COUNT(MaChuyenGia) AS SoLuongChuyenGia 
FROM ChuyenGia 
GROUP BY ChuyenNganh 
HAVING COUNT(MaChuyenGia) > 5;

--5. Tìm chuyên gia có số năm kinh nghiệm cao nhất và hiển thị cả danh sách kỹ năng của họ.
WITH MaxExperience AS 
(
    SELECT MAX(NamKinhNghiem) AS MaxKinhNghiem
    FROM ChuyenGia
)
SELECT ChuyenGia.HoTen, ChuyenGia.NamKinhNghiem, KyNang.TenKyNang, ChuyenGia_KyNang.CapDo
FROM ChuyenGia INNER JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
			   INNER JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
WHERE ChuyenGia.NamKinhNghiem = (SELECT MaxKinhNghiem FROM MaxExperience)
ORDER BY ChuyenGia.HoTen;

-- 6. Liệt kê tên các chuyên gia và số lượng dự án họ tham gia, đồng thời tính toán tỷ lệ phần trăm so với tổng số dự án trong hệ thống.
SELECT CG.HoTen, COUNT(CGD.MaDuAn) AS SoLuongDuAn,
       (COUNT(CGD.MaDuAn) * 100.0 / (SELECT COUNT(DISTINCT MaDuAn) FROM DuAn)) AS TyLePhanTram
FROM ChuyenGia CG LEFT JOIN ChuyenGia_DuAn CGD ON CG.MaChuyenGia = CGD.MaChuyenGia 
GROUP BY CG.HoTen;

--7. Hiển thị tên công ty và số lượng dự án của mỗi công ty, bao gồm cả những công ty không có dự án nào.
SELECT CT.TenCongTy, COUNT(DA.MaDuAn) AS SoLuongDuAn 
FROM CongTy CT LEFT JOIN DuAn DA ON CT.MaCongTy = DA.MaCongTy 
GROUP BY CT.TenCongTy;

-- 8. Tìm kỹ năng được sở hữu bởi nhiều chuyên gia nhất, đồng thời hiển thị số lượng chuyên gia sở hữu kỹ năng đó.
SELECT TOP 1 K.TenKyNang, COUNT(CGK.MaChuyenGia) AS SoLuongChuyenGia
FROM KyNang K INNER JOIN ChuyenGia_KyNang CGK ON K.MaKyNang = CGK.MaKyNang
GROUP BY K.TenKyNang
ORDER BY SoLuongChuyenGia DESC;

-- 9. Liệt kê tên các chuyên gia có kỹ năng 'Python' với cấp độ từ 4 trở lên, đồng thời tìm kiếm những người cũng có kỹ năng 'Java'.
SELECT CG.HoTen 
FROM ChuyenGia CG INNER JOIN ChuyenGia_KyNang CGK ON CG.MaChuyenGia = CGK.MaChuyenGia
				  INNER JOIN KyNang K ON CGK.MaKyNang = K.MaKyNang
WHERE K.TenKyNang = N'Python' 
	AND CGK.CapDo >= 4
    AND CG.MaChuyenGia IN 
	(
		SELECT MaChuyenGia 
		FROM ChuyenGia_KyNang INNER JOIN KyNang K2 ON ChuyenGia_KyNang.MaKyNang = K2.MaKyNang
		WHERE K2.TenKyNang = N'Java'
    );

--10. Tìm dự án có nhiều chuyên gia tham gia nhất và hiển thị danh sách tên các chuyên gia tham gia vào dự án đó.
SELECT CG.HoTen
FROM ChuyenGia CG INNER JOIN ChuyenGia_DuAn CGD ON CG.MaChuyenGia = CGD.MaChuyenGia
				  INNER JOIN DuAn DA ON CGD.MaDuAn = DA.MaDuAn
WHERE DA.MaDuAn = 
(
    SELECT TOP 1 DA.MaDuAn
    FROM DuAn DA INNER JOIN ChuyenGia_DuAn CGD ON DA.MaDuAn = CGD.MaDuAn
    GROUP BY DA.MaDuAn
    ORDER BY COUNT(CGD.MaChuyenGia) DESC
);

-- 11. Hiển thị tên và số lượng kỹ năng của mỗi chuyên gia, đồng thời lọc ra những người có ít nhất 5 kỹ năng.
SELECT CG.HoTen, COUNT(CGK.MaKyNang) AS SoLuongKyNang 
FROM ChuyenGia CG LEFT JOIN ChuyenGia_KyNang CGK ON CG.MaChuyenGia = CGK.MaChuyenGia 
GROUP BY CG.HoTen
HAVING COUNT(CGK.MaKyNang) >= 5;

-- 12. Tìm các cặp chuyên gia làm việc cùng dự án và hiển thị thông tin về số năm kinh nghiệm của từng cặp.
SELECT CG1.HoTen AS ChuyenGia1, CG1.NamKinhNghiem AS NamKinhNghiem1, 
       CG2.HoTen AS ChuyenGia2, CG2.NamKinhNghiem AS NamKinhNghiem2, 
       DA.TenDuAn 
FROM ChuyenGia_DuAn CGD1 
		INNER JOIN ChuyenGia_DuAn CGD2 ON CGD1.MaDuAn = CGD2.MaDuAn 
		INNER JOIN ChuyenGia CG1 ON CGD1.MaChuyenGia = CG1.MaChuyenGia 
		INNER JOIN ChuyenGia CG2 ON CGD2.MaChuyenGia = CG2.MaChuyenGia 
		INNER JOIN DuAn DA ON CGD1.MaDuAn = DA.MaDuAn 
WHERE CGD1.MaChuyenGia < CGD2.MaChuyenGia;

-- 13. Liệt kê tên các chuyên gia và số lượng kỹ năng cấp độ 5 của họ, đồng thời tính toán tỷ lệ phần trăm so với tổng số kỹ năng mà họ sở hữu.
SELECT CG.HoTen, COUNT(CASE WHEN CGK.CapDo = 5 THEN 1 END) AS SoLuongKyNangCap5,
	   (COUNT(CASE WHEN CGK.CapDo = 5 THEN 1 END) * 100.0 / COUNT(CGK.MaKyNang)) AS TyLePhanTram
FROM  ChuyenGia CG INNER JOIN ChuyenGia_KyNang CGK ON CG.MaChuyenGia = CGK.MaChuyenGia 
GROUP BY CG.HoTen;

-- 14. Tìm các công ty không có dự án nào và hiển thị cả thông tin về số lượng nhân viên trong mỗi công ty đó.
SELECT CT.TenCongTy, COUNT(CG.MaChuyenGia) AS SoLuongNhanVien
FROM CongTy CT LEFT JOIN ChuyenGia CG ON CG.MaChuyenGia = CT.MaCongTy
WHERE NOT EXISTS 
(
    SELECT 1 
    FROM DuAn DA 
    WHERE DA.MaCongTy = CT.MaCongTy
)
GROUP BY CT.TenCongTy;

-- 15. Hiển thị tên chuyên gia và tên dự án họ tham gia, bao gồm cả những chuyên gia không tham gia dự án nào, sắp xếp theo tên chuyên gia.
SELECT CG.HoTen AS TenChuyenGia, DA.TenDuAn AS TenDuAn 
FROM ChuyenGia CG LEFT JOIN ChuyenGia_DuAn CGD ON CG.MaChuyenGia = CGD.MaChuyenGia 
				  LEFT JOIN DuAn DA ON CGD.MaDuAn = DA.MaDuAn
ORDER BY CG.HoTen;

-- 17. Hiển thị tên công ty và tổng số năm kinh nghiệm của tất cả chuyên gia trong các dự án của công ty đó, chỉ hiển thị những công ty có tổng số năm kinh nghiệm lớn hơn 10 năm.
SELECT CT.TenCongTy, SUM(CG.NamKinhNghiem) AS TongNamKinhNghiem 
FROM CongTy CT INNER JOIN DuAn DA ON CT.MaCongTy = DA.MaCongTy 
			   INNER JOIN ChuyenGia_DuAn CGD ON DA.MaDuAn = CGD.MaDuAn 
			   INNER JOIN ChuyenGia CG ON CGD.MaChuyenGia = CG.MaChuyenGia 
GROUP BY CT.TenCongTy
HAVING SUM(CG.NamKinhNghiem) > 10;

-- 18. Tìm các chuyên gia có kỹ năng 'Java' nhưng không có kỹ năng 'Python', đồng thời hiển thị danh sách các dự án mà họ đã tham gia.
SELECT CG.HoTen, DA.TenDuAn
FROM ChuyenGia CG LEFT JOIN ChuyenGia_KyNang CGK1 
	ON CG.MaChuyenGia = CGK1.MaChuyenGia 
		AND CGK1.MaKyNang = (SELECT MaKyNang FROM KyNang WHERE TenKyNang = 'Java')
				  LEFT JOIN ChuyenGia_KyNang CGK2 ON CG.MaChuyenGia = CGK2.MaChuyenGia 
		AND CGK2.MaKyNang = (SELECT MaKyNang FROM KyNang WHERE TenKyNang = 'Python')
				  LEFT JOIN ChuyenGia_DuAn CGD ON CG.MaChuyenGia = CGD.MaChuyenGia 
				  LEFT JOIN DuAn DA ON CGD.MaDuAn = DA.MaDuAn
GROUP BY CG.HoTen, DA.TenDuAn
HAVING COUNT(CGK1.MaKyNang) > 0 AND COUNT(CGK2.MaKyNang) = 0;

-- 19. Tìm chuyên gia có số lượng kỹ năng nhiều nhất và hiển thị cả danh sách các dự án mà họ đã tham gia.
WITH ChuyenGiaMaxKyNang AS 
(
    SELECT CG.MaChuyenGia,CG.HoTen, COUNT(CGK.MaKyNang) AS SoLuongKyNang
    FROM ChuyenGia CG INNER JOIN ChuyenGia_KyNang CGK ON CG.MaChuyenGia = CGK.MaChuyenGia
    GROUP BY CG.MaChuyenGia, CG.HoTen
)
SELECT CG.HoTen, CG.SoLuongKyNang, DA.TenDuAn
FROM ChuyenGiaMaxKyNang CG INNER JOIN ChuyenGia_DuAn CGD ON CG.MaChuyenGia = CGD.MaChuyenGia
						   INNER JOIN DuAn DA ON CGD.MaDuAn = DA.MaDuAn
WHERE CG.SoLuongKyNang = (SELECT MAX(SoLuongKyNang) FROM ChuyenGiaMaxKyNang);

-- 20. Liệt kê các cặp chuyên gia có cùng chuyên ngành và hiển thị thông tin về số năm kinh nghiệm của từng người trong cặp đó.
SELECT CG1.HoTen AS ChuyenGia1, CG2.HoTen AS ChuyenGia2, 
    CG1.ChuyenNganh, CG1.NamKinhNghiem AS NamKinhNghiem1,
    CG2.NamKinhNghiem AS NamKinhNghiem2
FROM ChuyenGia CG1 INNER JOIN ChuyenGia CG2 ON CG1.MaChuyenGia <> CG2.MaChuyenGia
WHERE CG1.ChuyenNganh = CG2.ChuyenNganh
ORDER BY CG1.ChuyenNganh, CG1.HoTen, CG2.HoTen;

-- 21. Tìm công ty có tổng số năm kinh nghiệm của các chuyên gia trong dự án cao nhất và hiển thị danh sách tất cả các dự án mà công ty đó đã thực hiện.
WITH MaxExperienceCompany AS 
(
    SELECT TOP 1 CT.MaCongTy
    FROM CongTy CT INNER JOIN DuAn DA ON CT.MaCongTy = DA.MaCongTy 
				   INNER JOIN ChuyenGia_DuAn CGD ON DA.MaDuAn = CGD.MaDuAn 
				   INNER JOIN ChuyenGia CG ON CGD.MaChuyenGia = CG.MaChuyenGia 
    GROUP BY CT.MaCongTy 
    ORDER BY SUM(CG.NamKinhNghiem) DESC
)
SELECT DA.TenDuAn
FROM DuAn DA INNER JOIN MaxExperienceCompany MEC ON DA.MaCongTy = MEC.MaCongTy
ORDER BY DA.TenDuAn;

-- 22. Tìm kỹ năng được sở hữu bởi tất cả các chuyên gia và hiển thị danh sách chi tiết 
--về từng chuyên gia sở hữu kỹ năng đó cùng với cấp độ của họ.
SELECT K.TenKyNang, CG.HoTen AS TenChuyenGia, CGK.CapDo
FROM KyNang K INNER JOIN ChuyenGia_KyNang CGK ON K.MaKyNang = CGK.MaKyNang
			  INNER JOIN ChuyenGia CG ON CGK.MaChuyenGia = CG.MaChuyenGia
WHERE K.MaKyNang IN 
(
    SELECT K.MaKyNang
    FROM KyNang K INNER JOIN ChuyenGia_KyNang CGK ON K.MaKyNang = CGK.MaKyNang
    GROUP BY K.MaKyNang
    HAVING COUNT(DISTINCT CGK.MaChuyenGia) = (SELECT COUNT(*) FROM ChuyenGia)
)
ORDER BY K.TenKyNang, CG.HoTen;

--23. Tìm tất cả các chuyên gia có ít nhất 2 kỹ năng thuộc cùng một lĩnh vực và hiển thị tên chuyên gia cùng với tên lĩnh vực đó.
SELECT CG.HoTen AS TenChuyenGia, K.LoaiKyNang AS LinhVuc
FROM ChuyenGia CG INNER JOIN ChuyenGia_KyNang CGK ON CG.MaChuyenGia = CGK.MaChuyenGia
				  INNER JOIN KyNang K ON CGK.MaKyNang = K.MaKyNang
GROUP BY CG.HoTen, K.LoaiKyNang
HAVING COUNT(DISTINCT K.MaKyNang) >= 2;

--24. Hiển thị tên các dự án và số lượng chuyên gia tham gia cho mỗi dự án, chỉ hiển thị những dự án có hơn 3 chuyên gia tham gia.
SELECT DA.TenDuAn, COUNT(DISTINCT CG.MaChuyenGia) AS SoLuongChuyenGia
FROM DuAn DA INNER JOIN ChuyenGia_DuAn CGD ON DA.MaDuAn = CGD.MaDuAn
			 INNER JOIN ChuyenGia CG ON CGD.MaChuyenGia = CG.MaChuyenGia
GROUP BY DA.TenDuAn
HAVING COUNT(DISTINCT CG.MaChuyenGia) > 3;
  
--25.Tìm công ty có số lượng dự án lớn nhất và hiển thị tên công ty cùng với số lượng dự án.
SELECT CT.TenCongTy, COUNT(DA.MaDuAn) AS SoLuongDuAn
FROM CongTy CT INNER JOIN DuAn DA ON CT.MaCongTy = DA.MaCongTy
GROUP BY CT.TenCongTy
HAVING COUNT(DA.MaDuAn) = 
(
    SELECT MAX(SoLuongDuAn)
    FROM 
	(
        SELECT COUNT(DA.MaDuAn) AS SoLuongDuAn
        FROM DuAn DA
        GROUP BY DA.MaCongTy
    ) AS SubQuery
)
ORDER BY SoLuongDuAn DESC;

--26. Liệt kê tên các chuyên gia có kinh nghiệm từ 5 năm trở lên và có ít nhất 4 kỹ năng khác nhau.
SELECT CG.HoTen
FROM ChuyenGia CG INNER JOIN ChuyenGia_KyNang CGK ON CG.MaChuyenGia = CGK.MaChuyenGia
GROUP BY CG.MaChuyenGia, CG.HoTen, CG.NamKinhNghiem
HAVING CG.NamKinhNghiem >= 5 AND COUNT(DISTINCT CGK.MaKyNang) >= 4;

--27. Tìm tất cả các kỹ năng mà không có chuyên gia nào sở hữu.
SELECT K.TenKyNang
FROM KyNang K LEFT JOIN ChuyenGia_KyNang CGK ON K.MaKyNang = CGK.MaKyNang
WHERE CGK.MaChuyenGia IS NULL;

--28. Hiển thị tên chuyên gia và số năm kinh nghiệm của họ, sắp xếp theo số năm kinh nghiệm giảm dần.
SELECT HoTen, NamKinhNghiem
FROM ChuyenGia
ORDER BY NamKinhNghiem DESC;

--29. Tìm tất cả các cặp chuyên gia có ít nhất 2 kỹ năng giống nhau.
SELECT CG1.MaChuyenGia AS ChuyenGia1, CG2.MaChuyenGia AS ChuyenGia2
FROM ChuyenGia_KyNang CG1 INNER JOIN ChuyenGia_KyNang CG2 ON CG1.MaKyNang = CG2.MaKyNang
WHERE CG1.MaChuyenGia < CG2.MaChuyenGia
GROUP BY CG1.MaChuyenGia, CG2.MaChuyenGia
HAVING COUNT(CG1.MaKyNang) >= 2;

--31. Liệt kê tên các chuyên gia cùng với số lượng kỹ năng cấp độ cao nhất mà họ sở hữu.
SELECT C.HoTen, COUNT(K.MaKyNang) AS SoLuongKyNangCaoNhat
FROM ChuyenGia C INNER JOIN ChuyenGia_KyNang CGK ON C.MaChuyenGia = CGK.MaChuyenGia
				 INNER JOIN KyNang K ON CGK.MaKyNang = K.MaKyNang
WHERE CGK.CapDo = (SELECT MAX(CapDo) FROM ChuyenGia_KyNang WHERE MaChuyenGia = C.MaChuyenGia)
GROUP BY C.HoTen;

--32. Tìm dự án mà tất cả các chuyên gia đều tham gia và hiển thị tên dự án cùng với danh sách tên chuyên gia tham gia.
SELECT D.TenDuAn, STRING_AGG(C.HoTen, ', ') AS DanhSachChuyenGia
FROM DuAn D INNER JOIN ChuyenGia_DuAn CGD ON D.MaDuAn = CGD.MaDuAn
			INNER JOIN ChuyenGia C ON CGD.MaChuyenGia = C.MaChuyenGia
GROUP BY D.TenDuAn
HAVING COUNT(DISTINCT C.MaChuyenGia) = (SELECT COUNT(*) FROM ChuyenGia);

--33. Tìm tất cả các kỹ năng mà ít nhất một chuyên gia sở hữu nhưng không thuộc về nhóm kỹ năng 'Python' hoặc 'Java'.
SELECT K.TenKyNang
FROM KyNang K INNER JOIN ChuyenGia_KyNang CGK ON K.MaKyNang = CGK.MaKyNang
WHERE K.TenKyNang NOT IN ('Python', 'Java')
GROUP BY K.TenKyNang;