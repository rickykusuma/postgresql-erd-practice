select *
from pg_tables
where schemaname = 'public';

-- Membuat Table Barang
create table barang
(
    kode   int          not null,
    name   varchar(100) not null,
    harga  int          not null,
    jumlah int          not null
);

-- Mengubah Table -> Menambah Column
alter table barang
    ADD COLUMN deskripsi text;

-- Delete column
alter table barang
    drop column deskripsi;

-- Rename column
alter table barang
    rename column name to nama;

-- null value => biasa digunakan untuk required / optional dalam database (dipakai ketika membuat table)
-- create table barang(
--     kode int not null, < Required
--     name varchar(100) not null, < Required
--     harga int null, < Optional
--     jumlah int not null < Required
-- );

-- Default value => menambahkan default value (biasa digunakan untuk DATETIME / TIMESTAMP ingin valuenya nilai waktu saat ini dengan menggunakan value current_timestamp)
-- create table barang(
--     kode int not null, < Required
--     name varchar(100) not null, < Required
--     harga int null default 0, < Optional dengan default value 0
--     jumlah int not null default 0, < Required dengan default value 0
--     waktu_dibuat TIMESTAMP not null default current_timestamp
-- );

-- Membuat ulang Table flow => Delete semua data dan table -> recreate ulang Table dengan column yang sama sehingga data kosong
truncate barang;

-- Menghapus Table sepenuhnya
DROP TABLE barang;

-- Membuat ulang table dengan column yang baru
create table barang
(
    kode         int          not null,
    name         varchar(100) not null,
    harga        int          not null default 1000,
    jumlah       int          not null default 0,
    waktu_dibuat TIMESTAMP    not null default current_timestamp
);

-- INSERT DATA
-- ketika ingin insert data, table harus dibuat terlebih dahulu
create table products
(
    id          varchar(10)  not null,
    name        varchar(100) not null,
    description text,
    price       int          not null,
    quantity    int          not null default 0,
    created_at  timestamp    not null default current_timestamp
);

-- Memasukkan Data
insert into products(id, name, price, quantity)
values ('P0001', 'Mie Ayam Original', 15000, 100);

insert into products(id, name, description, price, quantity)
values ('P0002', 'Mie Ayam Bakso Tahu', ' Mie Ayam Original + Bakso Tahu', 20000, 100);

-- Multiple Insert Data
insert into products(id, name, price, quantity)
values ('P0003', 'Mie Ayam Ceker', 20000, 100),
       ('P0004', 'Mie Ayam Spesial', 25000, 100),
       ('P0005', 'Mie Ayam Yamin', 15000, 100);


-- Mengambil Data semua column
select *
from products;

-- Mengambil Data spesifik Column
select id, name, price, quantity
from products;

-- Primary Key
-- PK adlah identitas untuk tiap baris data yang ada didalam table, value harus unique
-- Disarankan 1 Column sebagai Primary key agar mempermudah untuk di maintenance, kecuali ada kasus khusus, seperti membuat table yang berelasi many to many

--     Contoh ketika menambahkan saat create table
-- create table products
-- (
--     id          varchar(10)  not null,
--     name        varchar(100) not null,
--     description text,
--     price       int          not null,
--     quantity    int          not null default 0,
--     created_at  timestamp    not null default current_timestamp,
--     primary key (id) <- Perintah untuk menentukan Primary Key
-- );

-- Contoh ketika menggunakan Alter Table / Menambah PK di table yang sudah ada
alter table products
    add primary key (id);

-- WHERE CLAUSE
--  Saat mencari data ingin mengambil data spesifik, bisa menggunakan perintah WHERE clause setelah perintah SELECT
select id, name, price, quantity
from products
where price = 15000;

-- UPDATE DATA
-- untuk update data di tabel bisa menggunakan perintah "UPDATE" dimana kita harus memberitahukan data mana yang diupdate dengan WHERE Clause
-- NOTE: jangan sampai WHERE Clause nya salah, bisa" mengupdate seluruh data ditabel
-- untuk update kita harus beritahu, kolom mana yang akan diupdate

-- Membuat Enum (Value yang sudah fixed)
create type PRODUCT_CATEGORY as enum ('Makanan','Minuman','Lain-Lain');

alter table products
    add column category PRODUCT_CATEGORY;

-- Mengubah Satu Kolom bisa set bbrp kolum sekaligus
update products
set category    ='Makanan',
    description =null
where id = 'P0001';

update products
set category ='Makanan'
where id = 'P0002';

