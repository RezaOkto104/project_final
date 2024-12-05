import 'package:flutter/material.dart';
import 'confirmation_screen.dart';

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
    super.dispose();
  }

  void _navigateToConfirmation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          namaLengkap: _namaLengkapController.text,
          nimNikNip: _nimNikNipController.text,
          namaDosen: _namaDosenController.text,
          tanggal: _tanggalController.text,
          jamMulai: _jamMulaiController.text,
          jamSelesai: _jamSelesaiController.text,
          jumlahPeserta: _jumlahPesertaController.text,
          selectedRuangan: _selectedRuangan,
          selectedTandaPengenal: _selectedTandaPengenal,
        ),
      ),
    );
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
                          return 'Nama lengkap tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

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
                    const SizedBox(height: 16.0),

                    // Nama Dosen
                    TextFormField(
                      controller: _namaDosenController,
                      decoration:
                          const InputDecoration(labelText: 'Nama Dosen'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama dosen tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Tanggal
                    TextFormField(
                      controller: _tanggalController,
                      decoration: const InputDecoration(labelText: 'Tanggal'),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _tanggalController.text =
                                "${pickedDate.toLocal()}".split(' ')[0];
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
                    const SizedBox(height: 16.0),

                    // Jam Mulai
                    TextFormField(
                      controller: _jamMulaiController,
                      decoration:
                          const InputDecoration(labelText: 'Jam Mulai (HH:MM)'),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jam mulai tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Jam Selesai
                    TextFormField(
                      controller: _jamSelesaiController,
                      decoration: const InputDecoration(
                          labelText: 'Jam Selesai (HH:MM)'),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jam selesai tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Jumlah Peserta
                    TextFormField(
                      controller: _jumlahPesertaController,
                      decoration:
                          const InputDecoration(labelText: 'Jumlah Peserta'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jumlah peserta tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Nama Ruangan
                    DropdownButtonFormField<String>(
                      value: _selectedRuangan,
                      decoration:
                          const InputDecoration(labelText: 'Nama Ruangan'),
                      items: _ruanganList.map((String ruangan) {
                        return DropdownMenuItem<String>(
                          value: ruangan,
                          child: Text(ruangan),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRuangan = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Nama ruangan harus dipilih';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Tanda Pengenal
                    DropdownButtonFormField<String>(
                      value: _selectedTandaPengenal,
                      decoration:
                          const InputDecoration(labelText: 'Tanda Pengenal'),
                      items: _tandaPengenalList.map((String tanda) {
                        return DropdownMenuItem<String>(
                          value: tanda,
                          child: Text(tanda),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTandaPengenal = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Tanda pengenal harus dipilih';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Nomor HP/WA
                    TextFormField(
                      controller: TextEditingController(),
                      decoration:
                          const InputDecoration(labelText: 'Nomor HP/WA Aktif'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor HP/WA tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Pernyataan Penggunaan Labor
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _agree,
                          onChanged: (bool? value) {
                            setState(() {
                              _agree = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Saya memahami dan akan bertanggung jawab atas segala konsekuensi peminjaman dan sanggup menaati standar penggunaan alat dan ruangan yang berlaku.',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Tombol Kirim
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && _agree) {
                          _navigateToConfirmation();
                        } else if (!_agree) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Anda harus menyetujui pernyataan penggunaan labor')),
                          );
                        }
                      },
                      child: const Text('KIRIM'),
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
