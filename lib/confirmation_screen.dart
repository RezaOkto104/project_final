import 'package:flutter/material.dart';
import 'dart:async'; // Import untuk Timer
import 'riwayat.dart'; // Pastikan ini adalah file yang benar

class ConfirmationScreen extends StatefulWidget {
  final String namaLengkap;
  final String nimNikNip;
  final String namaDosen;
  final String tanggal;
  final String jamMulai;
  final String jamSelesai;
  final String jumlahPeserta;
  final String? selectedRuangan;
  final String? selectedTandaPengenal;

  const ConfirmationScreen({
    super.key,
    required this.namaLengkap,
    required this.nimNikNip,
    required this.namaDosen,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPeserta,
    required this.selectedRuangan,
    required this.selectedTandaPengenal,
  });

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int _countdown = 7; // Waktu countdown mulai dari 7 detik
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Mulai countdown
    _startCountdown();
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

  @override
  void dispose() {
    _timer?.cancel(); // Hentikan timer saat widget dibuang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Peminjaman'),
        backgroundColor: Colors.blueAccent,
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
              _buildDataRow('Nama Lengkap:', widget.namaLengkap),
              _buildDataRow('NIM/NIK/NIP:', widget.nimNikNip),
              _buildDataRow('Nama Dosen:', widget.namaDosen),
              _buildDataRow('Tanggal:', widget.tanggal),
              _buildDataRow('Jam Mulai:', widget.jamMulai),
              _buildDataRow('Jam Selesai:', widget.jamSelesai),
              _buildDataRow('Jumlah Peserta:', widget.jumlahPeserta),
              _buildDataRow(
                  'Nama Ruangan:', widget.selectedRuangan ?? 'Belum dipilih'),
              _buildDataRow('Tanda Pengenal:',
                  widget.selectedTandaPengenal ?? 'Belum dipilih'),
              const SizedBox(height: 20.0),
              const Text(
                'Terima kasih telah mengisi formulir peminjaman.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Anda akan diarahkan ke halaman riwayat dalam $_countdown detik.',
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
