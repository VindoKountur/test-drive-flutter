import 'support.dart';

import 'data.dart';

class User {
  final Data data;
  final Support support;

  User({required this.data, required this.support});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        data: Data.fromJson(json['data']),
        support: Support.fromJson(json['support']));
  }
}
