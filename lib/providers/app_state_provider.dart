import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  bool _isModifyMode = false;
  List<String> _selectNoteIds = [];
  String _firstItem;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _layoutViewMode;

  bool get isModify {
    return _isModifyMode;
  }

  int get layoutViewMode {
    return _layoutViewMode;
  }

  List<String> get selectedNoteIds {
    return _selectNoteIds;
  }

  int get numSelected {
    return _selectNoteIds.length;
  }

  Future<void> onStartup() async {
    _getCurrentNoteLayout();
  }

  ///Call this function on the first
  void setFirstNoteSelect(String idNote) {
    _firstItem = idNote;
  }

  bool didNoteSelected(String idNote) {
    if (idNote == _firstItem) {
      return true;
    } else {
      return false;
    }
  }

  void triggerModifyMode() {
    _isModifyMode = !_isModifyMode;
    _firstItem = null;
    _selectNoteIds = [];
    notifyListeners();
  }

  void selectNoteId(String idNote, bool isSelect) {
    if (isSelect) {
      _selectNoteIds.add(idNote);
    } else {
      _selectNoteIds.removeWhere((id) => id == idNote);
    }
    notifyListeners();
  }

  ///Change the layout of notes, that should it in list view (0) or grid view
  /// (1)
  Future<void> triggerNoteLayout() async {
    if (_layoutViewMode == 0) {
      _layoutViewMode = 1;
      notifyListeners();
      SharedPreferences pref = await _prefs;
      pref.setInt('noteLayout', 1);
    } else {
      _layoutViewMode = 0;
      notifyListeners();
      SharedPreferences pref = await _prefs;
      pref.setInt('noteLayout', 0);
    }
  }

  Future<void> _getCurrentNoteLayout() async {
    final SharedPreferences prefs = await _prefs;
    _layoutViewMode = prefs.getInt('noteLayout') ?? 0;
  }
}
