import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../LOGIN/login.dart';
import '../chang themebutton.dart';
import '../thembuilder.dart';

import 'Simister1.dart';
import 'Teachers.dart';
import 'UserPRO.dart';
import 'simister.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    return Scaffold(
      drawer: Container(
        width: 180,
        child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              child: ListView(
                children: [
                  Center(
                    child: Text(" $text!",
                        style: GoogleFonts.gloriaHallelujah(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  ChangeThemeButtonWidget(),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'HOME',
                style: GoogleFonts.gloriaHallelujah(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homepage(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                'Teacher',
                style: GoogleFonts.gloriaHallelujah(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherList(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: Colors.white,
              ),
              title: Text('Subject',
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Simis(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.girl,
                color: Colors.white,
              ),
              title: Text('student',
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Simis1(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.admin_panel_settings,
                color: Colors.white,
              ),
              title: Text('Users',
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPRO(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text('LogOut',
                  style: GoogleFonts.gloriaHallelujah(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              onTap: () {
                logout(context);
              },
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        
        title: Text(
          'H O M E',
          style: GoogleFonts.lobster(
            textStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        
        child: Container(
          
          child: GridView(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 200.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserPRO(),
                            ));
                      },
                      child: Column(
                        children: [
                          Image.network(
                            "https://cdn-icons-png.flaticon.com/512/476/476863.png",
                            width: 110,
                          ),
                          Text(
                            "USERS",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 200.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherList(),
                            ));
                      },
                      child: Column(
                        children: [
                          Image.network(
                            "https://cdn-icons-png.flaticon.com/512/1995/1995574.png",
                            width: 100,
                          ),
                          Text(
                            "TEACHERS",
                          )
                        ],
                      ),
                      //
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 200.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Simis1(),
                            ));
                      },
                      child: Column(
                        children: [
                          Image.network(
                            "https://cdn-icons-png.flaticon.com/512/3135/3135810.png",
                            width: 100,
                          ),
                          Text(
                            "STUDENTS",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 200.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Simis(),
                            ));
                      },
                      child: Column(
                        children: [
                          Image.network(
                            "https://cdn-icons-png.flaticon.com/512/2232/2232688.png",
                            width: 100,
                          ),
                          Text(
                            "SUBJECTS",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
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