update products
set category    ='Makanan',
    description ='Mie Ayam + Ceker'
where id = 'P0003';

update products
set category ='Makanan'
where id = 'P0004';

update products
set category ='Makanan'
where id = 'P0005';

select *
from products;

-- Mengubah dengan Value di kolom
update products
set price= price + 5000
where id = 'P0004';

-- Insert Data untuk contoh menghapus data di table
insert into products(id, name, price, quantity, category)
values ('P0009', 'contoh', 1000, 100, 'Minuman');

-- Delete Data
-- untuk mendelete 1 table bisa menggunakan
-- delete from products; < HATI - HATI karena bisa menghapus seluruh data
-- menghapus data di table bisa menggunakan perintah "DELETE" di spesifik baris menggunakan WHERE Clause
delete
from products
where id = 'P0009';

select *
from products;


-- Alias
-- postgresql memiliki fitur untuk melakukan alias untuk kolom dan t abel
-- alias dipakai untuk mengubah nama kolom atau nama table ketika melakukan select data
-- alias biasa digunakan ketika melakukan join antar table

-- ALIAS untuk kolom
-- disini bukan mengubah nama kolom table, tetapi mengubah nama ketika select query nya saja agar tidak bentrok
select id          as kode,
       price       as harga,
       description as deskripsi
from products;

-- ALIAS untuk Table
select id            as kode,
       price         as harga,
       p.description as deskripsi
from products as p;


-- WHERE OPERATOR
select *
from products
where price > 15000;

select *
from products
where price <= 15000;

select *
from products
where products.category != 'Minuman';

-- AND / OR OPERATOR

select *
from products
where price > 15000
  AND products.category = 'Makanan';

select *
from products
where price < 15000
   OR products.category = 'Makanan';

insert into products(id, name, price, quantity, category)
values ('P0006', 'Es teh tawar', 10000, 100, 'Minuman'),
       ('P0007', 'Es Campur', 20000, 100, 'Minuman'),
       ('P0008', 'Jus Jeruk', 10000, 100, 'Minuman');

select *
from products
where price < 10000
   or products.category = 'Makanan';

-- Prioritas dengan kurung ()
-- Jadi fokus Quantity > 200 and price > 15000; baru cari product category makanan
select *
from products
where products.category = 'Makanan'
   or (quantity > 200 AND price > 15000);


-- LIKE Operator
-- Mencari sebagian data dalam String, cocok untuk mencari sebagian kata dalam String
-- Performance LIKE Sangat lambat, tidak disarankan ketika Datanya sudah terlalu besar
-- LIKE Case Sensitive, jika tidak ingin case sensitive bisa gunakan ILIKE
select *
from products
where name ilike '%bakso%';

select *
from products
where name like '%Es%';

-- NULL Operator
-- IS NULL => Mencari data Null
-- IS NOT NULL => Mencari data yang tidak null / ada isi nya.

select *
from products
where description is null;

-- BETWEEN Operator
-- biasa digunakan dalam range seperti price > 1000 and price < 2000
-- bisa menggunakan NOT BETWEEN untuk mencari diluar selain range tersebut
select *
from products
where price between 10000 and 20000;

-- IN Operator
-- operator untuk mlekaukan pencarian sebuah kolom dengan beberapa nilai.
-- contoh ingin mencari products dengan category Makanan atau Minuman, maka bisa menggunakan operator IN.
-- untuk kebalikannya NOT IN
select *
From products
where products.category in ('Makanan', 'Minuman');

-- ORDER BY CLAUSE
-- Order By digunakan untuk mengurutkan Data, bisa diurut dengan Ascending / Descending
select *
from products
order by price asc, id desc;

-- Limit Clause
-- Biasa digunakan untuk membatasi jumlah data yang diambil saat sql select
-- untuk skip hasil query bisa menggunakan OFFSET
select *
from products
order by id asc
limit 2 offset 2;

-- DISTINCT
-- digunakan saat select untuk menghilangkan data duplikat, untuk mencari unique value saja
select products.category
from products;
select DISTINCT products.category
from products;

-- ARITHMETIC Operator
select 10 + 10 as hasil;

select id, price / 1000 as price_in_k
from products;

-- Mathematical function
select power(10, 2);


-- AUTO INCREMENT
-- biasa digunakan untuk create table dengan auto increment pada id untuk menjadi Primary key dengan surrogate key
create table admin
(
    id         serial not null,
    first_name varchar(100),
    last_name  varchar(100),
    primary key (id)
);

select *
from admin;

