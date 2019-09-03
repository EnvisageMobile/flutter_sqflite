import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sqflite/screens/AddNote/Note.dart';
import 'package:flutter_sqflite/utils/DbHelper.dart';

class AddNote extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  AddNote(this.appBarTitle,this.note);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new AddNoteScreen(this.appBarTitle,this.note);
  }
}

class AddNoteScreen extends State<AddNote> {
  DbHelper dbHelper = new DbHelper();
  String _notes="";
  final String appBarTitle;
  final Note note;
  TextEditingController titleController = TextEditingController();

  AddNoteScreen(this.appBarTitle,this.note);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: (){_goToPreviousScreen();},
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: null),
        ),
        body: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20.00),child:  TextField(
              decoration:
              InputDecoration(icon: Icon(Icons.supervised_user_circle), hintText: "Enter Note"),
              controller:titleController,
            ),)
            ,
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () => saveData(),
                child: new Text("SAVE"),
              ) ,
            ),


          ],
        ),
      ),

    );
  }

  saveData() {
    setState(() {
      _goToPreviousScreen();
      _sendData();
    });
  }

  void _sendData() async {
    int _result = await dbHelper.insertNote(titleController.text);
    print("result from databse $_result");
  //  _showSnackBar(context, 'Note Deleted Successfully');
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _goToPreviousScreen() {

   Navigator.pop(context,true);
  }
}
