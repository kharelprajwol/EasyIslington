import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/gradehub_provider.dart';
import '../../auth/screens/home_screen.dart';
import '../models/year.dart';
import 'module_screen.dart';

class YearScreen extends StatefulWidget {
  @override
  _YearScreenState createState() => _YearScreenState();
}

class _YearScreenState extends State<YearScreen> {
  List<String> years = [];
  Map<String, double> yearWeights = {};

  TextEditingController _addYearController = TextEditingController();
  TextEditingController _addWeightController = TextEditingController();
  TextEditingController _editYearController = TextEditingController();
  TextEditingController _editWeightController = TextEditingController();

  void _addYear(String year, int weight) {
    if (weight > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Weight should not exceed 100%')),
      );
      return;
    }

    final gradeHubProvider =
        Provider.of<GradeHubProvider>(context, listen: false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
        ),
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
                                  hintText: 'Add year',
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
                                _addYear(
                                  _addYearController.text,
                                  int.parse(_addWeightController.text),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
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
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      trailing: Text(
                                        yearAverage.toStringAsFixed(1),
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
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
                                                    Color>(Colors.blue),
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
            ],
          ),
        ),
      ),
    );
  }
}
