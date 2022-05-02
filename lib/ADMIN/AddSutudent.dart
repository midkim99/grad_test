import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_test/ADMIN/Students.dart';

class AddStudentDialog extends StatefulWidget {
  int semester;
  AddStudentDialog({Key? key, required this.semester}) : super(key: key);

  @override
  _AddStudentDialogState createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  String? dropDownValue = null;

  get index => null;
  @override
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

    var studentnamecontroller = TextEditingController();
    var phonenumbercontroller = TextEditingController();
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Text('AddStudent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.teal,
                )),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .where('role', isEqualTo: 'student')
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
                    decoration: InputDecoration(hintText: " Student Email"),
                    items: data
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e['email'].toString()),
                              value: e["email"],
                            ))
                        .toList(),
                    value: dropDownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  );
                } else {
                  return Text('Please add student first');
                }
              }
            },
          ),
          SizedBox(height: 5.0),
          buildTextField('StudentName', studentnamecontroller),
          SizedBox(height: 5.0),
          buildTextField('PhoneNumber', phonenumbercontroller),
          SizedBox(height: 5.0),
          ElevatedButton(
            child: Text(
              'submit',
            ),
            onPressed: () {
              FirebaseFirestore.instance.collection("studentlist").doc().set({
                'student_name': studentnamecontroller.text,
                'phone_number': phonenumbercontroller.text,
                'email': dropDownValue,
                'semester': widget.semester.toString(),
              });
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => Student(semester: index + 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
