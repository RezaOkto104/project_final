import 'package:flutter/material.dart';
import 'peminjaman_form.dart'; // Pastikan untuk mengimpor file ini

class LabInfoScreen extends StatelessWidget {
  final String labName;
  final String status;
  final bool isAvailable;

  const LabInfoScreen({
    super.key,
    required this.labName,
    required this.status,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Lab'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke layar sebelumnya
          },
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueAccent, Colors.white],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                labName, // Menampilkan nama lab yang diterima
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Gambar Lab
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/lab.jpeg', // Pastikan gambar Anda di folder assets
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Informasi Lab
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const InfoRow(
                      title: 'Jumlah Maksimal Peserta',
                      value: '35', // Ganti dengan data yang sesuai jika ada
                    ),
                    const SizedBox(height: 10),
                    const InfoRow(
                      title: 'Jumlah fasilitas',
                      value: '35', // Ganti dengan data yang sesuai jika ada
                    ),
                    const SizedBox(height: 10),
                    InfoRow(
                      title: 'Status ketersediaan',
                      value: isAvailable ? 'Tersedia' : 'Dipakai',
                      valueColor: isAvailable ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Tombol Konfirmasi
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke PeminjamanForm
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PeminjamanForm(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Konfirmasi',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const InfoRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
