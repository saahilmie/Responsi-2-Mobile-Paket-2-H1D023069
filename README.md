# Responsi 2 Mobile - Paket 2 (H1D023069)
## Aplikasi Inventaris Bahan Makanan Supermarket

### Data Diri
- **Nama**: Khonsaa Hilmi Mufiida
- **NIM**: H1D023069
- **Shift Awal**: A
- **Shift Baru**: D

---

## Tentang Aplikasi

Aplikasi mobile untuk mengelola inventaris bahan makanan di supermarket. Aplikasi ini dibangun menggunakan Flutter untuk frontend dan CodeIgniter 4 sebagai REST API backend. Fitur utama meliputi autentikasi pengguna (login & registrasi) serta operasi CRUD lengkap untuk data inventaris bahan makanan.

---

## Demo Aplikasi

Berikut adalah demo dari aplikasi yang saya buat, jika ada kekurangan saya mohon maaf.

![Demo Aplikasi](/docs/demo-aplikasi.mp4)

---

## Screenshot Aplikasi

### 1. Splash Screen
<img src="/docs/splash.jpg" width="400">

Tampilan awal saat aplikasi dibuka. Menampilkan logo dan nama aplikasi dengan loading indicator. Splash screen akan otomatis mengecek status login user - jika sudah login akan langsung masuk ke halaman inventaris, jika belum akan diarahkan ke halaman login.

### 2. Login Page
<img src="/docs/login.jpg" width="400">

Halaman login dengan form email dan password. Dilengkapi dengan validasi input dan fitur show/hide password menggunakan icon mata. Terdapat link menuju halaman registrasi bagi user yang belum memiliki akun.

### 3. Register Page
<img src="/docs/register.jpg" width="400">

Halaman registrasi untuk membuat akun baru. User perlu mengisi nama, email, password, dan konfirmasi password. Semua field memiliki validasi - password minimal 6 karakter dan konfirmasi password harus sama. Setelah berhasil registrasi akan muncul snackbar hijau dan otomatis kembali ke halaman login.

### 4. Inventaris Page
<img src="/docs/inventaris-page.jpg" width="400">

Halaman utama yang menampilkan daftar inventaris bahan makanan dalam bentuk card. Setiap card menampilkan nama barang, harga (format Rupiah), jumlah stok, tanggal masuk, dan tanggal kedaluwarsa. Terdapat indikator warna untuk status kedaluwarsa (hijau = segar, kuning = 30 hari lagi, orange = 7 hari lagi, merah = sudah kadaluwarsa). Di bagian atas ada tombol refresh dan logout, sementara floating action button di kanan bawah untuk tambah data baru.

### 5. Tambah Inventaris
<img src="/docs/tambah.jpg" width="400">

Form untuk menambah data inventaris baru. Terdiri dari dua card - card pertama untuk informasi bahan makanan (nama, harga, jumlah stok) dan card kedua untuk informasi tanggal (tanggal masuk dan kedaluwarsa). Tanggal dipilih menggunakan date picker dengan tema hijau sesuai warna aplikasi. Semua field wajib diisi dan memiliki validasi.

### 6. Inventaris Page Setelah Tambah
<img src="/docs/inventaris-page-setelah-tambah-1.jpg" width="400">

Tampilan halaman inventaris setelah berhasil menambah data baru. Data baru langsung muncul di list dengan snackbar hijau menandakan data berhasil ditambahkan. List otomatis di-refresh untuk menampilkan data terbaru.

### 7. Detail Inventaris (1)
<img src="/docs/detail-1.jpg" width="400">

Halaman detail menampilkan informasi lengkap satu item inventaris. Di bagian atas ada status card dengan warna sesuai kondisi kedaluwarsa. Bagian tengah menampilkan icon, nama barang, harga, dan jumlah stok dalam badge hijau. Di bagian bawah ada informasi tanggal masuk dan kedaluwarsa dengan icon masing-masing.

### 8. Ubah Inventaris
<img src="/docs/ubah-inventaris-1.jpg" width="400">

