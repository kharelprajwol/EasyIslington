import 'package:easy_islington/features/discussions/Screens/discussions_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import '../../../providers/student_provider.dart';
//import '../../assesment_schedule/screens/assesment_schedule_screen.dart';
import '../../gradehub/screens/year_screen.dart';
import '../../timetable/screens/schedule_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/home';

  // Function to load and show the PDF
  Future<void> _displayPdf(BuildContext context) async {
    try {
      final document = await PDFDocument.fromAsset(
          'assets/userManual.pdf'); // Load the PDF from assets

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("User Manual"),
            backgroundColor: Colors.red.shade900,
          ),
          body: PDFViewer(document: document),
        ),
      ));
    } catch (e) {
      print('Error loading PDF: $e'); // Print the error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while loading the PDF.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
              TextButton(
                onPressed: () => _displayPdf(context), // Call the function here
                child: Text(
                  'For detailed instructions, click here.',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
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
                        student.email,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle the "Update your profile" button press
                        },
                        child: Text(
                          'Update profile',
                          style: TextStyle(color: Colors.white, fontSize: 14),
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
