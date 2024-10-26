import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:notes_writing_app/model/note_app_model/note_app_model.dart';
import 'package:notes_writing_app/services/apiintegration.dart';

class AddEditProvider extends ChangeNotifier {
  final TextEditingController contentController = TextEditingController();

  final TextEditingController titleController = TextEditingController();
  final Scaffoldkey = GlobalKey<ScaffoldState>();
  final _service = NoteDb.instance;
  bool isLoading = false;
  List<NoteAppModel> _note = [];
  List<NoteAppModel> get note => _note;

  Future<void> getApiCalling() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getNote();

    _note = response.reversed.toList();
    print(_note);
    isLoading = false;
    notifyListeners();
  }

  saveeditingData(String id) async {
    final title = titleController.text;
    final content = contentController.text;
    final newmodel =
        NoteAppModel.create(title: title, content: content, id: id);
    final data = await NoteDb.instance.updateNote(newmodel);
    if (data != null) {
      updatingIndex(data);
    } else {
      print("error");
      //return ;
    }

    // if (note != null) {
    //   print("not saved");
    // } else {
    //   Navigator.of(Scaffoldkey.currentContext!).pop();
    // }
    notifyListeners();
  }

  // initilizeController() {
  //   titleController = TextEditingController();
  //   contentController = TextEditingController();
  //   notifyListeners();
  // }

  disposecontroller() {
    contentController.dispose();
    titleController.dispose();
  }

  Future<void> postdata() async {
    print("postdata calling");
    final newmodel = NoteAppModel(
        title: titleController.text,
        content: contentController.text,
        id: DateTime.now().millisecondsSinceEpoch.toString());

    NoteDb.instance.createNote(newmodel);
    notifyListeners();
  }

  clearController() {
    contentController.clear();
    titleController.clear();
    notifyListeners();
  }

  //editing the note by using provider
  NoteAppModel? editNoteById(String id) {
    try {
      return note.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }

  //updatedindexfunction
  updatingIndex(NoteAppModel value) {
    final index = _note.indexWhere((note) => note.id == value.id);
    if (index == -1) {
      return null;
    }
    _note.removeAt(index);
    _note.insert(index, value);
    notifyListeners();

    //  return value;
  }

  //deletingfinction
  deletnote(String val) {
    NoteDb.instance.deleteNote(val);
    final index = _note.indexWhere((note) => note.id == val);
    if (index == -1) {
      return null;
    }
    _note.removeAt(index);
    notifyListeners();
  }
}
