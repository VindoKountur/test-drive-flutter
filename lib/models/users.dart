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

  List<Data> get dataPengguna {
    return data;
  }
}

class Data {
  const Data({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
  });

  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class Support {
  Support({required this.url, required this.text});

  final String url;
  final String text;

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(url: json['url'], text: json['text']);
  }
}
