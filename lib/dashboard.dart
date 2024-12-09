import 'package:flutter/material.dart';
import 'list.dart'; // Pastikan untuk mengimpor file yang sesuai
import 'riwayat_page.dart'; // Pastikan untuk mengimpor file yang sesuai

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
        leading: Padding(
          padding:
              const EdgeInsets.all(8.0), // Menambahkan padding untuk estetika
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain, // Mengatur agar gambar sesuai ukuran
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            title: const Text('Melihat List Lab'),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LabListScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Riwayat'),
            leading: const Icon(Icons.history),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RiwayatPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            leading: const Icon(Icons.logout),
            onTap: () {
              // Tambahkan logika untuk log out di sini
              // Misalnya, menghapus token atau kembali ke halaman login
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
        ],
      ),
    );
  }
}
