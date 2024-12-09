import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_final/database/riwayat.dart';

class ApiService {
  final String baseUrl =
      'http://localhost/api.php'; // Ganti dengan URL server Anda

  // Menambahkan reservasi baru
  Future<void> addReservation(Riwayat riwayat) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama_lengkap': riwayat.namaLengkap,
        'nim': riwayat.nim,
        'nama_dosen': riwayat.namaDosen,
        'tanggal': riwayat.tanggal,
        'jam_mulai': riwayat.jamMulai,
        'jam_selesai': riwayat.jamSelesai,
        'jumlah_peserta': riwayat.jumlahPeserta,
        'ruangan': riwayat.ruangan,
        'tanda_pengenal': riwayat.tandaPengenal,
      }),
    );

    if (response.statusCode != 200) {
      print('Response body: ${response.body}');
      throw Exception('Failed to add reservation: ${response.body}');
    }
  }

  // Mendapatkan semua reservasi
  Future<List<Riwayat>> fetchReservations() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Riwayat.fromMap(item)).toList();
    } else {
      throw Exception('Failed to load reservations');
    }
  }

  // Memperbarui reservasi
  Future<void> updateReservation(Riwayat riwayat) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': riwayat.id,
        'nama_lengkap': riwayat.namaLengkap,
        'nim': riwayat.nim,
        'nama_dosen': riwayat.namaDosen,
        'tanggal': riwayat.tanggal,
        'jam_mulai': riwayat.jamMulai,
        'jam_selesai': riwayat.jamSelesai,
        'jumlah_peserta': riwayat.jumlahPeserta,
        'ruangan': riwayat.ruangan,
        'tanda_pengenal': riwayat.tandaPengenal,
      }),
    );

    if (response.statusCode != 200) {
      print('Response body: ${response.body}');
      throw Exception('Failed to update reservation: ${response.body}');
    }
  }

  // Menghapus reservasi
  Future<void> deleteReservation(int id) async {
    final response = await http.delete(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );

    if (response.statusCode != 200) {
      print('Response body: ${response.body}');
      throw Exception('Failed to delete reservation: ${response.body}');
    }
  }
}
