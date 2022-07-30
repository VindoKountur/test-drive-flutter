import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.user}) : super(key: key);

  final Data user;

  setHighlight(idUser) async {
    String idUserStr = idUser.toString();
    final prefs = await SharedPreferences.getInstance();
    final highlighted = prefs.getStringList('highlighted') ?? [];
    late String snackText;
    if (highlighted.contains(idUserStr)) {
      highlighted.remove(idUserStr);
      snackText = 'Remove from Highlight';
    } else {
      highlighted.add(idUserStr);
      snackText = 'Add to Highlight';
    }
    prefs.setStringList('highlighted', highlighted);
    return snackText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              child: ClipOval(
                child: Image.network(
                  user.avatar,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${user.first_name} ${user.last_name}',
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(user.email),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final String snackText = await setHighlight(user.id);
                final prefs = await SharedPreferences.getInstance();
                final highlighted = prefs.getStringList('highlighted');
                print(highlighted);
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(snackText)));
              },
              child: const Text('Toggle Highlight'),
            ),
          ],
        ),
      ),
    );
  }
}
