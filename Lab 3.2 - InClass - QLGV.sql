--Nguyễn Lê Hưng
--23520567
--IT004.P113.2

--Lab 3.2 - InClass - QLGV

--1. Tìm danh sách các giáo viên có mức lương cao nhất trong mỗi khoa, kèm theo tên khoa và hệ số lương.
SELECT K.TENKHOA, GV.HOTEN, GV.MUCLUONG, GV.HESO
FROM GIAOVIEN GV INNER JOIN KHOA K ON GV.MAKHOA = K.MAKHOA
WHERE GV.MUCLUONG = (
    SELECT MAX(GV1.MUCLUONG)
    FROM GIAOVIEN GV1
    WHERE GV1.MAKHOA = GV.MAKHOA
);

--2. Liệt kê danh sách các học viên có điểm trung bình cao nhất trong mỗi lớp, kèm theo tên lớp và mã lớp.


--3.Tính tổng số tiết lý thuyết (TCLT) và thực hành (TCTH) mà mỗi giáo viên đã giảng dạy trong năm học 2023, 
--sắp xếp theo tổng số tiết từ cao xuống thấp.
SELECT GV.MAGV, GV.HOTEN, 
       SUM(MH.TCLT) AS TONG_TCLT, 
       SUM(MH.TCTH) AS TONG_TCTH
FROM GIAOVIEN GV INNER JOIN GIANGDAY GD ON GV.MAGV = GD.MAGV
				 INNER JOIN MONHOC MH ON GD.MAMH = MH.MAMH
WHERE GD.NAM = 2023
GROUP BY GV.MAGV, GV.HOTEN
ORDER BY (SUM(MH.TCLT) + SUM(MH.TCTH)) DESC;

--4. Tìm những học viên thi cùng một môn học nhiều hơn 2 lần nhưng chưa bao giờ đạt điểm trên 7, 
--kèm theo mã học viên và mã môn học.
SELECT KQ.MAHV, KQ.MAMH
FROM KETQUATHI KQ
WHERE KQ.DIEM <= 7
GROUP BY KQ.MAHV, KQ.MAMH
HAVING COUNT(*) > 2;

--5. Xác định những giáo viên đã giảng dạy ít nhất 3 môn học khác nhau trong cùng một năm học, 
--kèm theo năm học và số lượng môn giảng dạy
SELECT MAGV, NAM, SoLuongMonHoc
FROM 
(
    SELECT MAGV, NAM, COUNT(DISTINCT MAMH) AS SoLuongMonHoc
    FROM GIANGDAY
    GROUP BY MAGV, NAM
) AS SubQuery
WHERE SoLuongMonHoc >= 3;

--6. Tìm những học viên có sinh nhật trùng với ngày thành lập của khoa mà họ đang theo học, 
--kèm theo tên khoa và ngày sinh của học viên.
SELECT HV.HO, HV.TEN, HV.NGSINH, K.TENKHOA, K.NGTLAP
FROM HOCVIEN HV INNER JOIN LOP L ON HV.MALOP = L.MALOP
				INNER JOIN GIAOVIEN GV ON L.MAGVCN = GV.MAGV
				INNER JOIN KHOA K ON GV.MAKHOA = K.MAKHOA
WHERE DAY(HV.NGSINH) = DAY(K.NGTLAP)
  AND MONTH(HV.NGSINH) = MONTH(K.NGTLAP);

--7. Liệt kê các môn học không có điều kiện tiên quyết (không yêu cầu môn học trước), 
--kèm theo mã môn và tên môn học.
SELECT MH.MAMH, MH.TENMH
FROM MONHOC MH LEFT JOIN DIEUKIEN DK ON MH.MAMH = DK.MAMH
WHERE DK.MAMH_TRUOC IS NULL;

