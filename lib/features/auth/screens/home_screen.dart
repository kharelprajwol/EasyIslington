import 'package:easy_islington/features/grade_calculator/screens/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/class_schedule_provider.dart';
import '../../../providers/student_provider.dart';
import '../../assesment_schedule/screens/assesment_schedule_screen.dart';

import '../../gradehub/screens/year_screen.dart';
import '../../timetable/models/schedule.dart';
import '../../timetable/screens/schedule_screen.dart';
import '../../timetable/widgets/schedule_tile.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    // Get today's date
    final today = DateFormat('EEEE').format(DateTime.now());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blue.shade900, // set the background color here
              child: Text('Today\'s Classes',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Kalam',
                      fontSize: fontSize,
                    ),
                  )),
            ),
            Consumer<ClassScheduleProvider>(
              builder: (context, classScheduleProvider, child) {
                final schedules = classScheduleProvider.schedules
                    .where((schedule) => schedule.day == today)
                    .toList();
                return schedules.isNotEmpty
                    ? Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: schedules.length,
                          itemBuilder: (context, index) {
                            final schedule = schedules[index];
                            return ScheduleTile(schedule: schedules[index]);
                          },
                        ),
                      )
                    : Text('No classes today');
              },
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blue.shade900, // set the background color here
              child: Text('Upcoming Assessment',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Kalam',
                      fontSize: fontSize,
                    ),
                  )),
            ),
          ],
        ),
      ),
      //body: Center(child: Text("hello")),
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
                        student.email,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      //SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          // Handle the "Update your profile" button press
                        },
                        child: Text(
                          'Update your profile',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ExpansionTile(
              leading: Icon(Icons.grade),
              title: Text(
                'Grades',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontFamily: 'Kalam',
                    fontSize: fontSize,
                  ),
                ),
              ),
              children: [
                ListTile(
                  //leading: Icon(Icons.star),
                  title: Text(
                    'GradeHub',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontFamily: 'Kalam',
                        fontSize: fontSize - 5,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Handle GradeHub button press
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => YearScreen()),
                    );
                  },
                ),
                ListTile(
                  //leading: Icon(Icons.calculate),
                  title: Text(
                    'Grade Calculator',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontFamily: 'Kalam',
                        fontSize: fontSize - 5,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GradeCalculatorPage()),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.schedule),
              title: Text('Schedule',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontFamily: 'Kalam',
                      fontSize: fontSize,
                    ),
                  )),
              children: [
                ListTile(
                  title: Text('Class Schedule',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontFamily: 'Kalam',
                          fontSize: fontSize - 5,
                        ),
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassScheduleScreen()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Assessment Schedule',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontFamily: 'Kalam',
                          fontSize: fontSize - 5,
                        ),
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssessmentScreen()),
                    );
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.forum),
              title: Text('Discussions'),
              onTap: () {
                // Handle Forum button press
                //showDiscussions(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle Settings button press
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
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
