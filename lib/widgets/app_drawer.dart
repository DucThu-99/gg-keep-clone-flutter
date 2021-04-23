import 'package:flutter/material.dart';
import 'package:gg_keep_clone/screens/setting_screen.dart';
import 'package:gg_keep_clone/screens/trash_screen.dart';

class MainDrawer extends StatelessWidget {
  void _trashHandler(BuildContext ctx) {
    Navigator.pop(ctx);
    Navigator.of(ctx).pushNamed(TrashScreen.routeName);
  }

  void _settingHandler(BuildContext ctx) {
    Navigator.pop(ctx);
    Navigator.of(ctx).pushNamed(SettingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'DTNotes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // _buildListTile(
          //   Icons.event_note_rounded,
          //   'Notes',
          //   () {},
          // ),
          // _buildListTile(
          //   Icons.check_box_rounded,
          //   'Checklist',
          //   () {},
          // ),
          // Divider(
          //   thickness: 1.0,
          // ),
          // _buildListTile(
          //   Icons.bookmark,
          //   'Your bookmark',
          //   () {},
          // ),
          // Divider(
          //   thickness: 1.0,
          // ),
          _buildListTile(
            Icons.delete,
            'Trash',
            () => _trashHandler(context),
          ),
          _buildListTile(
            Icons.settings,
            'Settings',
            () => _settingHandler(context),
          ),
        ],
      ),
    );
  }

  ListTile _buildListTile(IconData icon, String title, Function opTapHandler) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: opTapHandler,
    );
  }
}
