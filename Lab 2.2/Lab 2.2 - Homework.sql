--Lab 2.2 - Homework
--Nguyễn Lê Hưng
--23520567
--IT004.P113.2
--Link github: 


--1 Liệt kê tất cả các chuyên gia và sắp xếp theo họ tên.
select * from ChuyenGia order by HoTen;

--2 Hiển thị tên và số điện thoại của các chuyên gia có chuyên ngành 'Phát triển phần mềm'.
select HoTen, SoDienThoai from ChuyenGia where ChuyenNganh = N'Phát triển phần mềm';

--3 Liệt kê tất cả các công ty có trên 100 nhân viên.
select * from CongTy where SoNhanVien > 100;

--4 Hiển thị tên và ngày bắt đầu của các dự án bắt đầu trong năm 2023.
select TenDuAn, NgayBatDau from DuAn where year(NgayBatDau) = 2023;

--5 Liệt kê tất cả các kỹ năng và sắp xếp theo tên kỹ năng.
select * from KyNang order by TenKyNang;

--6 Hiển thị tên và email của các chuyên gia có tuổi dưới 35 (tính đến năm 2024).
select HoTen, Email from ChuyenGia where (2024 - year(NgaySinh) < 35);

--7 Hiển thị tên và chuyên ngành của các chuyên gia nữ.
select HoTen, ChuyenNganh from ChuyenGia where GioiTinh = N'Nữ';

--8 Liệt kê tên các kỹ năng thuộc loại 'Công nghệ'.
select TenKyNang from KyNang where LoaiKyNang = N'Công nghệ';

--9 Hiển thị tên và địa chỉ của các công ty trong lĩnh vực 'Phân tích dữ liệu'.
select TenCongTy, DiaChi from CongTy where LinhVuc = N'Phân tích dữ liệu';

--10 Liệt kê tên các dự án có trạng thái 'Hoàn thành'.
select TenDuAn from DuAn where TrangThai = N'Hoàn thành';

--11 Hiển thị tên và số năm kinh nghiệm của các chuyên gia, sắp xếp theo số năm kinh nghiệm giảm dần.
select HoTen, NamKinhNghiem from ChuyenGia order by NamKinhNghiem desc;

--12 Liệt kê tên các công ty và số lượng nhân viên, chỉ hiển thị các công ty có từ 100 đến 200 nhân viên.
select TenCongTy, SoNhanVien from CongTy where SoNhanVien between 100 and 200;

--13 Hiển thị tên dự án và ngày kết thúc của các dự án kết thúc trong năm 2023.
select TenDuAn, NgayKetThuc from DuAn where year(NgayKetThuc) = 2023;

--14 Liệt kê tên và email của các chuyên gia có tên bắt đầu bằng chữ 'N'.
select HoTen, Email from ChuyenGia where HoTen like 'N%';

--15 Hiển thị tên kỹ năng và loại kỹ năng, không bao gồm các kỹ năng thuộc loại 'Ngôn ngữ lập trình'.
select TenKyNang, LoaiKyNang from KyNang where not LoaiKyNang = N'Ngôn ngữ lập trình';

--16 Hiển thị tên công ty và lĩnh vực hoạt động, sắp xếp theo lĩnh vực.
select TenCongTy, LinhVuc from CongTy order by LinhVuc;

--17 Hiển thị tên và chuyên ngành của các chuyên gia nam có trên 5 năm kinh nghiệm.
select HoTen, ChuyenNganh from ChuyenGia where GioiTinh = 'Nam' and NamKinhNghiem > 5;

--18 Liệt kê tất cả các chuyên gia trong cơ sở dữ liệu.
select * from ChuyenGia;

--19 Hiển thị tên và email của tất cả các chuyên gia nữ.
select HoTen, Email from ChuyenGia where GioiTinh = N'Nữ';

--20 Liệt kê tất cả các công ty và số nhân viên của họ, sắp xếp theo số nhân viên giảm dần.
select * from CongTy order by SoNhanVien desc;

--21 Hiển thị tất cả các dự án đang trong trạng thái "Đang thực hiện".
select * from DuAn where TrangThai = N'Đang thực hiện';

--22 Liệt kê tất cả các kỹ năng thuộc loại "Ngôn ngữ lập trình".
select * from KyNang where LoaiKyNang = N'Ngôn ngữ lập trình';

--23 Hiển thị tên và chuyên ngành của các chuyên gia có trên 8 năm kinh nghiệm.
select HoTen, ChuyenNganh from ChuyenGia where NamKinhNghiem > 8;

--24 Liệt kê tất cả các dự án của công ty có MaCongTy là 1.
select * from DuAn where MaCongTy = 1;

--25 Đếm số lượng chuyên gia trong mỗi chuyên ngành.
select ChuyenNganh, count(*) as 'SoChuyenGia' from ChuyenGia group by ChuyenNganh;