insert into admin(first_name, last_name)
values ('Ricky', 'Andrianto');
select *
from admin;

-- Untuk melihat id terakhir bisa menggunakan currval(pg_get_serial_sequence('admin','id'));
-- atau select currval('admin_id_seq');
select currval('admin_id_seq');

-- SEQUENCE
-- saat menggunakan tipe data SERIAL, sebenarnya di belakangnya postgresql menggunakan Sequence
-- sequence adalah fitur untuk membuat function auto increment

-- Membuat Sequence
create sequence contoh_sequence;

-- untuk memanggil sequence, otomatis increment
select nextval('contoh_sequence');

-- untuk mengambil nilai terakhir sequence
select currval('contoh_sequence');

-- STRING FUNCTION
-- bisa di check di web official untuk penggunaan string function
-- beberapa contoh dibawah
select id, lower(name), length(name), lower(products.description)
from products;


-- Date and Time Function
-- bisa check web offical untuk penggunaan function date and time function
-- Menambah kolom timestamp

select id, extract(year from products.created_at), extract(month from products.created_at)
from products;

-- Flow Control Function
-- Postgresql memiliki fitur flow control function
-- Mirip IF ELSE di bahasa pemrograman
-- Fitur ini tidak se komplekx yang dimiliki pemrograman
-- cek official

-- Flow control CASE
select id,
       case products.category
           when 'Makanan' then 'Enak'
           when 'Minuman' then 'Segar'
           else 'Apa itu?'
           end as category
from products;

-- Bisa juga menggunakan operator comparation
select id,
       price,
       case
           when price <= 15000 then 'Murah'
           when price <= 2000 then 'Mahal'
           else 'Mahal Banget'
           end as murah
from products
order by price asc;

select *
from products;
-- Menggunakan Flow Control Case check Null dan membuat kategori custom
select id,
       name,
       case
           when description is null then 'kosong'
           else description
           end as description,
       case
           when name ilike '%mie%' then 'Noodle'
           when name ilike '%es%' then 'Ice'
           else 'lain-lain'
           end as kategori
from products;

-- AGGREGATE FUNCTION bisa check lebih lengkap ke official site
-- MAX, MIN, AVG, SUM, COUNT, GROUP BY, HAVING
select count(id) as "Total Product"
from products;
select avg(price) as "Rata-Rata harga"
from products;
select max(price) as "Harga Termahal"
from products;
select min(price) as "Harga Termurah"
from products;

-- Group By
-- biasanya digunakan ketika ingin datanya di grouping berdasarkan kriteria tertentu
-- contoh melihat semua product tapi per category
select category, count(id) as "Total Product"
from products
group by category;

select category, avg(price) as "Total Product", min(price) as "harga murah", max(price) as "Harga termahal"
from products
group by category;


-- HAVING CLAUSE
-- biasa digunakan untuk tambahan filter terhadap data yang sudah digrouping
-- Misal ingin menampilkan rata-rata harga per kategori, tapi yang harganya diatas 10.000 misalnya
-- Jika menggunakan WHERE di select, tidak bisa dilakukan.
-- untuk memfilter hasil agregate function harus menggunakan having clause

select category, count(id) as "Total"
from products
group by category
having count(id) > 1;

select category, avg(price) as "AVG Product", min(price) as "harga murah", max(price) as "Harga termahal"
from products
group by category
having avg(price) >= 20000;

-- CONSTRAINT
-- constraint digunakan untuk menjaga data di tabel tetap baik
-- constraint juga digunakan untuk menjaga terjadi validasi yang salah di program kita, sehingga dat ayang masuk ke database tetap terjaga.

-- UNIQUE CONSTRAINT
-- Unique constraint adalah constraint yang memastikan bahwa data kita tetap unique
-- Jika mencoba memasukkan data yang duplikat akan ditolak oleh Postgresql

create table customer
(
    id         serial       not null,
    email      varchar(100) not null,
    first_name varchar(100) not null,
    last_name  varchar(100),
    primary key (id),
    constraint unique_email unique (email)
);

insert into customer(email, first_name, last_name)
values ('ricky@gmail.com', 'ricky', '');

select *
from customer;

-- Existing Email, jadi error
insert into customer(email, first_name, last_name)
values ('ricky@gmail.com', 'ricky', '');


insert into customer(email, first_name, last_name)
values ('Tets58@gmail.com', 'Tets', ''),
       ('joko@gmail.com', 'Joko', ''),
       ('budi@gmail.com', 'Budi', '');

