
/*

	Digunakan untuk analisa yang lebih mendalam dan sebagai tempat cek/konfirmasi apakah hasil dari 
	PowerBI maupun Excel benar

*/

-- Buat table untuk analisa

CREATE TABLE bike.main AS
WITH cost_data AS(
SELECT CASE
	WHEN yr=0 THEN 2021
    ELSE 2022
    END AS tahun,
    price AS harga,
    COGS AS pengeluaran
FROM bike.cost_table)
SELECT bike.*,
	cost.harga,
    cost.pengeluaran AS modal,
	ROUND(bike.pengendara * cost.harga,2) AS Pendapatan,
    ROUND(bike.pengendara * cost.pengeluaran,2) AS Pengeluaran,
    ROUND((bike.pengendara * cost.harga) - (bike.pengendara * cost.pengeluaran), 2) AS Keuntungan
FROM bike.bike_modification bike
JOIN cost_data cost
ON bike.tahun=cost.tahun;


-- Ketahui hubungan antar metrik dan dimensi

SELECT musim,
		SUM(keuntungan) AS total_keuntungan
FROM bike.main
GROUP BY 1
ORDER BY 2 DESC;

SELECT tipe_pengendara,
		SUM(keuntungan) AS total_keuntungan
FROM bike.main
GROUP BY 1
ORDER BY 2 DESC;

SELECT situasi_cuaca,
		SUM(keuntungan) AS total_keuntungan,
        SUM(pengendara) AS total_pengendara
FROM bike.main
GROUP BY 1
ORDER BY 2 DESC;

SELECT tahun,
		musim,
		situasi_cuaca,
        SUM(keuntungan) AS total_keuntungan,
        SUM(pengendara) AS total_pengendara
FROM bike.main
GROUP BY 1,2,3
ORDER BY 1 DESC,2 DESC;

SELECT bulan,
		SUM(keuntungan) AS total_keuntungan,
        ROW_NUMBER() OVER() AS num
FROM bike.main
GROUP BY 1;

-- Buat daftar untuk bulan terbaik berdasarkan keuntungan pada tahun 2021

WITH ranking AS (
		SELECT bulan,
				SUM(keuntungan) AS total_keuntungan,
				ROW_NUMBER() OVER(ORDER BY SUM(keuntungan) ASC) AS 2021_ranking
		FROM bike.main
		WHERE tahun = 2021
		GROUP BY 1
)
SELECT CASE
			WHEN bulan = 1 THEN "Januari"
            WHEN bulan = 2 THEN "Februari"
            WHEN bulan = 3 THEN "Maret"
            WHEN bulan = 4 THEN "April"
            WHEN bulan = 5 THEN "Mei"
            WHEN bulan = 6 THEN "Juni"
            WHEN bulan = 7 THEN "Juli"
            WHEN bulan = 8 THEN "Agustus"
            WHEN bulan = 9 THEN "September"
            WHEN bulan = 10 THEN "Oktober"
            WHEN bulan = 11 THEN "November"
			WHEN bulan = 12 THEN "Desember"
        END AS nama_bulan,
        total_keuntungan,
        2021_ranking
FROM ranking;

-- Ranking untuk hari terbaik berdasarkan keuntungan pada tahun 2021

WITH selected AS(
SELECT 	DAY(tanggal) AS hari,
CASE
			WHEN bulan = 1 THEN "Januari"
            WHEN bulan = 2 THEN "Februari"
            WHEN bulan = 3 THEN "Maret"
            WHEN bulan = 4 THEN "April"
            WHEN bulan = 5 THEN "Mei"
            WHEN bulan = 6 THEN "Juni"
            WHEN bulan = 7 THEN "Juli"
            WHEN bulan = 8 THEN "Agustus"
            WHEN bulan = 9 THEN "September"
            WHEN bulan = 10 THEN "Oktober"
            WHEN bulan = 11 THEN "November"
			WHEN bulan = 12 THEN "Desember"
        END AS nama_bulan,
		SUM(Keuntungan) AS total_keuntungan
FROM bike.main
WHERE tahun = 2021
GROUP BY 1,2)
SELECT CONCAT(nama_bulan, " ", hari) AS tanggal,
		total_keuntungan,
        ROW_NUMBER() OVER(ORDER BY total_keuntungan DESC) AS ranking
FROM selected;

-- Buat table dengan nama bulan untuk mempermudah

