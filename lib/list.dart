import 'package:flutter/material.dart';
import 'keterangan_lab.dart'; // Pastikan ini adalah file yang benar

class LabListScreen extends StatefulWidget {
  const LabListScreen({super.key});

  @override
  _LabListScreenState createState() => _LabListScreenState();
}

class _LabListScreenState extends State<LabListScreen> {
  List<LabItemData> labs = [
    LabItemData(
        labId: 'lab_1',
        name: 'LAB ICT 1',
        status: 'Tersedia',
        isAvailable: true),
    LabItemData(
        labId: 'lab_2',
        name: 'LAB ICT 2',
        status: 'Dipakai',
        isAvailable: false),
    LabItemData(
        labId: 'lab_3',
        name: 'LAB KOMPUTASI SAINS',
        status: 'Dipakai',
        isAvailable: false),
    LabItemData(
        labId: 'lab_4',
        name: 'LAB KOMPUTASI TEKNIK',
        status: 'Tersedia',
        isAvailable: true),
  ];

  List<LabItemData> filteredLabs = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredLabs = labs; // Awalnya, semua lab ditampilkan
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredLabs = labs
          .where((lab) => lab.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Lab'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'LAB - LAB FST',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SearchBar(
              onChanged: updateSearchQuery,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: filteredLabs.map((lab) {
                  return LabItem(
                    name: lab.name,
                    status: lab.status,
                    isAvailable: lab.isAvailable,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: onChanged, // Memanggil fungsi ketika teks berubah
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}

class LabItemData {
  final String labId;
  final String name;
  final String status;
  final bool isAvailable;

  LabItemData({
    required this.labId,
    required this.name,
    required this.status,
    required this.isAvailable,
  });
}

class LabItem extends StatefulWidget {
  final String name;
  final String status;
  final bool isAvailable;

  const LabItem({
    super.key,
    required this.name,
    required this.status,
    required this.isAvailable,
  });

  @override
  _LabItemState createState() => _LabItemState();
}

class _LabItemState extends State<LabItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          // Navigasi ke halaman keterangan lab
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LabInfoScreen(
                labName: widget.name,
                status: widget.status,
                isAvailable: widget.isAvailable,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color.fromARGB(255, 212, 245, 255)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? const Color.fromARGB(255, 138, 138, 138).withOpacity(0.2)
                    : Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.status,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.isAvailable ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
