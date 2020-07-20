-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 20 Jul 2020 pada 08.17
-- Versi server: 10.3.16-MariaDB
-- Versi PHP: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kampus`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_news`
--

CREATE TABLE `tb_news` (
  `id_news` int(11) NOT NULL,
  `title_news` varchar(150) NOT NULL,
  `image_news` text NOT NULL,
  `description_news` text NOT NULL,
  `date_news` date NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_news`
--

INSERT INTO `tb_news` (`id_news`, `title_news`, `image_news`, `description_news`, `date_news`, `id_user`) VALUES
(1, '\r\nSekitar 250 Orang Bersaing Ketat Perebutkan Kuliah Gratis dan Jaminan Kerja Kelas Kerjasama PNP-P.T. Trakindo', '1.jpg', 'Menurut Direktur, peserta yang mendaftar mencapai 252 orang dan yang diterima untuk kerjasama Trakindo hanya 1 kelas, dengan jumlah 24 orang. Setelah tes tertulis berbasis komputer ini mereka yang dinyatakan lulus tahap awal akan menjalani beberapa tes kelanjutan yang diselenggarakan langsung oleh Trakindo.\r\n\r\n ', '2020-07-02', 1),
(2, 'Jurusan Teknik Mesin', 'mesin.jpg', 'Menghasilkan tenaga kerja yang profesional dalam bidang permesinan dan tanggap terhadap perkembangan ilmu pengetahuan dan teknologi permesinan khususnya dalam bidang perawatan & perbaikan mesin dan mesin produksi.', '2020-07-01', 1),
(29, 'new', 'image_picker5803765858747800437.jpg', 'new', '2020-07-20', 0);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_news`
--
ALTER TABLE `tb_news`
  ADD PRIMARY KEY (`id_news`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_news`
--
ALTER TABLE `tb_news`
  MODIFY `id_news` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
