import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/gradehub_provider.dart';
import '../models/module.dart';
import '../models/year.dart';
import 'assessment_screen.dart';

class ModuleScreen extends StatefulWidget {
  final String year;

  ModuleScreen({required this.year});

  @override
  _ModuleScreenState createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  List<Module> modules = [];

  TextEditingController _addModuleController = TextEditingController();
  TextEditingController _addWeightController = TextEditingController();
  TextEditingController _editModuleController = TextEditingController();
  TextEditingController _editWeightController = TextEditingController();

  // void _addModule(String module, double weight) {
  //   setState(() {
  //     modules.add(module);
  //     moduleWeights[module] = weight;
  //   });
  //   _addModuleController.clear();
  //   _addWeightController.clear();
  // }

  // void _removeModule(String module) {
  //   setState(() {
  //     modules.remove(module);
  //     moduleWeights.remove(module);
  //   });
  // }

  // void _editModule(String module) {
  //   // Set the initial values for the text fields
  //   _editModuleController.text = module;
  //   _editWeightController.text = moduleWeights[module].toString();

  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Edit Module'),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: _editModuleController,
  //                 decoration: InputDecoration(
  //                   hintText: 'Module',
  //                 ),
  //               ),
  //               SizedBox(height: 16.0),
  //               TextField(
  //                 controller: _editWeightController,
  //                 keyboardType: TextInputType.number,
  //                 decoration: InputDecoration(
  //                   hintText: 'Credit',
  //                 ),
  //               ),
  //             ],
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('Cancel'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             TextButton(
  //               child: Text('Save'),
  //               onPressed: () {
  //                 // Update the module and weight
  //                 String newModule = _editModuleController.text;
  //                 double newWeight = double.parse(_editWeightController.text);
  //                 setState(() {
  //                   modules.remove(module);
  //                   modules.add(newModule);
  //                   moduleWeights[newModule] = newWeight;
  //                 });
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final gradeHubProvider =
          Provider.of<GradeHubProvider>(context, listen: false);
      final yearData =
          gradeHubProvider.years.firstWhere((year) => year.year == widget.year);

      if (yearData != null) {
        // Assuming the yearData has a list of modules with their names and weights
        setState(() {
          modules = yearData.modules;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modules for ${widget.year}'),
        backgroundColor: Colors.red.shade900,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _addModuleController,
                              decoration: InputDecoration(
                                hintText: 'Module',
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
                                hintText: 'Credit',
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
                              // _addModule(_addModuleController.text,
                              //     double.parse(_addWeightController.text));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green.shade900),
                            ),
                            child: Text('Add'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ...modules.map(
                      (module) => Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle button press for this module
                                      // For example, navigate to another screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AssessmentScreen(
                                                  year: widget.year,
                                                  module: module.name),
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
                                              '${module.name} (${module.credit})',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '0',
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
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      //_editModule(module);
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
                                      //_removeModule(module);
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
        ),
      ),
    );
  }
}
