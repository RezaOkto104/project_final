class Laboratory {
  final int id; // ID tidak boleh null
  final String labName;
  final int maxCapacity;
  final int status;
  final int maxFacilities; // Kolom baru

  Laboratory({
    required this.id,
    required this.labName,
    required this.maxCapacity,
    required this.status,
    required this.maxFacilities, // Tambahkan parameter
  });

  // Menyimpan data ke dalam map untuk SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID harus diberikan saat menampilkan data
      'lab_name': labName,
      'max_capacity': maxCapacity,
      'status': status,
      'max_facilities': maxFacilities, // Tambahkan ke map
    };
  }

  // Mengambil data dari map dan mengembalikan objek Laboratory
  factory Laboratory.fromMap(Map<String, dynamic> map) {
    return Laboratory(
      id: map['id'],
      labName: map['lab_name'],
      maxCapacity: map['max_capacity'],
      status: map['status'],
      maxFacilities: map['max_facilities'], // Ambil dari map
    );
  }

  // Menambahkan metode copyWith
  Laboratory copyWith({
    int? id,
    String? labName,
    int? maxCapacity,
    int? status,
    int? maxFacilities,
  }) {
    return Laboratory(
      id: id ?? this.id,
      labName: labName ?? this.labName,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      status: status ?? this.status,
      maxFacilities: maxFacilities ?? this.maxFacilities,
    );
  }
}
