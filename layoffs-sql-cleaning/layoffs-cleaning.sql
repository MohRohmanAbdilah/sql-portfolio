-- SQL Project: Data Cleaning
-- Dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022

# Menyalin Data Mentah

-- Menampilkan data awal
SELECT * 
FROM datacleaning.layoffs;

-- Membuat salinan tabel asli
CREATE TABLE phk 
LIKE layoffs;

-- Menyalin isi data ke tabel baru
INSERT INTO phk
SELECT * FROM layoffs;

# Menghapus Duplikat

-- Menampilkan isi tabel
SELECT * FROM phk;

-- Menemukan duplikat dengan ROW_NUMBER
SELECT *, 
  ROW_NUMBER() OVER (
    PARTITION BY company, location, total_laid_off, `date`, 
                 percentage_laid_off, industry, stage, funds_raised
    ORDER BY date_added
  ) AS nomer
FROM phk;

-- Membuat tabel baru phk2 dan menambahkan kolom rownumber
CREATE TABLE phk2 LIKE phk;
ALTER TABLE phk2 ADD COLUMN rownum INT;

-- Memasukkan data sambil memberi nomor baris
INSERT INTO phk2 (
  company,
  location,
  total_laid_off,
  `date`,
  percentage_laid_off,
  industry,
  source,
  stage,
  funds_raised,
  country,
  date_added,
  rownum
)
SELECT 
  company,
  location,
  total_laid_off,
  `date`,
  percentage_laid_off,
  industry,
  source,
  stage,
  funds_raised,
  country,
  date_added,
  ROW_NUMBER() OVER (
    PARTITION BY company, location, total_laid_off, `date`, 
                 percentage_laid_off, industry, stage, funds_raised
    ORDER BY date_added
  ) AS rownum
FROM phk;

-- Menghapus baris duplikat
DELETE FROM phk2 WHERE rownum > 1;

# Menstandarkan Data

-- Menghapus spasi dan titik
UPDATE phk2 SET company = TRIM(company);
UPDATE phk2 SET company = TRIM(BOTH '.' FROM company);

-- Melihat industry kosong
SELECT * FROM phk2 WHERE industry IS NULL OR industry = '';

-- (Jika ada industri kosong, bisa gunakan update dari baris lain yang memiliki company sama)
-- Contoh logika (dapat dikembangkan):
-- UPDATE phk2 t1
-- JOIN phk2 t2 ON t1.company = t2.company
-- SET t1.industry = t2.industry
-- WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

-- Mengubah country kosong menjadi NULL
UPDATE phk2
SET country = NULL
WHERE country = '';

-- Mengisi country berdasarkan lokasi
UPDATE phk2 t1
JOIN phk2 t2 ON t1.location = t2.location
SET t1.country = t2.country
WHERE t1.country IS NULL AND t2.country IS NOT NULL;

-- Konversi format tanggal ke DATE
UPDATE phk2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
UPDATE phk2
SET date_added = STR_TO_DATE(date_added, '%m/%d/%Y');

-- Ubah tipe kolom menjadi DATE
ALTER TABLE phk2 MODIFY COLUMN `date` DATE;
ALTER TABLE phk2 MODIFY COLUMN date_added DATE;

-- Cek nilai NULL atau kosong di kolom penting
SELECT * FROM phk2
WHERE total_laid_off IS NULL OR OR total_laid_off = '' 
OR percentage_laid_off IS NULL OR percentage_laid_off = '';

-- Menghapus baris tanpa data PHK dan persentase
DELETE FROM phk2
WHERE (total_laid_off IS NULL OR total_laid_off = '')
  AND (percentage_laid_off IS NULL OR percentage_laid_off = '');

-- Menghapus kolom hasil row_number 
ALTER TABLE phk2
drop column rownum;

-- Tampilkan hasil akhir
SELECT * FROM phk2;


