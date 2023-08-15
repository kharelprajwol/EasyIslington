import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/student_provider.dart';
import 'dashboard_service.dart'; // Make sure to import your service

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DashboardService _dashboardService = DashboardService();

  String _studentId = ''; //
  String _oldPassword = '';
  String _newPassword = '';

  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;

  @override
  void initState() {
    super.initState();
    _studentId =
        Provider.of<StudentProvider>(context, listen: false).student.id;
    _oldPassword =
        Provider.of<StudentProvider>(context, listen: false).student.password;
  }

  void _submit(BuildContext context) async {
    print(_studentId);
    print(_oldPassword);
    bool isOldPasswordValid = await _dashboardService.checkOldPassword(
      studentId: _studentId,
      password: _oldPassword,
    );

    if (isOldPasswordValid && _formKey.currentState!.validate()) {
      bool isUpdated = await _dashboardService.updateStudentPassword(
        studentId: _studentId,
        newPassword: _newPassword,
      );
      if (isUpdated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password changed successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to change password")),
        );
      }
    } else if (!isOldPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Old password is incorrect")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text(
          'Change Password',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontFamily: 'Kalam',
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: _obscureOldPassword,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureOldPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureOldPassword = !_obscureOldPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
                onChanged: (value) {
                  _oldPassword = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
                onChanged: (value) {
                  _newPassword = value;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _submit(context),
                child: Text('Change Password'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
