import 'package:flutter/material.dart';

import 'models/pubs.dart';

class PubCard extends StatelessWidget {
  const PubCard({
    Key? key,
    required this.pub,
  }) : super(key: key);

  final Pubs pub;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ListTile(
        leading: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 64,
            minHeight: 64,
            maxWidth: 84,
            maxHeight: 84,
          ),
          child: Image.network('http://192.168.1.189:1337${pub.picture.url}',
              fit: BoxFit.cover),
        ),
        title: Text(pub.name),
        subtitle: Text(pub.address),
        trailing: Column(children: <Widget>[
          const Text('Avg Price'),
          Text(pub.avgPrice.toString())
        ]),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      ),
    );
  }
}
