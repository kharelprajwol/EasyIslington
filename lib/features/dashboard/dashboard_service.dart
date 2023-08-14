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
}
