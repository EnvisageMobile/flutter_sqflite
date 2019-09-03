class Note {
  int _id;
  String _title;



  Note(this._title);

  int get id => _id;

  set id(int value) {
    _id = value;
  }


  String get title => _title;


  set title(String value) {
    _title = value;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    return map;
  }

 Note.fromMapObject(Map<String,dynamic> map){
this._id=map['id'];
this._title=map['title'];
  }

}