CREATE TABLE bike.bike_month AS
SELECT bulan,
		CASE
			WHEN bulan = 1 THEN "Januari"
            WHEN bulan = 2 THEN "Februari"
            WHEN bulan = 3 THEN "Maret"
            WHEN bulan = 4 THEN "April"
            WHEN bulan = 5 THEN "Mei"
            WHEN bulan = 6 THEN "Juni"
            WHEN bulan = 7 THEN "Juli"
            WHEN bulan = 8 THEN "Agustus"
            WHEN bulan = 9 THEN "September"
            WHEN bulan = 10 THEN "Oktober"
            WHEN bulan = 11 THEN "November"
			WHEN bulan = 12 THEN "Desember"
        END AS nama_bulan
FROM bike.main
GROUP BY 1;


-- Buat tabel tentang total keuntungan dan rata-rata pengeluaran berdasarkan waktu

WITH penjualan_overtime AS(
	SELECT YEAR(tanggal) AS year_date,
			MONTH(tanggal) AS month_date,
			SUM(keuntungan) AS total_keuntungan,
			ROUND(AVG(pengeluaran),2) AS avg_pengeluaran
	FROM bike.main
	GROUP BY 1,2
)
SELECT p.year_date AS tahun,
		m.nama_bulan,
        CONCAT("$ ",p.total_keuntungan) AS total_keuntungan,
        CONCAT("$ " ,SUM(p.total_keuntungan) OVER(PARTITION BY p.year_date ORDER BY p.year_date,p.month_date)) AS akumulasi_total_keuntungan,
        CONCAT("$ ", p.avg_pengeluaran) AS avg_pengeluaran,
        CONCAT("$ " ,ROUND(AVG(p.avg_pengeluaran) OVER(PARTITION BY p.year_date ORDER BY p.year_date,p.month_date),2)) AS akumulasi_avg_pengeluaran
FROM penjualan_overtime p
JOIN bike.bike_month m
ON p.month_date=m.bulan;


-- Lihat data tentang jumlah pengendara berdasarkan jenis pengendara berdasarkan waktu

WITH jenis_pengendara AS(
	SELECT tahun,
			bulan,
			tipe_pengendara,
			SUM(pengendara) AS total_pengendara
	FROM bike.main
	GROUP BY 1,2,3
)
SELECT j.tahun,
		m.nama_bulan,
        j.tipe_pengendara,
        j.total_pengendara,
        SUM(j.total_pengendara) OVER(PARTITION BY j.tipe_pengendara ORDER BY j.tahun, j.bulan) AS akumulasi_total_pengendara
FROM jenis_pengendara j
JOIN bike.bike_month m
ON j.bulan = m.bulan;


-- Kontribusi masing-masing tipe pengendara terhadap jumlah pengendara

WITH tipe AS(
	SELECT tipe_pengendara,
			SUM(pengendara) AS total_pengendara
	FROM bike.main
	GROUP BY 1
)
SELECT tipe_pengendara,
		total_pengendara,
        SUM(total_pengendara) OVER() AS total_keseluruhan,
        CONCAT(ROUND((total_pengendara / SUM(total_pengendara) OVER() * 100),2), " %") AS kontribusi
FROM tipe
GROUP BY 1,2;


-- jumlah pengendara casual dan registered terbanyak berdasarkan Jam terbaik

WITH casual_jam AS(
	WITH tipe_jam AS(
		SELECT hari,
				jam,
				tipe_pengendara,
				SUM(pengendara) AS total_pengendara
		FROM bike.main
		WHERE tahun = 2021
		GROUP BY 1,2,3
	)
	SELECT ROW_NUMBER() OVER() AS ranking,
			CONCAT(hari, " jam ", jam, " memiliki jumlah pengendara ", total_pengendara) AS ranking_jam_terbaik_pengendara_casual_2021
	FROM tipe_jam
	WHERE tipe_pengendara LIKE "casual"
	ORDER BY total_pengendara DESC
	LIMIT 5
),
registered_jam AS(
	WITH tipe_jam AS(
		SELECT hari,
				jam,
				tipe_pengendara,
				SUM(pengendara) AS total_pengendara
		FROM bike.main
		WHERE tahun = 2021
		GROUP BY 1,2,3
	)
	SELECT ROW_NUMBER() OVER() AS ranking,
			CONCAT(hari, " jam ", jam, " memiliki jumlah pengendara ", total_pengendara) AS ranking_jam_terbaik_pengendara_registered_2021
	FROM tipe_jam
	WHERE tipe_pengendara LIKE "registered"
	ORDER BY total_pengendara DESC
	LIMIT 5
)
SELECT r.ranking,
		c.ranking_jam_terbaik_pengendara_casual_2021,
        r.ranking_jam_terbaik_pengendara_registered_2021
