import 'package:flutter/material.dart';
import 'confirmation_screen.dart'; // Import ConfirmationScreen
import 'database/database_service.dart'; // Import database helper
import 'database/riwayat.dart'; // Import model Riwayat
import 'riwayat_page.dart'; // Import halaman Riwayat

class PeminjamanForm extends StatefulWidget {
  const PeminjamanForm({super.key});

  @override
  _PeminjamanFormState createState() => _PeminjamanFormState();
}

class _PeminjamanFormState extends State<PeminjamanForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaLengkapController = TextEditingController();
  final _nimNikNipController = TextEditingController();
  final _namaDosenController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _jamMulaiController = TextEditingController();
  final _jamSelesaiController = TextEditingController();
  final _jumlahPesertaController = TextEditingController();
  final _nomorHpController =
      TextEditingController(); // Controller untuk Nomor HP/WA
  String? _selectedRuangan;
  String? _selectedTandaPengenal;
  bool _agree = false;

  final List<String> _ruanganList = [
    'Lab ICT 1',
    'Lab ICT 2',
    'Lab Komputasi Sains',
    'Lab Komputasi Teknik',
  ];

  final List<String> _tandaPengenalList = [
    'KTM',
    'KTP',
    'SIM',
  ];

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _nimNikNipController.dispose();
    _namaDosenController.dispose();
    _tanggalController.dispose();
    _jamMulaiController.dispose();
    _jamSelesaiController.dispose();
    _jumlahPesertaController.dispose();
    _nomorHpController.dispose(); // Dispose untuk Nomor HP/WA
    super.dispose();
  }

  void _navigateToConfirmation() {
    if (_formKey.currentState!.validate()) {
      // Buat objek Riwayat
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
        nomorHp: _nomorHpController.text, // Menyimpan Nomor HP/WA
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Peminjaman Laboratorium'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Nama Lengkap
                    TextFormField(
                      controller: _namaLengkapController,
                      decoration:
                          const InputDecoration(labelText: 'Nama Lengkap'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Lengkap tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    // NIM/NIK/NIP
                    TextFormField(
                      controller: _nimNikNipController,
                      decoration:
                          const InputDecoration(labelText: 'NIM/NIK/NIP'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NIM/NIK/NIP tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    // Nama Dosen
                    TextFormField(
                      controller: _namaDosenController,
                      decoration:
                          const InputDecoration(labelText: 'Nama Dosen'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama Dosen tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    // Tanggal
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
                    // Jam Mulai
                    TextFormField(
                      controller: _jamMulaiController,
                      decoration: const InputDecoration(labelText: 'Jam Mulai'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jam Mulai tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    // Jam Selesai
                    TextFormField(
                      controller: _jamSelesaiController,
                      decoration:
                          const InputDecoration(labelText: 'Jam Selesai'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jam Selesai tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    // Jumlah Peserta
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
                    // Ruangan
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
                    // Tanda Pengenal
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
                    // Nomor HP/WA
                    TextFormField(
                      controller: _nomorHpController,
                      decoration:
                          const InputDecoration(labelText: 'Nomor HP/WA'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor HP/WA tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    // Persetujuan
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
