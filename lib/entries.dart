import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_day_1/model/entry.dart';
import 'package:flutter_day_1/model/user.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamProvider<List<Entry>>(
      create: (context) => user.getEntries(),
      child: EntriesList(),
    );
  }
}

class EntriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var entries = Provider.of<List<Entry>>(context);

    if (entries == null) return Text('loading...');

    return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(context, entries[index]);
        });
  }
}

Widget _buildRow(context, Entry entry) {
  return ListTile(
    title: Text(entry.date()),
    subtitle: Text(entry.content.substring(0, min(entry.content.length, 50))),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Details(entry: entry),
        ),
      );
    },
  );
}
