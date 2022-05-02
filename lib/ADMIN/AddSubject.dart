import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Subject.dart';

class AddSubjectDialog extends StatefulWidget {
  int semester;
  AddSubjectDialog({Key? key, required this.semester}) : super(key: key);

  @override
  _AddSubjectDialogState createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  late String? dropDownValue = null;

  get index => null;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Widget buildTextField(String hint, TextEditingController controller) {
      return Container(
          margin: EdgeInsets.all(4),
          child: TextField(
            decoration: InputDecoration(
              labelText: hint,
              border: OutlineInputBorder(borderSide: BorderSide()),
            ),
            controller: controller,
          ));
    }

    var subjectnamecontroller = TextEditingController();
    var codecontroller = TextEditingController();

    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Text(
              'AddSubject',
            ),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("teacher").get(),
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
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(hintText: "TeacherName"),
                    items: data
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e['teacher_name'].toString()),
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
                  return Text('Please add teachers first');
                }
              }
            },
          ),
          SizedBox(height: 5.0),
          buildTextField('SubjectName', subjectnamecontroller),
          SizedBox(height: 5.0),
          buildTextField('Code', codecontroller),
          SizedBox(height: 5.0),
          ElevatedButton(
            child: Text(
              'Submit',
            ),
            onPressed: () {
              FirebaseFirestore.instance.collection("subject").doc().set({
                'subject_name': subjectnamecontroller.text,
                'code': codecontroller.text,
                'semester': widget.semester.toString(),
                'email': dropDownValue,
              });
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => Subject(semester: index + 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
