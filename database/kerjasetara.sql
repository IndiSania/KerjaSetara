CREATE DATABASE IF NOT EXISTS kerjasetara CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE kerjasetara;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS training_enrollments;
DROP TABLE IF EXISTS freelance_services;
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS trainings;
DROP TABLE IF EXISTS candidate_profiles;
DROP TABLE IF EXISTS company_profiles;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE users(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(120) NOT NULL,email VARCHAR(190) NOT NULL UNIQUE,password_hash VARCHAR(255) NOT NULL,role ENUM('candidate','company','admin') NOT NULL DEFAULT 'candidate',status ENUM('Aktif','Ditangguhkan') NOT NULL DEFAULT 'Aktif',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE candidate_profiles(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,user_id INT UNSIGNED NOT NULL UNIQUE,headline VARCHAR(160),location VARCHAR(120),skills TEXT,experience TEXT,education TEXT,accessibility_needs TEXT,portfolio_url VARCHAR(255),remote_preference TINYINT(1) DEFAULT 0,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE company_profiles(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,user_id INT UNSIGNED NOT NULL UNIQUE,company_name VARCHAR(160) NOT NULL,description TEXT,website VARCHAR(255),location VARCHAR(120),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE jobs(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,company_id INT UNSIGNED NOT NULL,title VARCHAR(180) NOT NULL,description TEXT NOT NULL,requirements TEXT,skills TEXT,work_type ENUM('Remote','Hybrid','Onsite') DEFAULT 'Remote',employment_type VARCHAR(50) DEFAULT 'Penuh waktu',location VARCHAR(120),salary_range VARCHAR(100),accessibility TEXT,deadline DATE,status ENUM('Aktif','Ditangguhkan','Ditutup') DEFAULT 'Aktif',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,FOREIGN KEY(company_id) REFERENCES users(id) ON DELETE CASCADE,INDEX(status),INDEX(work_type)) ENGINE=InnoDB;
CREATE TABLE applications(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,job_id INT UNSIGNED NOT NULL,candidate_id INT UNSIGNED NOT NULL,cover_letter TEXT,status ENUM('Menunggu','Ditinjau','Diproses','Diterima','Ditolak') DEFAULT 'Menunggu',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,UNIQUE KEY unique_candidate_job(job_id,candidate_id),FOREIGN KEY(job_id) REFERENCES jobs(id) ON DELETE CASCADE,FOREIGN KEY(candidate_id) REFERENCES users(id) ON DELETE CASCADE,INDEX(candidate_id),INDEX(status)) ENGINE=InnoDB;
CREATE TABLE trainings(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,title VARCHAR(180) NOT NULL,category VARCHAR(80) NOT NULL,description TEXT NOT NULL,duration VARCHAR(80) NOT NULL,level VARCHAR(40) DEFAULT 'Pemula',status ENUM('Aktif','Ditangguhkan') DEFAULT 'Aktif',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP) ENGINE=InnoDB;
CREATE TABLE training_enrollments(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,training_id INT UNSIGNED NOT NULL,user_id INT UNSIGNED NOT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,UNIQUE KEY unique_training_user(training_id,user_id),FOREIGN KEY(training_id) REFERENCES trainings(id) ON DELETE CASCADE,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE) ENGINE=InnoDB;
CREATE TABLE freelance_services(id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,user_id INT UNSIGNED NOT NULL,title VARCHAR(180) NOT NULL,category VARCHAR(80) NOT NULL,description TEXT NOT NULL,price INT UNSIGNED DEFAULT 0,portfolio_url VARCHAR(255),status ENUM('Aktif','Ditangguhkan') DEFAULT 'Aktif',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,INDEX(status)) ENGINE=InnoDB;
-- Password semua akun demo: password
INSERT INTO users(id,name,email,password_hash,role,status) VALUES
(1,'Administrator KerjaSetara','admin@kerjasetara.test','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','admin','Aktif'),
(2,'Nusa Digital','hr@nusadigital.test','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','company','Aktif'),
(3,'Sania Pratama','sania@kerjasetara.test','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','candidate','Aktif'),
(4,'Akses Kreatif Studio','talent@aksesstudio.test','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','company','Aktif');
INSERT INTO company_profiles(user_id,company_name,description,website,location) VALUES
(2,'Nusa Digital','Perusahaan teknologi yang berkomitmen membangun lingkungan kerja inklusif.','https://example.com','Jakarta / Remote'),
(4,'Akses Kreatif Studio','Studio kreatif yang membuka kesempatan bagi talenta desain dan konten.','https://example.com','Bandung / Hybrid');
INSERT INTO candidate_profiles(user_id,headline,location,skills,experience,education,accessibility_needs,remote_preference) VALUES
(3,'Junior Web Developer | PHP & MySQL','Jepara, Jawa Tengah','HTML, CSS, JavaScript, PHP, MySQL, Laravel','Membangun beberapa proyek website sebagai proyek pembelajaran.','SMK - Pengembangan Perangkat Lunak dan Gim','Terbantu dengan instruksi tertulis dan agenda wawancara yang dibagikan sebelumnya.',1);
INSERT INTO jobs(company_id,title,description,requirements,skills,work_type,employment_type,location,salary_range,accessibility,deadline,status) VALUES
(2,'Junior Web Developer','Membantu tim mengembangkan dan memelihara website, memperbaiki bug, serta berkolaborasi dengan tim desain dan produk. Kandidat pemula dengan portofolio proyek dipersilakan melamar.','Memahami HTML, CSS, dasar PHP dan database. Mampu belajar mandiri.','PHP, HTML, CSS, MySQL, Git','Remote','Penuh waktu','Remote - Indonesia','4–6 juta/bulan','Wawancara daring; dokumentasi kerja tertulis; akomodasi dapat didiskusikan.','2027-12-31','Aktif'),
(4,'Junior UI/UX Designer','Membantu merancang alur pengguna, wireframe, dan prototipe untuk produk digital bersama tim produk.','Memiliki portofolio desain dan memahami prinsip usability. Figma menjadi nilai tambah.','Figma, UI/UX, Wireframing, Prototyping','Hybrid','Kontrak','Bandung','Sesuai pengalaman','Wawancara daring dapat diatur; kebutuhan akomodasi dapat didiskusikan.','2027-06-30','Aktif'),
(2,'Admin Data Junior','Membantu memeriksa, merapikan, dan memperbarui data operasional dengan mengikuti prosedur.','Teliti, memahami spreadsheet, dan dapat mengikuti panduan kerja.','Spreadsheet, Data Entry, Administrasi','Remote','Paruh waktu','Remote - Indonesia','2–3 juta/bulan','Panduan tugas tertulis dan jadwal fleksibel berdasarkan kesepakatan.','2027-08-30','Aktif'),
(4,'Content Writer Freelance','Menyusun artikel singkat, deskripsi produk, dan konten edukasi berdasarkan brief.','Kemampuan menulis bahasa Indonesia yang baik dan terbuka terhadap revisi.','Penulisan, Riset, Bahasa Indonesia','Remote','Freelance','Remote - Indonesia','Sesuai kesepakatan','Brief tertulis, komunikasi asinkron, dan tenggat yang disepakati.','2027-12-31','Aktif');
INSERT INTO trainings(title,category,description,duration,level,status) VALUES
('Dasar Pengembangan Web','Teknologi','Pelajari struktur halaman, styling, dan dasar interaktivitas untuk membangun website sederhana.','4 minggu','Pemula','Aktif'),
('UI/UX Design dengan Figma','Kreatif','Kenali kebutuhan pengguna, buat wireframe, dan susun prototipe antarmuka yang mudah digunakan.','3 minggu','Pemula','Aktif'),
('Kesiapan Kerja Digital','Karier','Latihan menyusun CV, menyiapkan portofolio, berkomunikasi profesional, dan menghadapi wawancara.','2 minggu','Pemula','Aktif'),
('Administrasi Digital dan Spreadsheet','Administrasi','Pelajari pengolahan data dasar, validasi sederhana, dan praktik menjaga kerapian data.','3 minggu','Pemula','Aktif');
INSERT INTO freelance_services(user_id,title,category,description,price,portfolio_url,status) VALUES
(3,'Pembuatan Landing Page','Pemrograman','Membuat landing page responsif untuk portofolio, usaha kecil, atau profil layanan dengan struktur rapi.',350000,'https://example.com','Aktif'),
(4,'Desain Konten Media Sosial','Desain','Mendesain paket konten media sosial dengan gaya visual konsisten sesuai brief dan identitas merek.',150000,'https://example.com','Aktif');
