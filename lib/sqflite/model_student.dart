
class ModelStudent {

  String? id;
  String name;
  // ignore: non_constant_identifier_names
  String  roll_no;

  // ignore: non_constant_identifier_names
  ModelStudent ({this.id, required this.name, required this.roll_no});

  factory ModelStudent.fromMap(Map<String, dynamic> json) {
    return ModelStudent(
        id: json["id"].toString() ,
        name: json["name"],
        roll_no: json["roll_no"]);
  }

  Map<String,dynamic> toMap() {

    Map<String,dynamic> single_Record = {
      "name" : name,
      "roll_no" : roll_no,

    };

    return single_Record;
  }
}