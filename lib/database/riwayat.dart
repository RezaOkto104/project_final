class Riwayat {
  final int? id; // ID reservasi, bisa null jika baru
  final String namaLengkap; // Nama lengkap peminjam
  final String nim; // NIM/NIK/NIP peminjam
  final String namaDosen; // Nama dosen yang mengawasi
  final String tanggal; // Tanggal peminjaman
  final String jamMulai; // Jam mulai peminjaman
  final String jamSelesai; // Jam selesai peminjaman
  final int jumlahPeserta; // Jumlah peserta yang ikut
  final String ruangan; // Nama ruangan yang dipinjam
  final String tandaPengenal; // Tanda pengenal peminjam
  final String nomorHp; // Nomor HP/WA peminjam
  final String persetujuan; // Status persetujuan peminjaman

  // Konstruktor untuk inisialisasi objek Riwayat
  Riwayat({
    this.id, // ID tidak wajib diisi
    required this.namaLengkap, // Nama lengkap wajib diisi
    required this.nim, // NIM/NIK/NIP wajib diisi
    required this.namaDosen, // Nama dosen wajib diisi
    required this.tanggal, // Tanggal peminjaman wajib diisi
    required this.jamMulai, // Jam mulai peminjaman wajib diisi
    required this.jamSelesai, // Jam selesai peminjaman wajib diisi
    required this.jumlahPeserta, // Jumlah peserta wajib diisi
    required this.ruangan, // Nama ruangan wajib diisi
    required this.tandaPengenal, // Tanda pengenal wajib diisi
    required this.nomorHp, // Nomor HP/WA wajib diisi
    this.persetujuan = 'Belum Disetujui', // Status persetujuan default
  });

  // Mengonversi data objek Riwayat ke dalam format Map untuk disimpan di SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID bisa null
      'nama_lengkap': namaLengkap, // Nama lengkap peminjam
      'nim': nim, // NIM/NIK/NIP peminjam
      'nama_dosen': namaDosen, // Nama dosen yang mengawasi
      'tanggal': tanggal, // Tanggal peminjaman
      'jam_mulai': jamMulai, // Jam mulai peminjaman
      'jam_selesai': jamSelesai, // Jam selesai peminjaman
      'jumlah_peserta': jumlahPeserta, // Jumlah peserta
      'ruangan': ruangan, // Nama ruangan yang dipinjam
      'tanda_pengenal': tandaPengenal, // Tanda pengenal peminjam
      'nomor_hp': nomorHp, // Menambahkan nomor_hp ke map
      'persetujuan': persetujuan, // Status persetujuan
    };
  }

  // Mengambil data dari Map dan mengembalikan objek Riwayat
  factory Riwayat.fromMap(Map<String, dynamic> map) {
    return Riwayat(
      id: map['id'], // ID dari map
      namaLengkap: map['nama_lengkap'], // Nama lengkap dari map
      nim: map['nim'], // NIM/NIK/NIP dari map
      namaDosen: map['nama_dosen'], // Nama dosen dari map
      tanggal: map['tanggal'], // Tanggal dari map
      jamMulai: map['jam_mulai'], // Jam mulai dari map
      jamSelesai: map['jam_selesai'], // Jam selesai dari map
      jumlahPeserta: map['jumlah_peserta'], // Jumlah peserta dari map
      ruangan: map['ruangan'], // Nama ruangan dari map
      tandaPengenal: map['tanda_pengenal'], // Tanda pengenal dari map
      nomorHp: map['nomor_hp'], // Mengambil nomor_hp dari map
      persetujuan: map['persetujuan'], // Status persetujuan dari map
    );
  }
}
