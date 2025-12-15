# PostgreSQL ERD Practice

Repository ini berisi latihan desain database dan implementasi SQL PostgreSQL
dalam satu file SQL (`postgresql.sql`) yang mencakup DDL dan DML.

## Sumber Belajar
- ERD & Database Design  
  https://youtu.be/S4igMZFCvh8
- PostgreSQL SQL Implementation  
  https://youtu.be/iEeveYoD0SA

## Isi Repository
postgresql-erd-practice/
├─ postgresql.sql
└─ README.md

### postgresql.sql
Berisi:
- DDL  
  - CREATE TABLE  
  - PRIMARY KEY  
  - FOREIGN KEY  
  - Constraint dan relasi antar tabel
- DML  
  - INSERT data contoh untuk testing

File disusun agar bisa dijalankan dari kondisi database kosong (replayable).

## Cara Menjalankan
1. Buat database kosong
   CREATE DATABASE erd_practice;
2. Import file SQL
   psql -U postgres -d erd_practice -f postgresql.sql

## Tujuan
- Memahami ERD (Conceptual → Logical → Physical)
- Mengimplementasikan relasi database ke PostgreSQL
- Melatih penulisan SQL yang rapi dan reusable
- Membiasakan workflow database pada real project

## Catatan
- Tidak ada credential atau data sensitif
- Fokus pada database design dan SQL
- Tidak mencakup backend framework atau ORM
