# KerjaSetara — Platform Kerja Inklusif
Platform yang mempertemukan pencari kerja penyandang disabilitas dengan perusahaan inklusif, sekaligus menyediakan profil/CV, lowongan, lamaran online, pelatihan keterampilan, dan marketplace jasa freelance.

## Teknologi
PHP 8+, MySQL/MariaDB, HTML, CSS responsif, JavaScript, PDO, prepared statements, password hashing, session, dan CSRF token.

## Instalasi XAMPP
1. Ekstrak folder `KerjaSetara` ke `C:\xampp\htdocs\KerjaSetara`.
2. Jalankan Apache dan MySQL.
3. Buka phpMyAdmin, impor `database/kerjasetara.sql`.
4. Periksa kredensial di `config/config.php` (default XAMPP: root tanpa password).
5. Buka `http://localhost/KerjaSetara/public/`.

## Akun demo
Password: `password`
- Admin: admin@kerjasetara.test
- Perusahaan: hr@nusadigital.test
- Pencari kerja: sania@kerjasetara.test

## Modul
- Pencari kerja: profil/CV, keterampilan, pendidikan, portofolio, preferensi remote dan kebutuhan akomodasi opsional, kirim lamaran, lacak status.
- Perusahaan: profil, buat/tangguhkan lowongan, tentukan tipe kerja, keterampilan, kualifikasi, gaji, tenggat dan akomodasi, tinjau kandidat serta perbarui status.
- Admin: statistik platform, moderasi lowongan dan status akun.
- Lowongan: cari/filter berdasarkan kata kunci, lokasi dan tipe kerja; halaman detail dan lamaran online.
- Pelatihan: katalog kursus dan pendaftaran.
- Freelance: katalog jasa, publikasi jasa, harga dan portofolio.
- Aksesibilitas: skip link, navigasi keyboard, label form, desain responsif, tombol pembesar teks, kontras yang jelas.

Aplikasi ini adalah starter project untuk pembelajaran. Sebelum dipakai publik, tambahkan verifikasi email, pembatasan login, logging, kebijakan privasi, audit keamanan, validasi URL/unggahan, serta proses moderasi yang lebih lengkap. Informasi akomodasi bersifat pilihan; hindari meminta diagnosis yang tidak diperlukan.
