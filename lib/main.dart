import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; // Mengimpor paket sqflite untuk database SQLite
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Mengimpor sqflite_ffi untuk dukungan FFI
import 'package:project_final/login_page.dart'; // Mengimpor halaman login
import 'list.dart'; // Mengimpor halaman daftar laboratorium
import 'loading_screen.dart'; // Mengimpor layar loading
import 'peminjaman_form.dart'; // Mengimpor formulir peminjaman
import 'riwayat_page.dart'; // Mengimpor halaman riwayat
import 'dashboard.dart'; // Mengimpor halaman dashboard

void main() {
  // Inisialisasi databaseFactory untuk menggunakan FFI
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp()); // Menjalankan aplikasi
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      title: 'Aplikasi Peminjaman Laboratorium', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema warna utama aplikasi
      ),
      initialRoute:
          '/loading', // Halaman awal yang ditampilkan saat aplikasi dimulai
      routes: {
        '/': (context) => const LoginPage(), // Rute untuk halaman LoginPage
        '/list': (context) =>
            const LabListScreen(), // Rute untuk halaman daftar laboratorium
        '/loading': (context) =>
            const LoadingScreen(), // Rute untuk halaman loading
        '/peminjaman_form': (context) =>
            const PeminjamanForm(), // Rute untuk halaman formulir peminjaman
        '/riwayat': (context) =>
            const RiwayatPage(), // Rute untuk halaman riwayat
        '/dashboard': (context) =>
            const DashboardScreen(), // Rute untuk halaman dashboard
      },
    );
  }
}
