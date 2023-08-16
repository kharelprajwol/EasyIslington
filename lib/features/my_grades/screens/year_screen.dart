import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/gradehub_provider.dart';
import '../../dashboard/home_screen.dart';
import '../models/year.dart';
import 'module_screen.dart';

class YearScreen extends StatefulWidget {
  @override
  _YearScreenState createState() => _YearScreenState();
}

class _YearScreenState extends State<YearScreen> {
  List<String> years = [];
  Map<String, double> yearWeights = {};
  double targetPercentage = 0.0;

  TextEditingController _addYearController = TextEditingController();
  TextEditingController _addWeightController = TextEditingController();
  TextEditingController _editYearController = TextEditingController();
  TextEditingController _editWeightController = TextEditingController();
  TextEditingController _targetPercentageController = TextEditingController();

  void _addYear(String year, int weight) {
    final gradeHubProvider =
        Provider.of<GradeHubProvider>(context, listen: false);

    // 1. Check if there are already 3 years.
    if (gradeHubProvider.years.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can add only up to 3 years.')),
      );
      return;
    }

    // 2. Check if the total weight exceeds 100 with the new weight.
    int totalWeight = weight;
    for (var y in gradeHubProvider.years) {
      totalWeight += y.weight;
    }
    if (totalWeight > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Total weight should not exceed 100%')),
      );
      return;
    }

    // If both checks pass, then add the new year.
    final newYear = Year(id: '', year: year, weight: weight, modules: []);
    gradeHubProvider.addYear(newYear);
    _addYearController.clear();
    _addWeightController.clear();
  }

  void _removeYear(String year) {
    final gradeHubProvider =
        Provider.of<GradeHubProvider>(context, listen: false);
    gradeHubProvider.removeYear(year);
  }

  void _editYear(String year) {
    _editYearController.text = year;
    _editWeightController.text = yearWeights[year].toString();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Year'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _editYearController,
                  decoration: InputDecoration(
                    hintText: 'Year',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _editWeightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Weight %',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  String newYear = _editYearController.text;
                  double newWeight = double.parse(_editWeightController.text);
                  setState(() {
                    years.remove(year);
                    years.add(newYear);
                    yearWeights[newYear] = newWeight;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _updateTargetPercentage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Target Percentage'),
          content: TextField(
            controller: _targetPercentageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter Target %',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  targetPercentage =
                      double.parse(_targetPercentageController.text);
                });
                _targetPercentageController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double getAchieved(GradeHubProvider gradeHubProvider) {
    double totalAchieved = 0.0;

    for (var year in gradeHubProvider.years) {
      double yearAverage = gradeHubProvider.calculateYearAverage(year.year);
      totalAchieved += (yearAverage * year.weight) / 100;
    }

    return totalAchieved;
  }

  double getRequired(GradeHubProvider gradeHubProvider) {
    double achieved = getAchieved(gradeHubProvider);
    return targetPercentage - achieved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Years'),
        backgroundColor: Colors.red.shade900,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Target: ${targetPercentage.toStringAsFixed(1)} %",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    if (targetPercentage == 0.0)
                      ElevatedButton(
                        onPressed: _updateTargetPercentage,
                        child: Text('Add'),
                      )
                    else
                      ElevatedButton(
                        onPressed: _updateTargetPercentage,
                        child: Text('Edit'),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<GradeHubProvider>(
                  builder: (context, gradeHubProvider, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: _addYearController,
                                decoration: InputDecoration(
                                  hintText: 'Year',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: TextField(
                                controller: _addWeightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Weight %',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                try {
                                  int weight =
                                      int.parse(_addWeightController.text);
                                  _addYear(_addYearController.text, weight);
                                } catch (e) {
                                  if (e is FormatException) {
                                    // Handle the exception for non-integer values
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Please enter a valid weight value.'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else {
                                    // Handle other potential exceptions
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('An error occurred: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue.shade900),
                              ),
                              child: Text('Add'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        ...gradeHubProvider.years.map(
                          (year) {
                            double yearAverage = gradeHubProvider
                                .calculateYearAverage(year.year);
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ModuleScreen(year: year.year),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                          '${year.year} (${year.weight}%)',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        trailing: Text(
                                          yearAverage.toStringAsFixed(1),
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            _editYear(year.year);
                                          },
                                          icon: Icon(Icons.edit, size: 18),
                                          label: Text('Edit'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Colors.blue.shade900),
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            _removeYear(year.year);
                                          },
                                          icon: Icon(Icons.remove_circle,
                                              size: 18),
                                          label: Text('Remove'),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red.shade700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<GradeHubProvider>(
                  builder: (context, gradeHubProvider, _) {
                    double achieved = getAchieved(gradeHubProvider);
                    double required = getRequired(gradeHubProvider);

                    return Column(
                      children: [
                        Text(
                          "Achieved: ${achieved.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (targetPercentage != 0.0)
                          Text(
                            "Required: ${required.isNegative ? 0.0 : required.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