--8. Tìm danh sách các giáo viên dạy nhiều môn học nhất trong học kỳ 1 năm 2006, 
--kèm theo số lượng môn học mà họ đã dạy.
SELECT GD.MAGV, GV.HOTEN, COUNT(GD.MAMH) AS SO_LUONG_MON_HOC
FROM GIANGDAY GD INNER JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
WHERE GD.HOCKY = 1 AND GD.NAM = 2006
GROUP BY GD.MAGV, GV.HOTEN
HAVING COUNT(GD.MAMH) = 
	(
        SELECT MAX(MONHOC_COUNT)
        FROM 
		(
            SELECT COUNT(GD1.MAMH) AS MONHOC_COUNT
            FROM GIANGDAY GD1
            WHERE GD1.HOCKY = 1 AND GD1.NAM = 2006
            GROUP BY GD1.MAGV
        ) AS MONHOC_COUNTS
    );
GO

--9. Tìm những giáo viên đã dạy cả môn “Co So Du Lieu” và “Cau Truc Roi Rac” trong cùng một học kỳ, 
--kèm theo học kỳ và năm học.
SELECT GD.MAGV, GV.HOTEN, GD.HOCKY, GD.NAM
FROM GIANGDAY GD INNER JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
WHERE (GD.MAMH = 'CSDL' OR GD.MAMH = 'CTRRR') 
GROUP BY GD.MAGV, GV.HOTEN, GD.HOCKY, GD.NAM
HAVING  COUNT(DISTINCT GD.MAMH) = 2;

--10. Liệt kê danh sách các môn học mà tất cả các giáo viên trong khoa “CNTT” 
--đều đã giảng dạy ít nhất một lần trong năm 2006.
SELECT M.MAMH, M.TENMH
FROM MONHOC M
WHERE NOT EXISTS 
(
    SELECT 1
    FROM GIAOVIEN GV
    WHERE GV.MAKHOA = 'CNTT'
    AND NOT EXISTS 
	(
        SELECT 1
        FROM GIANGDAY GD
        WHERE GD.MAMH = M.MAMH
        AND GD.MAGV = GV.MAGV
        AND GD.NAM = 2006
    )
);

--11. Tìm những giáo viên có hệ số lương cao hơn mức lương trung bình của tất cả giáo viên trong khoa của họ, 
--kèm theo tên khoa và hệ số lương của giáo viên đó.
SELECT GV.HOTEN, GV.HESO, K.TENKHOA
FROM GIAOVIEN GV INNER JOIN KHOA K ON GV.MAKHOA = K.MAKHOA
WHERE GV.HESO > 
(
    SELECT AVG(GV2.HESO)
    FROM GIAOVIEN GV2
    WHERE GV2.MAKHOA = GV.MAKHOA
);

--12. Xác định những lớp có sĩ số lớn hơn 40 nhưng không có giáo viên nào dạy quá 2 môn trong học kỳ 1 năm 2006, 
--kèm theo tên lớp và sĩ số.
SELECT L.TENLOP, L.SISO FROM LOP L
WHERE L.SISO > 40 AND NOT EXISTS 
(
    SELECT 1
    FROM GIANGDAY GD INNER JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
    WHERE GD.HOCKY = 1 AND GD.NAM = 2006
					   AND GD.MAGV = L.MAGVCN
    GROUP BY GD.MAGV
    HAVING COUNT(DISTINCT GD.MAMH) > 2
);

--13. Tìm những môn học mà tất cả các học viên của lớp “K11” đều đạt điểm trên 7 trong lần thi cuối cùng của họ, 
--kèm theo mã môn và tên môn học.
SELECT MH.MAMH, MH.TENMH FROM MONHOC MH
WHERE NOT EXISTS 
(
    SELECT 1
    FROM HOCVIEN HV INNER JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
    WHERE HV.MALOP = 'K11' 
	AND KQ.MAMH = MH.MAMH
	AND KQ.LANTHI = 
	(
		SELECT MAX(LANTHI)
		FROM KETQUATHI
		WHERE MAHV = HV.MAHV
	)
    AND KQ.DIEM <= 7
)
GO

--14. Liệt kê danh sách các giáo viên đã dạy ít nhất một môn học trong mỗi học kỳ của năm 2006, 
--kèm theo mã giáo viên và số lượng học kỳ mà họ đã giảng dạy.
SELECT G.MAGV, COUNT(DISTINCT GD.HOCKY) AS SoLuongHocky
FROM GIAOVIEN G INNER JOIN GIANGDAY GD ON G.MAGV = GD.MAGV
WHERE GD.NAM = 2006
GROUP BY G.MAGV
HAVING COUNT(DISTINCT GD.HOCKY) = 2;

