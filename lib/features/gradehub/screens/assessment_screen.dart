import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/gradehub_provider.dart';
import '../models/assessment.dart';

class AssessmentScreen extends StatefulWidget {
  final String year;
  final String module;

  AssessmentScreen({required this.year, required this.module});

  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  List<Assessment> assessments = [];
  // final List<String> assessments = [];
  // Map<String, int> enteredMarks = {};
  // Map<String, double> enteredWeights = {};

  TextEditingController _addAssessmentController = TextEditingController();
  TextEditingController _addMarkController = TextEditingController();
  TextEditingController _addWeightController = TextEditingController();
  TextEditingController _editAssessmentController = TextEditingController();
  TextEditingController _editWeightController = TextEditingController();
  TextEditingController _editMarkController = TextEditingController();

  void _addAssessment(
      String assessmentName, int assessmentMark, int assessmentWeight) {
    final gradeHubProvider =
        Provider.of<GradeHubProvider>(context, listen: false);
    final newAssessment = Assessment(
        id: '',
        name: assessmentName,
        weight: assessmentWeight,
        mark:
            assessmentMark); // create a new Year object with the provided data
    gradeHubProvider.addAssessmentForModule(
        widget.year, widget.module, newAssessment);

    _addAssessmentController.clear();
    _addMarkController.clear();
    _addWeightController.clear();
  }

  void _removeAssessment(
      String year, String moduleName, String assessmentName) {
    final gradeHubProvider =
        Provider.of<GradeHubProvider>(context, listen: false);
    gradeHubProvider.removeAssessmentForModuleAndYear(
        year, moduleName, assessmentName);
  }

  // void _editAssessment(String assessment) {
  //   // Set the initial values for the text fields
  //   _editAssessmentController.text = assessment;
  //   _editWeightController.text = enteredWeights[assessment].toString();
  //   _editMarkController.text = enteredMarks[assessment].toString();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Edit Assessment'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: _editAssessmentController,
  //               decoration: InputDecoration(
  //                 hintText: 'Assessment',
  //               ),
  //             ),
  //             SizedBox(height: 16.0),
  //             TextField(
  //               controller: _editWeightController,
  //               keyboardType: TextInputType.number,
  //               decoration: InputDecoration(
  //                 hintText: 'Weight',
  //               ),
  //             ),
  //             SizedBox(height: 16.0),
  //             TextField(
  //               controller: _editMarkController,
  //               keyboardType: TextInputType.number,
  //               decoration: InputDecoration(
  //                 hintText: 'Mark',
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Save'),
  //             onPressed: () {
  //               // Update the assessment, weight, and mark
  //               String newAssessment = _editAssessmentController.text;
  //               double newWeight = double.parse(_editWeightController.text);
  //               int newMark = int.parse(_editMarkController.text);

  //               setState(() {
  //                 assessments.remove(assessment);
  //                 assessments.add(newAssessment);
  //                 enteredWeights[newAssessment] = newWeight;
  //                 enteredMarks[newAssessment] = newMark;
  //               });

  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    print('hello');
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final gradeHubProvider =
          Provider.of<GradeHubProvider>(context, listen: false);
      final yearData =
          gradeHubProvider.years.firstWhere((year) => year.year == widget.year);

      if (yearData != null) {
        final moduleData = yearData.modules
            .firstWhere((module) => module.name == widget.module);
        if (moduleData != null) {
          setState(() {
            assessments = moduleData.assessments;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.module),
        backgroundColor: Colors.red.shade900,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<GradeHubProvider>(
              builder: (context, gradeHubProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _addAssessmentController,
                        decoration: InputDecoration(
                          hintText: 'Assessment',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _addWeightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Weight',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _addMarkController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Mark',
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
                        _addAssessment(
                            _addAssessmentController.text,
                            int.parse(_addMarkController.text),
                            int.parse(_addWeightController.text));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green.shade800),
                      ),
                      child: Text('Add'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ...assessments.map((assessment) => Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: null,
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
                                            '${assessment.name} (${assessment.weight}%)',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            '${assessment.mark}',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // _editAssessment(assessment);
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
                                    _removeAssessment(widget.year,
                                        widget.module, assessment.name);
                                  },
                                  icon: Icon(Icons.remove_circle, size: 18),
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
                    )),
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
            );
          }),
        ),
      ),
    );
  }
}
