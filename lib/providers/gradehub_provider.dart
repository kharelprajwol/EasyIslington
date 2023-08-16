import 'package:flutter/material.dart';
import '../features/my_grades/models/assessment.dart';
import '../features/my_grades/models/module.dart';
import '../features/my_grades/models/year.dart';
import '../features/my_grades/my_grades_service.dart';

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

  void addYear(Year year) {
    _years.add(year);
    notifyListeners();
  }

  void removeYear(String yearName) {
    _years.removeWhere((year) => year.year == yearName);
    notifyListeners();
  }

  void addModuleForYear(String year, Module module) {
    final yearIndex = _years.indexWhere((y) => y.year == year);
    if (yearIndex != -1) {
      _years[yearIndex].modules.add(module);
      notifyListeners();
    }
  }

  void removeModule(String yearName, String moduleName) {
    final yearIndex = _years.indexWhere((year) => year.year == yearName);
    if (yearIndex != -1) {
      final moduleIndex = _years[yearIndex]
          .modules
          .indexWhere((module) => module.name == moduleName);
      if (moduleIndex != -1) {
        _years[yearIndex].modules.removeAt(moduleIndex);
        notifyListeners();
      }
    }
  }

  void addAssessmentForModule(
      String year, String moduleName, Assessment assessment) {
    final yearIndex = _years.indexWhere((y) => y.year == year);
    if (yearIndex != -1) {
      final moduleIndex =
          _years[yearIndex].modules.indexWhere((m) => m.name == moduleName);
      if (moduleIndex != -1) {
        _years[yearIndex].modules[moduleIndex].assessments.add(assessment);
        notifyListeners();
      }
    }
  }

  void removeAssessmentForModuleAndYear(
      String year, String moduleName, String assessmentName) {
    final yearIndex = _years.indexWhere((y) => y.year == year);
    if (yearIndex != -1) {
      final moduleIndex =
          _years[yearIndex].modules.indexWhere((m) => m.name == moduleName);
      if (moduleIndex != -1) {
        _years[yearIndex]
            .modules[moduleIndex]
            .assessments
            .removeWhere((a) => a.name == assessmentName);
        notifyListeners();
      }
    }
  }

  double calculateYearAverage(String yearName) {
    Year year = years.firstWhere((element) => element.year == yearName);
    if (year.modules.isEmpty) return 0.0;

    double totalWeight = 0.0;
    double weightedSum = 0.0;

    for (Module module in year.modules) {
      double moduleAverage = calculateModuleAverage(yearName, module.name);
      weightedSum += module.credit * moduleAverage;
      totalWeight += module.credit;
    }

    double yearAverage = totalWeight > 0 ? weightedSum / totalWeight : 0.0;
    return yearAverage;
  }

  double calculateModuleAverage(String yearName, String moduleName) {
    Year year = years.firstWhere((element) => element.year == yearName);
    Module module =
        year.modules.firstWhere((element) => element.name == moduleName);

    if (module.assessments.isEmpty) return 0.0;

    double totalWeight = 0.0;
    double weightedSum = 0.0;

    for (Assessment assessment in module.assessments) {
      weightedSum += assessment.weight * assessment.mark;
      totalWeight += assessment.weight;
    }

    double moduleAverage = totalWeight > 0 ? weightedSum / totalWeight : 0.0;
    return moduleAverage;
  }

  void editModuleForYear(String yearName, String originalModuleName,
      String updatedModuleName, int updatedCredit) {
    final yearIndex = _years.indexWhere((year) => year.year == yearName);

    if (yearIndex != -1) {
      // Find the module within the year using the module name
      final moduleIndex = _years[yearIndex]
          .modules
          .indexWhere((module) => module.name == originalModuleName);

      if (moduleIndex != -1) {
        Module existingModule = _years[yearIndex].modules[moduleIndex];
        // Update the module details
        existingModule.name = updatedModuleName;
        existingModule.credit = updatedCredit;

        notifyListeners(); // Notify listeners of the change
      }
    }
  }

  void updateTargetForModule(
      String yearName, String moduleName, int newTarget) {
    final yearIndex = _years.indexWhere((year) => year.year == yearName);

    if (yearIndex != -1) {
      // Find the module within the year using the module name
      final moduleIndex = _years[yearIndex]
          .modules
          .indexWhere((module) => module.name == moduleName);

      if (moduleIndex != -1) {
        // Update the module's target
        _years[yearIndex].modules[moduleIndex].target = newTarget;
        notifyListeners(); // Notify listeners of the change
      }
    }
  }
}