-- Jika ingin menambah/menghapus unique constraint
alter table customer
    drop constraint unique_email;

alter table customer
    add constraint unique_email unique (email);

-- CHECK CONSTRAINT
-- constraint yang bisa ditambahkan kondisi pengecekannya,
-- cocok untuk mengecek data sebelum dimasukkan ke dalam database
-- misal ingin memastikan harga harus diatas 1000.
-- Contoh ketika saat create table
create table products
(
    id          varchar(100) not null,
    name        varchar(100) not null,
    description text,
    price       int          not null,
    quantity    int          not null,
    created_at  timestamp    not null default current_timestamp,
    primary key (id),
    constraint price_check check (price >= 1000)
);
-- contoh ketika alter table
alter table products
    add constraint price_check check (price >= 1000);

select *
from products;

insert into products(id, name, description, price, quantity)
values ('P0009', 'contoh check constraint', '', 100, 100);


-- INDEX
-- digunakan untuk menggantikan pencarian sequential dari baris pertama - akhir, apabila jutaan data akan sangat lambat proses pencariannya
-- menggunakan index dengan mengubah cara postgresql menyimpan data pada kolom
-- saat membuat index, postgre akan menyimpan dalam struktur data B-Tree (Check wiki)
-- manfaatnya pencarian sangat cepan dan juka akan mempermudah ketika pengurutan menggunakan order by

-- CARA KERJA INDEX
-- bisa membuat lebih dari 1 index ditable, setiap membuat index, bisa membuat index untuk beberapa kolom sekaligus
-- example: (col1,col2,col3)
-- Artinya punya kemampuan untuk mencari lebih menggunakan index untuk kombinasi query di (col1),(col1,col2) dan (col1,col2,col3)

-- SIDE EFFECTS MEMBUAT INDEX
-- ADVANTAGES
-- search & query data lebih cepat

-- DISADVANTAGES
-- Memperlambat proses manipulasi data (insert,update n delete)

-- HAL YANG TIDAK PERLU INDEX
-- Saat membuat primary key dan unique constraint, kita tidak perlu menambahkan lagi index,
-- hal ini dikarenakan postgresql secara otomatis akan menambahkan index pada kolom primary key dan unique constraint.

create table sellers
(
    id    serial       not null,
    name  varchar(100) not null,
    email varchar(100) not null,
    primary key (id),
    constraint email_unique unique (email)
);

insert into sellers(name, email)
values ('Galeri Olahraga', 'galeri@pzn.com'),
       ('Toko Tono', 'tono@pzn.com'),
       ('Toko Budi', 'budi@pzn.com'),
       ('Toko Rully', 'rully@pzn.com');

select *
from sellers;

select *
from sellers
where id = 1;

create index sellers_id_and_name_index on sellers (id, name);
create index sellers_email_and_name_index on sellers (email, name);
create index sellers_name_index on sellers (name);
select *
from sellers
where id = 1
   OR name = 'Toko Tono';
select *
from sellers
where email = 'rully@pzn.com'
   or name = 'Toko Tono';
select *
from sellers
where name = 'Toko Tono';
drop index sellers_id_and_name_index;
-- NOTE: GUNAKAN INDEX DENGAN BIJAK

-- FULL TEXT SEARCH
-- Masalah dengan LIKE Operator
-- Operasi LIKE Sangat lambat karena mencari dari baris pertama sampai akhir.
-- Menambah index tidak akan membantu.
-- PostgreSQL Menyediakan Fitur Full text search jika ada kasus yang ingin melakukan hal ini.

-- FullTextSearch bisa mencari sebagain kata di kolom dengan tipe data String
-- Sangat cocok ketika membutuhkan pencarian yang tidak hanya sekedar operasi = (equals)
-- di PostgreSQL Full text search menggunakan function to_tsvector(text) dan to_tsquery(query)
-- bahkan tidak bsa menggunakan function tersebut tanpa membuat index, namun performannya sama saja dengan LIKE, lambat karena harus dicheck 1 1.
-- OPERATOR FULL TEXT SEARCH Menggunakan @@, bukan =

select *
from products
where to_tsvector(name) @@ to_tsquery('mie');


-- FULL TEXT SEARCH INDEX
-- Untuk membuat index full-text search kita bisa menggunakan perintah yang sama dengan index biasa, tapi harus disebutkan detail dari jenis index Full-text searchnya

-- Contoh Implementasi nya.
select cfgname
from pg_ts_config;

create index products_name_search on products using gin (to_tsvector('indonesian', name));

