import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../class_schedule/class_schedule_service.dart';
import '../auth_service.dart';
import '../../dashboard/home_screen.dart';
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;
  AuthService authService = AuthService();

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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void authenticateStudent() {
    print(_usernameController.text);
    print(_passwordController.text);
    setState(() {
      _isLoading = true;
    });
    authService.signinStudent(
        context: context,
        username: _usernameController.text,
        password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double imageSize = screenWidth / 2;
    double textFieldPadding = screenWidth / 20;
    double fontSize = screenWidth > 400 ? 15 : 12;

    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                          controller: _usernameController,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontFamily: 'Kalam',
                              fontSize: fontSize,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Username",
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your username";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
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
                                  if (_formKey.currentState!.validate()) {
                                    authenticateStudent();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade900,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(screenHeight * 0.01),
                                  child: Text(
                                    "Sign In",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontFamily: 'Kalam',
                                        fontSize: fontSize + 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(
                                  email:
                                      'xyzkharelp@gmail.com', // Updated to username
                                ),
                              ),
                            );
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
