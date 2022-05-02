import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Teachers.dart';

class AddTeacherDialog extends StatefulWidget {
  AddTeacherDialog({Key? key}) : super(key: key);

  @override
  _AddTeacherDialogState createState() => _AddTeacherDialogState();
}

class _AddTeacherDialogState extends State<AddTeacherDialog> {
  String? dropDownValue = null;

  Widget build(BuildContext context) {
    Widget buildTextField(String hint, TextEditingController controller) {
      return Container(
          margin: EdgeInsets.all(4),
          child: TextField(
            decoration: InputDecoration(
              labelText: hint,
            ),
            controller: controller,
          ));
    }

    var teachernamecontroller = TextEditingController();
    var Educationallevelcontroller = TextEditingController();

    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Text(
              'AddTeacher',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.teal),
            ),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .where('role', isEqualTo: 'teacher')
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasData) {
                  List<Map<String, dynamic>> data = [];
                  snapshot.data!.docs.forEach((element) {
                    data.add(element.data());
                  });
                  return new DropdownButtonFormField<String>(
                    decoration: InputDecoration(hintText: "TeacherEmail"),
                    items: data
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e['email'].toString()),
                              value: e["email"],
                            ))
                        .toList(),
                    value: dropDownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  );
                } else {
                  return Text('Please add teachers first');
                }
              }
            },
          ),
          SizedBox(height: 5.0),
          buildTextField('TeacherName', teachernamecontroller),
          SizedBox(height: 5.0),
          buildTextField('EducationalLevel', Educationallevelcontroller),
          SizedBox(height: 5.0),
          ElevatedButton(
            child: Text(
              'Submit',
            ),
            onPressed: () {
              FirebaseFirestore.instance.collection("teacher").doc().set({
                'teacher_name': teachernamecontroller.text,
                'educational_level': Educationallevelcontroller.text,
                'email': dropDownValue,
              });
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeacherList(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
