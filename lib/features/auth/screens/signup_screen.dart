import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../auth_service.dart';

class SignupScreen extends StatefulWidget {
  final String email;

  SignupScreen({Key? key, required this.email}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _obscureText = true;

  List<String> specializations = [
    'BSc (Hons) Computing',
    'BSc (Hons) Computer Networking',
    'BSc (Hons) Multimedia Technologies'
  ];
  var _selectedSpecialisation = null;

  List<int> years = [1, 2, 3];
  int? _selectedYear;

  bool _isFirstSemesterSelected = false;
  bool _isSecondSemesterSelected = false;

  List<String> sections = ['C12', 'C15'];
  var _selectedSection;

  AuthService authService = AuthService();

  @override
  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_handleTextChange);
    _lastNameController.addListener(_handleTextChange);
    _passwordController.addListener(_handleTextChange);

    // Extracting the username part from the email
    _usernameController.text = widget.email.split('@').first;
  }

  void _handleTextChange() {
    setState(() {});
  }

  void addStudent() {
    authService.signupStudent(
        context: context,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        username: _usernameController.text,
        email: widget.email,
        password: _passwordController.text,
        specialization: _selectedSpecialisation,
        year: _selectedYear.toString(),
        semester: "1",
        group: _selectedSection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: TextEditingController(text: widget.email),
                    keyboardType: TextInputType.emailAddress,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _usernameController,
                    enabled: false, // This makes it non-editable
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedSpecialisation,
                    items: specializations
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Specialisation',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedSpecialisation = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your specialisation';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Year'),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: years.length,
                    itemBuilder: (BuildContext context, int index) {
                      final year = years[index];

                      return Row(
                        children: <Widget>[
                          //Text('Year'),
                          Text('$year'),
                          Checkbox(
                            value: _selectedYear == year,
                            onChanged: (value) {
                              setState(() {
                                _selectedYear = value == true ? year : null;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Semester: '),
                      Text('1st'),
                      Checkbox(
                        value: _isFirstSemesterSelected,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isFirstSemesterSelected = newValue!;
                            _isSecondSemesterSelected = !newValue;
                          });
                        },
                      ),
                      Text('2nd'),
                      Checkbox(
                        value: _isSecondSemesterSelected,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isFirstSemesterSelected = !newValue!;
                            _isSecondSemesterSelected = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedSection,
                    decoration: InputDecoration(
                      labelText: 'Section',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedSection = value;
                      });
                    },
                    items: sections.map<DropdownMenuItem<String>>((section) {
                      return DropdownMenuItem<String>(
                        value: section,
                        child: Text(section),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your section';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addStudent();
                      }
                    },
                    child: Text('Finish Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