create index products_description_search on products using gin (to_tsvector('indonesian', name));

drop index products_name_search;
drop index products_description_search;

-- Cara menggunakan Full-text-search Index
-- ini mencari nama / deskripsi per kata, jika value yang dicari 'mi' tidak akan ketemu
select *
from products
where name @@ to_tsquery('mie');

select *
from products
where description @@ to_tsquery('mie');

UPDATE products
set description = 'Mie Ayam Original + Bakso Tahu'
where id = 'P0002';

-- QUERY OPERATOR
-- to_tsquery mendukung banyak operator
-- & untuk AND, | untuk OR, ! untuk NOT, '' '' untuk semua data

select *
from products
where name @@ to_tsquery('original | bakso');

select *
from products
where name @@ to_tsquery('tahu & bakso');

select *
from products
where name @@ to_tsquery('!bakso');

select *
from products
where name @@ to_tsquery('!mie');

select *
from products
where name @@ to_tsquery('''ayam bakso''');

-- TIPE DATA TSVECTOR
-- bisa secara otomatis membuat kolom dengan tipe data TSVECTOR
-- Secara otomatis kolom tersebut berisi text yang memiliki index full-text search

-- TABLE RELATIONSHIP

-- FOREIGN KEY
-- DIGUNAKAN UNTUK KONEKSI / RELATIONSHIP ANTAR TABLE

create table wishlist
(
    id          serial      not null,
    id_product  varchar(10) not null,
    description text,
    primary key (id),
    constraint fk_wishlist_product foreign key (id_product) references products (id)
);
-- CARA MENAMBAHKAN FOREIGN KEY PADA EXISTING  TABLE
alter table wishlist
    drop constraint fk_wishlist_product;


alter table wishlist
    add constraint fk_wishlist_product foreign key (id_product) references products (id);

-- manfaat menggunakan foreign key
-- foreign key memastikan bahwa data yang kita masukkan ke kolom tersebut harus tersedia di tabel reference nya.
-- selain itu saat kita menghapus data ditable reference,
-- postgresql akan mengecek apakah idnya digunakan di foreign key di tabel lain,
-- jika digunakan maka secara otomatis akan menolak proses delete data ditable reference tersebut

-- contoh ketika id_product tidak ada di tabel product yang id nya 'SALAH'
insert into wishlist(id_product, description)
values ('SALAH', 'contoh salah');


insert into wishlist(id_product, description)
values ('P0001', 'Mie ayam kesukaan'),
       ('P0002', 'Mie ayam kesukaan'),
       ('P0005', 'Mie ayam kesukaan');

select *
from wishlist;
-- tidak boleh dirubah foreing key nya dengna di update
update wishlist
set id_product = 'SALAH'
where id = 2;

-- contoh mau delete data ID P0005 yang mana di wishlist ada P0005 Foreign key nya.
delete
from products
where id = 'P0005';

-- CARA MENGHAPUS DATA BERELASI
-- mengubah behavior menghapus relasi
-- DISARANKAN MENGGUNAKAN RESTRICT BEHAVIOR FOREIGN KEY,
alter table wishlist
    add constraint fk_wishlist_product foreign key (id_product) references products (id)
        on delete cascade on update cascade;

insert into products(id, name, price, quantity, category)
values ('XXX', 'Xxx', 10000, 100, 'Minuman');

select *
from products;

insert into wishlist(id_product, description)
values ('XXX', 'Contoh');

select *
from wishlist;

delete
from products
where id = 'XXX';

select *
from wishlist;


-- JOIN
-- semakin banyak join, maka proses query akan semakin berat dan lambat, jadi harap bijak melakukan join
-- idealnya kita melakukan join jangan lebih dari 5 tabel, karena itu bisa berdampak ke performa query yang lambat

select *
from wishlist
         join products on products.id = wishlist.id_product;

select products.id, products.name, products.price, wishlist.description
from wishlist
         join products on products.id = wishlist.id_product;

-- JIKA MENGGUNAKAN ALIAS
select p.id, p.name, p.price, w.description
from wishlist as w
         join products as p on p.id = w.id_product;

select *
from products
         join wishlist on wishlist.id_product = products.id;

-- membuat relasi ke table customers
alter table wishlist
    add column id_customer int;

alter table wishlist
    add constraint fk_wishlist_customer foreign key (id_customer) references customer (id);

update wishlist
set id_customer = 3
where id in (2, 3);

update wishlist
set id_customer = 5
where id = 4;

select *
from wishlist;

