import 'package:flutter/material.dart';
import 'login_page.dart'; // Pastikan ini sesuai dengan nama file Anda

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Navigasi ke halaman login setelah 1,5 detik
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginPage()), // Ganti dengan LoginPage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Ganti dengan logo aplikasi Anda
              Image.asset(
                'assets/logo.png', // Pastikan Anda memiliki logo di folder assets
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(), // Indikator loading
            ],
          ),
        ),
      ),
    );
  }
}
