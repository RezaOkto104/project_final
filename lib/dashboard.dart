import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk antarmuka pengguna
import 'package:project_final/login_page.dart'; // Mengimpor halaman login
import 'list.dart'; // Mengimpor file yang berisi LabListScreen
import 'riwayat_page.dart'; // Mengimpor file yang berisi RiwayatPage

// Widget untuk tampilan dashboard
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key}); // Konstruktor untuk DashboardScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'), // Judul AppBar
        backgroundColor: Colors.blueAccent, // Warna latar belakang AppBar
        leading: Padding(
          padding:
              const EdgeInsets.all(8.0), // Menambahkan padding untuk estetika
          child: GestureDetector(
            onTap: () {
              Navigator.pop(
                  context); // Kembali ke halaman sebelumnya saat logo ditekan
            },
            child: Image.asset(
              'assets/logo.png', // Gambar logo yang ditampilkan di AppBar
              fit: BoxFit.contain, // Mengatur agar gambar sesuai ukuran
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20), // Padding di sekitar ListView
        children: [
          // Item untuk melihat daftar laboratorium
          ListTile(
            title: const Text('Melihat List Lab'), // Teks item
            leading: const Icon(Icons.list), // Ikon di sebelah kiri
            onTap: () {
              // Navigasi ke LabListScreen saat item ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LabListScreen(), // Halaman yang dituju
                ),
              );
            },
          ),
          // Item untuk melihat riwayat
          ListTile(
            title: const Text('Riwayat'), // Teks item
            leading: const Icon(Icons.history), // Ikon di sebelah kiri
            onTap: () {
              // Navigasi ke RiwayatPage saat item ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const RiwayatPage(), // Halaman yang dituju
                ),
              );
            },
          ),
          // Item untuk logout
          ListTile(
            title: const Text('Log Out'), // Teks item
            leading: const Icon(Icons.logout), // Ikon di sebelah kiri
            onTap: () {
              // Navigasi ke LoginPage saat item ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LoginPage(), // Halaman yang dituju
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
