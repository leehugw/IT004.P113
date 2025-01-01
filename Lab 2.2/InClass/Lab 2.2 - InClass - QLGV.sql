﻿--IT004.P113.2
--Nguyễn Lê Hưng
--23520567

--Lab 2.2 InClass

--Tắt khóa ngoại
alter table DIEUKIEN nocheck constraint ALL
alter table GIANGDAY nocheck constraint ALL
alter table GIAOVIEN nocheck constraint ALL
alter table HOCVIEN nocheck constraint ALL
alter table KETQUATHI nocheck constraint ALL 
alter table KHOA nocheck constraint ALL
alter table LOP nocheck constraint ALL 
alter table MONHOC nocheck constraint ALL

--Nhập dữ liệu
insert into KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA) values
('KHMT','Khoa hoc may tinh','6/7/2005','GV01'),
('HTTT','He thong thong tin','6/7/2005','GV02'),
('CNPM','Cong nghe phan mem','6/7/2005','GV04'),
('MTT','Mang va truyen thong','10/20/2005','GV03'),
('KTMT','Ky thuat may tinh','12/20/2005',null);

insert into GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA) values
('GV01','Ho Thanh Son','PTS','GS','Nam','5/2/1950','1/11/2004',5.00,2250000,'KHMT'),
('GV02','Tran Tam Thanh','TS','PGS','Nam','12/17/1965','4/20/2004',4.50,2025000,'HTTT'),
('GV03','Do Nghiem Phung','TS','GS','Nu','8/1/1950','9/23/2004',4.00,1800000,'CNPM'),
('GV04','Tran Nam Son','TS','PGS','Nam','2/22/1961','1/12/2005',4.50,2025000,'KTMT'),
('GV05','Mai Thanh Danh','ThS','GV','Nam','3/12/1958','1/12/2005',3.00,1350000,'HTTT'),
('GV06','Tran Doan Hung','TS','GV','Nam','3/11/1953','1/12/2005',4.50,2025000,'KHMT'),
('GV07','Nguyen Minh Tien','ThS','GV','Nam','11/23/1971','3/1/2005',4.00,1800000,'KHMT'),
('GV08','Le Thi Tran','KS','','Nu','3/26/1974','3/1/2005',1.69,760500,'KHMT'),
('GV09','Nguyen To Lan','ThS','GV','Nu','12/31/1966','3/1/2005',4.00,1800000,'HTTT'),
('GV10','Le Tran Anh Loan','KS','','Nu','7/17/1972','3/1/2005',1.86,837000,'CNPM'),
('GV11','Ho Thanh Tung','CN','GV','Nam','1/12/1980','5/15/2005',2.67,1201500,'MTT'),
('GV12','Tran Van Anh','CN','','Nu','3/29/1981','5/15/2005',1.69,760500,'CNPM'),
('GV13','Nguyen Linh Dan','CN','','Nu','5/23/1980','5/15/2005',1.69,760500,'KTMT'),
('GV14','Truong Minh Chau','ThS','GV','Nu','11/30/1976','5/15/2005',3.00,1350000,'MTT'),
('GV15','Le Ha Thanh','ThS','GV','Nam','5/4/1978','5/15/2005',3.00,1350000,'KHMT');
 
insert into MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA) values
('THDC','Tin hoc dai cuong',4,1,'KHMT'),
('CTRR','Cau truc roi rac',5,0,'KHMT'),
('CSDL','Co so du lieu',3,1,'HTTT'),
('CTDLGT','Cau truc du lieu va giai thuat',3,1,'KHMT'),
('PTTKTT','Phan tich thiet ke thuat toan',3,0,'KHMT'),
('DHMT','Do hoa may tinh',3,1,'KHMT'),
('KTMT','Kien truc may tinh',3,0,'KTMT'),
('TKCSDL','Thiet ke co so du lieu',3,1,'HTTT'),
('PTTKHTTT','Phan tich thiet ke he thong thong tin',4,1,'HTTT'),
('HDH','He dieu hanh',4,0,'KTMT'),
('NMCNPM','Nhap mon cong nghe phan mem',3,0,'CNPM'),
('LTCFW','Lap trinh C for win',3,1,'CNPM'),
('LTHDT','Lap trinh huong doi tuong',3,1,'CNPM');

