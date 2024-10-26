import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notes_writing_app/model/note_app_model/note_app_model.dart';

import 'package:http/http.dart' as http;
import 'package:notes_writing_app/provider/api_provider/api_provider.dart';
import 'package:notes_writing_app/services/urls.dart';
import 'package:provider/provider.dart';

abstract class Apicalls {
  Future<List<NoteAppModel>> getNote();
  Future<bool> createNote(NoteAppModel value);
  Future<void> updateNote(NoteAppModel value);
  Future<void> deleteNote(String id);
}

class NoteDb implements Apicalls {
  NoteDb._internal();
  static NoteDb instance = NoteDb._internal();
  NoteDb factory() {
    return instance;
  }

  final Scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Future<bool> createNote(NoteAppModel value) async {
    print(value.id);
    print(value.content);
    print(value.title);
    try {
      final url = Uri.parse(UrlLinks.basrUrl + UrlLinks.createNote);
      final result = await http.post(url,
          headers: {"content-type": "application/json "},
          body: jsonEncode({
            "_id": value.id,
            "title": value.title,
            "content": value.content,
          }));
      print("${result.body}post response");
      if (result.statusCode == 200 || result.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("$e this is exception");
      return false;
    }
  }

  @override
  Future<bool> deleteNote(String id) async {
    final url = UrlLinks.basrUrl + UrlLinks.deleteNote;
    final uri = Uri.parse("$url/$id");
    final response = await http.delete(uri);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<NoteAppModel>> getNote() async {
    try {
      final url = UrlLinks.basrUrl + UrlLinks.getNote;
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final data = result["data"] as List;

        //if so may keys are there data = result as map
        // for (var i = 0; i < data.length; i++) {
        //   return NoteAppModel.fromJson(data[i]);
        //  print(i);
        //}
        // return NoteAppModel.fromJson(data);
        return data
            .map(
              (e) => NoteAppModel.fromJson(e),
            )
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<NoteAppModel?> updateNote(NoteAppModel value) async {
    print("update note");
    print(value.id);
    print(value.content);
    print(value.title);

    try {
      final url = UrlLinks.basrUrl + UrlLinks.updateNote;
      final uri = Uri.parse(url);
      // final response = await http.put(uri);
      final result = await http.put(
        uri,
        body: jsonEncode(
            {"_id": value.id, "content": value.content, "title": value.title}),
        headers: {"content-type": "application/json "},
      );
      print(result.body);

      if (result.statusCode == 200) {
        final data = jsonDecode(result.body);
        return NoteAppModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
    // if (result == null) {
    //   return null;
    // } else {
    //   final Scaffoldkey = GlobalKey<ScaffoldState>();
    //   final pro = Provider.of(Scaffoldkey.currentContext!, listen: false);
    //   pro.updatingIndex(value);
    // }
  }

  // Future<void> deleteUser(int id) async {
  //   final url = UrlLinks.basrUrl + UrlLinks.deleteNote;
  //   final uri = Uri.parse(url);
  //   final response = await http.delete(uri);

  //   if (response.statusCode == 200) {
  //     return;
  //   } else {
  //     throw Exception('Failed to delete');
  //   }
  // }
}
