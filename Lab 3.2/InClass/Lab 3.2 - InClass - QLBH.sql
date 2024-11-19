--Nguyễn Lê Hưng
--23520567
--IT004.P113.2

--Lab 3.2 - InClass - QLBH

--1. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số
--lượng từ 10 đến 20, và tổng trị giá hóa đơn lớn hơn 500.000
SELECT CTHD.SOHD
FROM CTHD INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE (MASP = 'BB01' OR MASP = 'BB02') 
	AND (SL BETWEEN 10 AND 20) 
	AND (TRIGIA > 500000);

--2. Tìm các số hóa đơn mua cùng lúc 3 sản phẩm có mã số “BB01”, “BB02” và “BB03”, mỗi sản
--phẩm mua với số lượng từ 10 đến 20, và ngày mua hàng trong năm 2023.
SELECT CTHD.SOHD
FROM CTHD INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE MASP = 'BB01' AND YEAR(NGHD) = 2023
INTERSECT 
SELECT CTHD.SOHD 
FROM CTHD INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE MASP = 'BB02' AND YEAR(NGHD) = 2023
INTERSECT
SELECT CTHD.SOHD 
FROM CTHD INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
WHERE MASP = 'BB03' AND YEAR(NGHD) = 2023;

--3. Tìm các khách hàng đã mua ít nhất một sản phẩm có mã số “BB01” với số lượng từ 10 đến 20, và
--tổng trị giá tất cả các hóa đơn của họ lớn hơn hoặc bằng 1 triệu đồng.
SELECT KHACHHANG.MAKH
FROM CTHD INNER JOIN HOADON ON CTHD.SOHD = HOADON.SOHD
		INNER JOIN KHACHHANG ON HOADON.MAKH = KHACHHANG.MAKH
WHERE (MASP = 'BB01') 
	AND (SL BETWEEN 10 AND 20) 
	AND (TRIGIA > 500000);

--4. Tìm các nhân viên bán hàng đã thực hiện giao dịch bán ít nhất một sản phẩm có mã số “BB01”
--hoặc “BB02”, mỗi sản phẩm bán với số lượng từ 15 trở lên, và tổng trị giá của tất cả các hóa đơn mà
--nhân viên đó xử lý lớn hơn hoặc bằng 2 triệu đồng.
SELECT NHANVIEN.MANV, HOTEN
FROM NHANVIEN INNER JOIN HOADON ON NHANVIEN.MANV = HOADON.MANV
			INNER JOIN CTHD ON HOADON.SOHD = CTHD.SOHD
WHERE (MASP = 'BB01' OR MASP = 'BB02')
	AND (SL >= 15)
	AND TRIGIA >= 2000000;

--5. Tìm các khách hàng đã mua ít nhất hai loại sản phẩm khác nhau với tổng số lượng từ tất cả các hóa
--đơn của họ lớn hơn hoặc bằng 50 và tổng trị giá của họ lớn hơn hoặc bằng 5 triệu đồng.
SELECT HOTEN
FROM KHACHHANG KH
JOIN HOADON HD ON KH.MAKH = HD.MAKH
JOIN CTHD ON HD.SOHD = CTHD.SOHD
WHERE TRIGIA >= 5000000
GROUP BY KH.MAKH, KH.HOTEN
HAVING COUNT(DISTINCT CTHD.MASP) >= 2
   AND SUM(CTHD.SL) >= 50;

--6. Tìm những khách hàng đã mua cùng lúc ít nhất ba sản phẩm khác nhau trong cùng một hóa đơn và
--mỗi sản phẩm đều có số lượng từ 5 trở lên.
SELECT DISTINCT HD.SOHD, KH.HOTEN
FROM HOADON HD
JOIN CTHD ON HD.SOHD = CTHD.SOHD
JOIN KHACHHANG KH ON HD.MAKH = KH.MAKH
WHERE CTHD.SL >= 5
GROUP BY HD.SOHD, KH.HOTEN
HAVING COUNT(DISTINCT CTHD.MASP) >= 3;

--7. Tìm các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất và đã được bán ra ít nhất 5 lần
--trong năm 2007
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP
JOIN CTHD ON SP.MASP = CTHD.MASP
JOIN HOADON HD ON CTHD.SOHD = HD.SOHD
WHERE SP.NUOCSX = 'Trung Quoc' AND YEAR(HD.NGHD) = 2007
GROUP BY SP.MASP, SP.TENSP
HAVING COUNT(HD.SOHD) >= 5;

