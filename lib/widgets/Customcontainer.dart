import 'package:flutter/material.dart';
import 'package:notes_writing_app/provider/appedit_provider/addedit_provider.dart';
import 'package:notes_writing_app/view/addnote.dart';
import 'package:provider/provider.dart';

class ContainerSets extends StatelessWidget {
  final String title;
  final String content;
  final String id;
  const ContainerSets(
      {super.key,
      required this.title,
      required this.content,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddEditProvider>(context, listen: false);
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(top: 3, left: 5, right: 3),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.4),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      provider.deletnote(id );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                GestureDetector(
                    onTap: () {
                      // Provider.of<AddEditProvider>(context, listen: false)
                      //     .saveeditingData(
                      //         NoteAppModel(content: content, title: title));
                      Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => AddNote(
                                    id: id,
                                    type: ActionType.EditNote,
                                  )))
                          //   .then((value) {
                          // provider.getApiCalling();
                          //  }
                          //  )
                          ;
                    },
                    child: const Text("Edit"))
                // TextButton(
                //     onPressed: () {

                //     },
                // child: Text("Edit"))
              ],
            ),
            Text(
              content,
              //  textDirection: TextDirection.rtl,
              // textAlign: TextAlign.start,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black),
            )
          ],
        ));
  }
}
