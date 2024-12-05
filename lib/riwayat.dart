import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Peminjaman'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Ganti dengan logika untuk kembali ke dashboard
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (route) => false);
          },
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB2D0FF),
              Color(0xFFDEE9FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hari ini',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                buildRiwayatItem(
                  waktu: '6.40',
                  nama: 'Ammar As\'ad (NIM)',
                  keterangan: 'Mengajukan Peminjaman\nLab - Komputasi Sains',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  isButtonDisabled: true,
                ),
                const SizedBox(height: 8),
                buildRiwayatItem(
                  waktu: '7.00',
                  nama: 'Reza Okto (NIM)',
                  keterangan: 'Mengajukan Peminjaman\nLab - Komputasi Teknik',
                  backgroundColor: const Color(0xFFFFE5E5),
                  textColor: Colors.red,
                  icon: Icons.remove_circle,
                  iconColor: Colors.red,
                  buttonText: 'Hapus Pengajuan',
                  buttonColor: Colors.blue,
                  onButtonPressed: () {
                    // Tambahkan aksi untuk hapus pengajuan
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengajuan berhasil dihapus'),
                      ),
                    );
                  },
                ),
                const Spacer(), // Menambahkan Spacer untuk memisahkan konten dan tombol
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke dashboard
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'dashboard.dart', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                  ),
                  child: const Text(
                    'Kembali ke Dashboard',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRiwayatItem({
    required String waktu,
    required String nama,
    required String keterangan,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
    required Color iconColor,
    String? buttonText,
    Color? buttonColor,
    bool isButtonDisabled = false,
    VoidCallback? onButtonPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                waktu,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                nama,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                keterangan,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
              if (buttonText != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isButtonDisabled ? null : onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
