import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_manager/models/tea.dart';
import 'package:restaurant_manager/screens/home/tea_tile.dart';

class TeaList extends StatefulWidget {
  const TeaList({Key? key}) : super(key: key);

  @override
  _TeaListState createState() => _TeaListState();
}

class _TeaListState extends State<TeaList> {
  @override
  Widget build(BuildContext context) {
    final List<Tea> teas = Provider.of<List<Tea>>(context);

    return ListView.builder(
      itemCount: teas.length,
      itemBuilder: (context, index) {
        return TeaTile(tea: teas[index]);
      },
    );
  }
}
