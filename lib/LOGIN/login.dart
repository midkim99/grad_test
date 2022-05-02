import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_test/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _style = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.teal[500],
    fontSize: 60,
  );
  var uid = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Image.asset('assets/logo.png', height: 150),
                        Card(
                         
                          child: ListView(
                            padding: EdgeInsets.all(10),
                            shrinkWrap: true,
                            children: [
                              Center(
                                child: Text("Login",
                                    style:
                                        GoogleFonts.lobster(textStyle: _style)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: 'ex..@garmian.edu.krd',
                                  helperText: 'Example@garmian.edu.krd',
                                  prefixIcon: Icon(
                                    Icons.email,
                                  ),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(15),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.length == 0) {
                                    return "please Enter valid Email";
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@+garmian+.edu+.krd")
                                      .hasMatch(value)) {
                                    return ("Please enter a valid email");
                                  } else if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Please create an account");
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  emailController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: _isObscure3,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.key,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure3
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure3 = !_isObscure3;
                                        });
                                      }),
                                  hintText: 'Password',
                                  helperText: 'Enter your password',
                                ),
                                validator: (value) {
                                  RegExp regex = new RegExp(r'^.{6,}$');
                                  if (value!.isEmpty) {
                                    return "Password cannot be empty";
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return ("please enter valid password min. 6 character");
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              ElevatedButton(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      visible = true;
                                    });
                                    signIn(
                                        emailController.text,
                                        passwordController.text);
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .whenComplete(() {
          User? user = FirebaseAuth.instance.currentUser;
          setState(() {
            uid = user!.uid;
          });
        }).whenComplete(() {
          setValues();
        }).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyApp(),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  void setValues() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();

    sharedpref.setString('email', emailController.text);
    sharedpref.setString('uid', '$uid');
    print(
        "////////////////////////////////////////////////////////////////////////");
    print('Setvalue ...Setvalue.');
    print(
        "////////////////////////////////////////////////////////////////////////");
  }
}
