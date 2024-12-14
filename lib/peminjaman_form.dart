import 'package:flutter/material.dart';
import 'confirmation_screen.dart'; // Mengimpor layar konfirmasi
import 'database/database_service.dart'; // Mengimpor helper database
import 'database/riwayat.dart'; // Mengimpor model Riwayat
import 'database/laboratory.dart'; // Mengimpor model Laboratory
import 'riwayat_page.dart'; // Mengimpor halaman Riwayat

// Widget untuk formulir peminjaman laboratorium
class PeminjamanForm extends StatefulWidget {
  const PeminjamanForm({super.key});

  @override
  _PeminjamanFormState createState() => _PeminjamanFormState();
}

// State untuk PeminjamanForm
class _PeminjamanFormState extends State<PeminjamanForm> {
  final _formKey = GlobalKey<FormState>(); // Kunci untuk formulir
  final _namaLengkapController =
      TextEditingController(); // Kontrol untuk nama lengkap
  final _nimNikNipController =
      TextEditingController(); // Kontrol untuk NIM/NIK/NIP
  final _namaDosenController =
      TextEditingController(); // Kontrol untuk nama dosen
  final _tanggalController = TextEditingController(); // Kontrol untuk tanggal
  final _jamMulaiController =
      TextEditingController(); // Kontrol untuk jam mulai
  final _jamSelesaiController =
      TextEditingController(); // Kontrol untuk jam selesai
  final _jumlahPesertaController =
      TextEditingController(); // Kontrol untuk jumlah peserta
  final _nomorHpController =
      TextEditingController(); // Kontrol untuk nomor HP/WA
  String? _selectedRuangan; // Ruangan yang dipilih
  String? _selectedTandaPengenal; // Tanda pengenal yang dipilih
  bool _agree = false; // Status persetujuan

  List<String> _ruanganList = []; // Daftar ruangan
  final List<String> _tandaPengenalList = [
    'KTM',
    'KTP',
    'SIM',
  ]; // Daftar tanda pengenal

  @override
  void initState() {
    super.initState();
    _fetchRuanganList(); // Mengambil daftar ruangan saat widget diinisialisasi
  }

  // Fungsi untuk mengambil daftar ruangan dari database
  Future<void> _fetchRuanganList() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    List<Laboratory> laboratories =
        await dbHelper.getLaboratories(); // Mengambil laboratorium
    setState(() {
      _ruanganList = laboratories
          .map((lab) => lab.labName)
          .toList(); // Mengisi daftar ruangan
    });
  }

  @override
  void dispose() {
    // Menghapus kontrol saat widget dibuang
    _namaLengkapController.dispose();
    _nimNikNipController.dispose();
    _namaDosenController.dispose();
    _tanggalController.dispose();
    _jamMulaiController.dispose();
    _jamSelesaiController.dispose();
    _jumlahPesertaController.dispose();
    _nomorHpController.dispose(); // Menghapus kontrol untuk nomor HP/WA
    super.dispose();
  }

  // Fungsi untuk menavigasi ke layar konfirmasi
  void _navigateToConfirmation() {
    if (_formKey.currentState!.validate()) {
      // Memeriksa validitas formulir
      // Membuat objek Riwayat
      Riwayat riwayat = Riwayat(
        id: null, // ID akan diatur oleh database
        namaLengkap: _namaLengkapController.text,
        nim: _nimNikNipController.text,
        namaDosen: _namaDosenController.text,
        tanggal: _tanggalController.text,
        jamMulai: _jamMulaiController.text,
        jamSelesai: _jamSelesaiController.text,
        jumlahPeserta: int.parse(_jumlahPesertaController.text),
        ruangan: _selectedRuangan!,
        tandaPengenal: _selectedTandaPengenal!,
        nomorHp: _nomorHpController.text, // Menyimpan nomor HP/WA
        persetujuan: 'Belum Disetujui', // Default ke 'Belum Disetujui'
      );

      // Navigasi ke halaman konfirmasi dengan objek Riwayat
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            riwayat: riwayat,
            autoNavigate: true, // Set autoNavigate jika ingin otomatis
          ),
        ),
      );
    }
  }

  // Widget untuk membuat TextFormField dengan validasi
  Widget formText(dynamic _cont, String label) {
    return TextFormField(
      controller: _cont,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Peminjaman Laboratorium'), // Judul aplikasi
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.lightBlue
            ], // Gradient latar belakang
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Warna latar belakang formulir
              borderRadius: BorderRadius.circular(10.0), // Sudut melengkung
            ),
            child: Form(
              key: _formKey, // Kunci formulir
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Input untuk Nama Lengkap
                    formText(_namaLengkapController, "Nama Lengkap"),
                    // Input untuk NIM/NIK/NIP
                    formText(_nimNikNipController, "NIM/NIK/NIP"),
                    // Input untuk Nama Dosen
                    formText(_namaDosenController, "Nama Dosen"),
                    // Input untuk Tanggal
                    TextFormField(
                      controller: _tanggalController,
                      decoration: const InputDecoration(labelText: 'Tanggal'),
                      readOnly: true, // Membuat field ini read-only
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _tanggalController.text = "${pickedDate.toLocal()}"
                                .split(' ')[0]; // Format tanggal
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    // Input untuk Jam Mulai
                    formText(_jamMulaiController, "Jam Mulai"),
                    // Input untuk Jam Selesai
                    formText(_jamSelesaiController, "Jam Selesai"),
                    // Input untuk Jumlah Peserta
                    TextFormField(
                      controller: _jumlahPesertaController,
                      decoration:
                          const InputDecoration(labelText: 'Jumlah Peserta'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jumlah Peserta tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    // Dropdown untuk Ruangan
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Nama Ruangan'),
                      value: _selectedRuangan,
                      items: _ruanganList.map((String ruangan) {
                        return DropdownMenuItem<String>(
                          value: ruangan,
                          child: Text(ruangan),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRuangan = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Silakan pilih ruangan';
                        }
                        return null;
                      },
                    ),
                    // Dropdown untuk Tanda Pengenal
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Tanda Pengenal'),
                      value: _selectedTandaPengenal,
                      items: _tandaPengenalList.map((String tandaPengenal) {
                        return DropdownMenuItem<String>(
                          value: tandaPengenal,
                          child: Text(tandaPengenal),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTandaPengenal = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Silakan pilih tanda pengenal';
                        }
                        return null;
                      },
                    ),
                    // Input untuk Nomor HP/WA
                    formText(_nomorHpController, "Nomor HP/WA"),
                    // Checkbox untuk persetujuan
                    Row(
                      children: [
                        Checkbox(
                          value: _agree,
                          onChanged: (value) {
                            setState(() {
                              _agree = value!;
                            });
                          },
                        ),
                        const Text('Saya setuju dengan syarat dan ketentuan'),
                      ],
                    ),
                    // Tombol Kirim
                    ElevatedButton(
                      onPressed: _agree ? _navigateToConfirmation : null,
                      child: const Text('Kirim'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