--15. Tìm những giáo viên vừa là trưởng khoa vừa giảng dạy ít nhất 2 môn khác nhau trong năm 2006, 
--kèm theo tên khoa và mã giáo viên.
SELECT G.MAGV, K.TENKHOA
FROM GIAOVIEN G INNER JOIN KHOA K ON G.MAKHOA = K.MAKHOA
				INNER JOIN GIANGDAY GD ON G.MAGV = GD.MAGV
WHERE K.TRGKHOA = G.MAGV
  AND GD.NAM = 2006
GROUP BY G.MAGV, K.TENKHOA
HAVING COUNT(DISTINCT GD.MAMH) >= 2;

--16. Xác định những môn học mà tất cả các lớp do giáo viên chủ nhiệm “Nguyen To Lan” đều phải học trong năm 2006, 
--kèm theo mã lớp và tên lớp.
SELECT DISTINCT M.MAMH, M.TENMH
FROM MONHOC M INNER JOIN GIANGDAY GD ON M.MAMH = GD.MAMH
			  INNER JOIN LOP L ON GD.MALOP = L.MALOP
			  INNER JOIN GIAOVIEN GV ON L.MAGVCN = GV.MAGV
WHERE GV.HOTEN = 'Nguyen To Lan'
	AND GD.NAM = 2006
	AND L.MALOP IN 
	(
		SELECT MALOP
		FROM LOP L
		JOIN GIAOVIEN GV ON L.MAGVCN = GV.MAGV
		WHERE GV.HOTEN = 'Nguyen To Lan'
	)
GROUP BY M.MAMH, M.TENMH
HAVING COUNT(DISTINCT L.MALOP) = 
(
    SELECT COUNT(DISTINCT MALOP)
    FROM LOP L
    JOIN GIAOVIEN GV ON L.MAGVCN = GV.MAGV
    WHERE GV.HOTEN = 'Nguyen To Lan'
);

--17. Liệt kê danh sách các môn học mà không có điều kiện tiên quyết (không cần phải học trước
--bất kỳ môn nào), nhưng lại là điều kiện tiên quyết cho ít nhất 2 môn khác nhau, kèm theo mã môn và
--tên môn học.
SELECT M.MAMH, M.TENMH
FROM MONHOC M LEFT JOIN DIEUKIEN D ON M.MAMH = D.MAMH_TRUOC
GROUP BY M.MAMH, M.TENMH
HAVING COUNT(DISTINCT D.MAMH) >= 2 AND NOT EXISTS 
(
    SELECT 1
    FROM DIEUKIEN D1
    WHERE D1.MAMH = M.MAMH
);

--18. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 
--nhưng chưa thi lại môn này và cũng chưa thi bất kỳ môn nào khác sau lần đó.
SELECT H.MAHV, H.HO + ' ' + H.TEN AS HOTEN
FROM HOCVIEN H
WHERE H.MAHV IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    WHERE KQ.MAMH = 'CSDL' AND KQ.LANTHI = 1 AND KQ.DIEM < 5
)
AND H.MAHV NOT IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    WHERE KQ.MAMH = 'CSDL' AND KQ.LANTHI > 1
)
AND H.MAHV NOT IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    WHERE KQ.LANTHI > 1
);

--19. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy 
--bất kỳ môn học nào trong năm 2006, nhưng đã từng giảng dạy trước đó.
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN 
(
    SELECT GD.MAGV
    FROM GIANGDAY GD
    WHERE GD.NAM < 2006
)
AND GV.MAGV NOT IN 
(
    SELECT GD.MAGV
    FROM GIANGDAY GD
    WHERE GD.NAM = 2006
);

--20. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào
--thuộc khoa giáo viên đó phụ trách trong năm 2006, nhưng đã từng giảng dạy các môn khác của khoa khác.
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV INNER JOIN KHOA K ON GV.MAKHOA = K.MAKHOA
WHERE GV.MAGV IN 
(
    SELECT GD.MAGV
    FROM GIANGDAY GD INNER JOIN MONHOC MH ON GD.MAMH = MH.MAMH
    WHERE GD.NAM = 2006
    AND MH.MAKHOA != GV.MAKHOA
)
AND GV.MAGV NOT IN 
(
    SELECT GD.MAGV
    FROM GIANGDAY GD INNER JOIN MONHOC MH ON GD.MAMH = MH.MAMH
    WHERE GD.NAM = 2006
    AND MH.MAKHOA = GV.MAKHOA
);

