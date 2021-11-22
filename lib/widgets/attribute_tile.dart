import 'package:flutter/material.dart';

class AttributeTile extends StatelessWidget {
  const AttributeTile({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final Widget value;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title),
        ),
        subtitle: value,
      ),
    );
  }
}