--26 Tìm chuyên gia có số năm kinh nghiệm cao nhất.
select top 1 * from ChuyenGia order by NamKinhNghiem desc;

--27 Liệt kê tổng số nhân viên cho mỗi công ty mà có số nhân viên lớn hơn 100. 
--   Sắp xếp kết quả theo số nhân viên tăng dần.
select MaCongTy, TenCongTy, DiaChi, LinhVuc, SoNhanVien as 'TongSoNhanVien' 
from CongTy where SoNhanVien > 100 order by SoNhanVien asc;

--28 Xác định số lượng dự án mà mỗi công ty tham gia có trạng thái 'Đang thực hiện'. 
--   Chỉ bao gồm các công ty có hơn một dự án đang thực hiện. Sắp xếp kết quả theo số lượng dự án giảm dần.
select MaCongTy, count (*) as 'SoDuAn' from DuAn where TrangThai = N'Đang thực hiện'
group by MaCongTy having count(*) > 1 order by SoDuAn desc;

--29 Tìm kiếm các kỹ năng mà chuyên gia có cấp độ từ 4 trở lên và tính tổng số chuyên gia cho mỗi kỹ năng đó.
--   Chỉ bao gồm những kỹ năng có tổng số chuyên gia lớn hơn 2. Sắp xếp kết quả theo tên kỹ năng tăng dần.
select KyNang.TenKyNang, count(distinct ChuyenGia_KyNang.MaChuyenGia) as 'SoChuyenGia'
from ChuyenGia_KyNang inner join KyNang on ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
where ChuyenGia_KyNang.CapDo > 4 group by KyNang.TenKyNang
having count(distinct ChuyenGia_KyNang.MaChuyenGia) > 2 order by KyNang.TenKyNang asc;

--30 Liệt kê tên các công ty có lĩnh vực 'Điện toán đám mây' và tính tổng số nhân viên của họ. 
--   Sắp xếp kết quả theo tổng số nhân viên tăng dần.
select TenCongTy, SoNhanVien from CongTy 
where LinhVuc = N'Điện toán đám mây' order by SoNhanVien asc;

--31 Liệt kê tên các công ty có số nhân viên từ 50 đến 150 và tính trung bình số nhân viên của họ. 
--   Sắp xếp kết quả theo tên công ty tăng dần.
select TenCongTY, (select avg(SoNhanVien) 
				   from CongTy 
				   where SoNhanVien between 50 and 150) as 'TrungBinhSoNhanVien'
from CongTy where SoNhanVien between 50 and 150 order by TenCongTy asc;

--32 Xác định số lượng kỹ năng cho mỗi chuyên gia có cấp độ tối đa là 5 và 
--   chỉ bao gồm những chuyên gia có ít nhất một kỹ năng đạt cấp độ tối đa này. 
--   Sắp xếp kết quả theo tên chuyên gia tăng dần.
select ChuyenGia.HoTen, count(distinct ChuyenGia_KyNang.MaKyNang) as SoKyNang
from ChuyenGia_KyNang inner join ChuyenGia on ChuyenGia_KyNang.MaChuyenGia = ChuyenGia.MaChuyenGia
where ChuyenGia_KyNang.CapDo = 5 group by ChuyenGia.HoTen
having count(distinct ChuyenGia_KyNang.MaKyNang) > 0 order by ChuyenGia.HoTen asc;

--33 Liệt kê tên các kỹ năng mà chuyên gia có cấp độ từ 4 trở lên và tính tổng số chuyên gia 
--   cho mỗi kỹ năng đó. Chỉ bao gồm những kỹ năng có tổng số chuyên gia lớn hơn 2. 
--   Sắp xếp kết quả theo tên kỹ năng tăng dần.
select KyNang.TenKyNang, count(distinct ChuyenGia_KyNang.MaChuyenGia) as 'SoChuyenGia'
from ChuyenGia_KyNang inner join KyNang on ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
where ChuyenGia_KyNang.CapDo > 4 group by KyNang.TenKyNang
having count(distinct ChuyenGia_KyNang.MaChuyenGia) > 2
order by KyNang.TenKyNang asc;

--34 Tìm kiếm tên của các chuyên gia trong lĩnh vực 'Phát triển phần mềm' và 
--       tính trung bình cấp độ kỹ năng của họ. 
--   Chỉ bao gồm những chuyên gia có cấp độ trung bình lớn hơn 3. 
--   Sắp xếp kết quả theo cấp độ trung bình giảm dần.
select ChuyenGia.HoTen, avg(ChuyenGia_KyNang.CapDo) as 'CapDoTrungBinh'
from ChuyenGia inner join ChuyenGia_KyNang on ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
where ChuyenGia.ChuyenNganh = N'Phát triển phần mềm' group by ChuyenGia.HoTen
having avg(ChuyenGia_KyNang.CapDo) > 3 order by CapDoTrungBinh desc;


