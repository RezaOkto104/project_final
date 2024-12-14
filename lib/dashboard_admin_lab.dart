import 'package:flutter/material.dart'; // Mengimpor paket Flutter untuk antarmuka pengguna
import 'database/database_service.dart'; // Mengimpor layanan database
import 'database/laboratory.dart'; // Mengimpor model Laboratory

// Widget utama untuk dashboard admin laboratorium
class DashboardAdminLab extends StatefulWidget {
  const DashboardAdminLab({Key? key})
      : super(key: key); // Konstruktor untuk widget

  @override
  _DashboardAdminState createState() =>
      _DashboardAdminState(); // Membuat state untuk widget
}

// State untuk DashboardAdminLab
class _DashboardAdminState extends State<DashboardAdminLab> {
  // Controller untuk input teks
  final _labNameController =
      TextEditingController(); // Controller untuk nama laboratorium
  final _maxCapacityController =
      TextEditingController(); // Controller untuk kapasitas maksimal
  final _maxFacilitiesController =
      TextEditingController(); // Controller untuk jumlah fasilitas maksimal
  int _status = 0; // Status default "Tidak Tersedia"

  late Future<List<Laboratory>>
      _laboratoriesFuture; // Future untuk daftar laboratorium

  @override
  void initState() {
    super.initState(); // Memanggil inisialisasi dari superclass
    _refreshLaboratories(); // Memuat ulang daftar laboratorium saat inisialisasi
  }

  // Fungsi untuk memuat ulang daftar laboratorium
  void _refreshLaboratories() {
    _laboratoriesFuture = DatabaseHelper()
        .getLaboratories(); // Mengambil data laboratorium dari database
    setState(() {}); // Memperbarui tampilan
  }

  // Fungsi untuk menambah laboratorium ke dalam database
  Future<void> _addLaboratory() async {
    final labName =
        _labNameController.text; // Mengambil nama laboratorium dari input
    final maxCapacity = int.tryParse(_maxCapacityController.text) ??
        0; // Mengambil kapasitas maksimal
    final maxFacilities = int.tryParse(_maxFacilitiesController.text) ??
        0; // Mengambil jumlah fasilitas maksimal

    // Validasi input
    if (labName.isEmpty || maxCapacity <= 0 || maxFacilities <= 0) {
      return; // Menghentikan eksekusi jika input tidak valid
    }

    // Membuat objek Laboratory baru
    final laboratory = Laboratory(
      id: null, // ID akan dibuat otomatis di database
      labName: labName,
      maxCapacity: maxCapacity,
      maxFacilities: maxFacilities,
      status: _status,
    );

    await DatabaseHelper()
        .insertLaboratory(laboratory); // Menyimpan laboratorium ke database

    // Reset form input
    _labNameController.clear();
    _maxCapacityController.clear();
    _maxFacilitiesController.clear();

    _refreshLaboratories(); // Memperbarui daftar laboratorium
    Navigator.pop(context); // Menutup dialog
  }

  // Fungsi untuk menghapus laboratorium
  Future<void> _deleteLaboratory(int id) async {
    await DatabaseHelper()
        .deleteLaboratory(id); // Menghapus laboratorium dari database
    _refreshLaboratories(); // Memperbarui daftar laboratorium setelah penghapusan
  }

