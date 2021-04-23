import 'package:flutter/material.dart';
import 'package:gg_keep_clone/models/note.dart';
import 'package:gg_keep_clone/providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  static const String routeName = '/note_screen';

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _didInit = false;
  Note note;
  NoteListProvider notesProviders;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_didInit) {
      final String _idNote =
          ModalRoute.of(context).settings.arguments as String;
      notesProviders = Provider.of<NoteListProvider>(context, listen: false);
      if (_idNote == null) {
        note = Note(
          id: DateTime.now().toString(),
          content: '',
          lastModify: DateTime.now(),
          title: null,
        );
      } else {
        note = notesProviders.getNoteWithId(_idNote);
        _controller.text = note.content;
        // print('Your content: ${note.content}');

      }
      _didInit = true;
    }
  }

  void _showSnackBar(String content) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Change Your Note'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  notesProviders.saveNote(
                    note.id,
                    note.title,
                    _controller.text,
                    DateTime.now(),
                  );
                  _showSnackBar('Your note has been saved!');
                })
          ],
        ),
        body: SingleChildScrollView(
          child: TextField(
            controller: _controller,
            minLines: 100,
            maxLines: 1000,
            decoration: InputDecoration(
              hintText: 'You should note something...',
            ),
          ),
        ),
      ),
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true;
      },
    );
  }
}
