import 'package:flutter/material.dart';
import 'package:gg_keep_clone/providers/app_state_provider.dart';
import 'package:gg_keep_clone/widgets/note_tile.dart';
import 'package:provider/provider.dart';

class NoteSelectModeTile extends StatefulWidget {
  final String idNote;
  final String title;
  final String lastModify;

  NoteSelectModeTile({
    this.idNote,
    this.title,
    this.lastModify,
  });

  @override
  _NoteSelectModeTileState createState() => _NoteSelectModeTileState();
}

class _NoteSelectModeTileState extends State<NoteSelectModeTile> {
  bool _isSelected;
  bool _init = true;
  AppStateProvider state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_init) {
      state = Provider.of<AppStateProvider>(context, listen: false);
      _isSelected = state.didNoteSelected(widget.idNote);
      _init = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return state.layoutViewMode == 0
        ? CheckboxListTile(
            title: Text(widget.title),
            subtitle: Text(widget.lastModify),
            secondary: Icon(Icons.event_note_rounded),
            value: _isSelected,
            onChanged: (value) {
              setState(() {
                _isSelected = value;
              });
              state.selectNoteId(widget.idNote, value);
            })
        : CustomGridSelectModeTile(
            title: widget.title,
            subTitle: widget.lastModify,
            onChanged: (value) {
              setState(() {
                _isSelected = value;
              });
              state.selectNoteId(widget.idNote, value);
            },
            secondary: Icon(
              Icons.event_note_rounded,
            ),
            value: _isSelected,
          );
  }
}

class CustomGridSelectModeTile extends StatelessWidget {
  final bool value;
  final String title;
  final String subTitle;
  final Widget secondary;
  final ValueChanged<bool> onChanged;

  CustomGridSelectModeTile({
    this.value = false,
    @required this.title,
    @required this.subTitle,
    this.secondary,
    this.onChanged,
  });

  void _handleValueChange() {
    assert(onChanged != null);
    switch (value) {
      case false:
        onChanged(true);
        break;
      case true:
        onChanged(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomGridTile(
      title: title,
      lastModify: subTitle,
      trailing: Checkbox(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
