import 'package:flutter/material.dart';
import 'package:gg_keep_clone/models/note.dart';
import 'package:gg_keep_clone/providers/app_state_provider.dart';
import 'package:gg_keep_clone/providers/note_provider.dart';
import 'package:gg_keep_clone/widgets/note_select_mode_tile.dart';
import 'package:gg_keep_clone/widgets/note_tile.dart';
import 'package:provider/provider.dart';

class NoteListSection extends StatefulWidget {
  @override
  _NoteListSectionState createState() => _NoteListSectionState();
}

class _NoteListSectionState extends State<NoteListSection> {
  bool _init = true;
  Size _screenSize;
  AppStateProvider stateProv;
  NoteListProvider notesProv;
  List<Note> notes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      _screenSize = MediaQuery.of(context).size;
      stateProv = Provider.of<AppStateProvider>(context);
      notesProv = Provider.of<NoteListProvider>(context);
      notes = notesProv.items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return notes.length == 0
        ? Center(
            child: Text('You don\'t hava anything note!'),
          )
        : SingleChildScrollView(
            child: Container(
              height: _screenSize.height * 0.85,
              padding: const EdgeInsets.all(8),
              child: stateProv.layoutViewMode == 0
                  ? ListView.builder(
                      itemBuilder: (cxt, index) {
                        return Column(
                          children: [
                            !stateProv.isModify
                                ? NoteTile(
                                    idNote: notes[index].id,
                                    title: notes[index].title,
                                    lastModify: notesProv.getLastModify(
                                      notesProv.items[index].lastModify,
                                    ),
                                  )
                                : NoteSelectModeTile(
                                    idNote: notes[index].id,
                                    title: notes[index].title,
                                    lastModify: notesProv.getLastModify(
                                      notesProv.items[index].lastModify,
                                    ),
                                  ),
                            Divider(),
                          ],
                        );
                      },
                      itemCount: notes.length,
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return !stateProv.isModify
                            ? NoteTile(
                                idNote: notes[index].id,
                                title: notes[index].title,
                                lastModify: notesProv.getLastModify(
                                  notesProv.items[index].lastModify,
                                ),
                              )
                            : NoteSelectModeTile(
                                idNote: notes[index].id,
                                title: notes[index].title,
                                lastModify: notesProv.getLastModify(
                                  notesProv.items[index].lastModify,
                                ),
                              );
                      },
                    ),
            ),
          );
  }
}