Form edit data inventaris. Form ini sama seperti form tambah, tapi sudah terisi dengan data sebelumnya. User dapat mengubah semua field dan tombol submit berubah menjadi "UBAH". Setelah berhasil update akan muncul snackbar hijau dan kembali ke halaman detail dengan data terbaru.

### 9. Detail Inventaris (2)
<img src="/docs/detail-2.jpg" width="400">

Tampilan detail setelah data diubah. Semua perubahan langsung terlihat di halaman ini. Status kedaluwarsa juga otomatis terupdate sesuai tanggal yang baru.

### 10. Detail Inventaris (3)
<img src="/docs/detail-3.jpg" width="400">

Detail item dengan status kedaluwarsa yang berbeda. Card status di atas berubah warna sesuai kondisi barang - bisa hijau (segar), kuning (perhatian), orange (segera kadaluwarsa), atau merah (sudah kadaluwarsa).

### 11. Detail Inventaris (4)
<img src="/docs/detail-4.jpg" width="400">

Contoh lain tampilan detail dengan status dan data yang berbeda. Menunjukkan konsistensi UI di seluruh aplikasi dengan layout yang sama tapi konten dinamis.

### 12. Konfirmasi Hapus
<img src="/docs/hapus.jpg" width="400">

Dialog konfirmasi saat user menekan tombol hapus. Menampilkan nama barang yang akan dihapus dengan dua pilihan - tombol "Batal" untuk membatalkan aksi dan tombol "Hapus" berwarna merah untuk konfirmasi penghapusan. Ini mencegah user tidak sengaja menghapus data.

### 13. Inventaris Page Final
<img src="/docs/inventaris-page.jpg" width="400">

Tampilan akhir halaman inventaris dengan beberapa data. Menunjukkan variasi status kedaluwarsa yang berbeda-beda pada setiap item. User dapat scroll list untuk melihat semua data, tap card untuk lihat detail, atau pull to refresh untuk reload data dari server.

---

## Test API dengan Postman

### 1. Test API Registrasi
<img src="/docs/coba-test-api-registrasi.png" width="400">

Testing endpoint registrasi menggunakan method POST. Request body berisi nama, email, dan password dalam format JSON. Response menunjukkan code 200, status true, dan message "Registrasi Berhasil" yang artinya user baru berhasil dibuat di database.

### 2. Test API Login
<img src="/docs/coba-test-api-login.png" width="400">

Testing endpoint login dengan method POST. Request body berisi email dan password. Response berhasil dengan code 200 dan mengembalikan token autentikasi serta data user (id, nama, email). Token ini yang akan digunakan untuk akses endpoint lain yang memerlukan autentikasi.

### 3. Test API Inventaris - Header Authorization
<img src="/docs/coba-test-api-inventaris-tambah-header.png" width="400">

Screenshot menunjukkan penggunaan Authorization header dengan format "Bearer {token}" untuk akses endpoint inventaris. Token didapat dari response login dan wajib disertakan di header untuk endpoint yang memerlukan autentikasi.

### 4. Test API Inventaris - Tambah Data
<img src="/docs/coba-test-api-inventaris.png" width="400">

Testing endpoint tambah inventaris dengan method POST. Request body berisi nama, harga, jumlah, tanggal_masuk, dan tanggal_kedaluwarsa. Response mengembalikan data inventaris baru lengkap dengan id, member_id, dan timestamp created_at yang menandakan data berhasil tersimpan di database.

---

## Spesifikasi API

### Base URL
```
http://10.55.57.82/inventaris-api/public
```
**Note**: Ganti IP sesuai dengan IP komputer Anda jika menjalankan di device fisik.

### Endpoints

#### 1. Registrasi
- **URL**: `/registrasi`
- **Method**: `POST`
- **Header**: 
  ```
  Content-Type: application/json
  ```
- **Body**:
  ```json
  {
    "nama": "string",
    "email": "string (unique)",
    "password": "string"
  }
  ```
