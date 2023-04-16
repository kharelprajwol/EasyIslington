import 'package:flutter/material.dart';

import '../features/gradehub/models/year.dart';
import '../features/gradehub/services/gradehub_service.dart';

class GradeHubProvider with ChangeNotifier {
  List<Year> _years = [];

  List<Year> get years => _years;

  Future<void> fetchAndSetYears(String studentId) async {
    try {
      print("inside provider");
      final List<Year> fetchedYears =
          await GradehubService().fetchYears(studentId);
      _years = fetchedYears;
      print(years[1].weight);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
