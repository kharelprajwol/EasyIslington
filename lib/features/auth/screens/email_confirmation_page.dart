import 'package:flutter/material.dart';
import 'dart:math';
import '../auth_service.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'signup_screen.dart';

class EmailConfirmationPage extends StatefulWidget {
  @override
  _EmailConfirmationPageState createState() => _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends State<EmailConfirmationPage> {
  bool _isConfirmationCodeVisible = false;
  String? _generatedCode;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _confirmationCodeController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Confirmation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!_isConfirmationCodeVisible)
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your college email',
                  labelText: 'College Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            SizedBox(height: 20),
            if (_isConfirmationCodeVisible)
              TextField(
                controller: _confirmationCodeController,
                decoration: InputDecoration(
                  hintText: 'Enter confirmation code',
                  labelText: 'Confirmation Code',
                ),
                keyboardType: TextInputType.number,
              ),
            SizedBox(height: 20),
            if (!_isConfirmationCodeVisible)
              ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text;
                  if (_isValidEmail(email)) {
                    final result = await _authService.checkEmailExists(
                        context: context, email: email);
                    if (result['status']) {
                      _generatedCode = _generateConfirmationCode();
                      print(_generatedCode);
                      await _sendEmail(email, _generatedCode!);
                      setState(() {
                        _isConfirmationCodeVisible = true;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['message']),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Invalid email. Please enter a valid college email."),
                      ),
                    );
                  }
                },
                child: Text("Next"),
              ),
            if (_isConfirmationCodeVisible)
              ElevatedButton(
                onPressed: () {
                  final code = _confirmationCodeController.text;
                  if (code == _generatedCode) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            SignupScreen(email: _emailController.text)));
                    // Navigate to signup screen
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("Please enter the correct confirmation code."),
                      ),
                    );
                  }
                },
                child: Text("Confirm"),
              ),
          ],
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@islingtoncollege\.edu\.np$");
    return regex.hasMatch(email);
  }

  String _generateConfirmationCode() {
    var rng = Random();
    var code = '';
    for (var i = 0; i < 4; i++) {
      code += rng.nextInt(10).toString();
    }
    return code;
  }

  Future<void> _sendEmail(String email, String code) async {
    print('Sending email to: $email');
    final smtpServer = gmail('xyzkharelp@gmail.com', 'rytomhliapuyeghh');

    final message = Message()
      ..from = Address('xyzkharelp@gmail.com', 'EasyIslington')
      ..recipients.add(email)
      ..subject = 'Your Confirmation Code'
      ..text = '$code';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Message not sent.');
      print('Error: $e');
      if (e is MailerException) {
        for (var p in (e as MailerException).problems) {
          print('Code: ${p.code}');
          print('Msg: ${p.msg}');
          //print('Domain: ${p.domain}');
        }
      }
    }
  }
}
