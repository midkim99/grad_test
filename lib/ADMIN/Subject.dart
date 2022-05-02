import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_test/ADMIN/simister.dart';
import 'package:grad_test/chang%20themebutton.dart';
import 'package:provider/provider.dart';
import '../thembuilder.dart';
import 'AddSubject.dart';
import 'Simister1.dart';
import 'Teachers.dart';
import 'UserPRO.dart';
import 'homescreen.dart';

var editTController = TextEditingController();
var editnameController = TextEditingController();
var editcodeController = TextEditingController();

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
                editTController.text = doc['email'];
                editnameController.text = doc['subject_name'];
                editcodeController.text = doc['code'];
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
                              'UpdateSubject',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.teal),
                            ),
                          ),
                          TextFormField(
                            controller: editTController,
                            decoration: InputDecoration(
                              helperText: "update T eamail",
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            controller: editnameController,
                            decoration: InputDecoration(
                              helperText: "update subject",
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: editcodeController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.done),
                                helperText: 'update Code'),
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
                                    .collection("subject")
                                    .doc(doc.id)
                                    .update({
                                  'email': editTController.text,
                                  'subject_name': editnameController.text,
                                  'code': editcodeController.text,
                                });
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Subject(semester: index + 1),
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
                      .collection("subject")
                      .doc(doc.id)
                      .delete();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.amber,
                )),
            title: Text(
              doc['subject_name'],
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

class Subject extends StatefulWidget {
  final int semester;
  Subject({required this.semester});
  get doc => null;
  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    void showAddSubjectDialog() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: AddSubjectDialog(semester: widget.semester),
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
          'Subject List',
          style: TextStyle(color: Theme.of(context).iconTheme.color),
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
          showAddSubjectDialog();
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
                    "https://cdn-icons-png.flaticon.com/512/2232/2232688.png"),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("subject")
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
