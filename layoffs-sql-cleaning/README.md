# SQL Project: Data Cleaning – Layoffs Dataset

## 📌 Project Summary
Proyek ini berfokus pada **data cleaning** untuk dataset PHK (layoffs).  
Tujuan utama adalah untuk:
- Menghapus data **duplikat**.
- Menstandarkan **format data** seperti tanggal dan teks.
- Menangani **missing values**.
- Menyiapkan dataset yang siap pakai untuk analisis lebih lanjut.

---

## 📊 Dataset
- **Source:** [Kaggle – Layoffs 2022](https://www.kaggle.com/datasets/swaptr/layoffs-2022)  
- **Deskripsi Kolom:**
  - `company` – Nama perusahaan
  - `location` – Lokasi perusahaan
  - `industry` – Industri perusahaan
  - `total_laid_off` – Jumlah karyawan yang di-PHK
  - `percentage_laid_off` – Persentase karyawan yang di-PHK
  - `date` – Tanggal PHK
  - `stage` – Tahap pendanaan perusahaan
  - `country` – Negara
  - `funds_raised` – Total dana yang telah dihimpun

---

## 🛠 Tools Used
- **MySQL** – Untuk query dan pembersihan data
- **Kaggle** – Sumber dataset

---

## 🚀 How to Run
1. **Import** dataset CSV ke MySQL.
2. Clone repository ini:
   ```bash
   git clone https://github.com/MohRohmanAbdilah/layoffs_cleaning.sql.git
