import 'package:flutter/material.dart';

class showDegree extends StatefulWidget {
  const showDegree({Key? key}) : super(key: key);

  @override
  State<showDegree> createState() => _showDegreeState();
}

class _showDegreeState extends State<showDegree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       

        //  backgroundColor: Color(0xFF4A184C),
        title: Text("show degree"),
        centerTitle: true,
        
      ),
    );
  }
}
