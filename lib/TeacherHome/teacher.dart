import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test/LOGIN/login.dart';
import 'package:grad_test/TeacherHome/ElevationPage.dart';
import 'package:provider/provider.dart';
import '../chang themebutton.dart';
import '../thembuilder.dart';

class teacher extends StatefulWidget {
  @override
  State<teacher> createState() => _teacherState();
}

class _teacherState extends State<teacher> {
  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;
  var email = '';
  var role = '';

  TextEditingController lis = TextEditingController();
  @override
  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    DocumentSnapshot userdoc = await ref.doc(user!.uid).get();
    setState(() {
      email = userdoc.get('email');
      role = userdoc.get('role');
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout),
            )
          ],
          leading: ChangeThemeButtonWidget(),
          title: Text(
            email,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('subject')
                .where('email', isEqualTo: auth.currentUser!.email)
                .get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data!.docs.length);
                if (snapshot.hasData)
                  return Center(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListView(shrinkWrap: true, children: <Widget>[
                          ListTile(
                            leading: Image.network(
                              "https://cdn-icons-png.flaticon.com/512/167/167755.png",
                              width: 35,
                              height: 35,
                            ),
                            title: Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ElevationPage(
                                            snapshot.data!.docs[index]),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    snapshot.data!.docs[index]['subject_name']
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      );
                    },
                  ));
                else
                  return Text('nothing');
              }
              return LinearProgressIndicator();
            }));
  }
}

Future<void> logout(BuildContext context) async {
  CircularProgressIndicator();
  await FirebaseAuth.instance.signOut();

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}