insert into LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN) values
('K11','Lop 1 khoa 1','K1108',11,'GV07'),
('K12','Lop 2 khoa 1','K1205',12,'GV09'),
('K13','Lop 3 khoa 1','K1305',12,'GV14');

insert into HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) values
('K1101','Nguyen Van','A','1/27/1986','Nam','TpHCM','K11'),
('K1102','Tran Ngoc','Han','3/1/1986','Nu','Kien Giang','K11'),
('K1103','Ha Duy','Lap','4/18/1986','Nam','Nghe An','K11'),
('K1104','Tran Ngoc','Linh','3/30/1986','Nu','Tay Ninh','K11'),
('K1105','Tran Minh','Long','2/27/1986','Nam','TpHCM','K11'),
('K1106','Le Nhat','Minh','1/24/1986','Nam','TpHCM','K11'),
('K1107','Nguyen Nhu','Nhut','1/27/1986','Nam','Ha Noi','K11'),
('K1108','Nguyen Manh','Tam','2/27/1986','Nam','Kien Giang','K11'),
('K1109','Phan Thi Thanh','Tam','1/27/1986','Nu','Vinh Long','K11'),
('K1110','Le Hoai','Thuong','2/5/1986','Nu','Can Tho','K11'),
('K1111','Le Ha','Vinh','12/25/1986','Nam','Vinh Long','K11'),
('K1201','Nguyen Van','B','2/11/1986','Nam','TpHCM','K12'),
('K1202','Nguyen Thi Kim','Duyen','1/18/1986','Nu','TpHCM','K12'),
('K1203','Tran Thi Kim','Duyen','9/17/1986','Nu','TpHCM','K12'),
('K1204','Truong My','Hanh','5/19/1986','Nu','Dong Nai','K12'),
('K1205','Nguyen Thanh','Nam','4/17/1986','Nam','TpHCM','K12'),
('K1206','Nguyen Thi Truc','Thanh','3/4/1986','Nu','Kien Giang','K12'),
('K1207','Tran Thi Bich','Thuy','2/8/1986','Nu','Nghe An','K12'),
('K1208','Huynh Thi Kim','Trieu','4/8/1986','Nu','Tay Ninh','K12'),
('K1209','Pham Thanh','Trieu','2/23/1986','Nam','TpHCM','K12'),
('K1210','Ngo Thanh','Tuan','2/14/1986','Nam','TpHCM','K12'),
('K1211','Do Thi','Xuan','3/9/1986','Nu','Ha Noi','K12'),
('K1212','Le Thi Phi','Yen','3/12/1986','Nu','TpHCM','K12'),
('K1301','Nguyen Thi Kim','Cuc','6/9/1986','Nu','Kien Giang','K13'),
('K1302','Truong Thi My','Hien','3/18/1986','Nu','Nghe An','K13'),
('K1303','Le Duc','Hien','3/12/1986','Nam','Tay Ninh','K13'),
('K1304','Le Quang','Hien','4/18/1986','Nam','TpHCM','K13'),
('K1305','Le Thi','Huong','3/27/1986','Nu','TpHCM','K13'),
('K1306','Nguyen Thai','Huu','3/30/1986','Nam','Ha Noi','K13'),
('K1307','Tran Minh','Man','5/28/1986','Nam','TpHCM','K13'),
('K1308','Nguyen Hieu','Nghia','4/8/1986','Nam','Kien Giang','K13'),
('K1309','Nguyen Trung','Nghia','1/18/1987','Nam','Nghe An','K13'),
('K1310','Tran Thi Hong','Tham','4/22/1986','Nu','Tay Ninh','K13'),
('K1311','Tran Minh','Thuc','4/4/1986','Nam','TpHCM','K13'),
('K1312','Nguyen Thi Kim','Yen','9/7/1986','Nu','TpHCM','K13');

insert into GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY) values
('K11','THDC','GV07',1,2006,'1/2/2006','5/12/2006'),
('K12','THDC','GV06',1,2006,'1/2/2006','5/12/2006'),
('K13','THDC','GV15',1,2006,'1/2/2006','5/12/2006'),
('K11','CTRR','GV02',1,2006,'1/9/2006','5/17/2006'),
('K12','CTRR','GV02',1,2006,'1/9/2006','5/17/2006'),
('K13','CTRR','GV08',1,2006,'1/9/2006','5/17/2006'),
('K11','CSDL','GV05',2,2006,'6/1/2006','7/15/2006'),
('K12','CSDL','GV09',2,2006,'6/1/2006','7/15/2006'),
('K13','CTDLGT','GV15',2,2006,'6/1/2006','7/15/2006'),
('K13','CSDL','GV05',3,2006,'8/1/2006','12/15/2006'),
('K13','DHMT','GV07',3,2006,'8/1/2006','12/15/2006'),
('K11','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006'),
('K12','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006'),
('K11','HDH','GV04',1,2007,'1/2/2007','2/18/2007'),
('K12','HDH','GV04',1,2007,'1/2/2007','3/20/2007'),
('K11','DHMT','GV07',1,2007,'2/18/2007','3/20/2007');

