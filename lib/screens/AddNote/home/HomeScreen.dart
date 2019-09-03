import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sqflite/screens/AddNote/AddNote.dart';
import 'package:flutter_sqflite/utils/DbHelper.dart';
import 'package:sqflite/sqflite.dart';

import '../Note.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeScrrenState();
  }
}

class HomeScrrenState extends State<HomeScreen> {
  int count = 0;
  List<Note> list_note;
  DbHelper _dbHelper = new DbHelper();

  @override
  Widget build(BuildContext context) {
    if (list_note == null) {
      list_note = List<Note>();
      updateList();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Note",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => exit(0),
        ),
      ),
      body: getList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gonext("Add Note",);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getList() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int posiion) {
        return Card(
          elevation: 5.0,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.blue, child: Icon(Icons.print)),
            title: Text(
              this.list_note[posiion].title,
              style: TextStyle(color: Colors.grey),
            ),
            subtitle: Text(this.list_note[posiion].title),
            trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  _deleteNote(context, list_note[posiion]);
                }),
            onTap:(){
              gonext("Edit Note",this.list_note[posiion]);
            } ,
          ),
        );
      },
    );
  }

  void _deleteNote(BuildContext context, Note list_note) async {
    int result = await _dbHelper.deleteNote(list_note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateList();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateList() {
    Future<Database> futureDb = _dbHelper.initalizeDatabase();
    futureDb.then((database) {
      Future<List<Note>> futureNoteList = _dbHelper.showAllData();
      futureNoteList.then((list_note) {
        setState(() {
          this.list_note = list_note;
          this.count = list_note.length;
        });
      });
    });
  }

  void gonext(String text,Note note) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNote(text,note);
    }));
    if (result == true) {
      updateList();
    }
  }
}
