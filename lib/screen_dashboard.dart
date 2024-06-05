import 'package:flutter/material.dart';
import 'package:untitled111/screen_add_update_record.dart';
import 'package:untitled111/sqflite/database_student.dart';
import 'package:untitled111/sqflite/model_student.dart';


// ignore: camel_case_types
class screenDashboard extends StatefulWidget {
  const screenDashboard({super.key});

  @override
  State<screenDashboard> createState() => _screenDashboardState();
}

// ignore: camel_case_types
class _screenDashboardState extends State<screenDashboard> {
  DatabaseStudent databaseStudent = DatabaseStudent ();

  List<ModelStudent> list_student = [];

  @override
  void initState() {
    super.initState();
    loadData();

  }
  loadData(){
    databaseStudent.initionalizaDatabase().then((onValue){
      databaseStudent.GetAllRecord().then((value){
        setState(() {
          list_student = value;
        });
    });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder:(builder) =>  ScreenAddUpdateRecord()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(

        title: const Text("Sqflite Application"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: list_student.length,
          itemBuilder: (context,index) {
            return ListTile(
              title: Text(list_student[index].name),
              subtitle:Text(list_student[index].roll_no),
            );
          },
        ),
      ),
    );

  }
}

