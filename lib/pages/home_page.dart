import 'package:flutter/material.dart';
import 'package:test_drive/repository.dart';

import '../models/data.dart';
import '../models/users.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future users;
  List<Data> dataUsers = [];
  Repository repository = Repository();

  // getData() async {
  //   users = (await repository.getUsersData()) as Future<Users>;
  // }

  @override
  void initState() {
    super.initState();
    users = repository.getUsersData();

    users.then((value) {
      setState(() {
        dataUsers = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(2),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.black12,
                  shadowColor: Colors.black26,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                        child: Image.network(
                          dataUsers[index].avatar,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                        '${dataUsers[index].first_name} ${dataUsers[index].last_name}'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.mail),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text('${dataUsers[index].email}'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: ((context, index) => SizedBox(height: 6)),
          itemCount: dataUsers.length),
    );
  }
}