--21. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn "Khong dat", 
--nhưng có điểm trung bình tất cả các môn khác trên 7.
SELECT HV.HO + ' ' + HV.TEN AS HOVATEN
FROM HOCVIEN HV INNER JOIN LOP L ON HV.MALOP = L.MALOP
WHERE L.TENLOP = 'K11' -- Lọc học viên thuộc lớp "K11"
AND HV.MAHV IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    WHERE KQ.KQUA = 'Khong dat'
    GROUP BY KQ.MAHV, KQ.MAMH
    HAVING COUNT(KQ.LANTHI) > 3
)
AND HV.MAHV IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    GROUP BY KQ.MAHV
    HAVING AVG(KQ.DIEM) > 7
);

--22. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn "Khong dat" và thi
--lần thứ 2 của môn CTRR đạt đúng 5 điểm, nhưng điểm trung bình của tất cả các môn khác đều dưới 6
SELECT HV.HO + ' ' + HV.TEN AS HOVATEN
FROM HOCVIEN HV INNER JOIN LOP L ON HV.MALOP = L.MALOP
WHERE L.TENLOP = 'K11'
AND HV.MAHV IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    WHERE KQ.KQUA = 'Khong dat'
    GROUP BY KQ.MAHV, KQ.MAMH
    HAVING COUNT(KQ.LANTHI) > 3
)
AND HV.MAHV IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    WHERE KQ.MAMH = 'CTRR' AND KQ.LANTHI = 2
    AND KQ.DIEM = 5
)
AND HV.MAHV IN 
(
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    GROUP BY KQ.MAHV
    HAVING AVG(KQ.DIEM) < 6
);

--23. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ 
--của một năm học và có tổng số tiết giảng dạy (TCLT + TCTH) lớn hơn 30 tiết
SELECT GV.MAGV, COUNT(DISTINCT L.MALOP) AS SoLop, 
       SUM(MH.TCLT + MH.TCTH) AS TongTietGiangDay
FROM GIAOVIEN GV INNER JOIN GIANGDAY GD ON GV.MAGV = GD.MAGV
				 INNER JOIN MONHOC MH ON GD.MAMH = MH.MAMH
				 INNER JOIN LOP L ON GD.MALOP = L.MALOP
WHERE MH.TENMH = N'Cau Truc Roi Rac'
GROUP BY GV.MAGV
HAVING COUNT(DISTINCT L.MALOP) >= 2
   AND SUM(MH.TCLT + MH.TCTH) > 30;

--24. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng), kèm theo số
--lần thi của mỗi học viên cho môn này.
WITH LAN_THI_CUOI AS 
(
    SELECT MAHV, MAMH, MAX(LANTHI) AS LANTHI_CUOI
    FROM KETQUATHI
    WHERE MAMH = 'CSDL'
    GROUP BY MAHV, MAMH
)
SELECT KQ.MAHV, HV.HO, HV.TEN, KQ.DIEM, 
	   MAX(KQ.LANTHI) AS LANTHI_CUOI, 
	   COUNT(*) AS SO_LAN_THI
FROM LAN_THI_CUOI LC
	INNER JOIN KETQUATHI KQ ON LC.MAHV = KQ.MAHV AND LC.MAMH = KQ.MAMH AND LC.LANTHI_CUOI = KQ.LANTHI
		INNER JOIN HOCVIEN HV ON KQ.MAHV = HV.MAHV
WHERE KQ.MAMH = 'CSDL'
GROUP BY KQ.MAHV, HV.HO, HV.TEN, KQ.DIEM, LANTHI_CUOI;

--25. Danh sách học viên và điểm trung bình tất cả các môn (chỉ lấy điểm của lần thi sau cùng), kèm
--theo số lần thi trung bình cho tất cả các môn mà mỗi học viên đã tham gia.