-- CARA JOIN MULTIPLE TABLE
select c.email, p.id, p.name, w.description
from wishlist as w
         join products as p on w.id_product = p.id
         join customer as c on w.id_customer = c.id;


-- ONE TO ONE RELATIONSHIP
-- set kolom foreign key menjadi unique agar tetap menjadi 1 to 1 relationship

create table wallet
(
    id          serial not null,
    id_customer int    not null,
    balance     int    not null default 0,
    primary key (id),
    constraint wallet_customer_unique unique (id_customer), -- membuat customer id FK menjadi unique
    constraint fk_wallet_customer foreign key (id_customer) references customer (id)
);
select *
from wallet;
select *
from customer;
insert into wallet (id_customer, balance)
values (7, 3000000),
       (5, 2000000),
       (6, 4000000);

select *
from wallet;

select *
from customer
         join wallet on wallet.id_customer = customer.id;


-- ONE TO MANY RELATIONSHIP
create table categories
(
    id   varchar(10)  not null,
    name varchar(100) not null,
    primary key (id)
);
select *
from categories;
insert into categories(id, name)
values ('C0001', 'Makanan'),
       ('C0002', 'Minuman');

-- REMOVE ENUM CATEGORY ON PRODUCT TABLE
alter table products
    drop column category;

alter table products
    add column id_category varchar(10);

alter table products
    add constraint fk_product_category foreign key (id_category) references categories (id);

select *
from products;

update products
set id_category='C0001'
where id in ('P0005', 'P0003', 'P0001', 'P0004', 'P0002');

update products
set id_category='C0002'
where id in ('P0006', 'P0007', 'P0008');

select *
from products
         join categories on products.id_category = categories.id;

-- MANY TO MANY RELATIONSHIP
-- table A ke banyak Table B
-- Table B ke banyak Table A
-- Contoh Produk Tabel dan Penjualan Tabel
-- dimana setiap produk bisa dijual berkali kali, dan setiap penjualan bisa untuk lebih dari satu produk

-- implementasi di tabel many to many adalah
-- membuat 1 tabel sebagai jembatan antara table a dan tabel b yang berisi dari id dari table A dan id dari table B
-- kita juga bsa menambahkan beberapa data ke dalam table relasi ini.
create table orders
(
    id         serial    not null,
    total      int       not null,
    order_date timestamp not null default current_timestamp,
    primary key (id)
);

create table orders_detail
(

    id_product varchar(10) not null,
    id_order   int         not null,
    price      int         not null,
    quantity   int         not null,
    primary key (id_order, id_product)
);

alter table orders_detail
    add constraint fk_orders_detail_product foreign key (id_product) references products (id);

alter table orders_detail
    add constraint fk_orders_detail_order foreign key (id_order) references orders (id);

insert into orders(total)
values (1),
       (1),
       (1);

select *
from orders;

select *
from products
order by id;

-- Bikin Relasi
insert into orders_detail(id_product, id_order, price, quantity)
values ('P0001', 1, 1000, 2),
       ('P0002', 1, 1000, 2),
       ('P0003', 1, 1000, 2);

insert into orders_detail(id_product, id_order, price, quantity)
values ('P0004', 2, 1000, 2),
       ('P0006', 2, 1000, 2),
       ('P0007', 2, 1000, 2);

insert into orders_detail(id_product, id_order, price, quantity)
values ('P0001', 3, 1000, 2),
       ('P0004', 3, 1000, 2),
       ('P0005', 3, 1000, 2);

select *
from orders_detail;

select *
from orders
         join orders_detail on orders_detail.id_order = orders.id
         join products on orders_detail.id_product = products.id
        join categories on categories.id = products.id_category
where orders.id = 1;

-- JENIS JENIS JOIN
-- INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN

-- INNER JOIN
-- dimana terdapat relasi antara tabel pertama dan tabel kedua (ini ada default join di postgresql)

insert into categories(id, name) values('C0003','Gadget'),('C0004','Laptop'),('C0005','Pulsa');

select * from categories;

select * from products;

insert into products(id, name, price,quantity)
values ('X0001','Contoh 1',10000,100),('X0002','Contoh 2',10000,100);

-- Melakukan Inner Join pada product
    select * from categories
    inner join products on products.id_category = categories.id;

-- LEFT JOIN
-- sama seperti join / inner join. tetapi data dari table pertama akan diambil juga, jika tidak memiliki relasi di tabel kedua, maka hasilnya akan Null
select * from categories
left join products on products.id_category = categories.id order by products.id;