- **Response Success**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": "Registrasi Berhasil"
  }
  ```
- **Response Error**:
  ```json
  {
    "code": 400,
    "status": false,
    "data": "Email sudah terdaftar"
  }
  ```

#### 2. Login
- **URL**: `/login`
- **Method**: `POST`
- **Header**: 
  ```
  Content-Type: application/json
  ```
- **Body**:
  ```json
  {
    "email": "string",
    "password": "string"
  }
  ```
- **Response Success**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": {
      "token": "string",
      "user": {
        "id": "integer",
        "nama": "string",
        "email": "string"
      }
    }
  }
  ```
- **Response Error**:
  ```json
  {
    "code": 400,
    "status": false,
    "data": "Email tidak ditemukan / Password tidak valid"
  }
  ```

#### 3. List Inventaris
- **URL**: `/inventaris`
- **Method**: `GET`
- **Header**: 
  ```
  Content-Type: application/json
  Authorization: Bearer {token}
  ```
- **Response Success**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": [
      {
        "id": "integer",
        "member_id": "integer",
        "nama": "string",
        "harga": "integer",
        "jumlah": "integer",
        "tanggal_masuk": "string (YYYY-MM-DD)",
        "tanggal_kedaluwarsa": "string (YYYY-MM-DD)"
      }
    ]
  }
  ```

#### 4. Detail Inventaris
- **URL**: `/inventaris/{id}`
- **Method**: `GET`
- **Header**: 
  ```
  Content-Type: application/json
  Authorization: Bearer {token}
  ```
- **Response Success**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": {
      "id": "integer",
      "member_id": "integer",
      "nama": "string",
      "harga": "integer",
      "jumlah": "integer",
      "tanggal_masuk": "string",
      "tanggal_kedaluwarsa": "string"
    }
  }
  ```

#### 5. Tambah Inventaris
- **URL**: `/inventaris`
- **Method**: `POST`
- **Header**: 
  ```
  Content-Type: application/json
  Authorization: Bearer {token}
  ```
- **Body**:
  ```json
  {
    "nama": "string",
    "harga": "integer",
    "jumlah": "integer",
    "tanggal_masuk": "string (YYYY-MM-DD)",
    "tanggal_kedaluwarsa": "string (YYYY-MM-DD)"
  }
  ```
- **Response Success**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": {
      "id": "integer",
      "member_id": "integer",
      "nama": "string",
      "harga": "integer",
      "jumlah": "integer",
      "tanggal_masuk": "string",
      "tanggal_kedaluwarsa": "string"
    }
  }
  ```

#### 6. Ubah Inventaris
- **URL**: `/inventaris/{id}`
- **Method**: `PUT`
- **Header**: 
  ```
  Content-Type: application/json
  Authorization: Bearer {token}
  ```
- **Body**:
  ```json
  {
    "nama": "string",
    "harga": "integer",
    "jumlah": "integer",
    "tanggal_masuk": "string (YYYY-MM-DD)",
    "tanggal_kedaluwarsa": "string (YYYY-MM-DD)"
  }
  ```
- **Response Success**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": {
      "id": "integer",
      "member_id": "integer",
      "nama": "string",
      "harga": "integer",
      "jumlah": "integer",
      "tanggal_masuk": "string",
      "tanggal_kedaluwarsa": "string"
    }
  }
  ```

#### 7. Hapus Inventaris
- **URL**: `/inventaris/{id}`
- **Method**: `DELETE`
- **Header**: 
  ```
  Content-Type: application/json
  Authorization: Bearer {token}
  ```
- **Response Success**:
  ```json
  {
    "code": 200,
    "status": true,
    "data": "Data berhasil dihapus"
  }
  ```

---

## Struktur Kode dan Penjelasan Fungsi

### Backend (CodeIgniter 4)

#### 1. **Database Schema** (`inventaris_api`)

**Tabel `member`**
- Menyimpan data pengguna aplikasi
- Field: `id`, `nama`, `email`, `password` (hashed)
- Digunakan untuk autentikasi login

**Tabel `member_token`**
- Menyimpan token autentikasi setiap user
- Field: `id`, `member_id`, `auth_key`
- Relasi foreign key ke tabel member
- Token digunakan untuk validasi akses API

