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

  double targetPercentage = 0.0;
  TextEditingController _targetPercentageController = TextEditingController();

  bool isValidCredit(int credit) {
    return credit == 15 || credit == 30 || credit == 60;
  }

  void _addModule(String module, int credit) {
    final gradeHubProvider =
        Provider.of<GradeHubProvider>(context, listen: false);
    final newModule = Module(
        id: '',
        name: module,
        credit: credit,
        target: 0,
        average: 0,
        required: 0,
        assessments: []);
    gradeHubProvider.addModuleForYear(widget.year, newModule);

    _addModuleController.clear();
    _addWeightController.clear();
  }

  void _removeModule(String yearName, String moduleName) {
    final gradeHubProvider =
        Provider.of<GradeHubProvider>(context, listen: false);
    gradeHubProvider.removeModule(yearName, moduleName);
  }

  void _editModule(
      String originalModuleName, String updatedModuleName, int updatedCredit) {
    final gradeHubProvider =
        Provider.of<GradeHubProvider>(context, listen: false);
    gradeHubProvider.editModuleForYear(
        widget.year, originalModuleName, updatedModuleName, updatedCredit);

    _editModuleController.clear();
    _editWeightController.clear();
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
    // Assuming you have a method for calculating the module average
    //return gradeHubProvider.calculateModuleAverage(widget.year);
    return 0.0;
  }

  double getRequired(GradeHubProvider gradeHubProvider) {
    double achieved = getAchieved(gradeHubProvider);
    return targetPercentage - achieved;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final gradeHubProvider =
          Provider.of<GradeHubProvider>(context, listen: false);
      final yearData =
          gradeHubProvider.years.firstWhere((year) => year.year == widget.year);

      if (yearData != null) {
        setState(() {
          modules = yearData.modules;
        });
      }
    });
  }

  Future<void> _showEditDialog(Module module) async {
    _editModuleController.text = module.name;
    _editWeightController.text = module.credit.toString();

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit Module'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTextField(
              controller: _editModuleController,
              hintText: 'Module',
              borderColor: Colors.blue,
            ),
            SizedBox(height: 16.0),
            _buildTextField(
              controller: _editWeightController,
              hintText: 'Credit',
              borderColor: Colors.blue,
              isNumber: true,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () {
              int parsedCredit = int.parse(_editWeightController.text);
              if (isValidCredit(parsedCredit)) {
                _editModule(
                    module.name, _editModuleController.text, parsedCredit);
                Navigator.of(ctx).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Invalid credit! Please enter 15, 30, or 60.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modules for ${widget.year}'),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Consumer<GradeHubProvider>(
            builder: (context, gradeHubProvider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  // Add Module Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _addModuleController,
                          hintText: 'Module',
                          borderColor: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: _buildTextField(
                          controller: _addWeightController,
                          hintText: 'Credit',
                          borderColor: Colors.blue,
                          isNumber: true,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          int parsedCredit =
                              int.parse(_addWeightController.text);
                          if (isValidCredit(parsedCredit)) {
                            _addModule(_addModuleController.text, parsedCredit);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Invalid credit! Please enter 15, 30, or 60.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade900),
                        ),
                        icon: Icon(Icons.add, color: Colors.white),
                        label:
                            Text('Add', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  // Modules List
                  ...modules.map((module) {
                    double moduleAverage = gradeHubProvider
                        .calculateModuleAverage(widget.year, module.name);
                    return _buildModuleCard(
                        module, moduleAverage, gradeHubProvider);
                  }),
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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Color borderColor,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }

  Widget _buildModuleCard(
      Module module, double moduleAverage, GradeHubProvider gradeHubProvider) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      elevation: 5.0,
      child: Column(
        children: [
          ListTile(
            title: Text('${module.name} (${module.credit})',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            trailing: Text(moduleAverage.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AssessmentScreen(year: widget.year, module: module.name),
                ),
              );
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () => _showEditDialog(module),
                icon: Icon(Icons.edit, size: 18, color: Colors.white),
                label: Text('Edit', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue.shade900),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _removeModule(widget.year, module.name);
                },
                icon: Icon(Icons.remove_circle_outline,
                    size: 18, color: Colors.white),
                label: Text('Remove', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red.shade900),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
