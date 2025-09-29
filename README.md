# Laporan Performa Toman Bike Share (2021-2022)
Analisa pada perusahaan penyewaan sepeda Toman Bike Share dengan MySQL, Power BI, dan Excel. Serta membuat model Regresi menggunakan ML untuk forecasting pada data kompleks

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

  
![image](https://github.com/AlHafidzLuhurDarma/Toman_bike_Analisis/blob/main/visualization/Screenshot%202025-09-27%20183940.png)
