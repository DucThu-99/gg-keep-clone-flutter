import 'package:flutter/material.dart';

class TrashScreen extends StatefulWidget {
  static const routeName = 'trash_screen';
  @override
  _TrashScreenState createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trash'),
      ),
    );
  }
}
