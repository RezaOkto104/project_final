import 'package:flutter/material.dart';
import 'package:project_final/dashboard.dart'; // Mengimpor halaman dashboard biasa
import 'package:project_final/dashboard_admin.dart'; // Mengimpor halaman dashboard admin

// Widget untuk halaman login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

// State untuk LoginPage
class _LoginPageState extends State<LoginPage> {
  // Kontrol untuk input username dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk menangani proses login
  void _login() {
    String username = _usernameController.text.trim(); // Mengambil username
    String password = _passwordController.text.trim(); // Mengambil password

    // Verifikasi login berdasarkan username dan password
    if (username == 'user' && password == 'user') {
      // Navigasi ke DashboardUser  jika login berhasil
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const DashboardScreen(), // Halaman Dashboard biasa
        ),
      );
    } else if (username == 'admin' && password == 'admin') {
      // Navigasi ke DashboardAdmin jika login berhasil
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const DashboardAdmin(), // Halaman Dashboard Admin
        ),
      );
    } else {
      // Menampilkan pesan jika login gagal
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Gagal'), // Judul dialog
            content:
                const Text('Username atau password salah.'), // Pesan kesalahan
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
                child: const Text('Tutup'), // Teks tombol untuk menutup dialog
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Titik awal gradien
            end: Alignment.bottomCenter, // Titik akhir gradien
            colors: [
              Color(0xFFB2D0FF), // Warna gradien pertama
              Color(0xFFDEE9FF), // Warna gradien kedua
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 32.0), // Padding horizontal
            child: Container(
              padding: const EdgeInsets.all(20), // Padding di dalam kontainer
              decoration: BoxDecoration(
                color: Colors.white, // Warna latar belakang kontainer
                borderRadius: BorderRadius.circular(16), // Sudut melengkung
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Warna bayangan
                    blurRadius: 10, // Blur radius bayangan
                    offset: const Offset(0, 4), // Posisi bayangan
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ukuran kolom minimum
                children: [
                  const Text(
                    'LOG IN', // Judul halaman login
                    style: TextStyle(
                      fontSize: 24, // Ukuran font
                      fontWeight: FontWeight.bold, // Ketebalan font
                      color: Colors.black, // Warna font
                    ),
                  ),
                  const SizedBox(height: 20), // Jarak antara judul dan input
                  TextField(
                    controller:
                        _usernameController, // Menghubungkan kontrol username
                    decoration: InputDecoration(
                      labelText: 'NIM/NIP', // Label untuk input username
                      labelStyle:
                          TextStyle(color: Colors.grey[600]), // Gaya label
                      filled: true, // Mengisi latar belakang input
                      fillColor:
                          const Color(0xFFF5F5F5), // Warna latar belakang input
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Sudut melengkung border
                        borderSide: BorderSide.none, // Tanpa garis border
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Jarak antara input username dan password
                  TextField(
                    controller:
                        _passwordController, // Menghubungkan kontrol password
                    obscureText: true, // Menyembunyikan teks password
                    decoration: InputDecoration(
                      labelText: 'Password', // Label untuk input password
                      labelStyle:
                          TextStyle(color: Colors.grey[600]), // Gaya label
                      filled: true, // Mengisi latar belakang input
                      fillColor:
                          const Color(0xFFF5F5F5), // Warna latar belakang input
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Sudut melengkung border
                        borderSide: BorderSide.none, // Tanpa garis border
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Jarak antara input password dan tombol
                  SizedBox(
                    width:
                        double.infinity, // Lebar tombol sesuai dengan kontainer
                    child: ElevatedButton(
                      onPressed:
                          _login, // Memanggil fungsi login saat tombol ditekan
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF8A4AFF), // Warna latar belakang tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12), // Sudut melengkung tombol
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16), // Padding vertikal tombol
                      ),
                      child: const Text(
                        'Log in', // Teks tombol
                        style: TextStyle(
                          fontSize: 16, // Ukuran font tombol
                          color: Colors.white, // Warna font tombol
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