**Tabel `inventaris`**
- Menyimpan data inventaris bahan makanan
- Field: `id`, `member_id`, `nama`, `harga`, `jumlah`, `tanggal_masuk`, `tanggal_kedaluwarsa`, `created_at`
- Relasi ke member dengan cascade delete (kalau user dihapus, semua inventarisnya juga terhapus)

#### 2. **Controllers**

**`RestfulController.php`**
- Base controller untuk semua controller API
- Extends ResourceController dari CodeIgniter
- Function `responseHasil()`: Standardisasi format response JSON dengan code, status, dan data
- Digunakan oleh semua controller lain untuk konsistensi response

**`RegistrasiController.php`**
- Handle proses registrasi user baru
- Function `registrasi()`:
  - Validasi input (nama, email, password tidak boleh kosong)
  - Cek apakah email sudah terdaftar
  - Hash password menggunakan `password_hash()`
  - Simpan data user baru ke database
  - Return response sukses atau error

**`LoginController.php`**
- Handle proses login user
- Function `login()`:
  - Cari user berdasarkan email
  - Validasi password dengan `password_verify()`
  - Generate random token untuk autentikasi
  - Simpan token ke tabel member_token
  - Return token dan data user
- Function `RandomString()`:
  - Generate random string 100 karakter untuk token
  - Kombinasi angka dan huruf besar-kecil

**`InventarisController.php`**
- Handle semua operasi CRUD inventaris
- Function `verifyToken()`:
  - Ambil token dari Authorization header
  - Validasi token di database
  - Return member_id jika valid, null jika tidak
- Function `list()`:
  - Ambil semua data inventaris milik user yang login
  - Filter by member_id untuk data isolation
- Function `create()`:
  - Tambah data inventaris baru
  - Otomatis assign member_id dari token
- Function `detail($id)`:
  - Ambil detail satu inventaris
  - Validasi apakah inventaris milik user tersebut
- Function `ubah($id)`:
  - Update data inventaris
  - Validasi kepemilikan data
- Function `hapus($id)`:
  - Delete inventaris dari database
  - Validasi kepemilikan data

#### 3. **Models**

**`MMember.php`**
- Model untuk tabel member
- Define field yang bisa diisi: nama, email, password

**`MMemberToken.php`**
- Model untuk tabel member_token
- Define field: member_id, auth_key

**`MInventaris.php`**
- Model untuk tabel inventaris
- Primary key: id
- Allowed fields: member_id, nama, harga, jumlah, tanggal_masuk, tanggal_kedaluwarsa

#### 4. **Routes** (`Routes.php`)
- Define semua endpoint API
- `/registrasi` → RegistrasiController
- `/login` → LoginController
- Group `/inventaris` dengan 5 method (GET list, POST create, GET detail, PUT update, DELETE)

---

### Frontend (Flutter)

#### 1. **Helpers**

**`api.dart`**
- Class untuk handle semua request ke API
- Constant `baseUrl`: URL base API (adjustable untuk emulator/device)
- Function `getHeaders()`:
  - Generate header dengan Content-Type JSON
  - Otomatis include Authorization Bearer token jika ada
- Function `post()`, `get()`, `put()`, `delete()`:
  - Wrapper untuk HTTP request dengan error handling
  - Encode body ke JSON
  - Decode response dari JSON
  - Catch network error dan return format error standar

**`user_info.dart`**
- Class untuk manage data user pakai SharedPreferences
- Function `setToken()`: Simpan token autentikasi
- Function `getToken()`: Ambil token untuk API request
- Function `setUserInfo()`: Simpan id, nama, email user
- Function `getUserId()`, `getNama()`, `getEmail()`: Getter data user
- Function `logout()`: Clear semua data dari SharedPreferences

#### 2. **Models**

**`login.dart`**
- Model untuk response login
- Property: code, status, token, userId, userNama, userEmail
- Factory `fromJson()`: Parse response API jadi object Login
- Handle kondisi sukses (code 200) dan error

**`registrasi.dart`**
- Model untuk response registrasi
- Property: code, status, data (message)
- Factory `fromJson()`: Parse response API

