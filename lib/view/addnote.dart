// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:notes_writing_app/provider/appedit_provider/addedit_provider.dart';
import 'package:provider/provider.dart';

enum ActionType {
  AddNote,
  EditNote,
}

class AddNote extends StatelessWidget {
  final ActionType type;
  final String? id;

  const AddNote({super.key, required this.type, this.id});

  Widget get savebutton =>
      Consumer<AddEditProvider>(builder: (ctx, value, child) {
        return TextButton.icon(
          onPressed: () {
            switch (type) {
              case ActionType.AddNote:
                value.postdata();
                Navigator.of(ctx).pop();
                break;
              case ActionType.EditNote:
                value.saveeditingData(id!);
                 Navigator.of(ctx).pop();
                break;
            }
          },
          icon: const Icon(
            Icons.save,
            color: Colors.black,
          ),
          label: const Text(
            "Save",
            style: TextStyle(color: Colors.black),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddEditProvider>(context, listen: false);
    if (type == ActionType.EditNote) {
      if (id == null) {
        Navigator.of(context).pop();
      }
      final note = provider.editNoteById(id!);
      if (note == null) {
       Navigator.of(context).pop();
      }
      provider.titleController.text = note!.title ?? 'no title';
      provider.contentController.text = note.content ?? 'no content';
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text(
            type.name.toString(),
          ),
          actions: [savebutton],
        ),
        body: Consumer<AddEditProvider>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: value.titleController,
                  decoration: InputDecoration(
                      label: const Text("Title"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: value.contentController,
                  maxLines: 4,
                  maxLength: 100,
                  decoration: InputDecoration(
                      hintText: "content",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
