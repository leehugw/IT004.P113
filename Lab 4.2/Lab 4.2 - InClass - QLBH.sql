--Nguyễn Lê Hưng
--23520567
--IT004.P113.2

--Lab 4.2 - InClass - QLBH﻿

--Bài tập 1---------------------------
-- 19. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua? 
SELECT COUNT(*)
FROM HOADON
WHERE MAKH IS NULL;

-- 20. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006. 
SELECT COUNT(DISTINCT MASP)
FROM CTHD INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE YEAR(NGHD) = 2006;

-- 21. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu? 
SELECT MAX(TRIGIA) AS 'MAX', MIN(TRIGIA) AS 'MIN'
FROM HOADON;

-- 22. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AS 'TriGiaTrungBinh'
FROM HOADON
WHERE YEAR(NGHD) = 2006;

-- 23. Tính doanh thu bán hàng trong năm 2006. 
SELECT SUM(TRIGIA) AS 'DoanhThu'
FROM HOADON
WHERE YEAR(NGHD) = 2006;

-- 24. Tìm số hóa đơn có trị giá cao nhất trong năm 2006. 
SELECT TOP 1 WITH TIES SOHD
FROM HOADON
WHERE YEAR(NGHD) = 2006 
ORDER BY TRIGIA DESC;

-- 25. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006. 
SELECT TOP 1 WITH TIES K.HOTEN 
FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH = H.MAKH 
WHERE YEAR(H.NGHD) = 2006 
ORDER BY H.TRIGIA DESC;

-- 26. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất. 
SELECT TOP 3 MAKH, HOTEN 
FROM KHACHHANG
ORDER BY DOANHSO DESC;

-- 27. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất. 
SELECT TOP 3 WITH TIES MASP, TENSP 
FROM SANPHAM
ORDER BY GIA DESC;

-- 28. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức 
-- giá cao nhất (của tất cả các sản phẩm). 
SELECT S.MASP, S.TENSP
FROM SANPHAM S
WHERE S.NUOCSX = 'Thai Lan' AND S.GIA IN 
( 
SELECT TOP 3 GIA
FROM SANPHAM 
ORDER BY GIA DESC
);

-- 29. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức 
-- giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất). 
SELECT TOP 3 WITH TIES MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
ORDER BY GIA DESC;

-- 30. * In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng). 
SELECT TOP 3 *
FROM KHACHHANG
ORDER BY DOANHSO DESC;

--Bài tập 2-------------------------
-- 31. Tính tổng số sản phẩm do “Trung Quoc” sản xuất. 
SELECT COUNT(MASP)
FROM SANPHAM
WHERE MASP IN (SELECT MASP
				FROM SANPHAM
				WHERE NUOCSX = 'Trung Quoc');

-- 32. Tính tổng số sản phẩm của từng nước sản xuất. 
SELECT NUOCSX, COUNT(DISTINCT MASP) AS TONGSOSANPHAM
FROM SANPHAM
GROUP BY NUOCSX;

-- 33. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm. 
SELECT NUOCSX, MAX(GIA) AS 'MAX', MIN(GIA) AS'MIN', AVG(GIA) AS GIATRUNGBINH
FROM SANPHAM
GROUP BY NUOCSX;

-- 34. Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD, SUM(TRIGIA) AS 'DOANH THU MOI NGAY'
FROM HOADON
GROUP BY NGHD;

-- 35. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT MASP, SUM(SL) AS TONGSLSP
FROM CTHD 
WHERE SOHD IN (SELECT SOHD
			   FROM HOADON
			   WHERE MONTH(NGHD) = 10 
					AND YEAR(NGHD) = 2006)
GROUP BY MASP;

-- 36. Tính doanh thu bán hàng của từng tháng trong năm 2006. 
SELECT MONTH(NGHD), SUM(TRIGIA) AS 'Doanh Thu'
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD);

-- 37. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau. 
SELECT SOHD 
FROM CTHD
GROUP BY SOHD 
HAVING COUNT(*) >= 4;

-- 38. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau). 
SELECT C.SOHD 
FROM CTHD C INNER JOIN SANPHAM S ON C.MASP = S.MASP 
WHERE S.NUOCSX = 'Viet Nam'
GROUP BY C.SOHD 
HAVING COUNT(DISTINCT C.MASP) >= 3;

-- 39. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.  
SELECT MAKH, HOTEN
FROM KHACHHANG
WHERE MAKH = (SELECT TOP 1 MAKH
				FROM HOADON
				GROUP BY MAKH
				ORDER BY COUNT(DISTINCT SOHD) DESC);

-- 40. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 MONTH(NGHD) AS 'THANG DOANH SO MAX'
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC;

-- 41. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP = (SELECT TOP 1 MASP
				FROM CTHD
				WHERE SOHD IN (SELECT SOHD
								FROM HOADON
								WHERE YEAR(NGHD) = 2006)
				GROUP BY MASP
				ORDER BY SUM(SL) ASC);

-- 42. Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất. 
SELECT S.NUOCSX, S.MASP, S.TENSP 
FROM SANPHAM S
WHERE EXISTS (
	SELECT *
	FROM SANPHAM S2
	GROUP BY S2.NUOCSX 
	HAVING S.GIA = MAX(S2.GIA) AND S.NUOCSX = S2.NUOCSX 
);;

-- 43. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau. 
SELECT NUOCSX 
FROM SANPHAM
GROUP BY NUOCSX 
HAVING COUNT(DISTINCT GIA) >= 3;

-- 44. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất. 
SELECT * 
FROM KHACHHANG
WHERE MAKH IN (SELECT TOP 1 MAKH
				FROM HOADON
				WHERE MAKH IN (SELECT TOP 10 MAKH
								FROM HOADON 
								GROUP BY MAKH
								ORDER BY SUM(TRIGIA) DESC)
				GROUP BY MAKH
				ORDER BY COUNT(MAKH) DESC);
-- 45. 