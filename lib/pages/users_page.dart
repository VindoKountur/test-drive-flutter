import 'package:flutter/material.dart';
import 'package:test_drive/pages/detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data.dart';
import '../repository.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Future users;
  List<Data> dataUsers = [];
  Repository repository = Repository();

  List<int> highlightUserId = [];

  @override
  void initState() {
    super.initState();
    getData();
    getHighlighted();
  }

  getData() async {
    List<Data> users = await repository.getUsersData();
    setState(() {
      dataUsers = users;
    });
  }

  getHighlighted() async {
    final prefs = await SharedPreferences.getInstance();
    final highlighted = prefs.getStringList('highlighted') ?? [];
    setState(() {
      highlightUserId = highlighted.map((e) => int.parse(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('USERS'),
        ),
        body: gridCard(dataUsers));
  }

  Widget gridCard(List<Data> users) => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 300,
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return userCard(users[index]);
        },
      );

  Widget userCard(Data user) {
    final bool isHighlight = highlightUserId.contains(user.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(user: user),
          ),
        ).then((value) {
          setState(() => highlightUserId = value);
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.blue, width: isHighlight ? 4 : 0),
        ),
        color: Colors.black12,
        margin: EdgeInsets.zero,
        shadowColor: Colors.black26,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                user.avatar,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text('Name :'),
                    Text(
                      '${user.first_name} ${user.last_name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Email :'),
                    Text(
                      user.email,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
