--cau1
CREATE DATABASE QLGV

CREATE TABLE KHOA(
	MAKHOA		 VARCHAR(4) PRIMARY KEY,
	TENKHOA		 VARCHAR(40),
	NGTLAP		 SMALLDATETIME,
	TRGKHOA		 CHAR(4)
);
CREATE TABLE MONHOC(
	MAMH		 VARCHAR (10) PRIMARY KEY,
	TCLT		 TINYINT,
	TCTH		 TINYINT,
	MAKHOA		 VARCHAR(4),
	FOREIGN KEY	(MAKHOA)	REFERENCES	KHOA(MAKHOA)
);
CREATE TABLE DIEUKIEN(
	MAMH		VARCHAR(10),
	MAMH_TRUOC	VARCHAR(10),
	PRIMARY KEY (MAMH, MAMH_TRUOC),
	FOREIGN KEY (MAMH)	REFERENCES MONHOC(MAMH),
	FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH)
);
CREATE TABLE GIAOVIEN(
	MAGV		CHAR(4)	Primary Key,
	HOTEN		VARCHAR(40),
	HOCVI		VARCHAR(10),
	HOCHAM		VARCHAR(10),
	GIOITINH	VARCHAR(3),
	NGSINH		SMALLDATETIME,
	NGVL		SMALLDATETIME,
	HESO		NUMERIC(4,2),
	MUCLUONG	MONEY,
	MAKHOA		VARCHAR(4)
	FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);
CREATE TABLE LOP(
	MALOP		CHAR(3) PRIMARY KEY,
	TENLOP		VARCHAR(40),
	TRGLOP		CHAR(5),
	SISO		TINYINT,
	MAGVCN		CHAR(4)
);
CREATE TABLE HOCVIEN(
	MAHV		CHAR(5) PRIMARY KEY,
	HO			VARCHAR(40),
	TEN			VARCHAR(10),
	NGSINH		SMALLDATETIME,
	GIOITINH	VARCHAR(3),
	NOISINH		VARCHAR(40),
	MALOP		CHAR(3)
);
CREATE TABLE GIANGDAY(
	MALOP		CHAR(3),
	MAMH		VARCHAR(10),
	MAGV		CHAR(4),
	HOCKY		TINYINT,
	NAM			SMALLINT,
	TUNGAY		SMALLDATETIME,
	DENNGAY		SMALLDATETIME,
	PRIMARY KEY (MALOP, MAMH),
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
    FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
);
CREATE TABLE KETQUATHI(
	MAHV		CHAR(5),
	MAMH		VARCHAR(10),
	LANTHI		TINYINT,
	NGTHI		SMALLDATETIME,
	DIEM		NUMERIC(4,2),
	KQUA		VARCHAR(10),
    PRIMARY KEY (MAHV, MAMH, LANTHI),
    FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);



--cau3
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_GIOITINHGV CHECK (GIOITINH IN ('Nam', 'Nu'))
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_GIOITINHHV CHECK (GIOITINH IN ('Nam', 'Nu'));

--cau4
ALTER TABLE KETQUATHI
ALTER COLUMN DIEM DECIMAL(4, 2);
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_DIEM CHECK (DIEM >= 0 AND DIEM <= 10); 

--cau5
ALTER TABLE KETQUATHI ADD CONSTRAINT CHK_KETQUA CHECK
(	
	(KQUA = 'Dat' AND DIEM >= 5 AND DIEM <= 10)
	OR (KQUA = 'Khong dat' AND DIEM < 5)
)

--cau6
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_LANTHI CHECK(LANTHI <= 3);

--cau7
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHK_HOCKY CHECK (HOCKY >= 1 AND HOCKY <= 3);

--cau8
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_HOCVI CHECK (HOCVI IN ('CN', 'KS' , 'Ths' , 'TS', 'PTS'));