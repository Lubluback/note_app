import 'package:flutter/material.dart';
//import 'package:notes_writing_app/model/note_app_model/note_app_model.dart';
import 'package:notes_writing_app/provider/appedit_provider/addedit_provider.dart';
//import 'package:notes_writing_app/provider/noteapp_provider/noteapp_provider.dart';
//import 'package:notes_writing_app/services/apiintegration.dart';
import 'package:notes_writing_app/view/addnote.dart';
import 'package:notes_writing_app/widgets/Customcontainer.dart';
import 'package:provider/provider.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // apiCalling();
      Provider.of<AddEditProvider>(context, listen: false).getApiCalling();
    });
    super.initState();
  }

  // apiCalling() async {
  //   final list = await NoteDb().getNote();
  //   noteModel = list;
  //   setState(() {});
  // }

  //List<NoteAppModel> noteModel = [];

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<AddEditProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                // AddNote(
                //  type: ActionType.AddNote,
                // );

                pro.clearController();

                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (ctx) => AddNote(
                              type: ActionType.AddNote,
                            )))
                    .then(
                  (value) {
                    print("this method calling after addnote saving");
                    pro.getApiCalling();
                  },
                );
              },
              label: const Text('Add'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.amberAccent),
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            title: const Text(
              "Write notes here:",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w400),
            ),
          ),
          body: Consumer<AddEditProvider>(
              builder: (BuildContext context, value, child) {
            return value.note.isEmpty
                ? Center(child: Text("no result found"))
                : GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    // shrinkWrap: true,
                    children: List.generate(value.note.length, (index) {
                      return ContainerSets(
                          title: value.note[index].title ?? "",
                          content: value.note[index].content ?? "",
                          id: value.note[index].id ?? "");
                    }));
          })),
    );
  }
}
