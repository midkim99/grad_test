import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AddTeacher.dart';
import 'homescreen.dart';

var editemailController = TextEditingController();
var editnameController = TextEditingController();
var editlevelController = TextEditingController();

Widget _buildList(snapshot) {
  return ListView.builder(
      itemCount: snapshot.docs.length,
      itemBuilder: (context, index) {
        final DocumentSnapshot doc = snapshot.docs[index];
        final _style = TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.teal,
          fontSize: 16,
        );
        return Card(
          child: ListTile(
              iconColor: Colors.amber,
              trailing: IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("teacher")
                        .doc(doc.id)
                        .delete();
                  },
                  icon: Icon(Icons.delete)),
              title: Text(
                doc['teacher_name'],
                style: GoogleFonts.rokkitt(textStyle: _style),
              ),
              subtitle: Text(
                doc['email'],
                style: GoogleFonts.rokkitt(textStyle: _style),
              ),
              leading: IconButton(
                onPressed: () {
                  editemailController.text = doc['email'];
                  editnameController.text = doc['teacher_name'];
                  editlevelController.text = doc['educational_level'];
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: Text(
                                    'UpdateTeacher',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.teal),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: editemailController,
                              decoration: InputDecoration(
                                // labelText: "Email",
                                helperText: 'please update T email',
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextFormField(
                              controller: editnameController,
                              decoration: InputDecoration(
                                // labelText: "Name",
                                helperText: 'please update T name',
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: editlevelController,
                              decoration: InputDecoration(
                                // labelText: "level",
                                helperText: 'please update T level',
                                prefixIcon: Icon(Icons.done),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            ElevatedButton(
                                child: Text(
                                  "update",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("teacher")
                                      .doc(doc.id)
                                      .update({
                                    'email': editemailController.text,
                                    'teacher_name': editnameController.text,
                                    'educational_level':
                                        editlevelController.text,
                                  });
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TeacherList(),
                                      ));
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: (Icon(Icons.edit)),
              )),
        );
      });
}

class TeacherList extends StatefulWidget {
  TeacherList({Key? key}) : super(key: key);

  @override
  _TeacherListState createState() => _TeacherListState();
}

class _TeacherListState extends State<TeacherList> {
  @override
  Widget build(BuildContext context) {
    void showAddTeacherDialog() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: AddTeacherDialog(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => homepage(),
                  ));
            }),
        title: Text(
          'Teacher List',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          showAddTeacherDialog();
        },
      ),
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/1995/1995574.png"),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("teacher")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();

                    return Expanded(child: _buildList(snapshot.data));
                  }),
            ])),
      ),
    );
  }
}
