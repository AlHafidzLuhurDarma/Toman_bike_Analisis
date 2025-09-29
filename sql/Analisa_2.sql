
SELECT * FROM bike.bike_modification;

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

SELECT str_to_date("4/1/2021", "%d/%m/%Y") AS converted;

WITH date_now AS (
	SELECT dteday,
			str_to_date(dteday, "%d/%m/%Y") AS dateday
	FROM bike.bike_share_yr_0
)
SELECT d.dateday,
		t.*
FROM bike.bike_share_yr_0 t
JOIN date_now d
ON t.dteday=d.dteday;


WITH dataframe AS (
SELECT *
FROM bike.bike_share_yr_0
UNION
SELECT *
FROM bike.bike_share_yr_1
)
SELECT str_to_date(dt.dteday, "%d/%m/%Y") AS dateday, 
		dt.season, 
        dt.yr, dt.weekday, 
        dt.hr, 
        dt.rider_type, 
        dt.riders, 
        cost.price, 
        cost.COGS,
        ROUND(dt.riders*cost.price,2) AS revenue,
        ROUND(dt.riders*cost.price - cost.COGS*dt.riders,2) AS profit
FROM dataframe dt
LEFT JOIN bike.cost_table cost
ON dt.yr=cost.yr;

WITH dataframe AS (
SELECT *
FROM bike.bike_share_yr_0
UNION
SELECT *
FROM bike.bike_share_yr_1
)
SELECT  ROUND(SUM(cost.COGS*dt.riders),0) AS total_modal,
		ROUND(SUM(dt.riders*cost.price),0) AS revenue,
        ROUND(SUM(dt.riders*cost.price) - SUM(cost.COGS*dt.riders),0) AS keuntungan
FROM dataframe dt
LEFT JOIN bike.cost_table cost
ON dt.yr=cost.yr;

SELECT SUM(riders)
FROM bike.bike_share_yr_0
WHERE rider_type LIKE "casual";


SELECT hari,
		bulan,
        tahun,
		SUM(pengendara) AS total_pengendara
FROM bike.bike_modification
GROUP BY 1,2,3
ORDER BY total_pengendara;

SELECT DISTINCT suhu
FROM bike.bike_modification
ORDER BY 1 DESC;

SELECT suhu,
        SUM(pengendara) AS total_pengendara,
		ROUND(AVG(pengendara),2) AS rata2_pengendara
FROM bike.bike_modification
GROUP BY 1
ORDER BY 2 DESC, 3 DESC;

SELECT musim,
		COUNT(suhu) AS suhu
FROM bike.bike_modification
WHERE suhu = 0.7
GROUP BY 1;

SELECT musim,
		SUM(pengendara) AS total_pengendara
FROM bike.bike_modification
GROUP BY 1
ORDER BY 2 DESC;

WITH panas AS(
SELECT 	musim,
		suhu,
        pengendara
FROM bike.bike_modification
WHERE musim LIKE "%Panas%"
)
SELECT DISTINCT suhu,
		SUM(pengendara) AS total_pengendara
FROM panas
GROUP BY 1
ORDER BY 2 DESC;

WITH semi AS(
SELECT 	musim,
		suhu,
        pengendara
FROM bike.bike_modification
WHERE musim LIKE "%Semi%"
)
SELECT DISTINCT suhu,
		SUM(pengendara) AS total_pengendara
FROM semi
GROUP BY 1
ORDER BY 2 DESC;

SELECT musim,
		COUNT(holiday) AS jumlah_holiday
FROM bike.bike_modification
WHERE holiday LIKE "Hari raya"
GROUP BY musim;

SELECT tahun,
		bulan,
        ROUND(COUNT(holiday)/24,0) AS jumlah_holiday
FROM bike.bike_modification
WHERE holiday LIKE "Hari raya"
GROUP BY 1,2;


SELECT hari,
		jam,
        SUM(pengendara) AS total_pengendara
FROM bike.bike_modification
GROUP BY 1,2;

SELECT kelembapan,
	SUM(pengendara) AS total_pengendara
FROM bike.bike_modification
GROUP BY 1
ORDER BY 2 DESC;

SELECT musim,
		kelembapan,
        SUM(pengendara) AS total_pengendara
FROM bike.bike_modification
GROUP BY 1,2
ORDER BY 3 DESC;

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
GROUP BY 1