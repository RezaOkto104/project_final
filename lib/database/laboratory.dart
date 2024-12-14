class Laboratory {
  final int? id; // ID laboratorium, nullable
  final String labName; // Nama laboratorium
  final int maxCapacity; // Kapasitas maksimum laboratorium
  final int status; // Status laboratorium (misalnya, aktif atau tidak)
  final int maxFacilities; // Jumlah fasilitas maksimum yang tersedia

  // Konstruktor untuk inisialisasi objek Laboratory
  Laboratory({
    this.id, // ID tidak lagi wajib
    required this.labName, // Nama laboratorium wajib diisi
    required this.maxCapacity, // Kapasitas maksimum wajib diisi
    required this.status, // Status wajib diisi
    required this.maxFacilities, // Fasilitas maksimum wajib diisi
  });

  // Mengonversi data objek Laboratory ke dalam format Map untuk disimpan di SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID bisa null
      'lab_name': labName, // Nama laboratorium
      'max_capacity': maxCapacity, // Kapasitas maksimum
      'status': status, // Status laboratorium
      'max_facilities': maxFacilities, // Fasilitas maksimum
    };
  }

  // Mengambil data dari Map dan mengembalikan objek Laboratory
  factory Laboratory.fromMap(Map<String, dynamic> map) {
    return Laboratory(
      id: map['id'], // ID tetap bisa diambil, meskipun null
      labName: map['lab_name'], // Nama laboratorium
      maxCapacity: map['max_capacity'], // Kapasitas maksimum
      status: map['status'], // Status laboratorium
      maxFacilities: map['max_facilities'], // Fasilitas maksimum
    );
  }

  // Metode untuk membuat salinan objek Laboratory dengan beberapa properti yang bisa diubah
  Laboratory copyWith({
    int? id, // ID baru (jika ingin diubah)
    String? labName, // Nama laboratorium baru (jika ingin diubah)
    int? maxCapacity, // Kapasitas maksimum baru (jika ingin diubah)
    int? status, // Status baru (jika ingin diubah)
    int? maxFacilities, // Fasilitas maksimum baru (jika ingin diubah)
  }) {
    return Laboratory(
      id: id ??
          this.id, // Gunakan ID baru jika ada, jika tidak gunakan yang lama
      labName: labName ??
          this.labName, // Gunakan nama baru jika ada, jika tidak gunakan yang lama
      maxCapacity: maxCapacity ??
          this.maxCapacity, // Gunakan kapasitas baru jika ada, jika tidak gunakan yang lama
      status: status ??
          this.status, // Gunakan status baru jika ada, jika tidak gunakan yang lama
      maxFacilities: maxFacilities ??
          this.maxFacilities, // Gunakan fasilitas baru jika ada, jika tidak gunakan yang lama
    );
  }
}
