import 'package:flutter/material.dart';
import 'database/database_service.dart';
import 'database/laboratory.dart';

class DashboardAdminLab extends StatefulWidget {
  const DashboardAdminLab({Key? key}) : super(key: key);

  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdminLab> {
  final _labNameController = TextEditingController();
  final _maxCapacityController = TextEditingController();
  final _maxFacilitiesController = TextEditingController();
  int _status = 0; // Default to "Not Available" status

  late Future<List<Laboratory>> _laboratoriesFuture;

  @override
  void initState() {
    super.initState();
    _refreshLaboratories();
  }

  // Refresh list of laboratories
  void _refreshLaboratories() {
    _laboratoriesFuture = DatabaseHelper().getLaboratories();
    setState(() {});
  }

  // Menambah laboratorium ke dalam database
  Future<void> _addLaboratory() async {
    final labName = _labNameController.text;
    final maxCapacity = int.tryParse(_maxCapacityController.text) ?? 0;
    final maxFacilities = int.tryParse(_maxFacilitiesController.text) ?? 0;

    if (labName.isEmpty || maxCapacity <= 0 || maxFacilities <= 0) {
      return; // Menangani kesalahan jika data kosong
    }

    final laboratory = Laboratory(
      id: 0, // ID akan dibuat otomatis di database
      labName: labName,
      maxCapacity: maxCapacity,
      maxFacilities: maxFacilities,
      status: _status,
    );

    await DatabaseHelper().insertLaboratory(laboratory);

    // Reset form
    _labNameController.clear();
    _maxCapacityController.clear();
    _maxFacilitiesController.clear();

    _refreshLaboratories(); // Refresh data
    Navigator.pop(context);
  }

  // Menghapus laboratorium
  Future<void> _deleteLaboratory(int id) async {
    await DatabaseHelper().deleteLaboratory(id);
    _refreshLaboratories(); // Refresh data setelah penghapusan
  }

  // Dialog untuk menambah laboratorium
  void _showAddLabDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Laboratorium'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _labNameController,
                  decoration:
                      const InputDecoration(labelText: 'Nama Laboratorium'),
                ),
                TextField(
                  controller: _maxCapacityController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Kapasitas Maksimal'),
                ),
                TextField(
                  controller: _maxFacilitiesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Jumlah Fasilitas Maksimal'),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Status:'),
                    Flexible(
                      child: Column(
                        children: [
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
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: _addLaboratory,
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  // Mengedit status ketersediaan
  void _editStatus(Laboratory lab) async {
    final newStatus = lab.status == 1 ? 0 : 1;
    final updatedLab = lab.copyWith(status: newStatus);
    await DatabaseHelper().updateLaboratory(updatedLab);
    _refreshLaboratories(); // Refresh data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        backgroundColor: const Color(0xFF8A4AFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Laboratory>>(
                future: _laboratoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final laboratories = snapshot.data;

                  if (laboratories == null || laboratories.isEmpty) {
                    return const Center(child: Text('Tidak ada laboratorium.'));
                  }

                  return ListView.builder(
                    itemCount: laboratories.length,
                    itemBuilder: (context, index) {
                      final lab = laboratories[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            lab.labName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kapasitas: ${lab.maxCapacity}'),
                              Text('Fasilitas Maks: ${lab.maxFacilities}'),
                              Text(
                                'Status: ${lab.status == 1 ? "Tersedia" : "Tidak Tersedia"}',
                                style: TextStyle(
                                  color: lab.status == 1
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  lab.status == 1
                                      ? Icons.toggle_on
                                      : Icons.toggle_off,
                                  color: lab.status == 1
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                onPressed: () => _editStatus(lab),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteLaboratory(lab.id),
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
            ElevatedButton(
              onPressed: _showAddLabDialog,
              child: const Text('Tambah Laboratorium'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A4AFF),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
