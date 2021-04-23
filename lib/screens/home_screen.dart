import 'package:flutter/material.dart';
import 'package:gg_keep_clone/providers/app_state_provider.dart';
import 'package:gg_keep_clone/providers/note_provider.dart';
import 'package:gg_keep_clone/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import 'account_screen.dart';
import 'note_list_section.dart';
import 'note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _init = true;
  bool _isLoading = false;
  NoteListProvider noteProv;
  AppStateProvider state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      state = Provider.of<AppStateProvider>(context);
      state.onStartup();
      // _layoutViewMode = await _getCurrentNoteLayout();
      noteProv = Provider.of<NoteListProvider>(context);
      noteProv.onStartup().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      _init = false;
    }
  }

  void _accountHandler(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(AccountScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: !state.isModify
            ? null
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: state.triggerModifyMode,
              ),
        title: !state.isModify
            ? Text('Notes')
            : Text('${state.numSelected} selected'),
        actions: !state.isModify
            ? [
                IconButton(
                  icon: state.layoutViewMode == 0
                      ? Icon(Icons.drag_handle)
                      : Icon(Icons.grid_view),
                  onPressed: state.triggerNoteLayout,
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () => _accountHandler(context),
                ),
                SizedBox(
                  width: 10,
                )
              ]
            : [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    if (state.numSelected != 0) {
                      noteProv.deleteNotesTemporary(state.selectedNoteIds);
                      state.triggerModifyMode();
                    }
                  },
                ),
              ],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : NoteListSection(),
            ),
          ),
        ],
      ),
      drawer: !state.isModify ? MainDrawer() : null,
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: !state.isModify
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(NoteScreen.routeName);
              },
            )
          : null,
    );
  }
}
