import 'package:flutter/material.dart';
import 'database/database_service.dart';
import 'peminjaman_form.dart'; // Mengimpor file PeminjamanForm untuk navigasi
import 'database/laboratory.dart'; // Mengimpor model Laboratory

// Widget untuk menampilkan informasi tentang laboratorium
class LabInfoScreen extends StatelessWidget {
  final Laboratory lab; // Menerima objek Laboratory

  const LabInfoScreen({
    super.key,
    required this.lab, // Mengharuskan lab untuk diisi
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Lab'), // Judul AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ikon kembali
          onPressed: () {
            Navigator.pop(context); // Kembali ke layar sebelumnya
          },
        ),
        backgroundColor: Colors.blueAccent, // Warna latar belakang AppBar
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueAccent,
                Colors.white
              ], // Gradien latar belakang
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20), // Jarak atas
              Text(
                lab.labName, // Menampilkan nama lab yang diterima
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Warna teks nama lab
                ),
              ),
              const SizedBox(height: 20), // Jarak antara nama lab dan gambar
              // Gambar Lab
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20), // Margin horizontal
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // Sudut melengkung
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Bayangan
                      blurRadius: 5,
                      offset: const Offset(0, 5), // Posisi bayangan
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      12), // Sudut melengkung untuk gambar
                  child: Image.asset(
                    'assets/lab.jpeg', // Pastikan gambar Anda di folder assets
                    fit: BoxFit
                        .cover, // Mengatur gambar agar sesuai dengan kontainer
                    height: 200, // Tinggi gambar
                    width: double.infinity, // Lebar gambar
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // Jarak antara gambar dan informasi lab
              // Informasi Lab
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20), // Margin horizontal
                padding: const EdgeInsets.all(16), // Padding di dalam kontainer
                decoration: BoxDecoration(
                  color: Colors.white, // Warna latar belakang informasi lab
                  borderRadius: BorderRadius.circular(12), // Sudut melengkung
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Bayangan
                      blurRadius: 5,
                      offset: const Offset(0, 5), // Posisi bayangan
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    InfoRow(
                      title: 'Jumlah Maksimal Peserta', // Judul informasi
                      value: lab.maxCapacity.toString(), // Data dari lab
                    ),
                    const SizedBox(height: 10), // Jarak antar informasi
                    InfoRow(
                      title: 'Jumlah fasilitas', // Judul informasi
                      value: lab.maxFacilities.toString(), // Data dari lab
                    ),
                    const SizedBox(height: 10), // Jarak antar informasi
                    InfoRow(
                      title: 'Status ketersediaan', // Judul informasi
                      value: lab.status == 1
                          ? 'Tersedia'
                          : 'Dipakai', // Status lab
                      valueColor: lab.status == 1
                          ? Colors.green
                          : Colors.red, // Warna status
                    ),
                  ],
                ),
              ),
              const Spacer(), // Mengisi ruang kosong
              // Tombol Konfirmasi
              Padding(
                padding:
                    const EdgeInsets.all(20.0), // Padding di sekitar tombol
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke PeminjamanForm
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PeminjamanForm(), // Mengarahkan ke PeminjamanForm
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Warna latar belakang tombol
                    minimumSize: const Size(
                        double.infinity, 50), // Ukuran minimum tombol
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Sudut melengkung tombol
                    ),
                  ),
                  child: const Text(
                    'Konfirmasi', // Teks tombol
                    style: TextStyle(
                        fontSize: 18, color: Colors.white), // Gaya teks tombol
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

// Widget untuk menampilkan baris informasi
class InfoRow extends StatelessWidget {
  final String title; // Judul informasi
  final String value; // Nilai informasi
  final Color valueColor; // Warna nilai informasi

  const InfoRow({
    super.key,
    required this.title, // Mengharuskan title untuk diisi
    required this.value, // Mengharuskan value untuk diisi
    this.valueColor = Colors.black, // Warna default untuk nilai
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Mengatur posisi judul dan nilai
      children: [
        Text(
          title, // Menampilkan judul
          style: const TextStyle(
              fontSize: 16, color: Colors.black), // Gaya teks judul
        ),
        Text(
          value, // Menampilkan nilai
          style: TextStyle(
            fontSize: 16,
            color: valueColor, // Mengatur warna nilai
          ),
        ),
      ],
    );
  }
}
