import 'package:flutter/material.dart';
import 'Subject.dart';
import 'homescreen.dart';

class Simis extends StatefulWidget {
  const Simis({Key? key}) : super(key: key);

  @override
  _SimisState createState() => _SimisState();
}

class _SimisState extends State<Simis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Semester",
        ),
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
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/logo.png"), fit: BoxFit.contain)),
        alignment: Alignment.center,
        margin: EdgeInsets.all(40.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Subject(semester: index + 1),
                        ));
                  },
                  child: Text(
                    "Semester ${index + 1}",
                  ),
                ),
              ]);
            }),
      ),
    );
  }
}
