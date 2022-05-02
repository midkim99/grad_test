import 'package:flutter/material.dart';
import 'Students.dart';
import 'homescreen.dart';

class Simis1 extends StatefulWidget {
  const Simis1({Key? key}) : super(key: key);

  @override
  _Simis1State createState() => _Simis1State();
}

class _Simis1State extends State<Simis1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Semesters",
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
                          builder: (context) => Student(semester: index + 1),
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
