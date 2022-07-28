class Support {
  Support({required this.url, required this.text});

  final String url;
  final String text;

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(url: json['url'], text: json['text']);
  }
}
