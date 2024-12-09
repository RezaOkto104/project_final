import 'package:flutter/material.dart';
import 'dart:async'; // Import untuk Timer
import 'database/database_service.dart'; // Import database helper
import 'database/riwayat.dart'; // Import model Riwayat
import 'riwayat_page.dart'; // Import halaman Riwayat

class ConfirmationScreen extends StatefulWidget {
  final Riwayat riwayat; // Menerima objek Riwayat
  final bool autoNavigate; // Tambahkan parameter untuk mode navigasi otomatis

  const ConfirmationScreen({
    Key? key,
    required this.riwayat,
    this.autoNavigate = false, // Default tidak otomatis
  }) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int _countdown = 5; // Countdown hanya jika navigasi otomatis
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (widget.autoNavigate) {
      _saveToDatabase(); // Simpan data ke database jika dari form
      _startCountdown(); // Mulai countdown untuk navigasi otomatis
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RiwayatPage()),
        );
      }
    });
  }

  Future<void> _saveToDatabase() async {
    final DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper
        .insertRiwayat(widget.riwayat); // Simpan objek Riwayat ke database
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hentikan timer jika widget dibuang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Peminjaman'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const RiwayatPage()),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Data Peminjaman Anda:',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              _buildDataRow('Nama Lengkap:', widget.riwayat.namaLengkap),
              _buildDataRow('NIM/NIK/NIP:', widget.riwayat.nim),
              _buildDataRow('Nama Dosen:', widget.riwayat.namaDosen),
              _buildDataRow('Tanggal:', widget.riwayat.tanggal),
              _buildDataRow('Jam Mulai:', widget.riwayat.jamMulai),
              _buildDataRow('Jam Selesai:', widget.riwayat.jamSelesai),
              _buildDataRow(
                  'Jumlah Peserta:', widget.riwayat.jumlahPeserta.toString()),
              _buildDataRow('Nama Ruangan:', widget.riwayat.ruangan),
              _buildDataRow('Tanda Pengenal:', widget.riwayat.tandaPengenal),
              const SizedBox(height: 20.0),
              const Text(
                'Terima kasih telah mengisi formulir peminjaman.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              if (widget
                  .autoNavigate) // Hanya tampilkan countdown jika otomatis
                Text(
                  'Anda akan diarahkan ke halaman riwayat dalam $_countdown det ik.',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
