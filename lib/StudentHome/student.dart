import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_test/LOGIN/login.dart';
import 'package:grad_test/StudentHome/studentmain.dart';
import 'package:provider/provider.dart';
import '../thembuilder.dart';

class StudentDegree extends StatefulWidget {
  final String subejctName;
  StudentDegree(this.subejctName);
  @override
  State<StudentDegree> createState() => _StudentDegreeState();
}

class _StudentDegreeState extends State<StudentDegree> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Result',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentMain(),
                  ));
            },
          ),
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('degree')
                .where('emailStudent', isEqualTo: auth.currentUser!.email)
                .where('subject', isEqualTo: widget.subejctName)
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
                if (snapshot.hasData) {
                  List<double> degrees = [];
                  snapshot.data!.docs.forEach((e) {
                    degrees.add(double.parse(e['degree']));
                  });
                  double total = 0;
                  degrees.forEach((e) {
                    total = total + e;
                  });
                  return Column(
                    children: [
                      Center(
                          child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 20,
                            shadowColor: Colors.brown[800],
                            margin: EdgeInsets.all(10),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.brown)),
                            child:
                                ListView(shrinkWrap: true, children: <Widget>[
                              ListTile(
                                leading: Image.network(
                                  "https://cdn-icons.flaticon.com/png/512/2196/premium/2196227.png?token=exp=1651481955~hmac=ab40a5d27a7f7b433102458f69de71e2",
                                  width: 35,
                                  height: 35,
                                ),
                                title: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(snapshot
                                              .data!.docs[index]['elevation']
                                              .toString() +
                                          ' = ' +
                                          snapshot.data!.docs[index]['degree']
                                              .toString()),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      )),
                      SizedBox(
                        height: 70,
                        width: 150,
                        child: Card(
                            child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Total = $total'),
                        )),
                      )
                    ],
                  );
                } else
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
