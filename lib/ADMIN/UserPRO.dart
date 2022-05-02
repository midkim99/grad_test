import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_test/ADMIN/register.dart';
import 'homescreen.dart';

var editemailController = TextEditingController();
var editroleController = TextEditingController();

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
                  editroleController.text = doc['role'];
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            TextFormField(
                              controller: editemailController,
                              decoration: InputDecoration(
                                helperText: 'please update the email',
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                              ),
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "please Enter valid Email";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@+garmian+.edu+.krd")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {},
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextFormField(
                              controller: editroleController,
                              decoration: InputDecoration(
                                helperText: "update the role",
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                              ),
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
                                      .collection("users")
                                      .doc(doc.id)
                                      .update({
                                    'email': editemailController.text,
                                    'role': editroleController.text
                                  });
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserPRO(),
                                      ));
                                }),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.amber,
                )),
            trailing: IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(doc.id)
                      .delete();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.amber,
                )),
            title: Text(
              doc['email'],
              style: GoogleFonts.rokkitt(textStyle: _style),
            ),
            subtitle: Text(
              doc["role"],
              style: GoogleFonts.rokkitt(textStyle: _style),
            ),
          ),
        );
      });
}

class UserPRO extends StatefulWidget {
  @override
  State<UserPRO> createState() => _UserPROState();
}

class _UserPROState extends State<UserPRO> {
  @override
  Widget build(BuildContext context) {
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
          },
        ),
        title: Text(
          'Users',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(),
            ),
          );
        },
      ),
      body: Container(
        child: Padding(
            padding: EdgeInsets.only(right: 8, left: 8),
            child: Column(children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.teal[50],
                backgroundImage: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/476/476863.png"),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
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
