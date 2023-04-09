import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_frontend/auth/screens/confirmation_screen.dart';
import '../../timetable/services/schedule_service.dart';
import '../services/signin_service.dart';
import 'home_screen.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void authenticateStudent() {
    signinStudent(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void showSchedule(BuildContext context) {
    getSchedule(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("EasyIslington",
      //       style: GoogleFonts.openSans(
      //         textStyle: TextStyle(
      //           fontFamily: 'Kalam',
      //           fontSize: 30,
      //         ),
      //       )),
      //   backgroundColor: Colors.red.shade900,
      // ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 250,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontFamily: 'Kalam',
                        fontSize: 15,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _emailController.text = value;
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        _passwordController.text = value;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password navigation
                          // You can navigate to the forgot password page using Navigator.push() method
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.green.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              authenticateStudent();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade900,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Sign In",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontFamily: 'Kalam',
                                    fontSize: 25,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement sign up navigation
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SignUpPage(),
                      //   ),
                      // );
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
