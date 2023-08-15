import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {
  final String _baseUrl = 'http://192.168.0.107:3000/api';

  Future<bool> updateStudent({
    required String studentId,
    required String firstName,
    required String lastName,
    required String email,
    required String specialization,
    required String year,
    required String semester,
    required String group,
    required String username,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/update-student/$studentId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'username': username,
          'specialization': specialization,
          'year': year,
          'semester': semester,
          'group': group,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error updating student: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error in updateStudent: $error');
      return false;
    }
  }

  Future<bool> checkOldPassword({
    required String studentId,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/check-old-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'studentID': studentId,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        if (responseBody.containsKey('isValid') &&
            responseBody['isValid'] == true) {
          return true;
        }
        // If 'isValid' exists but is false or doesn't exist at all
        print('Error checking old password: ${response.body}');
        return false;
      } else {
        print('Server responded with ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error in checkOldPassword: $error');
      return false;
    }
  }

  Future<bool> updateStudentPassword({
    required String studentId,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/update-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'studentId': studentId,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200 &&
          json.decode(response.body)['success'] == true) {
        return true;
      } else {
        print('Error updating password: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error in updateStudentPassword: $error');
      return false;
    }
  }
}
