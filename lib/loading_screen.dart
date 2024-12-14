import 'package:flutter/material.dart';
import 'login_page.dart'; // Mengimpor halaman login

// Widget untuk menampilkan layar loading
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

// State untuk LoadingScreen
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Navigasi ke halaman login setelah 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const LoginPage()), // Mengarahkan ke LoginPage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white], // Gradien latar belakang
            begin: Alignment.topLeft, // Titik awal gradien
            end: Alignment.bottomRight, // Titik akhir gradien
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Mengatur posisi kolom di tengah
            children: <Widget>[
              // Gambar logo aplikasi
              Image.asset(
                'assets/logo.png', // Pastikan Anda memiliki logo di folder assets
                width: 200, // Lebar gambar
                height: 200, // Tinggi gambar
              ),
              const SizedBox(
                  height: 20), // Jarak antara logo dan indikator loading
              const CircularProgressIndicator(), // Indikator loading
            ],
          ),
        ),
      ),
    );
  }
}
