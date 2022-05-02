import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_test/ADMIN/Simister1.dart';
import 'package:grad_test/ADMIN/UserPRO.dart';
import 'package:grad_test/ADMIN/homescreen.dart';
import '../chang themebutton.dart';
import '../thembuilder.dart';
import 'AddSutudent.dart';
import 'Teachers.dart';
import 'simister.dart';
import 'package:provider/provider.dart';

var editemailController = TextEditingController();
var editnameController = TextEditingController();
var editphoneController = TextEditingController();

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
            leading: IconButton(
              onPressed: () {
                editemailController.text = doc['email'];
                editnameController.text = doc['student_name'];
                editphoneController.text = doc['phone_number'];
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Center(
                            child: Text(
                              'UpdateStudent',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.teal),
                            ),
                          ),
                          TextFormField(
                            controller: editemailController,
                            decoration: InputDecoration(
                              helperText: "update student",
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: editnameController,
                            decoration: InputDecoration(
                              helperText: "update name",
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: editphoneController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.done),
                                helperText: 'pdate phone number'),
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
                                    .collection("studentlist")
                                    .doc(doc.id)
                                    .update({
                                  'email': editemailController.text,
                                  'student_name': editnameController.text,
                                  'phone_number': editphoneController.text,
                                });
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Student(semester: index + 1),
                                    ));
                              }),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: (Icon(
                Icons.edit,
                color: Colors.amber,
              )),
            ),
            trailing: IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("studentlist")
                      .doc(doc.id)
                      .delete();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.amber,
                )),
            title: Text(
              doc['student_name'],
              style: GoogleFonts.rokkitt(textStyle: _style),
            ),
            subtitle: Text(
              doc['email'],
              style: GoogleFonts.rokkitt(textStyle: _style),
            ),
          ),
        );
      });
}

class Student extends StatefulWidget {
  final int semester;

  Student({required this.semester});

  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  @override
  Widget build(BuildContext context) {
    void showAddStudentDialog() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: AddStudentDialog(semester: widget.semester),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        },
      );
    }

    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student List',
        ),
      ),
      drawer: Container(
        width: 180,
        child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              child: ListView(
                children: [
                  Center(
                    child: Text(" $text!",
                        style: GoogleFonts.gloriaHallelujah(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  ChangeThemeButtonWidget(),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'HOME',
                style: GoogleFonts.gloriaHallelujah(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homepage(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                'Teacher',
                style: GoogleFonts.gloriaHallelujah(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherList(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.white,
              ),
              title: Text('Subject',
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Simis(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.girl,
                color: Colors.white,
              ),
              title: Text('student',
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Simis1(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.admin_panel_settings,
                color: Colors.white,
              ),
              title: Text('Users',
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPRO(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text('LogOut',
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              onTap: () {
                logout(context);
              },
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showAddStudentDialog();
        },
      ),
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.teal[50],
                backgroundImage: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/3135/3135810.png"),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("studentlist")
                      .where('semester', isEqualTo: widget.semester.toString())
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
