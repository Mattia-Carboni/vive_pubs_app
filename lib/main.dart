import 'package:vive_pubs_app/pub_card.dart';
import 'package:flutter/material.dart';
import 'models/pubs.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(const ViveFridayApp());

class ViveFridayApp extends StatefulWidget {
  const ViveFridayApp({Key? key}) : super(key: key);

  @override
  ViveState createState() => ViveState();
}

class ViveState extends State<ViveFridayApp> {
  final List<Pubs> _listPubs = <Pubs>[];

  Future<String>? futurePubs;

  @override
  void initState() {
    super.initState();

    futurePubs = getPubs(_listPubs);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vive Pub',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('VIVE  Pub'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: _buildPubs(),
        ),
      ),
    );
  }

  Widget _buildPubs() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none) {
          return Container();
        }

        return ListView.builder(
          itemCount: _listPubs.length,
          itemBuilder: (context, index) {
            return PubCard(
              pub: _listPubs[index],
            );
          },
        );
      },
      future: futurePubs,
    );
  }
}

Future<String> getPubs(listPubs) async {
  Response response =
      await http.get(Uri.parse('http://192.168.1.189:1337/api/pubs'));
  if (response.statusCode == 200) {
    List<dynamic> pubsListRaw = jsonDecode(response.body);
    for (var i = 0; i < pubsListRaw.length; i++) {
      listPubs.add(Pubs.fromJson(pubsListRaw[i]));
    }

    return "Success!";
  } else {
    throw Exception('Failed to load data');
  }
}