**`inventaris.dart`**
- Model untuk data inventaris
- Property: id, memberId, nama, harga, jumlah, tanggalMasuk, tanggalKedaluwarsa
- Factory `fromJson()`: Parse JSON dari API jadi object
- Function `toJson()`: Convert object ke format JSON untuk API request

#### 3. **UI Pages**

**`main.dart`**
- Entry point aplikasi
- Define MaterialApp dengan tema hijau (#8da750)
- Widget `SplashCheck`:
  - Tampil 2 detik dengan loading
  - Cek token di SharedPreferences
  - Navigate ke InventarisPage jika sudah login, LoginPage jika belum
  - Auto-login functionality

**`login_page.dart`**
- Halaman login dengan form email & password
- State variable:
  - `_isLoading`: Track loading saat proses login
  - `_obscurePassword`: Toggle show/hide password
- Function `_login()`:
  - Validasi form
  - Call API login
  - Simpan token dan user info
  - Navigate ke InventarisPage jika sukses
  - Show snackbar error jika gagal
- UI: Email field, password field dengan icon mata, tombol login, link ke registrasi

**`registrasi_page.dart`**
- Halaman registrasi dengan form lengkap
- Form field: nama, email, password, konfirmasi password
- State variable:
  - `_obscurePassword`: Toggle untuk field password
  - `_obscureConfirmPassword`: Toggle untuk field konfirmasi
- Validasi:
  - Nama minimal 3 karakter
  - Email format valid (regex)
  - Password minimal 6 karakter
  - Konfirmasi password harus sama
- Function `_registrasi()`:
  - Call API registrasi
  - Show snackbar hijau jika sukses
  - Pop kembali ke login page

**`inventaris_page.dart`**
- Halaman utama list inventaris
- State:
  - `_inventarisList`: List data inventaris dari API
  - `_isLoading`: Track loading state
  - `_userName`: Nama user untuk ditampilkan di AppBar
- Function `_loadInventaris()`:
  - GET request ke API
  - Parse response jadi List<Inventaris>
  - Update UI
  - Handle unauthorized (redirect ke login)
- Function `_formatCurrency()`:
  - Format angka jadi Rupiah (Rp 85.000)
  - Locale Indonesia tanpa desimal
- Function `_getStatusColor()` & `_getStatusText()`:
  - Calculate selisih hari dari tanggal kedaluwarsa
  - Return warna dan text sesuai status (hijau/kuning/orange/merah)
- UI:
  - AppBar dengan nama user, tombol refresh & logout
  - ListView dengan card untuk setiap item
  - FloatingActionButton untuk tambah data
  - Empty state jika belum ada data
  - Pull to refresh

**`inventaris_form.dart`**
- Form untuk tambah dan edit inventaris
- Detect mode (tambah/edit) di `initState()`:
  - Cek apakah ada parameter inventaris
  - Set judul dan tombol sesuai mode
  - Pre-fill form jika edit mode
- Function `_selectDate()`:
  - Show DatePicker dengan tema hijau
  - Format tanggal ke YYYY-MM-DD
  - Update controller
- Function `_submit()`:
  - Validasi form
  - POST (tambah) atau PUT (edit) sesuai mode
  - Show snackbar sesuai hasil
  - Pop dengan result true jika sukses
- UI:
  - Dua card terpisah (info barang & tanggal)
  - DatePicker untuk tanggal masuk & kedaluwarsa
  - Validasi semua field

**`inventaris_detail.dart`**
- Halaman detail satu inventaris
- Function `_formatCurrency()`: Format harga ke Rupiah
- Function `_getStatusColor()` & `_getStatusText()`:
  - Sama seperti di inventaris_page
  - Untuk status card di atas
- Function `_confirmDelete()`:
  - Show AlertDialog konfirmasi
  - Return boolean (true jika user confirm)
- Function `_deleteInventaris()`:
  - DELETE request ke API
  - Show snackbar hasil
  - Pop kembali ke list jika sukses
- UI:
  - Status card dengan warna dinamis
  - Info card dengan icon, nama, harga, stok
  - Date info card dengan tanggal masuk & kedaluwarsa
  - Row button edit & hapus di bawah

---

## Cara Menjalankan Aplikasi

### Prerequisites
- XAMPP (Apache & MySQL)
- Flutter SDK
- Android Device / Emulator
- Postman (untuk testing API)

### Setup Backend

1. **Database**
   ```bash
   # Buka phpMyAdmin (http://localhost/phpmyadmin)
   # Buat database baru: inventaris_api
   # Import atau jalankan SQL schema yang ada di dokumentasi
   ```

2. **CodeIgniter 4**
   ```bash
   # Download CodeIgniter 4
   # Extract ke C:\xampp\htdocs\inventaris-api
   # Edit app/Config/Database.php untuk koneksi database
   ```

3. **Start XAMPP**
   ```bash
   # Start Apache dan MySQL dari XAMPP Control Panel
   ```

4. **Test API**
   ```bash
   # Buka Postman
   # Test endpoint registrasi dan login
   # Base URL: http://localhost/inventaris-api/public
   ```

### Setup Frontend

1. **Clone Repository**
   ```bash
   git clone <[repository-url](https://github.com/saahilmie/Responsi-2-Mobile-Paket-2-H1D023069)>
   cd inventaris_bahan_makanan
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Konfigurasi API URL**
   ```dart
   // Edit lib/helpers/api.dart
   // Sesuaikan baseUrl dengan device yang digunakan:
   
   // Untuk emulator:
   static const String baseUrl = 'http://10.0.2.2/inventaris-api/public';
   
   // Untuk physical device:
   // Cek IP komputer dengan ipconfig di CMD
   static const String baseUrl = 'http://192.168.x.x/inventaris-api/public';
   ```

4. **Run Aplikasi**
   ```bash
   # Pastikan device/emulator sudah terhubung
   flutter run
   ```

---

## Fitur Aplikasi

- **Autentikasi**: Registrasi dan Login dengan validasi
- **Token-based Authentication**: Secure API access
- **CRUD Inventaris**: Create, Read, Update, Delete bahan makanan
- **Status Kedaluwarsa**: Color-coded status berdasarkan tanggal
- **Date Picker**: UI friendly untuk input tanggal
- **Currency Format**: Format Rupiah otomatis
- **Show/Hide Password**: Toggle visibility password
- **Auto Login**: Persistent session dengan SharedPreferences
- **Pull to Refresh**: Refresh data dengan gesture
- **Empty State**: UI untuk kondisi data kosong
- **Confirmation Dialog**: Prevent accidental delete
- **Responsive UI**: Modern design dengan Material Design
- **Error Handling**: Proper error messages dan loading states

---

## Teknologi yang Digunakan

### Backend
- **Framework**: CodeIgniter 4
- **Database**: MySQL
- **Authentication**: Token-based (custom implementation)
- **API Architecture**: RESTful API

### Frontend
- **Framework**: Flutter
- **Language**: Dart
- **State Management**: StatefulWidget
- **HTTP Client**: http package
- **Local Storage**: shared_preferences
- **Date Formatting**: intl package

### Design
- **Color Scheme**: Hijau (#8da750)
- **UI Pattern**: Material Design
- **Icons**: Material Icons & Lucide Icons
- **Typography**: Default Flutter Typography

---

## Catatan Pengembangan

### Challenge yang Dihadapi
1. **Network Connection**: Flutter tidak bisa akses localhost langsung dari device, solved dengan menggunakan IP laptop dan pastikan satu jaringan WiFi
2. **Token Authentication**: Implementasi manual token auth di CodeIgniter tanpa library eksternal
3. **Date Formatting**: Konsistensi format tanggal antara frontend dan backend (YYYY-MM-DD)
4. **Status Calculation**: Logic untuk hitung selisih hari dan assign warna status

### Improvement yang Bisa Dilakukan
- Implementasi refresh token untuk keamanan lebih baik
- Add image upload untuk foto barang
- Implementasi search dan filter di list inventaris
- Add pagination untuk performa dengan data banyak
- Implementasi notification untuk barang yang akan kadaluwarsa
- Add kategori barang untuk grouping
- Export data ke PDF atau Excel
- Dark mode theme option

---
