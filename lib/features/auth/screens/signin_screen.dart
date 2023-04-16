import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../timetable/services/schedule_service.dart';
import '../services/signin_service.dart';
import 'home_screen.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double imageSize = screenWidth / 2;
    double textFieldPadding = screenWidth / 20;
    double fontSize = screenWidth > 400 ? 15 : 12;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(textFieldPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: imageSize,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  TextFormField(
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontFamily: 'Kalam',
                        fontSize: fontSize,
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
                  SizedBox(height: screenHeight * 0.02),
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
                  SizedBox(height: screenHeight * 0.025),
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
                            padding: EdgeInsets.all(screenHeight * 0.01),
                            child: Text("Sign In",
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontFamily: 'Kalam',
                                    fontSize: fontSize + 10,
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
// context,
// MaterialPageRoute(
// builder: (context) => SignUpPage(),
// ),
// );
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: fontSize,
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
