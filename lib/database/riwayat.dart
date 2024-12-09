class Riwayat {
  final int? id; // ID reservasi, bisa null jika baru
  final String namaLengkap; // Nama lengkap peminjam
  final String nim; // NIM/NIK/NIP peminjam
  final String namaDosen; // Nama dosen yang mengawasi
  final String tanggal; // Tanggal peminjaman
  final String jamMulai; // Jam mulai peminjaman
  final String jamSelesai; // Jam selesai peminjaman
  final int jumlahPeserta;
  final String ruangan; // Nama ruangan yang dipinjam
  final String tandaPengenal; // Tanda pengenal peminjam
  final String nomorHp; // Nomor HP/WA peminjam
  final String persetujuan; // Status persetujuan peminjaman

  Riwayat({
    this.id,
    required this.namaLengkap,
    required this.nim,
    required this.namaDosen,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.jumlahPeserta,
    required this.ruangan,
    required this.tandaPengenal,
    required this.nomorHp,
    this.persetujuan = 'Belum Disetujui',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_lengkap': namaLengkap,
      'nim': nim,
      'nama_dosen': namaDosen,
      'tanggal': tanggal,
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
      'jumlah_peserta': jumlahPeserta,
      'ruangan': ruangan,
      'tanda_pengenal': tandaPengenal,
      'nomor_hp': nomorHp, // Menambahkan nomor_hp ke map
      'persetujuan': persetujuan,
    };
  }

  factory Riwayat.fromMap(Map<String, dynamic> map) {
    return Riwayat(
      id: map['id'],
      namaLengkap: map['nama_lengkap'],
      nim: map['nim'],
      namaDosen: map['nama_dosen'],
      tanggal: map['tanggal'],
      jamMulai: map['jam_mulai'],
      jamSelesai: map['jam_selesai'],
      jumlahPeserta: map['jumlah_peserta'],
      ruangan: map['ruangan'],
      tandaPengenal: map['tanda_pengenal'],
      nomorHp: map['nomor_hp'], // Mengambil nomor_hp dari map
      persetujuan: map['persetujuan'],
    );
  }
}
