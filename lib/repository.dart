import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_drive/models/users.dart';

import 'models/user.dart';

class Repository {
  final String _baseUrl = 'https://reqres.in/api/users';

  Future getUsersData() async {
    final res = await http.get(Uri.parse(_baseUrl));

    if (res.statusCode == 200) {
      final users = Users.fromJson(jsonDecode(res.body));
      return users.data.map((e) => e).toList();
    } else {
      throw Exception('Gagal ambil daftar pengguna');
    }
  }

  Future getUser(int userId) async {
    final res = await http.get(Uri.parse('$_baseUrl/$userId'));

    if (res.statusCode == 200) {
      final user = User.fromJson(jsonDecode(res.body));
      return user.data;
    } else {
      throw Exception('Gagal ambil data profil');
    }
  }
}
