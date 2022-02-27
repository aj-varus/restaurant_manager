import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_manager/models/tea.dart';

class TeaList extends StatefulWidget {
  const TeaList({Key? key}) : super(key: key);

  @override
  _TeaListState createState() => _TeaListState();
}

class _TeaListState extends State<TeaList> {
  @override
  Widget build(BuildContext context) {
    final List<Tea> teas = Provider.of<List<Tea>>(context);

    return Container();
  }
}
