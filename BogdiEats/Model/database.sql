USE food;

CREATE TABLE warung (
	id_warung numeric(5) primary key not null,
	nama varchar(30) not null
)

CREATE TABLE kategori (
	id_kategori numeric(5) primary key not null,
	nama varchar(30) not null
)

CREATE TABLE menu (
	id_menu numeric(5) primary key not null,
	nama varchar(30) not null,
	foto varchar(100) not null,
	deskripsi text not null,
	harga numeric(6) not null,
	id_warung numeric(5) foreign key references warung(id_warung),
	id_kategori numeric(5) foreign key references kategori(id_kategori)
)

CREATE TABLE variasi (
	id_variasi numeric(5) primary key not null,
	nama varchar(30) not null,
	keterangan text not null,
	harga_tambahan numeric(7) not null,
	id_menu numeric(5) foreign key references menu(id_menu)
)

CREATE table transaksi (
	id_transaksi numeric(5) primary key not null,
	tanggal datetime not null,
	total numeric(7) not null,
	status_transaksi varchar(10) CHECK (status_transaksi IN ('pending', 'sukses', 'dibatalkan'))
)

ALTER TABLE transaksi ADD kode_meja varchar(3) not null
ALTER TABLE transaksi ADD metode_pembayaran varchar(10) not null

CREATE TABLE transaksi_item (
	id_item numeric(5) primary key not null,
	id_variasi numeric(5) foreign key references variasi(id_variasi),
	id_menu numeric(5) foreign key references menu(id_menu),
	id_transaksi numeric(5) foreign key references transaksi(id_transaksi),
	tanggal datetime not null,
	subtotal numeric (7) not null
)

ALTER table transaksi_item DROP COLUMN tanggal
ALTER table transaksi_item ADD qty numeric(2) not null
ALTER table transaksi_item ADD note text null

insert into warung values ('00001','Warung Bu Tini')
insert into warung values ('00002','Warung Pak Jono')

insert into kategori values ('00001', 'Mie'),('00002', 'Sop'), ('00003', 'Snek'), ('00004', 'Sayur'), ('00005', 'Nasi'), ('00006', 'Minum');

insert into menu values 
('00001','Nasi Goreng Ayam','nasigoreng.jpg','Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso','15000', '0001','0001'),
('00002','Mie Ayam','mieayam.jpg','Mie ayam dengan bumbu special, dengan campuran ayam bumbu manis','10000', '0002','0002'),
('00003','Nasi Kuning','nasigoreng.jpg','Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso','15000', '0001','0001'),
('00004','Nasi Merah','nasigoreng.jpg','Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso','15000', '0001','0001'),
('00005','Nasi Hijau','nasigoreng.jpg','Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso','15000', '0001','0001'),
('00006','Nasi Biru','nasigoreng.jpg','Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso','15000', '0001','0001');
insert into menu values 
('00007','Nasi Pink','nasigoreng.jpg','Nasi goreng dengan bumbu special, dengan campuran telur ayam dan bakso','15000', '0001','0001');


insert into variasi values ('00001','extra telur','jangan pakai kobis','3000','00001'),
('00002','extra bakso','jangan pakai sawi','4000','00002'),
('00003','extra cabe','jangan pakai kobis','500','00001'),
('00004','extra ayam','jangan pakai saus','3000','00002');

insert into transaksi values ('00001','2020/01/04','18000','sukses', 'A01', 'Go-pay'),
('00002','2020/01/04','18000','sukses', 'A01', 'Go-pay'),
('00003','2020/01/01','14000','sukses', 'A10', 'Cash'),
('00004','2020/01/01','14000','sukses', 'A10', 'Cash'),
('00005','2019/12/09','15500','sukses', 'B01', 'Ovo'),
('00006','2019/12/09','15500','sukses', 'B01', 'Ovo'),
('00007','2020/02/08','13000','sukses', 'A11', 'Go-pay'),
('00008','2020/02/08','13000','sukses', 'A11', 'Go-pay');

insert into transaksi_item values ('00001',1,'00001','00001','18000', 1, null)
insert into transaksi_item values ('00002',2,'00002','00002','18000', 1, null)
insert into transaksi_item values ('00003',1,'00001','00003','14000', 1, null)
insert into transaksi_item values ('00004',2,'00002','00004','14000', 1, null)
insert into transaksi_item values ('00005',1,'00001','00005','15500', 1, null)
insert into transaksi_item values ('00006',2,'00002','00006','15500', 1, null)
insert into transaksi_item values ('00007',1,'00001','00007','13000', 1, null)
insert into transaksi_item values ('00008',2,'00002','00008','13000', 1, null)

select * from transaksi join transaksi_item on transaksi.id_transaksi=transaksi_item.id_transaksi
where transaksi.tanggal='2020/01/04'

select * from transaksi join transaksi_item on transaksi.id_transaksi=transaksi_item.id_transaksi
where transaksi.tanggal>='2020/01/01' or transaksi.tanggal<='2020/01/30'

select * from transaksi_item

select * from variasi

DELETE FROM variasi