insert into DIEUKIEN (MAMH, MAMH_TRUOC) values
('CSDL','CTRR'),
('CSDL','CTDLGT'),
('CTDLGT','THDC'),
('PTTKTT','THDC'),
('PTTKTT','CTDLGT'),
('DHMT','THDC'),
('LTHDT','THDC'),
('PTTKHTTT','CSDL');

insert into KETQUATHI (MAHV, MAMH, LT, NGTHI, DIEM, KQUA) values
('K1101','CSDL',1,'7/20/2006',10.00,'Dat'),
('K1101','CTDLGT',1,'12/28/2006',9.00,'Dat'),
('K1101','THDC',1,'5/20/2006',9.00,'Dat'),
('K1101','CTRR',1,'5/13/2006',9.50,'Dat'),
('K1102','CSDL',1,'7/20/2006',4.00,'Khong Dat'),
('K1102','CSDL',2,'7/27/2006',4.25,'Khong Dat'),
('K1102','CSDL',3,'8/10/2006',4.50,'Khong Dat'),
('K1102','CTDLGT',1,'12/28/2006',4.50,'Khong Dat'),
('K1102','CTDLGT',2,'1/5/2007',4.00,'Khong Dat'),
('K1102','CTDLGT',3,'1/15/2007',6.00,'Dat'),
('K1102','THDC',1,'5/20/2006',5.00,'Dat'),
('K1102','CTRR',1,'5/13/2006',7.00,'Dat'),
('K1103','CSDL',1,'7/20/2006',3.50,'Khong Dat'),
('K1103','CSDL',2,'7/27/2006',8.25,'Dat'),
('K1103','CTDLGT',1,'12/28/2006',7.00,'Dat'),
('K1103','THDC',1,'5/20/2006',8.00,'Dat'),
('K1103','CTRR',1,'5/13/2006',6.50,'Dat'),
('K1104','CSDL',1,'7/20/2006',3.75,'Khong Dat'),
('K1104','CTDLGT',1,'12/28/2006',4.00,'Khong Dat'),
('K1104','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1104','CTRR',1,'5/13/2006',4.00,'Khong Dat'),
('K1104','CTRR',2,'5/20/2006',3.50,'Khong Dat'),
('K1104','CTRR',3,'6/30/2006',4.00,'Khong Dat'),
('K1201','CSDL',1,'7/20/2006',6.00,'Dat'),
('K1201','CTDLGT',1,'12/28/2006',5.00,'Dat'),
('K1201','THDC',1,'5/20/2006',8.50,'Dat'),
('K1201','CTRR',1,'5/13/2006',9.00,'Dat'),
('K1202','CSDL',1,'7/20/2006',8.00,'Dat'),
('K1202','CTDLGT',1,'12/28/2006',4.00,'Khong Dat'),
('K1202','CTDLGT',2,'1/5/2007',5.00,'Dat'),
('K1202','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1202','THDC',2,'5/27/2006',4.00,'Khong Dat'),
('K1202','CTRR',1,'5/13/2006',3.00,'Khong Dat'),
('K1202','CTRR',2,'5/20/2006',4.00,'Khong Dat'),
('K1202','CTRR',3,'6/30/2006',6.25,'Dat'),
('K1203','CSDL',1,'7/20/2006',9.25,'Dat'),
('K1203','CTDLGT',1,'12/28/2006',9.50,'Dat'),
('K1203','THDC',1,'5/20/2006',10.00,'Dat'),
('K1203','CTRR',1,'5/13/2006',10.00,'Dat'),
('K1204','CSDL',1,'7/20/2006',8.50,'Dat'),
('K1204','CTDLGT',1,'12/28/2006',6.75,'Dat'),
('K1204','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1204','CTRR',1,'5/13/2006',6.00,'Dat'),
('K1301','CSDL',1,'12/20/2006',4.25,'Khong Dat'),
('K1301','CTDLGT',1,'7/25/2006',8.00,'Dat'),
('K1301','THDC',1,'5/20/2006',7.75,'Dat'),
('K1301','CTRR',1,'5/13/2006',8.00,'Dat'),
('K1302','CSDL',1,'12/20/2006',6.75,'Dat'),
('K1302','CTDLGT',1,'7/25/2006',5.00,'Dat'),
('K1302','THDC',1,'5/20/2006',8.00,'Dat'),
('K1302','CTRR',1,'5/13/2006',8.50,'Dat'),
('K1303','CSDL',1,'12/20/2006',4.00,'Khong Dat'),
('K1303','CTDLGT',1,'7/25/2006',4.50,'Khong Dat'),
('K1303','CTDLGT',2,'8/7/2006',4.00,'Khong Dat'),
('K1303','CTDLGT',3,'8/15/2006',4.25,'Khong Dat'),
('K1303','THDC',1,'5/20/2006',4.50,'Khong Dat'),
('K1303','CTRR',1,'5/13/2006',3.25,'Khong Dat'),
('K1303','CTRR',2,'5/20/2006',5.00,'Dat'),
('K1304','CSDL',1,'12/20/2006',7.75,'Dat'),
('K1304','CTDLGT',1,'7/25/2006',9.75,'Dat'),
('K1304','THDC',1,'5/20/2006',5.50,'Dat'),
('K1304','CTRR',1,'5/13/2006',5.00,'Dat'),
('K1305','CSDL',1,'12/20/2006',9.25,'Dat'),
('K1305','CTDLGT',1,'7/25/2006',10.00,'Dat'),
('K1305','THDC',1,'5/20/2006',8.00,'Dat'),
('K1305','CTRR',1,'5/13/2006',10.00,'Dat');

