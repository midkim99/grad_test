import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_test/ADMIN/homescreen.dart';
import 'package:grad_test/StudentHome/studentmain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LOGIN/login.dart';
import 'TeacherHome/teacher.dart';
import 'package:provider/provider.dart';
import 'thembuilder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var uid = '';
  var role = '';
  var email = '';
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final _style = TextStyle(
          color: Colors.white,
          fontSize: 18,
        );
        final _styleDi = TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 22,
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
              primaryIconTheme: IconThemeData(color: Colors.amber),
              appBarTheme: AppBarTheme(
                centerTitle: true,
                titleTextStyle: GoogleFonts.paytoneOne(
                  textStyle: _style,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.amber[400],
                  elevation: 8,
                  focusColor: Colors.teal),
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: Colors.teal[50],
              accentColor: Colors.amber,
              dialogTheme: DialogTheme(
                  titleTextStyle: GoogleFonts.paytoneOne(textStyle: _styleDi)),
              dialogBackgroundColor: Colors.teal[50],
              drawerTheme: DrawerThemeData(
                elevation: 50,
                backgroundColor: Colors.amber[400],
              ),
              errorColor: Colors.red,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13), // <-- Radius
                      ),
                      elevation: 8,
                      shadowColor: Colors.brown,
                      primary: Colors.teal[500],
                      textStyle: GoogleFonts.paytoneOne(textStyle: _style))),
              focusColor: Colors.red,
              hintColor: Colors.teal,
              iconTheme: IconThemeData(color: Colors.white, size: 20),
              inputDecorationTheme: InputDecorationTheme(
                iconColor: Colors.teal,
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              cardTheme: CardTheme(
                elevation: 18,
                shadowColor: Colors.brown[800],
                margin: EdgeInsets.all(10),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.brown,
                    )),
              ),
              cardColor: Colors.white),
          darkTheme: MyThemes.darkTheme,
          home: rout(),
        );
      });

  rout() {
    if (role == 'student') {
      return StudentMain();
    }
    if (role == 'teacher') {
      return teacher();
    }
    if (role == 'admin') {
      return homepage();
    } else {
      return LoginPage();
    }
  }

  getValue() async {
    print('get value fiunction');
    SharedPreferences sharedprefs = await SharedPreferences.getInstance();
    setState(() {
      uid = sharedprefs.getString('uid')!;
    });

    DocumentSnapshot userdoc = await ref.doc(uid).get();
    setState(() {
      email = userdoc.get('email');
      role = userdoc.get('role');
    });
    print("////////////////////");
    print(email);
    print(role);
    print("////////////////////");
  }
}

fet() async {}
Future<void> logout(BuildContext context) async {
  CircularProgressIndicator();
  await FirebaseAuth.instance.signOut();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.getKeys();
  for (String key in preferences.getKeys()) {
    preferences.remove(key);
  }
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
}