  // Fungsi untuk menampilkan dialog tambah laboratorium
  void _showAddLabDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Laboratorium'), // Judul dialog
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Input untuk nama laboratorium
                TextField(
                  controller: _labNameController,
                  decoration:
                      const InputDecoration(labelText: 'Nama Laboratorium'),
                ),
                // Input untuk kapasitas maksimal
                TextField(
                  controller: _maxCapacityController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Kapasitas Maksimal'),
                ),
                // Input untuk jumlah fasilitas maksimal
                TextField(
                  controller: _maxFacilitiesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Jumlah Fasilitas Maksimal'),
                ),
                // Pilihan status laboratorium
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Status:'),
                    Flexible(
                      child: Column(
                        children: [
                          // Radio button untuk status "Tersedia"
                          RadioListTile<int>(
                            title: const Text('Tersedia'),
                            value: 1,
                            groupValue: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value!;
                              });
                            },
                          ),
                          // Radio button untuk status "Tidak Tersedia"
                          RadioListTile<int>(
                            title: const Text('Tidak Tersedia'),
                            value: 0,
                            groupValue: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            // Tombol untuk membatalkan dialog
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            // Tombol untuk menambah laboratorium
            ElevatedButton(
              onPressed: _addLaboratory,
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengedit status ketersediaan laboratorium
  void _editStatus(Laboratory lab) async {
    final newStatus =
        lab.status == 1 ? 0 : 1; // Mengubah status menjadi sebaliknya
    final updatedLab = lab.copyWith(
        status: newStatus); // Membuat salinan laboratorium dengan status baru
    await DatabaseHelper()
        .updateLaboratory(updatedLab); // Memperbarui laboratorium di database
    _refreshLaboratories(); // Memperbarui daftar laboratorium
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'), // Judul aplikasi
        backgroundColor: const Color(0xFF8A4AFF), // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding di sekitar konten
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Laboratory>>(
                future: _laboratoriesFuture, // Mengambil data laboratorium
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Menampilkan loading saat menunggu data
                  }

                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Error: ${snapshot.error}')); // Menampilkan pesan error jika ada
                  }

                  final laboratories =
                      snapshot.data; // Data laboratorium yang diambil

                  if (laboratories == null || laboratories.isEmpty) {
                    return const Center(
                        child: Text(
                            'Tidak ada laboratorium.')); // Menampilkan pesan jika tidak ada laboratorium
                  }

                  return ListView.builder(
                    itemCount: laboratories.length, // Jumlah laboratorium
                    itemBuilder: (context, index) {
                      final lab = laboratories[
                          index]; // Mengambil laboratorium berdasarkan index
                      return Card(
                        elevation: 4, // Elevasi untuk efek bayangan
                        margin: const EdgeInsets.symmetric(
                            vertical: 8), // Margin antara card
                        child: ListTile(
                          title: Text(
                            lab.labName,
                            style: const TextStyle(
                                fontWeight: FontWeight
                                    .bold), // Menebalkan nama laboratorium
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Kapasitas: ${lab.maxCapacity}'), // Menampilkan kapasitas laboratorium
                              Text(
                                  'Fasilitas Maks: ${lab.maxFacilities}'), // Menampilkan jumlah fasilitas
                              Text(
                                'Status: ${lab.status == 1 ? "Tersedia" : "Tidak Tersedia"}', // Menampilkan status laboratorium
                                style: TextStyle(
                                  color: lab.status == 1
                                      ? Colors
                                          .green // Warna hijau jika tersedia
                                      : Colors
                                          .red, // Warna merah jika tidak tersedia
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Tombol untuk mengedit status laboratorium
                              IconButton(
                                icon: Icon(
                                  lab.status == 1
                                      ? Icons
                                          .toggle_on // Ikon untuk status tersedia
                                      : Icons
                                          .toggle_off, // Ikon untuk status tidak tersedia
                                  color: lab.status == 1
                                      ? Colors
                                          .green // Warna hijau jika tersedia
                                      : Colors
                                          .grey, // Warna abu-abu jika tidak tersedia
                                ),
                                onPressed: () => _editStatus(
                                    lab), // Memanggil fungsi untuk mengedit status
                              ),
                              // Tombol untuk menghapus laboratorium
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red), // Ikon hapus
                                onPressed: () {
                                  if (lab.id != null) {
                                    _deleteLaboratory(lab
                                        .id!); // Menghapus laboratorium jika ID tidak null
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Tombol untuk menambah laboratorium
            ElevatedButton(
              onPressed:
                  _showAddLabDialog, // Memanggil dialog untuk menambah laboratorium
              child: const Text('Tambah Laboratorium'), // Teks tombol
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF8A4AFF), // Warna latar belakang tombol
                minimumSize:
                    const Size(double.infinity, 50), // Ukuran minimum tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
