import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/gradehub_provider.dart';
import '../../auth/screens/home_screen.dart';
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

  void _addYear(String year, double weight) {
    setState(() {
      years.add(year);
      yearWeights[year] = weight;
    });
    _addYearController.clear();
    _addWeightController.clear();
  }

  void _removeYear(String year) {
    setState(() {
      years.remove(year);
      yearWeights.remove(year);
    });
  }

  void _editYear(String year) {
    // Set the initial values for the text fields
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
                  // Update the year and weight
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
        title: Text('GradeHub'),
        backgroundColor: Colors.red.shade900,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Padding(
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
                                _addYear(_addYearController.text,
                                    double.parse(_addWeightController.text));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green.shade900),
                              ),
                              child: Text('Add'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        ...gradeHubProvider.years.map(
                          (year) => Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle button press for this year
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ModuleScreen(year: year.year),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.blue.shade900),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${year.year} (${year.weight}%)',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '0',
                                                //'${yearWeights[year]}%', // Display weight here
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Column(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     IconButton(
                                    //       onPressed: () {
                                    //         //_editYear(year);
                                    //       },
                                    //       icon: Icon(Icons.edit),
                                    //       color: Colors.orange.shade700,
                                    //     ),
                                    //     IconButton(
                                    //       onPressed: () {
                                    //         _removeYear(year);
                                    //       },
                                    //       icon: Icon(Icons.remove_circle),
                                    //       color: Colors.red.shade700,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          // _editYear(year);
                                        },
                                        icon: Icon(Icons.edit, size: 18),
                                        label: Text('Edit'),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orange.shade700),
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          // _removeYear(year);
                                        },
                                        icon:
                                            Icon(Icons.remove_circle, size: 18),
                                        label: Text('Remove'),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red.shade700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Call the save function here
                            //saveData();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade900),
                          ),
                          child: Text('Save'),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: Text(
                  'Analysis will be shown here',
                  style: TextStyle(
                    fontSize: 15.0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
