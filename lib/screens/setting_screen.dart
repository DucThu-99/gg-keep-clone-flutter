import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = 'setting_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: Text('Dark Theme'),
          ),
        ],
      ),
    );
  }
}
