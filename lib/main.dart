import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restapi/View/note_list.dart';
import 'package:restapi/services/notes_service.dart';

import 'View/Screen1.dart';



void setupLocation(){
  GetIt.I.registerLazySingleton(() => NotesService());
}

void main() {
  setupLocation();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteListCountry(),
    );
  }
}

