import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_test/TeacherHome/insertdegree.dart';
import 'package:grad_test/TeacherHome/teacher.dart';
import 'AddElevation.dart';

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

Widget _buildList(snapshot, DocumentSnapshot subjectDoc) {
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
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InsertDegree(
                    subjectDoc,
                    doc['elevation'],
                  ),
                ),
              );
            },
            child: ListTile(
              // leading: Image.network(
              //   "https://cdn-icons.flaticon.com/png/512/3387/premium/3387752.png?token=exp=1651406772~hmac=da1ed7f542d66add2069e57a76307ff7",
              //   width: 35,
              //   height: 35,
              // ),
              trailing: IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("elevation")
                        .doc(doc.id)
                        .delete();
                  },
                  icon: Icon(Icons.delete)),
              title: Text(
                doc['elevation'],
                style: GoogleFonts.rokkitt(textStyle: _style),
              ),
              subtitle: Text(
                doc["degree"],
                style: GoogleFonts.rokkitt(textStyle: _style),
              ),
            ),
          ),
        );
      });
}

class ElevationPage extends StatefulWidget {
  final DocumentSnapshot doc;
  const ElevationPage(this.doc, {Key? key}) : super(key: key);
  @override
  _ElevationPageState createState() => _ElevationPageState();
}

class _ElevationPageState extends State<ElevationPage> {
  void showElevationDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: ElevationDialog(widget.doc['subject_name']),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }

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
                  builder: (context) => teacher(),
                ));
          },
        ),
        title: Text(widget.doc['subject_name']),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showElevationDialog();
        },
      ),
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("elevation")
                      .where('subject', isEqualTo: widget.doc['subject_name'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();

                    return Expanded(
                        child: _buildList(snapshot.data, widget.doc));
                  }),
            ])),
      ),
    );
  }
}
