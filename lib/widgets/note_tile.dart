import 'package:flutter/material.dart';
import 'package:gg_keep_clone/providers/app_state_provider.dart';
import 'package:gg_keep_clone/screens/note_screen.dart';
import 'package:provider/provider.dart';

class NoteTile extends StatelessWidget {
  final String idNote;
  final String title;
  final String lastModify;

  NoteTile({
    this.idNote,
    this.title,
    this.lastModify,
  });

  void _navToNote(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      NoteScreen.routeName,
      arguments: idNote,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppStateProvider>(context, listen: false);
    return state.layoutViewMode == 0
        ? ListTile(
            leading: Icon(Icons.event_note_rounded),
            title: Text(
              title,
            ),
            subtitle: Text(
              lastModify,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () => _navToNote(context),
            onLongPress: () {
              state.triggerModifyMode();
              state.setFirstNoteSelect(idNote);
              state.selectNoteId(idNote, true);
            },
          )
        : InkWell(
            child: CustomGridTile(
              title: title,
              lastModify: lastModify,
            ),
            onTap: () => _navToNote(context),
            onLongPress: () {
              state.triggerModifyMode();
              state.setFirstNoteSelect(idNote);
              state.selectNoteId(idNote, true);
            },
          );
  }
}

class CustomGridTile extends StatelessWidget {
  final String title;
  final String lastModify;
  final Widget trailing;

  CustomGridTile({this.title, this.lastModify, this.trailing});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(title),
            Spacer(),
            Text(
              lastModify,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(Icons.event_note_rounded),
                Spacer(),
                if (trailing != null) trailing,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
