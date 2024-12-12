import 'package:flutter/material.dart';
import 'package:notes_writing_app/provider/appedit_provider/addedit_provider.dart';
import 'package:notes_writing_app/provider/noteapp_provider/noteapp_provider.dart';
import 'package:notes_writing_app/view/noteapp.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NoteAppProvider()),
          ChangeNotifierProvider(
            create: (_) => AddEditProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:const NoteApp()));
  }
}
