# Laporan Performa Toman Bike Share (2021-2022)

## Daftar Isi:
  * Ringkasan Eksekutif
  * Tujuan
  * Deskripsi Data
  *	Laporan Kinerja Perusahaan
    *	Performa Menyeluruh
    *	Periode Terbaik
    *	Demografi Pelanggan
    *	Aspek Eksternal
  *	Analisa Keputusan Menaikkan Harga
    *	Perubahan Jumlah Pelanggan
    *	Dampak pada Laba
  *	Rekomendasi
  *	Tambahan

## Ringkasan Eksekutif
Laporan ini menganalisa performa Toman Bike Share pada 2021 dan 2022, berfokus kepada dampak dari kenaikan harga dari $3.99 ke $4.99 per-unit sepeda. Hasil analisis menunjukkan peningkatan pendapatan dari $4.96M menjadi $10.23M dan laba bersih dari $3.42M menjadi $7.03M. Meskipun biaya operasional meningkat hampir dua kali lipat, margin laba tetap terjaga pada 45.35%. 
Pelanggan registered menyumbang 81% total perjalanan, sementara pelanggan casual mendominasi di musim panas. Insight ini menjadi dasar bagi strategi harga, promosi musiman, dan optimalisasi operasional.

## Tujuan
*	Analisa Pertumbuhan: Evaluasi pengaruh dari kenaikan harga sewa terhadap pola pertumbuhan revenue dan profit.
*	Klasifikasi Performa Perusahaan: Identifikasi pola profitability dalam berbagai aspek seperti bulan paling favorit bagi pelanggan, pengaruh hari libur, serta melakukan kajian dari dampak cuaca (suhu, kelembapan, dan musim) terhadap kinerja bisnis.
*	Profilling Pelanggan: Analisa perbedaan karakteristik antara pelanggan biasa(casual) dan langganan(registered) supaya bisa menemukan peluang untuk menaikkan bisnis.

## Deskripsi Data

Analisa akan berdasarkan pada data yang disediakan oleh Toman Bike Share dengan beberapa poin penting dalam operasi bisnis:

* Tanggal: Data memiliki rentang waktu 2 tahun, antara tahun 2021 sampai 2022 dengan satuan paling kecil adalah Jam, karena Toman Bike Share membuka penyewaan selama 24 jam, dan juga dilengkapi dengan keterangan hari libur serta hari aktif kerja.
* Faktor Luar: Toman Bike Share memiliki data yang menunjukkan faktor diluar kendali Perusahaan seperti kelembapan, suhu, musim, dan cuaca.
* Jenis Pelanggan: Pelanggan dibagi menjadi 2, yakni pelanggan Casual dan pelanggan Registered.
* Harga: Pada tahun 2021, harga sewa sepeda ada pada $3.99 per unit. Dan pada tahun 2022, harga sewa menjadi $4.99 per unit.

<p align="center">
 <img src="https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/Screenshot%202025-09-27%20183940.png" width=400 height=300> 
</p>

## Laporan Kinerja Perusahaan

* **Performa Menyeluruh**: Total pendapatan meningkat dari $4,96 juta pada tahun 2021 menjadi $10,23 juta pada tahun 2022, sementara laba bersih naik dari $3,42 juta menjadi $7,03 juta. Meskipun biaya operasional hampir dua kali lipat, margin laba keseluruhan tetap kuat pada angka 45,35%.
<p align="center">
 <img src="https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/BI_1.png" width=600 height=400>
</p>

* **Periode Terbaik**: Banyak pelanggan Toman Bike Share yang menyewa sepeda tidak secara rutin, kemungkinan ini karena pengaruh cuaca dan musim.
  *	Kuartal ketiga (Juli Sampai September) muncul sebagai periode paling menguntungkan dengan total laba bersih $3.30 Juta.
  *	Musim panas (Juni–September) juga menghasilkan total laba bersih tertinggi senilai  $3.35 Juta.
  *	Pada tahun 2021, 2 Juni menjadi hari dengan keuntungan puncak mencapai 394K. Dan pada tahun 2022 keuntungan puncak mencapai 749K pada 3 September.

* **Demografi Pelanggan**: Pelanggan Toman Bike Share dibagi menjadi 2 kategori, Casual dan Registered. Dengan persentase 81% pelanggan Registered, dan 19% pelanggan Casual.
  *	Total laba bersih yang didapat dari pelanggan Registered selama periode 2021 - 2022 adalah $8.49 Juta dengan puncaknya ada pada bulan September 2022 dengan laba bersih $600K. Pada tahun 2021, pelanggan Registered memberi keuntungan sebesar $2.73 Juta. Dan pada tahun 2022 memberi keuntungan sebesar $5.75 Juta 
  *	Total laba bersih yang didapat dari pelanggan Casual selama periode 2021 - 2022 adalah $1.9 Juta dengan puncaknya ada pada bulan Mei 2022 dengan laba bersih $151K .Pada tahun 2021, pelanggan Casual memberi keuntungan sebesar $680K. Dan pada tahun 2022  memberi keuntungan sebesar $1.28 Juta.
  *	Pelanggan Registered dan Casual mengalami jumlah kenaikan dari 2021 ke 2022 dengan rata-rata kenaikan jumlah pelanggan Registered 79.1% dan pelanggan Casual 65.3%.

