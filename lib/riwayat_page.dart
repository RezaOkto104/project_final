import 'package:flutter/material.dart';
import 'database/database_service.dart'; // Import DatabaseHelper
import 'database/riwayat.dart'; // Import Riwayat model
import 'confirmation_screen.dart'; // Import halaman rincian pengajuan

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Riwayat>> _riwayatFuture;
  Map<String, List<Riwayat>> _groupedRiwayat = {};

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  void _loadRiwayat() {
    _riwayatFuture = _dbHelper.getRiwayat();
    _riwayatFuture.then((riwayatList) {
      setState(() {
        // Mengelompokkan data berdasarkan tanggal
        _groupedRiwayat = _groupRiwayatByDate(riwayatList);
      });
    });
  }

  Map<String, List<Riwayat>> _groupRiwayatByDate(List<Riwayat> riwayatList) {
    final Map<String, List<Riwayat>> grouped = {};
    for (final riwayat in riwayatList) {
      if (!grouped.containsKey(riwayat.tanggal)) {
        grouped[riwayat.tanggal] = [];
      }
      grouped[riwayat.tanggal]!.add(riwayat);
    }
    return grouped;
  }

  Future<void> _deleteRiwayat(int id) async {
    await _dbHelper.deleteRiwayat(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengajuan berhasil dihapus'),
      ),
    );
    _loadRiwayat(); // Perbarui tampilan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Peminjaman'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/dashboard',
              (route) => false,
            );
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
            child: FutureBuilder<List<Riwayat>>(
              future: _riwayatFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (_groupedRiwayat.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada riwayat peminjaman.'),
                  );
                }

                return ListView.builder(
                  itemCount: _groupedRiwayat.keys.length,
                  itemBuilder: (context, index) {
                    final date = _groupedRiwayat.keys.toList()[index];
                    final riwayatList = _groupedRiwayat[date]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header untuk tanggal
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            date,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Daftar riwayat untuk tanggal tertentu
                        ...riwayatList.map((riwayat) {
                          IconData icon;
                          Color iconColor;
                          String statusText;

                          if (riwayat.persetujuan == 'Disetujui') {
                            icon = Icons.check_circle;
                            iconColor = Colors.green;
                            statusText = 'Disetujui';
                          } else if (riwayat.persetujuan == 'Tidak Disetujui') {
                            icon = Icons.cancel;
                            iconColor = Colors.red;
                            statusText = 'Tidak Disetujui';
                          } else {
                            icon = Icons.help_outline;
                            iconColor = Colors.grey;
                            statusText = 'Belum Disetujui';
                          }

                          return buildRiwayatItem(
                            waktu: riwayat.tanggal,
                            nama: riwayat.namaLengkap,
                            keterangan:
                                'Mengajukan Peminjaman\nLab - ${riwayat.ruangan}',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            icon: icon,
                            iconColor: iconColor,
                            statusText: statusText,
                            buttonText: 'Hapus Pengajuan',
                            buttonColor: Colors.red,
                            onButtonPressed: () => _deleteRiwayat(riwayat.id!),
                            rincianButtonText: 'Rincian Pengajuan',
                            rincianButtonColor: Colors.blue,
                            onRincianButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmationScreen(
                                    riwayat: riwayat,
                                    autoNavigate:
                                        false, // Set autoNavigate sesuai kebutuhan
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    );
                  },
                );
              },
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
    required String statusText,
    required String buttonText,
    required Color buttonColor,
    required VoidCallback onButtonPressed,
    required String rincianButtonText,
    required Color rincianButtonColor,
    required VoidCallback onRincianButtonPressed,
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
          Expanded(
            child: Column(
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
                const SizedBox(height: 8),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onButtonPressed,
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
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: onRincianButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: rincianButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                ),
                child: Text(
                  rincianButtonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
