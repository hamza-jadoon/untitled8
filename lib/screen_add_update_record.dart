import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled111/sqflite/database_student.dart';
import 'package:untitled111/sqflite/model_student.dart';

class ScreenAddUpdateRecord extends StatefulWidget {
  const ScreenAddUpdateRecord({super.key});

  @override
  State<ScreenAddUpdateRecord> createState() => _ScreenAddUpdateRecordState();
}

class _ScreenAddUpdateRecordState extends State<ScreenAddUpdateRecord> {
  DatabaseStudent databaseStudent = DatabaseStudent ();

  String name = "";
  // ignore: non_constant_identifier_names
  String roll_no = "";

  @override
  void initState() {
    super.initState();

  }

  void loadData() async {
    var path = await getDatabasesPath();
    print(path);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Record"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (String value){
                // ignore: avoid_print
                print("value $value");
                setState(() {
                  name = value;
                });
              },
              decoration: const InputDecoration (hintText: "Enter Name"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (String value){
                print("value ${value}");
                setState(() {
                  roll_no = value;
                });
              },
              decoration: const InputDecoration (hintText: "Enter Roll No"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  print("Add Record");

                  ModelStudent modelStudent1 =
                  ModelStudent(name: name, roll_no: roll_no);
                  print(modelStudent1.toMap());
                  databaseStudent.initionalizaDatabase().then((value) {
                    databaseStudent.AddRecord(modelStudent1);
                  });

                  // databaseStudent.AddRecord(modelStudent1);
                  // databaseStudent.UpdateRecord(modelStudent2);
                  //
                }, child: const Text("Add Button"))
          ],
        ),
      ),
    );
  }
}