--Bật khóa ngoại
alter table DIEUKIEN check constraint ALL
alter table GIANGDAY check constraint ALL
alter table GIAOVIEN check constraint ALL
alter table HOCVIEN check constraint ALL
alter table KETQUATHI check constraint ALL 
alter table KHOA check constraint ALL
alter table LOP check constraint ALL 
alter table MONHOC check constraint ALL

--Phần I/Trang 11
--Cau11
alter table HOCVIEN
add constraint CHK_TUOI check (year(getdate())-year(NGSINH)>=18);

--Cau12
alter table GIANGDAY
add constraint CHK_NGAYGIANGDAY check (TUNGAY<DENNGAY);

--Cau13
alter table GIAOVIEN
add constraint CHK_TUOIVAOLAM check (year(NGVL)-year(NGSINH)>=22);

--Cau14
alter table MONHOC
add constraint CHK_TINCHI_MH check (abs(TCLT - TCTH) <= 3);



--Phần III/Trang 12
--1. 
select HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, HOCVIEN.NGSINH, HOCVIEN.MALOP
from HOCVIEN, LOP where LOP.TRGLOP = HOCVIEN.MAHV;

--2. 
select HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, KETQUATHI.LANTHI, KETQUATHI.DIEM
from HOCVIEN, KETQUATHI
where KETQUATHI.MAHV = HOCVIEN.MAHV
and HOCVIEN.MALOP = 'K12' and KETQUATHI.MAMH = 'CTRR'
order by HOCVIEN.TEN, HOCVIEN.HO;

--3.
select HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, MONHOC.TENMH
from HOCVIEN, KETQUATHI, MONHOC
where KETQUATHI.MAHV = HOCVIEN.MAHV
and KETQUATHI.MAMH = MONHOC.MAMH and LANTHI = 1 and KQUA = 'Dat';

--4. 
select HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
from HOCVIEN, KETQUATHI
where KETQUATHI.MAHV = HOCVIEN.MAHV
and HOCVIEN.MALOP = 'K11'
and KETQUATHI.MAMH = 'CTRR'
and KETQUATHI.LANTHI = 1 
and KQUA = 'Khong Dat';

--5. 
select distinct HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN
from HOCVIEN, KETQUATHI
where KETQUATHI.MAHV = HOCVIEN.MAHV
and KETQUATHI.MAMH = 'CTRR'
and HOCVIEN.MAHV not in 
(
    select MAHV from KETQUATHI
    where MAMH = 'CTRR' and KQUA = 'Dat'
);
