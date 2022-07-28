import 'data.dart';
import 'support.dart';

class Users {
  final int page;
  final int per_page;
  final int total;
  final int total_pages;
  final List<Data> data;
  final Support support;

  Users(
      {required this.page,
      required this.per_page,
      required this.total,
      required this.total_pages,
      required this.data,
      required this.support});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        page: json['page'],
        per_page: json['per_page'],
        total: json['total'],
        total_pages: json['total_pages'],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        support: Support.fromJson(json['support']));
  }
}
