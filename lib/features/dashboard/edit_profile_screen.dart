import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/student_provider.dart';
import 'dashboard_service.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _yearController = TextEditingController();
  final _semesterController = TextEditingController();
  final _groupController = TextEditingController();

  final DashboardService dashboardService = DashboardService();

  @override
  void initState() {
    super.initState();

    final student =
        Provider.of<StudentProvider>(context, listen: false).student;
    _firstNameController.text = student.firstName;
    _lastNameController.text = student.lastName;
    _emailController.text = student.email;
    _usernameController.text = student.username;
    _specializationController.text = student.specialization;
    _yearController.text = student.year;
    _semesterController.text = student.semester;
    _groupController.text = student.group;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.red.shade900,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('First Name', _firstNameController),
            SizedBox(height: 10),
            _buildTextField('Last Name', _lastNameController),
            SizedBox(height: 10),
            _buildTextField('Email', _emailController, isEditable: false),
            SizedBox(height: 10),
            _buildTextField('Username', _usernameController, isEditable: false),
            SizedBox(height: 10),
            _buildTextField('Specialization', _specializationController),
            SizedBox(height: 10),
            _buildTextField('Year', _yearController),
            SizedBox(height: 10),
            _buildTextField('Semester', _semesterController),
            SizedBox(height: 10),
            _buildTextField('Group', _groupController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await dashboardService.updateStudent(
                  studentId:
                      Provider.of<StudentProvider>(context, listen: false)
                          .student
                          .id,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  username: _usernameController.text,
                  specialization: _specializationController.text,
                  year: _yearController.text,
                  semester: _semesterController.text,
                  group: _groupController.text,
                );

                if (result) {
                  Provider.of<StudentProvider>(context, listen: false)
                      .updateStudentFields(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    username: _usernameController.text,
                    specialization: _specializationController.text,
                    year: _yearController.text,
                    semester: _semesterController.text,
                    group: _groupController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Profile updated successfully!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "Failed to update profile. Please try again.")),
                  );
                }
              },
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isEditable = true}) {
    return TextField(
      controller: controller,
      readOnly: !isEditable,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900, width: 1.5),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900, width: 1.5),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _specializationController.dispose();
    _yearController.dispose();
    _semesterController.dispose();
    _groupController.dispose();
    super.dispose();
  }
}
