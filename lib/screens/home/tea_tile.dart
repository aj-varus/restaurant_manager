import 'package:flutter/material.dart';
import 'package:restaurant_manager/models/tea.dart';

class TeaTile extends StatelessWidget {
  final Tea tea;

  const TeaTile({Key? key, required this.tea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue[tea.strength.toInt()],
          ),
          title: Text(tea.name),
        ),
      ),
    );
  }
}