*	**Aspek Eksternal**: Suhu yang berkisar diantara 0.6 sampai 07 memiliki pengaruh signifikan terhadapa jumlah pelanggan (biasa dan langganan). Dan tentu cuaca yang cerah menjadi favorit pelanggan dengan total jumlah pelanggan sebesar 2.338.173 selama periode 2021 -2022.

<p align="center">
<img src="https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/laba_per_musim.png" width=500 height=400>
</p>

<p align="center">
<img src="https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/total_pengendara_per_suhu.png" width=300 height=300>
<img src="https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/total_pengendara_per_cuaca.png" width=300 height=300>
</p>

## Analisa Keputusan Menaikkan Harga Sewa
Kebijakan Toman Bike Share untuk menaikkan tarif terbukti tepat dan mengutungkan, ditunjukkan dengan tidak adanya penurunan jumlah pelangggan, bahkan terjadi peningkatan pada kedua segmen pelanggan. 
*	Perubahan Jumlah Pelanggan.
    *	Pelanggan Registered mengalami kenaikan jumlah pada semua bulan, dengan kenaikan tertinggi ada pada bulan Maret yang pada 2021 total pelanggan ada 51.219 orang kini menjadi 133.257 orang yang berarti mengalami kenaikan sebesar 160%..
    *	Pada tahun 2021, total pelanggan Registered tertinggi ada pada bulan Juni dengan 112.900 orang, dan pada tahun 2022 pelanggan tertinggi ada pada bulan September dengan total 174.795 orang.

<p align="center">
 <img src="https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/perbandingan_total_pengendara_recasual_antar_tahun.png" width=400 height=300>
</p>

   *	Pelanggan Casual juga mengalami kenaikan jumlah pada semua bulan, dengan kenaikan tertinggi ada pada bulan Januari yang pada 2021 total pelanggan ada 3.073 orang kini menjadi 8960 orang yang berarti mengalami kenaikan sebesar 190%.
   *	Pada tahun 2021, total pelanggan Registered tertinggi ada pada bulan Juli dengan 36.452 orang, dan pada tahun 2022 pelanggan tertinggi ada pada bulan Mei dengan total 44.235 orang.

<p align="center">
 <img src="https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/perbandingan_total_pengendara_registered_antar_tahun.png" width=400 height=300>
</p>

*	Dampak pada Laba: Pada tahun 2021, dengan harga sewa $3.99 Bulan Januari sampai Maret mengalami kenaikan konstan dan mencapai titik tertinggi dengan laba bersih $394K dan mengalami penurunan pada bulan Juli dengan laba bersih $388K. Sedangkan tahun 2022, ketika harga sewa dinaikkan menjadi 4.99 , kenaikan konstan justru mulai dari Januari hingga September dengan keuntungan tertinggi ada pada $750K dan menurun mulai pada Oktober dengan keuntungan 682K.

  ## Rekomendasi

*	Harga Sewa: Keputusan menaikkan harga menjadi $4.99 terbukti tidak menurunkan demand sama sekali. Namun tetap lakukan evaluasi untuk jangka panjang.
*	Musim: Manfaatkan jumlah pelanggan pada Musim Panas dan periode Kuartal ke-3 dengan melakukan promosi tambahan, lakukan event atau pemberian bonus untuk menjaga kepercayaan pelanggan.
    *	Pada pelanggan Registered tawarkan paket loyalty
    *	Pada pelanggan Casual, dorong promo musiman (paket holiday).
*	Efisiensi Operasional: Untuk menjada keuntungan akibat kebaikan biaya, diperlukan strategi agar margin keuntungan tetap terjaga.
    *	Tim Marketing: Promosi berbasis cuaca/musim patut dicoba.
    *	Tim Keuangan: Bantu evaluasi strategi harga jangka panjang (misalnya, dengan kesuksesan menaikkan harga sewa, apakah menaikkan harga sewa menjadi $5.99 layak dicoba?)

## Tambahan
Machine learning dapat digunakan untuk memprediksi rata-rata jumlah pelanggan pada jam tertentu berdasarkan kondisi lingkungan, cuaca, kalender, dan bisa dijadikan sebagai informasi pelengkan untuk analisa berdasarkan data historis.	
*	Model: Beberapa model regresi yang dicoba adalah Linear Regression, Random Forest, Decision Tree, Bagging, ExtraTrees, CatBoost, dll. Dan dari hasil training, model tree-based models (DecisionTree, RandomForest) memberikan akurasi lebih baik dibandingkan linear/SVR.

<p align="center">
 <img src="https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/ml.png" width=400 height=300>
</p>
*	Akurasi tertinggi di kisaran ~70% (RandomForest/DecisionTree). Dan model berhasil mengikuti pola musiman/harian (grafik prediksi mirip dengan tren data asli).

