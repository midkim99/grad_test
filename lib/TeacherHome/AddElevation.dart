import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ElevationPage.dart';

class ElevationDialog extends StatefulWidget {
  String subject;
  ElevationDialog(this.subject);
  @override
  _ElevationDialogState createState() => _ElevationDialogState();
}

class _ElevationDialogState extends State<ElevationDialog> {
  late String index;

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

    var elevationcontroller = TextEditingController();
    var degreecontroller = TextEditingController();

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(shrinkWrap: true, children: [
          Center(
            child: Text(
              'GradesType',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          buildTextField('GradesType', elevationcontroller),
          buildTextField('Degree', degreecontroller),
          ElevatedButton(
            child: Text(
              'ADD',
            ),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("elevation")
                  .doc(elevationcontroller.text)
                  .set({
                'elevation': elevationcontroller.text,
                'degree': degreecontroller.text,
                'subject': widget.subject,
              });
              var snapshot;
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ElevationPage(snapshot.data!.docs[index])));
            },
          )
        ]),
      ),
    );
  }
}