--8. Tìm các khách hàng đã mua ít nhất một sản phẩm do “Singapore” sản xuất trong năm 2006 và tổng
--trị giá hóa đơn của họ trong năm đó lớn hơn 1 triệu đồng.
SELECT DISTINCT KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
JOIN HOADON HD ON KH.MAKH = HD.MAKH
JOIN CTHD ON HD.SOHD = CTHD.SOHD
JOIN SANPHAM SP ON CTHD.MASP = SP.MASP
WHERE SP.NUOCSX = 'Singapore' AND YEAR(HD.NGHD) = 2006
GROUP BY KH.MAKH, KH.HOTEN
HAVING SUM(CTHD.SL * HD.TRIGIA) > 1000000;

--9. Tìm những nhân viên bán hàng đã thực hiện giao dịch bán nhiều nhất các sản phẩm do “Trung
--Quoc” sản xuất trong năm 2006.
SELECT TOP 1 NV.MANV, NV.HOTEN, SUM(CTHD.SL) AS TOTAL_SOLD
FROM NHANVIEN NV
JOIN HOADON HD ON NV.MANV = HD.MANV
JOIN CTHD ON HD.SOHD = CTHD.SOHD
JOIN SANPHAM SP ON CTHD.MASP = SP.MASP
WHERE SP.NUOCSX = 'Trung Quoc' AND YEAR(HD.NGHD) = 2006
GROUP BY NV.MANV, NV.HOTEN
ORDER BY TOTAL_SOLD DESC;

--10. Tìm những khách hàng chưa từng mua bất kỳ sản phẩm nào do “Singapore” sản xuất nhưng đã
--mua ít nhất một sản phẩm do “Trung Quoc” sản xuất.
SELECT KH.MAKH, KH.HOTEN
FROM KHACHHANG KH
WHERE KH.MAKH NOT IN (
    SELECT DISTINCT HD.MAKH
    FROM HOADON HD
    JOIN CTHD ON HD.SOHD = CTHD.SOHD
    JOIN SANPHAM SP ON CTHD.MASP = SP.MASP
    WHERE SP.NUOCSX = 'Singapore'
)
AND KH.MAKH IN (
    SELECT DISTINCT HD.MAKH
    FROM HOADON HD
    JOIN CTHD ON HD.SOHD = CTHD.SOHD
    JOIN SANPHAM SP ON CTHD.MASP = SP.MASP
    WHERE SP.NUOCSX = 'Trung Quoc'
);

--11. Tìm những hóa đơn có chứa tất cả các sản phẩm do “Singapore” sản xuất và trị giá hóa đơn lớn
--hơn tổng trị giá trung bình của tất cả các hóa đơn trong hệ thống.
SELECT HD.SOHD
FROM HOADON HD
JOIN CTHD CT ON HD.SOHD = CT.SOHD
JOIN SANPHAM SP ON CT.MASP = SP.MASP
WHERE SP.NUOCSX = 'Singapore'
GROUP BY HD.SOHD, HD.TRIGIA
HAVING COUNT(DISTINCT SP.MASP) = (
    SELECT COUNT(DISTINCT MASP)
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore'
)
AND HD.TRIGIA > (
    SELECT AVG(TRIGIA)
    FROM HOADON
);	

--12. Tìm danh sách các nhân viên có tổng số lượng bán ra của tất cả các loại sản phẩm vượt quá số
--lượng trung bình của tất cả các nhân viên khác.
SELECT NV.MANV, NV.HOTEN
FROM NHANVIEN NV
JOIN HOADON HD ON NV.MANV = HD.MANV
JOIN CTHD ON HD.SOHD = CTHD.SOHD
GROUP BY NV.MANV, NV.HOTEN
HAVING SUM(CTHD.SL) > (SELECT AVG(TOTAL) FROM (SELECT SUM(CTHD.SL) AS TOTAL 
	FROM NHANVIEN NV JOIN HOADON HD ON NV.MANV = HD.MANV JOIN CTHD ON HD.SOHD = CTHD.SOHD GROUP BY NV.MANV) AS AVG_TOTAL)

--13. Tìm danh sách các hóa đơn có chứa ít nhất một sản phẩm từ mỗi nước sản xuất khác nhau có
--trong hệ thống.
SELECT HD.SOHD
FROM HOADON HD
JOIN CTHD ON HD.SOHD = CTHD.SOHD
JOIN SANPHAM SP ON CTHD.MASP = SP.MASP
GROUP BY HD.SOHD
HAVING COUNT(DISTINCT SP.NUOCSX) = (SELECT COUNT(DISTINCT NUOCSX) FROM SANPHAM);