-- RIGHT JOIN
-- Kebalikan dari Left Join, tetapi data dari tabel kedua akan diambil juga, jika tabel pertama tidak memiliki relasi di tabel pertama, maka hasilnya akan NULL
select * from categories
right join products on products.id_category = categories.id order by products.id;

-- FULL JOIN
--  join dimana semua data tabel pertama dan tabel kedua akan ditampilkan, jika tidak ada data, maka hasilnya akan null
select * from categories
full join products on products.id_category = categories.id order by products.id;



-- SUBQUERIES
-- pencarian data menggunakan where dari hasil select query.
-- fitur ini dinamakan subquery
-- contoh kita ingin mencari products yang harganya diatas harga rata-rata aritnya kita akan melakukan select dengan where price > harga rata,
-- dimana harga rata-rata perlu kita hitung menggunakan query select lainnya menggunakan aggregate function avg

select * from products
where price > (select avg(price) from products);

-- SUBQUERY DI FORM
-- selain di WHERE clause, subquery juga bisa dilakukan di FROM clause
-- Misal kita ingin mencari data dari hasil query SELECLT, itu bisa kita lakukan di POSTGRESQL
-- contoh dari query dibawah ini adalah mencari max price yang data produknya memiliki category
-- bacanya dari dalam kurung dulu, karena prioritas
select max(price) from (Select products.price as price from categories join products on products.id_category = categories.id) as contoh;


-- SET OPERATOR
-- dimana ini adalah operasi antara hasil dari dua select query, ada banyak jenis set query

create table guestbooks
(
    id serial not null,
    email text not null,
    title text not null,
    content text,
    primary key (id)
);

select * from customer;

insert into guestbooks(email, title, content)
values ('joko@gmail.com','Feedback Joko','ini Feedback Joko'),
       ('joko@gmail.com','Feedback Joko','ini Feedback Joko'),
       ('budi@gmail.com','Feedback budi','ini Feedback budi'),
       ('Tets58@gmail.com','Feedback Tets58','ini Feedback Tets58'),
       ('tono@gmail.com','Feedback Tono','ini Feedback Tono'),
       ('tono@gmail.com','Feedback tono','ini Feedback tono');

select * from guestbooks;

-- UNION
-- operasi menggabungkan dua buah select query, dimana jika data data yang duplikat akan dijadikan 1

select distinct email from customer
union
select distinct email from guestbooks;

-- UNION all
-- dimana hasil dari dua buah select query,namu data duplikat tetap akan ditampilkan di hasil querynya
select distinct email from customer
union all
select distinct  email from guestbooks;

select email,count(email)
from (select distinct email from customer union all select distinct email from guestbooks) as contoh group by email;

select email, count(email) from customer group by email;

-- intersect
-- menggabungkan dua query namu yang diambil hanya data yang terdapat pada hasil query pertama dan kedua
-- data yang tidak hanya ada di salah satu query, akan dihapus dari hasil operasi intersect
-- datanya muncul tidak dalam keadaan duplikat

select distinct email
from customer
intersect
select distinct email from guestbooks;

-- EXCEPT
-- operasi dimana query pertama akan dihilangkan oleh query kedua,
-- jika ada query pertama yang sama dengan data yang ada di query ke dua
-- maka data tersebut akan dihapus dari hasil except

select distinct email
from customer
except
select distinct email from guestbooks;



-- TRANSACTION
-- saat membuat app berbasis database, jarang sekali kita akan melakukan satu jenis perintah SQL per aksi yang dibuat aplikasi
-- contoh, ketika membuat toko online, ketika customer menekan tombol pesan, banyak yang harus kita lakukan, misal
-- 1. membuat datapesanan di tabel order
-- 2. membuat data detail pesanan ditabel order detail
-- 3. menurunkan quantity di tabel produk
-- 4. etc
-- artinya bisa saja dalam satu aksi, kita akan melakukan beberapa perintah sekaligus
-- jika terjadi kesalahan di salah satu perintah, harapannya adalah perintah - perintah sebelumnya dibatalkan, agar tetap konsisten.

-- implementasi
start transaction;
insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','transaction');

insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','transaction2');

insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','transaction3');

insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','transaction4');

insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','transaction5');

select * from guestbooks;

commit;

start transaction;
insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','rollback');

insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','rollback 2');

insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','rollback 3');

insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','rollback 4');

insert into guestbooks(email, title, content)
values ('transaction@gmail.com','transaction','rollback 5');