FROM registered_jam r
JOIN casual_jam c
ON r.ranking=c.ranking;


/*
Akumulasi berjalan pada hari libur di tiap tahun, dan bulan berdasarkan jumlah pengendara dan kontribusinya
setiap bulan terhadap data akumulasi tersebut
*/

WITH libur AS(
	SELECT tahun,
			bulan,
			SUM(pengendara) AS total_pengendara
	FROM bike.main
	WHERE status_hari_kerja LIKE "Hari Libur"
	GROUP BY 1,2
),
akumulasi AS (SELECT tahun,
		bulan,
        total_pengendara,
        SUM(total_pengendara) OVER(PARTITION BY tahun ORDER BY tahun, bulan) AS akumulasi_pengendara_libur,
        SUM(total_pengendara) OVER() AS total_keseluruhan
FROM libur
)
SELECT tahun,
		bulan,
        total_pengendara,
        akumulasi_pengendara_libur,
        CONCAT(ROUND(total_pengendara/total_keseluruhan * 100,2), " %") AS persentase_dari_keseluruhan_pengendara_libur
FROM akumulasi;


-- Performa keuntungan berdasarkan hari libur dan cuaca yang cerah

WITH libur_cerah AS(
SELECT main.tahun,
		mth.nama_bulan,
        SUM(main.pengendara) AS total_pengendara,
        CONCAT(ROUND(SUM(main.keuntungan),1), " $") AS total_keuntungan
FROM bike.main main
JOIN bike.bike_month mth
ON main.bulan = mth.bulan
WHERE main.status_hari_kerja LIKE "Hari Libur" AND main.situasi_cuaca LIKE "Cerah"
GROUP BY 1,2
)
SELECT *
FROM libur_cerah
ORDER BY total_pengendara DESC;


-- Akumulasi keuntungan berdasarkan musim

WITH seleksi_musim AS(
SELECT tahun,
		bulan,
        musim,
        SUM(keuntungan) AS total_keuntungan
FROM bike.main
WHERE tahun = 2022
GROUP BY 1,2,3
)
SELECT tahun,
		bulan,
        musim,
        CONCAT("$ ",ROUND(total_keuntungan,1)) AS total_keuntungan,
        CONCAT("$ ", SUM(ROUND(total_keuntungan,1)) OVER(PARTITION BY musim ORDER BY tahun, bulan,musim)) AS akumulasi_per_musim
FROM seleksi_musim;


-- Lihat apakah terdapat bulan dimana pengendara pada tahun 2021 lebih sedikit dari pada 2022

WITH first_year AS(
SELECT tahun,
		bulan,
		SUM(pengendara) AS total_pengendara_2021
FROM bike.main
WHERE tahun = 2021
GROUP BY 1,2
), second_year AS(
SELECT tahun,
		bulan,
		SUM(pengendara) AS total_pengendara_2022
FROM bike.main
WHERE tahun=2022
GROUP BY 1,2
)
SELECT f.bulan,
		f.total_pengendara_2021,
        s.total_pengendara_2022,
        CASE
			WHEN f.total_pengendara_2021 < s.total_pengendara_2022 THEN "Naik"
            WHEN f.total_pengendara_2021 > s.total_pengendara_2022 THEN "Turun"
		END AS performa,
        s.total_pengendara_2022 - f.total_pengendara_2021 AS nilai_perubahan
FROM first_year f
JOIN second_year s
ON f.bulan = s.bulan;
-- ORDER BY nilai DESC


-- Lihat apakah terdapat bulan dimana pengendara Casual dan Registered pada tahun 2021 lebih sedikit dari pada 2022
-- Semua mengalami kenaikan, tambahkan nilai persentase untuk melihat kenaikan paling signifikan

