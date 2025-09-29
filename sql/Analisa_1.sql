
/*
=============== EDA sederhana =============

Identifikasi masing-masing kolom dan table
===========================================
*/

DESCRIBE bike.bike_share_yr_0;
SELECT * FROM bike.bike_share_yr_0
WHERE workingday = 0;

SELECT DISTINCT season FROM bike.bike_share_yr_0;
SELECT DISTINCT rider_type FROM bike.bike_share_yr_0;
SELECT DISTINCT weathersit FROM bike.bike_share_yr_0;

SELECT *
FROM bike.bike_share_yr_0
HAVING windspeed != 0;

/*

* Ganti format dteday dari text menjadi date

* Buat data yang memiliki keterangan pengganti data numerik dengan acuan:
	-season
		1(Desember-Februari, Musim Dingin)
		2(Maret-Mei, Musim Semi)
		3(Juni-Agustus, Musim Panas)
		4(September-November, Musim Gugur)
	-holiday
		0 = bukan hari raya
        1 = hari raya
	-workingday
		0 = libur
        1 = hari kerja
	-weekday
		0 = minggu ~~ 6 = sabtu
	-weathersit
		1 = Cerah
        2 = Kabut/Awan
        3 = Hujan/Salju Ringan
        4 = Hujan/Salju Lebat
*/

-- Ubah Format Waktu
SELECT dteday,
		str_to_date(dteday, "%d/%m/%Y") AS dateday
FROM bike.bike_share_yr_0;

-- Ubah format jam (Mungkin akan dibutuhkan)
SELECT dteday,
	CASE
		WHEN hr BETWEEN 0 AND 9 THEN CONCAT("0",hr,":00:00")
        ELSE CONCAT(hr,":00:00")
	END AS hourly_format,
    riders
FROM bike.bike_share_yr_0;

-- Ubah Numerik => Teks
SELECT season,
	CASE
		WHEN season = 1 THEN "Dingin"
        WHEN season = 2 THEN "Semi"
        WHEN season = 3 THEN "Panas"
        ELSE "Gugur"
	END AS season_name
FROM bike.bike_share_yr_0;

SELECT yr,
	CASE 
		WHEN yr = 0 THEN 2021
        ELSE 2022
	END AS year_date
FROM bike.bike_share_yr_0;

SELECT holiday,
	CASE
		WHEN holiday = 0 THEN "Bukan hari raya"
        ELSE "Hari raya"
	END AS holiday_status
FROM bike.bike_share_yr_0;

SELECT workingday,
	CASE
		WHEN workingday = 0 THEN "Hari Libur"
        ELSE "Hari Kerja"
	END AS workingday_status
FROM bike.bike_share_yr_0;

SELECT weekday,
	CASE
		WHEN weekday = 0 THEN "Minggu"
        WHEN weekday = 1 THEN "Senin"
        WHEN weekday = 2 THEN "Selasa"
        WHEN weekday = 3 THEN "Rabu"
        WHEN weekday = 4 THEN "Kamis"
        WHEN weekday = 5 THEN "Jumat"
        ELSE "Sabtu"
	END AS day_name
FROM bike.bike_share_yr_0;

SELECT weathersit,
	CASE
		WHEN weathersit = 1 THEN "Cerah"
        WHEN weathersit = 2 THEN "Kabut/Awan"
        WHEN weathersit = 3 THEN "Hujan/Salju Ringan"
        ELSE "Hujan/Salju Lebat"
	END AS weather_situation
FROM bike.bike_share_yr_0;


-- Gabungkan bike_share_yr_0 dan bike_share_yr_1 dan implementasikan perubahan2 diatas

CREATE TABLE bike.bike_modification AS
WITH bike_data AS(
SELECT *
FROM bike.bike_share_yr_0
UNION
SELECT *
FROM bike.bike_share_yr_1)
SELECT str_to_date(dteday, "%d/%m/%Y") AS tanggal,
	mnth AS bulan,
	CASE
		WHEN season = 1 THEN "Dingin"
        WHEN season = 2 THEN "Semi"
        WHEN season = 3 THEN "Panas"
        ELSE "Gugur"
	END AS musim,
	CASE 
		WHEN yr = 0 THEN 2021
        ELSE 2022
	END AS tahun,
	CASE
		WHEN holiday = 0 THEN "Bukan hari raya"
        ELSE "Hari raya"
	END AS holiday,
	CASE
		WHEN workingday = 0 THEN "Hari Libur"
        ELSE "Hari Kerja"
	END AS status_hari_kerja,
	CASE
		WHEN weekday = 0 THEN "Minggu"
        WHEN weekday = 1 THEN "Senin"
        WHEN weekday = 2 THEN "Selasa"
        WHEN weekday = 3 THEN "Rabu"
        WHEN weekday = 4 THEN "Kamis"
        WHEN weekday = 5 THEN "Jumat"
        ELSE "Sabtu"
	END AS hari,
    hr AS jam,
	CASE
		WHEN weathersit = 1 THEN "Cerah"
        WHEN weathersit = 2 THEN "Kabut/Awan"
        WHEN weathersit = 3 THEN "Hujan/Salju Ringan"
        ELSE "Hujan/Salju Lebat"
	END AS situasi_cuaca,
    temp AS suhu,
    atemp AS a_suhu,
    hum AS kelembapan,
    windspeed AS kecepatan_angin,
    rider_type AS tipe_pengendara,
    riders AS pengendara
FROM bike_data;