select * from guestbooks;

rollback;

-- locking
-- locking adalah proses mengunci data di DBMS
-- proses mengunci data sangat petning dilakukan. agar dapat terjamin konsistensinya
-- karena dbms pasti digunakan oleh banyak pengguna, dan pengguna itu bisa akses data yang sama, jika tidak ada proses locking
-- bisa dipastikan akan terjadi RACE CONDITION, yaitu proses balapan ketika mengubah data yang sama.

-- Contoh: ketika belanja di toko online, kita akan balapan membeli barang yang sama, jika data tidak terjaga,
-- bisa jadi kita salah mengupdate stock karena pada saat yang bersamaan banyak yang melakukan perubahan stock barang

-- Locking Record
-- saat kita melakukan proses transaction, lalu kita melakukan proses perubahaan data, data yang kita ubah tersebut akan secara otomatis di lock
-- hal ini membuat proses transaction sangat aman,
-- disarankan selalu menggunakan fitur transaction ketika memanipulasi data di database, terutama ketika perintah manipulasinya lebih dari satu kali.
-- locking ini akan membuat sebuah proses perubahan yang dilakukan oleh pihak lain akan diminta untuk menunggu
-- data akan di lock sampai kita melakukan commit atau rollback transaksi tersebut.

start transaction ;

update products
set description = 'Mie Ayam original Enak'
where id ='P0001';

select * from products where id = 'P0001';

commit;


-- LOCKING RECORD MANUAL
-- kadang ketika membuat aplikasi, kita juga sering melakukan select queryterlebih dahulu sebelum melakukan proses update misalnya.

-- jika ingin melakukan locking sebuah data secara manual, kita bisa tambahkan perintah FOR UPDATE di belakang query SELECT
-- saat lock record yang di select, maka jika ada proses lain akan melakukan update, delete, select for update lag, maka proses lain akan diminta menunggu sampai lock nya lepas.

start transaction ;
select * from products where id='P0001' for update;
rollback ;

select * from products where id='P0001';

update products
set price=30000,
quantity=200
where id = 'P0001';


-- DEADLOCK
-- situasi ada 2 proses yang saling menunggu satu sama lain, namu data yang ditunggu dua duanya di lock oleh proses lainnya,
-- sehinggap roses menunggunya ini tidak akan pernah selesai

start transaction ;
select * from products where id='P0001' for update;
select * from products where id='P0002' for update;
rollback ;


-- SCHEMA
-- di postgresql terdapat fitur bernama schema, anggap saja ini adalah folder didalam database
-- saat kita membuat database, secara tidak sadar sebenarnya kita menyimpan semua table kita di schema public
-- kita bisa membuat schema lain, dan pada schema yang berbeda, kita bisa membuat table dengan nama yang sma


-- create schema
create schema contoh;
-- drop schema
drop schema contoh;

-- mengecek schema sekarang ada dimana
select "current_schema"();

-- pindah schema
set search_path to contoh;

show search_path ;

select current_schema();

-- Membuat Table di Schema yang sedang kita pilih
-- contoh kita di schema contoh, kita akan membuat table di schema contoh.
-- bisa menentukan schema secara manual tanpa schema yang sedang dipilih, kita bisa menambahkan prefix nama schema di awal nama table nya
-- Misal namaschema.namatable

-- implementation
create table contoh.products
(
    id serial not null,
    name text not null,
    primary key (id)
);
set search_path to public;

insert into contoh.products(name)
values ('iphone'),('Playstation');

select * from contoh.products;

-- Select table antar schema
select * from public.products;


-- User Management
create role eko;
create role budi;

drop role eko;
drop role budi;

alter role eko login password 'rahasia';
alter role budi login password 'rahasia';

grant insert, update, select on all tables in schema public to eko;
grant usage,update,select ON guestbooks_id_seq to eko;
grant insert,update,select on customer to budi;


-- Backup Database
-- Postgre mendukung proses Backup Database.
-- postgresql menyediakan pg_dump untuk extract sql database menjadi archive file

-- cara implementasi nya
-- USER WAJIB SUPER ADMIN karena backup seluruh data
--pg_dump --host=localhost --port=5432 --dbname=belajar --username=ricky --format=plain --file=/Users/ricky/backup.sql

-- RESTORE DATABASE
-- pertama buat dulu database restore nya
create database belajar_restore;
-- tulis command dibawah
-- psql --host=localhost --port=5432 --dbname=belajar_restore --username=ricky --file=/Users/ricky/backup.sql
