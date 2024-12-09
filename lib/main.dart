import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:project_final/login_page.dart';
import 'list.dart';
import 'loading_screen.dart';
import 'peminjaman_form.dart';
import 'riwayat_page.dart';
import 'dashboard.dart';

void main() {
  // Inisialisasi databaseFactory
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Peminjaman Laboratorium',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loading', // Halaman awal
      routes: {
        '/': (context) => const LoginPage(), // Rute untuk LoginPage
        '/list': (context) => const LabListScreen(), // Rute untuk ListPage
        '/loading': (context) =>
            const LoadingScreen(), // Rute untuk LoadingScreen
        '/peminjaman_form': (context) =>
            const PeminjamanForm(), // Rute untuk PeminjamanForm
        '/riwayat': (context) => const RiwayatPage(), // Rute untuk RiwayatPage
        '/dashboard': (context) =>
            const DashboardScreen(), // Rute untuk DashboardPage
      },
    );
  }
}
