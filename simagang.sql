-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Okt 2025 pada 15.52
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simagang`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `absensi`
--

CREATE TABLE `absensi` (
  `id_absen` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `lokasi` varchar(150) DEFAULT NULL,
  `foto_mahasiswa` varchar(255) DEFAULT NULL,
  `status_validasi` enum('pending','disetujui','ditolak') DEFAULT 'pending',
  `id_dosen_validator` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota_kelompok`
--

CREATE TABLE `anggota_kelompok` (
  `id_anggota` int(11) NOT NULL,
  `id_kelompok` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `peran` enum('ketua','anggota') DEFAULT 'anggota'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokumen_magang`
--

CREATE TABLE `dokumen_magang` (
  `id_dokumen` int(11) NOT NULL,
  `id_pengajuan` int(11) NOT NULL,
  `jenis` enum('proposal','surat_penerimaan','surat_pelaksanaan','laporan') NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `tanggal_upload` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nip` varchar(30) NOT NULL,
  `prodi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `evaluasi_magang`
--

CREATE TABLE `evaluasi_magang` (
  `id_evaluasi` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `id_dosen` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `catatan` text DEFAULT NULL,
  `nilai` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kegiatan_harian`
--

CREATE TABLE `kegiatan_harian` (
  `id_kegiatan` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `foto_kegiatan` varchar(255) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `status_validasi` enum('pending','disetujui','ditolak') DEFAULT 'pending',
  `id_dosen_validator` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelompok`
--

CREATE TABLE `kelompok` (
  `id_kelompok` int(11) NOT NULL,
  `nama_kelompok` varchar(100) NOT NULL,
  `tahun` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_aktivitas`
--

CREATE TABLE `log_aktivitas` (
  `id_log` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `aktivitas` text NOT NULL,
  `waktu` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nim` varchar(20) NOT NULL,
  `angkatan` year(4) NOT NULL,
  `prodi` varchar(100) DEFAULT NULL,
  `status` enum('pra-magang','magang') DEFAULT 'pra-magang'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `mitra_perusahaan`
--

CREATE TABLE `mitra_perusahaan` (
  `id_mitra` int(11) NOT NULL,
  `nama_perusahaan` varchar(150) NOT NULL,
  `bidang` varchar(100) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `kontak` varchar(50) DEFAULT NULL,
  `status_mitra` enum('aktif','nonaktif') DEFAULT 'aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `monitoring_dosen`
--

CREATE TABLE `monitoring_dosen` (
  `id_monitoring` int(11) NOT NULL,
  `id_dosen` int(11) NOT NULL,
  `id_kelompok` int(11) NOT NULL,
  `tanggal_kunjungan` date NOT NULL,
  `catatan_monitoring` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id_notifikasi` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `pesan` text NOT NULL,
  `status_baca` enum('baru','dibaca') DEFAULT 'baru',
  `tanggal` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengajuan_magang`
--

CREATE TABLE `pengajuan_magang` (
  `id_pengajuan` int(11) NOT NULL,
  `id_kelompok` int(11) NOT NULL,
  `id_mitra` int(11) NOT NULL,
  `tanggal_pengajuan` date NOT NULL,
  `status_pengajuan` enum('menunggu','diterima','ditolak') DEFAULT 'menunggu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `persetujuan_korbid`
--

CREATE TABLE `persetujuan_korbid` (
  `id_persetujuan` int(11) NOT NULL,
  `id_pengajuan` int(11) NOT NULL,
  `id_korbid` int(11) NOT NULL,
  `status_acc` enum('ya','tidak') DEFAULT 'ya',
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','korbid','dosen','mahasiswa') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `absensi`
--
ALTER TABLE `absensi`
  ADD PRIMARY KEY (`id_absen`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_dosen_validator` (`id_dosen_validator`);

--
-- Indeks untuk tabel `anggota_kelompok`
--
ALTER TABLE `anggota_kelompok`
  ADD PRIMARY KEY (`id_anggota`),
  ADD KEY `id_kelompok` (`id_kelompok`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`);

--
-- Indeks untuk tabel `dokumen_magang`
--
ALTER TABLE `dokumen_magang`
  ADD PRIMARY KEY (`id_dokumen`),
  ADD KEY `id_pengajuan` (`id_pengajuan`);

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`),
  ADD UNIQUE KEY `nip` (`nip`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `evaluasi_magang`
--
ALTER TABLE `evaluasi_magang`
  ADD PRIMARY KEY (`id_evaluasi`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_dosen` (`id_dosen`);

--
-- Indeks untuk tabel `kegiatan_harian`
--
ALTER TABLE `kegiatan_harian`
  ADD PRIMARY KEY (`id_kegiatan`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_dosen_validator` (`id_dosen_validator`);

--
-- Indeks untuk tabel `kelompok`
--
ALTER TABLE `kelompok`
  ADD PRIMARY KEY (`id_kelompok`);

--
-- Indeks untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`),
  ADD UNIQUE KEY `nim` (`nim`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `mitra_perusahaan`
--
ALTER TABLE `mitra_perusahaan`
  ADD PRIMARY KEY (`id_mitra`);

--
-- Indeks untuk tabel `monitoring_dosen`
--
ALTER TABLE `monitoring_dosen`
  ADD PRIMARY KEY (`id_monitoring`),
  ADD KEY `id_dosen` (`id_dosen`),
  ADD KEY `id_kelompok` (`id_kelompok`);

--
-- Indeks untuk tabel `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id_notifikasi`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `pengajuan_magang`
--
ALTER TABLE `pengajuan_magang`
  ADD PRIMARY KEY (`id_pengajuan`),
  ADD KEY `id_kelompok` (`id_kelompok`),
  ADD KEY `id_mitra` (`id_mitra`);

--
-- Indeks untuk tabel `persetujuan_korbid`
--
ALTER TABLE `persetujuan_korbid`
  ADD PRIMARY KEY (`id_persetujuan`),
  ADD KEY `id_pengajuan` (`id_pengajuan`),
  ADD KEY `id_korbid` (`id_korbid`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `absensi`
--
ALTER TABLE `absensi`
  MODIFY `id_absen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `anggota_kelompok`
--
ALTER TABLE `anggota_kelompok`
  MODIFY `id_anggota` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `dokumen_magang`
--
ALTER TABLE `dokumen_magang`
  MODIFY `id_dokumen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `evaluasi_magang`
--
ALTER TABLE `evaluasi_magang`
  MODIFY `id_evaluasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kegiatan_harian`
--
ALTER TABLE `kegiatan_harian`
  MODIFY `id_kegiatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kelompok`
--
ALTER TABLE `kelompok`
  MODIFY `id_kelompok` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `mitra_perusahaan`
--
ALTER TABLE `mitra_perusahaan`
  MODIFY `id_mitra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `monitoring_dosen`
--
ALTER TABLE `monitoring_dosen`
  MODIFY `id_monitoring` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id_notifikasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pengajuan_magang`
--
ALTER TABLE `pengajuan_magang`
  MODIFY `id_pengajuan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `persetujuan_korbid`
--
ALTER TABLE `persetujuan_korbid`
  MODIFY `id_persetujuan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `absensi`
--
ALTER TABLE `absensi`
  ADD CONSTRAINT `absensi_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`) ON DELETE CASCADE,
  ADD CONSTRAINT `absensi_ibfk_2` FOREIGN KEY (`id_dosen_validator`) REFERENCES `users` (`id_user`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `anggota_kelompok`
--
ALTER TABLE `anggota_kelompok`
  ADD CONSTRAINT `anggota_kelompok_ibfk_1` FOREIGN KEY (`id_kelompok`) REFERENCES `kelompok` (`id_kelompok`) ON DELETE CASCADE,
  ADD CONSTRAINT `anggota_kelompok_ibfk_2` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `dokumen_magang`
--
ALTER TABLE `dokumen_magang`
  ADD CONSTRAINT `dokumen_magang_ibfk_1` FOREIGN KEY (`id_pengajuan`) REFERENCES `pengajuan_magang` (`id_pengajuan`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `evaluasi_magang`
--
ALTER TABLE `evaluasi_magang`
  ADD CONSTRAINT `evaluasi_magang_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluasi_magang_ibfk_2` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kegiatan_harian`
--
ALTER TABLE `kegiatan_harian`
  ADD CONSTRAINT `kegiatan_harian_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`) ON DELETE CASCADE,
  ADD CONSTRAINT `kegiatan_harian_ibfk_2` FOREIGN KEY (`id_dosen_validator`) REFERENCES `users` (`id_user`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `log_aktivitas`
--
ALTER TABLE `log_aktivitas`
  ADD CONSTRAINT `log_aktivitas_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `monitoring_dosen`
--
ALTER TABLE `monitoring_dosen`
  ADD CONSTRAINT `monitoring_dosen_ibfk_1` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`) ON DELETE CASCADE,
  ADD CONSTRAINT `monitoring_dosen_ibfk_2` FOREIGN KEY (`id_kelompok`) REFERENCES `kelompok` (`id_kelompok`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD CONSTRAINT `notifikasi_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pengajuan_magang`
--
ALTER TABLE `pengajuan_magang`
  ADD CONSTRAINT `pengajuan_magang_ibfk_1` FOREIGN KEY (`id_kelompok`) REFERENCES `kelompok` (`id_kelompok`) ON DELETE CASCADE,
  ADD CONSTRAINT `pengajuan_magang_ibfk_2` FOREIGN KEY (`id_mitra`) REFERENCES `mitra_perusahaan` (`id_mitra`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `persetujuan_korbid`
--
ALTER TABLE `persetujuan_korbid`
  ADD CONSTRAINT `persetujuan_korbid_ibfk_1` FOREIGN KEY (`id_pengajuan`) REFERENCES `pengajuan_magang` (`id_pengajuan`) ON DELETE CASCADE,
  ADD CONSTRAINT `persetujuan_korbid_ibfk_2` FOREIGN KEY (`id_korbid`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
