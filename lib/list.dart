import 'package:flutter/material.dart';
import 'database/database_service.dart'; // Mengimpor layanan database
import 'keterangan_lab.dart'; // Mengimpor layar informasi lab
import 'database/laboratory.dart'; // Mengimpor model Laboratory

// Widget untuk menampilkan daftar laboratorium
class LabListScreen extends StatefulWidget {
  const LabListScreen({super.key});

  @override
  State<LabListScreen> createState() => _LabListScreenState();
}

// State untuk LabListScreen
class _LabListScreenState extends State<LabListScreen> {
  List<Laboratory> _allLabs = []; // Menyimpan semua laboratorium
  List<Laboratory> _filteredLabs = []; // Menyimpan laboratorium yang difilter
  final TextEditingController _searchController =
      TextEditingController(); // Kontrol untuk pencarian

  @override
  void initState() {
    super.initState();
    _fetchLabs(); // Memanggil fungsi untuk mengambil data laboratorium
    _searchController
        .addListener(_filterLabs); // Menambahkan listener untuk pencarian
  }

  @override
  void dispose() {
    _searchController
        .dispose(); // Menghapus kontrol pencarian saat widget dibuang
    super.dispose();
  }

  // Fungsi untuk mengambil data laboratorium dari database
  Future<void> _fetchLabs() async {
    final labs =
        await DatabaseHelper().getLaboratories(); // Mengambil data laboratorium
    setState(() {
      _allLabs = labs; // Menyimpan semua laboratorium
      _filteredLabs = labs; // Menyimpan laboratorium yang difilter
    });
  }

  // Fungsi untuk memfilter laboratorium berdasarkan input pencarian
  void _filterLabs() {
    final query =
        _searchController.text.toLowerCase(); // Mengambil teks pencarian
    setState(() {
      _filteredLabs = _allLabs.where((lab) {
        return lab.labName
            .toLowerCase()
            .contains(query); // Memfilter laboratorium berdasarkan nama
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Laboratorium'), // Judul AppBar
        backgroundColor: Colors.blueAccent, // Warna latar belakang AppBar
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Kolom untuk input pencarian
            Padding(
              padding:
                  const EdgeInsets.all(8.0), // Padding di sekitar TextField
              child: TextField(
                controller:
                    _searchController, // Menghubungkan kontrol pencarian
                decoration: InputDecoration(
                  labelText: 'Cari Lab', // Label untuk TextField
                  prefixIcon: const Icon(Icons.search), // Ikon pencarian
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Sudut melengkung untuk border
                  ),
                ),
              ),
            ),
            Expanded(
              child: _filteredLabs
                      .isEmpty // Memeriksa apakah ada laboratorium yang difilter
                  ? const Center(
                      child: Text(
                          'Tidak ada laboratorium yang ditemukan'), // Pesan jika tidak ada laboratorium
                    )
                  : ListView.builder(
                      itemCount: _filteredLabs
                          .length, // Jumlah laboratorium yang difilter
                      itemBuilder: (context, index) {
                        final lab = _filteredLabs[
                            index]; // Mengambil laboratorium berdasarkan index
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5), // Margin untuk Card
                          child: ListTile(
                            title: Text(
                                lab.labName), // Menampilkan nama laboratorium
                            subtitle: Text(
                              lab.status == 1
                                  ? 'Tersedia'
                                  : 'Dipakai', // Menampilkan status laboratorium
                              style: TextStyle(
                                color: lab.status == 1
                                    ? Colors.green
                                    : Colors.red, // Warna status
                              ),
                            ),
                            onTap: () {
                              // Navigasi ke layar informasi lab saat laboratorium ditekan
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LabInfoScreen(
                                      lab: lab), // Mengarahkan ke LabInfoScreen
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
