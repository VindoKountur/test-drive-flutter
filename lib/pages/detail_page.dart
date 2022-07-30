import 'package:flutter/material.dart';

import '../models/data.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.user}) : super(key: key);

  final Data user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User ${user.first_name} ${user.last_name}'),
      ),
      body: const Center(
        child: Text('detail'),
      ),
    );
  }
}