WITH first_year AS(
SELECT tahun,
		bulan,
		SUM(pengendara) AS total_pengendara_2021
FROM bike.main
WHERE tahun = 2021 AND tipe_pengendara LIKE "Registered"
GROUP BY 1,2
), second_year AS(
SELECT tahun,
		bulan,
		SUM(pengendara) AS total_pengendara_2022
FROM bike.main
WHERE tahun=2022 AND tipe_pengendara LIKE "Registered"
GROUP BY 1,2
)
SELECT f.bulan,
		f.total_pengendara_2021 AS total_pengendara_registered_2021,
        s.total_pengendara_2022 AS total_pengendara_registered_2022,
        CASE
			WHEN f.total_pengendara_2021 < s.total_pengendara_2022 THEN "Naik"
            WHEN f.total_pengendara_2021 > s.total_pengendara_2022 THEN "Turun"
		END AS performa,
        s.total_pengendara_2022 - f.total_pengendara_2021 AS nilai_perubahan,
        CONCAT(ROUND(((s.total_pengendara_2022 - f.total_pengendara_2021) / f.total_pengendara_2021) * 100,2), "%") AS persentase
FROM first_year f
JOIN second_year s
ON f.bulan = s.bulan;


-- Berdasarkan pada setiap musim, jam berapa para pelanggan sering datang memesan sepeda?

WITH semi AS(
SELECT musim,
		jam,
        SUM(pengendara) AS total_pengendara,
        ROW_NUMBER() OVER(ORDER BY SUM(pengendara) DESC) AS ranking
FROM bike.main
WHERE musim LIKE "Semi"
GROUP BY 1,2
LIMIT 6
), dingin AS(
SELECT musim,
		jam,
        SUM(pengendara) AS total_pengendara,
        ROW_NUMBER() OVER(ORDER BY SUM(pengendara) DESC) AS ranking
FROM bike.main
WHERE musim LIKE "Dingin"
GROUP BY 1,2
LIMIT 6
), semi_dingin AS(
SELECT s.ranking,
		s.jam AS jam_musim_semi,
        s.total_pengendara AS pengendara_musim_semi,
        d.jam AS jam_musim_dingin,
        d.total_pengendara AS pengendara_musim_dingin
FROM semi s
JOIN dingin d
ON s.ranking=d.ranking
), gugur AS(
SELECT musim,
		jam,
        SUM(pengendara) AS total_pengendara,
        ROW_NUMBER() OVER(ORDER BY SUM(pengendara) DESC) AS ranking
FROM bike.main
WHERE musim LIKE "Gugur"
GROUP BY 1,2
LIMIT 6
), panas AS(
SELECT musim,
		jam,
        SUM(pengendara) AS total_pengendara,
        ROW_NUMBER() OVER(ORDER BY SUM(pengendara) DESC) AS ranking
FROM bike.main
WHERE musim LIKE "Panas"
GROUP BY 1,2
LIMIT 6
), gugur_panas AS(
SELECT g.ranking,
		g.jam AS jam_musim_gugur,
        g.total_pengendara AS pengendara_musim_gugur,
        p.jam AS jam_musim_panas,
        p.total_pengendara AS pengendara_musim_semi
FROM gugur g
JOIN panas p
ON g.ranking=p.ranking
)
SELECT *
FROM semi_dingin ds
JOIN gugur_panas gp
ON ds.ranking=gp.ranking;


-- total pelanggan berdasarkan situasi suhu dan a_suhu

WITH suhu AS(
SELECT suhu,
		SUM(pengendara) AS total_pengendara,
        ROW_NUMBER() OVER(ORDER BY SUM(pengendara) DESC) AS ranking
FROM bike.main
GROUP BY 1
LIMIT 6
), a_suhu AS(
SELECT a_suhu,
		SUM(pengendara) AS total_pengendara,
        ROW_NUMBER() OVER(ORDER BY SUM(pengendara) DESC) AS ranking
FROM bike.main
GROUP BY 1
LIMIT 6
)
SELECT s.ranking,
		s.suhu,
        s.total_pengendara,
        a.a_suhu,
        a.total_pengendara
FROM suhu s
JOIN a_suhu a
ON s.ranking=a.ranking;


-- Pengecekan data dan melakukan analisa total pelanggan berdasarkan situasi cuaca

SELECT situasi_cuaca,
		SUM(pengendara) AS total_pengendara
FROM bike.main
GROUP BY 1;

WITH seleksi_cuaca AS(
SELECT tahun,
		bulan,
        situasi_cuaca,
        SUM(pengendara) AS total_pengendara
FROM bike.main
WHERE tahun = 2022
GROUP BY 1,2,3
)
SELECT tahun,
		bulan,
        situasi_cuaca,
        total_pengendara,
        SUM(total_pengendara) OVER(PARTITION BY situasi_cuaca ORDER BY tahun, bulan,situasi_cuaca) AS akumulasi_per_cuaca
FROM seleksi_cuaca;

-- 
