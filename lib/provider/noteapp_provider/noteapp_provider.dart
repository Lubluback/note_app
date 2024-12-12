import 'package:flutter/material.dart';
import 'package:notes_writing_app/model/note_app_model.dart';
import 'package:notes_writing_app/services/apiintegration.dart';

class NoteAppProvider extends ChangeNotifier {
  String _name = 'undefined michi 😼';
  List<NoteAppModel> noteModel = [];

  String get name => _name;

  set name(String newName) {
    _name = newName;
    notifyListeners();
  }

  apiCalling() async {
    final list = await NoteDb.instance .getNote();
    noteModel = list;
    notifyListeners();
  }
}
