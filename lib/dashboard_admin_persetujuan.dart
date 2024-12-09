import 'package:flutter/material.dart';
import 'database/riwayat.dart';
import 'database/database_service.dart'; // Mengimpor DatabaseHelper

class DashboardAdminPersetujuan extends StatefulWidget {
  const DashboardAdminPersetujuan({super.key});

  @override
  _DashboardAdminPersetujuanState createState() =>
      _DashboardAdminPersetujuanState();
}

class _DashboardAdminPersetujuanState extends State<DashboardAdminPersetujuan> {
  List<Riwayat> riwayats = [];

  @override
  void initState() {
    super.initState();
    _loadRiwayatData();
  }

  // Fungsi untuk memuat data riwayat dari database menggunakan DatabaseHelper
  Future<void> _loadRiwayatData() async {
    List<Riwayat> data = await DatabaseHelper().getRiwayat();
    setState(() {
      riwayats = data;
    });
  }

  // Fungsi untuk memperbarui status persetujuan di database menggunakan DatabaseHelper
  Future<void> _updatePersetujuan(Riwayat riwayat, String status) async {
    Riwayat updatedRiwayat = Riwayat(
      id: riwayat.id,
      namaLengkap: riwayat.namaLengkap,
      nim: riwayat.nim,
      namaDosen: riwayat.namaDosen,
      tanggal: riwayat.tanggal,
      jamMulai: riwayat.jamMulai,
      jamSelesai: riwayat.jamSelesai,
      jumlahPeserta: riwayat.jumlahPeserta,
      ruangan: riwayat.ruangan,
      tandaPengenal: riwayat.tandaPengenal,
      nomorHp: riwayat.nomorHp,
      persetujuan: status, // Memperbarui status persetujuan
    );

    await DatabaseHelper().updateRiwayat(updatedRiwayat);
    _loadRiwayatData(); // Memuat ulang data setelah update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: riwayats.length,
          itemBuilder: (context, index) {
            final riwayat = riwayats[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(riwayat.namaLengkap),
                subtitle: Text('Status: ${riwayat.persetujuan}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tombol Centang untuk Disetujui
                    IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      onPressed: () {
                        _updatePersetujuan(riwayat, 'Disetujui');
                      },
                    ),
                    // Tombol Silang untuk Tidak Disetujui
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        _updatePersetujuan(riwayat, 'Tidak Disetujui');
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
