import 'package:easy_islington/features/class_schedule/class_schedule_service.dart';
import 'package:easy_islington/features/dashboard/edit_profile_screen.dart';
import 'package:easy_islington/features/discussions/Screens/discussions_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/student_provider.dart';
//import '../../assesment_schedule/screens/assesment_schedule_screen.dart';
import '../class_schedule/class_schedule_screen.dart';
import '../my_grades/screens/year_screen.dart';
//import '../../class_schedule/screens/schedule_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth > 400 ? 20 : 15;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontFamily: 'Kalam',
                fontSize: fontSize + 10,
              ),
            )),
        backgroundColor: Colors.red.shade900,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 80,
                color: Colors.red.shade900,
              ),
              SizedBox(height: 20),
              Text(
                'Use the drawer to access features and functionalities.',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: fontSize + 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Consumer<StudentProvider>(
              builder: (context, studentProvider, child) {
                final student = studentProvider.student;
                return DrawerHeader(
                  decoration: BoxDecoration(color: Colors.red.shade900),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        student.username,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileScreen()),
                          );
                        },
                        child: Text(
                          'Edit Profile',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kalam',
                              fontSize: fontSize - 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.grade),
              title: Text(
                'My Grades',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontFamily: 'Kalam',
                    fontSize: fontSize,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => YearScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text(
                'Class Schedule',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontFamily: 'Kalam',
                    fontSize: fontSize,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClassScheduleScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.forum),
              title: Text(
                'Discussions',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontFamily: 'Kalam',
                    fontSize: fontSize,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForumScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock_open),
              title: Text(
                'Change Password',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontFamily: 'Kalam',
                    fontSize: fontSize - 5,
                  ),
                ),
              ),
              onTap: () {
                // Handle the tap action for "Change Password"
                // You can navigate to a ChangePasswordScreen or show a dialog
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontFamily: 'Kalam',
                    fontSize: fontSize - 5,
                  ),
                ),
              ),
              onTap: () {
                // Handle Logout button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
