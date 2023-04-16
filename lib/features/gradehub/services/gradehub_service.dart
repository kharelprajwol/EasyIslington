import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/year.dart';

class GradehubService {
  //final String _baseUrl = 'http://192.168.0.104:3000/api/schedule';

  Future<List<Year>> fetchYears(String studentId) async {
    print("inside service");
    final response = await http.post(
      Uri.parse('http://192.168.0.100:3000/api/marks'),
      body: jsonEncode(<String, String>{'studentId': studentId}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse
          .map((year) => Year.fromMap(year as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load years');
    }
  }
}
