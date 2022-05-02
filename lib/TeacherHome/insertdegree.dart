import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'showDegree.dart';

class InsertDegree extends StatefulWidget {
  final DocumentSnapshot doc; //doc is subject details
  final String elevation;
  InsertDegree(this.doc, this.elevation);

  // get semester => null;
  //final int semester;

  //InsertDegree({required this.semester});

  @override
  _InsertDegreeState createState() => _InsertDegreeState();
}

class _InsertDegreeState extends State<InsertDegree> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.my_library_books_sharp),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => showDegree(),
                  ));
            },
          )
        ],

        //  backgroundColor: Color(0xFF4A184C),
        title: Text(widget.elevation),
        centerTitle: true,
      ),
      body: Container(
        // color: Colors.purple[50],
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("studentlist")
                      .where('semester', isEqualTo: widget.doc['semester'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();

                    return Expanded(child: _buildList(snapshot.data));
                  }),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 200.0,
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => showDegree()));
                      },
                      child: Text(
                        "ADD",
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        //  primary: Color(0xFF4A184C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13), // <-- Radius
                        ),
                      )),
                ),
              ),
            ])),
      ),
    );
  }

  Widget buildTextField(String hint, TextEditingController controller) {
    return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
            labelText: hint,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    // color: Color(0xFF4A184C),
                    )),
          ),
          controller: controller,
        ));
  }

  Widget _buildList(snapshot) {
    return Form(
      key: _formKey,
      child: ListView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot doc = snapshot.docs[index];

            return Card(
              child: ListTile(
                // iconColor: Color(0xFF4A184C),
                trailing: Container(
                  // color: Colors.purple[50],
                  width: 100,
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Please enter a degree';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      FirebaseFirestore.instance
                          .collection("degree")
                          .doc()
                          .set({
                        'degree': v,
                        'elevation': widget.elevation,
                        'subject': widget.doc['subject_name'],
                        'emailStudent': doc['email'],
                      });
                    },
                  ),
                ),
                //IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                title: Text(
                  doc['student_name'],
                ),
                // subtitle: Text(
                //   doc['email'],
                // ),
              ),
            );
          }),
    );
  }
}
