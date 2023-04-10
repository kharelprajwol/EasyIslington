import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradeCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grade Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GradeCalculator(),
      ),
    );
  }
}

class GradeCalculator extends StatefulWidget {
  @override
  _GradeCalculatorState createState() => _GradeCalculatorState();
}

class _GradeCalculatorState extends State<GradeCalculator> {
  bool _moduleSelected = false;
  bool _yearSelected = false;
  bool _classificationSelected = false;
  int _moduleRows = 2;
  int _yearRows = 2;
  int _classificationRows = 2;
  double _moduleResult = 75.0;
  double _yearResult = 0.0;
  double _classificationResult = 0.0;

  List<TextEditingController> _moduleCourseworkControllers = [];
  List<TextEditingController> _moduleWeightControllers = [];
  List<TextEditingController> _moduleMarkControllers = [];

  List<TextEditingController> _yearModuleControllers = [];
  List<TextEditingController> _yearCreditControllers = [];
  List<TextEditingController> _yearMarkControllers = [];

  List<TextEditingController> _classificationYearMarkControllers = [];
  List<TextEditingController> _classificationWeightControllers = [];

  void _selectModule() {
    setState(() {
      _moduleSelected = true;
      _yearSelected = false;
      _classificationSelected = false;
    });
  }

  void _selectYear() {
    setState(() {
      _yearSelected = true;
      _moduleSelected = false;
      _classificationSelected = false;
    });
  }

  void _selectClassification() {
    setState(() {
      _classificationSelected = true;
      _moduleSelected = false;
      _yearSelected = false;
    });
  }

  void _addModuleRow() {
    setState(() {
      _moduleRows += 1;
    });
  }

  void _addYearRow() {
    setState(() {
      _yearRows += 1;
    });
  }

  void _addClassificationRow() {
    setState(() {
      _classificationRows += 1;
    });
  }

  void _removeModuleRow() {
    setState(() {
      _moduleRows = _moduleRows > 0 ? _moduleRows - 1 : 0;
    });
  }

  void _removeYearRow() {
    setState(() {
      _yearRows = _yearRows > 0 ? _yearRows - 1 : 0;
    });
  }

  void _removeClassificationRow() {
    setState(() {
      _classificationRows =
          _classificationRows > 0 ? _classificationRows - 1 : 0;
    });
  }

  void _calculate() {
    // Add your calculation logic here
  }

  void _clear() {
    // Clear module text controllers
    for (final controller in _moduleCourseworkControllers) {
      controller.clear();
    }
    for (final controller in _moduleWeightControllers) {
      controller.clear();
    }
    for (final controller in _moduleMarkControllers) {
      controller.clear();
    }

    // Clear year text controllers
    for (final controller in _yearModuleControllers) {
      controller.clear();
    }
    for (final controller in _yearCreditControllers) {
      controller.clear();
    }
    for (final controller in _yearMarkControllers) {
      controller.clear();
    }

    // Clear classification text controllers
    for (final controller in _classificationWeightControllers) {
      controller.clear();
    }
    for (final controller in _classificationYearMarkControllers) {
      controller.clear();
    }

    // Clear any other TextField controllers, if applicable
  }

  @override
  void initState() {
    super.initState();
    _selectModule();
  }

  @override
  void dispose() {
    _moduleCourseworkControllers.forEach((controller) => controller.dispose());
    _moduleWeightControllers.forEach((controller) => controller.dispose());
    _moduleMarkControllers.forEach((controller) => controller.dispose());

    _yearModuleControllers.forEach((controller) => controller.dispose());
    _yearCreditControllers.forEach((controller) => controller.dispose());
    _yearMarkControllers.forEach((controller) => controller.dispose());

    _classificationYearMarkControllers
        .forEach((controller) => controller.dispose());
    _classificationWeightControllers
        .forEach((controller) => controller.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Calculate for',
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontFamily: 'Kalam',
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _selectModule,
                        child: Text(
                          'Module',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontFamily: 'Kalam',
                              fontSize: 19,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: _moduleSelected
                              ? Colors.green.shade900
                              : Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              topRight: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _selectYear,
                        child: Text(
                          'Year',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontFamily: 'Kalam',
                              fontSize: 19,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: _yearSelected
                              ? Colors.green.shade900
                              : Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _selectClassification,
                        child: Text(
                          'Classification',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontFamily: 'Kalam',
                              fontSize: 19,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: _classificationSelected
                              ? Colors.green.shade900
                              : Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                if (_moduleSelected)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // children: [
                        //   Text('Coursework'),
                        //   Text('Weight(%)'),
                        //   Text('Mark'),
                        // ],
                      ),
                      //for (int i = 1; i < _moduleRows + 1; i++) buildModuleRow(i),
                      for (int i = 1; i < _moduleRows + 1; i++)
                        Column(
                          children: [
                            buildModuleRow(i),
                            if (i != _moduleRows)
                              SizedBox(
                                  height:
                                      10), // Add space between rows, except the last one
                          ],
                        ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Target Mark',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildButtons(
                          _addModuleRow, _removeModuleRow, _calculate, _clear),
                    ],
                  ),
                if (_yearSelected)
                  Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   // children: [
                      //   //   Text('Module'),
                      //   //   Text('Credit'),
                      //   //   Text('Mark'),
                      //   // ],
                      // ),

                      //for (int i = 1; i < _yearRows + 1; i++) buildYearRow(i),
                      for (int i = 1; i < _yearRows + 1; i++)
                        Column(
                          children: [
                            buildYearRow(i),
                            if (i != _yearRows) SizedBox(height: 10),
                          ],
                        ),
                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Target Mark',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildButtons(
                          _addYearRow, _removeYearRow, _calculate, _clear),
                    ],
                  ),
                if (_classificationSelected)
                  Column(
                    children: [
                      //for (int i = 0; i < _classificationRows; i++) buildClassificationRow(i),
                      for (int i = 0; i < _classificationRows; i++)
                        Column(
                          children: [
                            buildClassificationRow(i),
                            if (i != _classificationRows - 1)
                              SizedBox(height: 10),
                          ],
                        ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Target Mark',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildButtons(_addClassificationRow,
                          _removeClassificationRow, _calculate, _clear),
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Result will appear here'),
          SizedBox(
            height: 10,
          ),
          if (_moduleResult > 0.0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your average mark:',
                  style: TextStyle(fontSize: 25, color: Colors.green.shade900),
                ),
                Text(
                  'Your grade:',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.green.shade900,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Row buildModuleRow(int i) {
    if (_moduleCourseworkControllers.length < i) {
      _moduleCourseworkControllers.add(TextEditingController());
      _moduleWeightControllers.add(TextEditingController());
      _moduleMarkControllers.add(TextEditingController());
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //SizedBox(width: 10),
        Expanded(
          flex: 2, // Give the first TextField twice the width of the others
          child: TextField(
            controller: _moduleCourseworkControllers[i - 1],
            decoration: InputDecoration(
              labelText: 'Coursework $i',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2, // The other two TextFields will have the default width
          child: TextField(
            controller: _moduleWeightControllers[i - 1],
            decoration: InputDecoration(
              labelText: 'Weight(%)',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1, // The other two TextFields will have the default width
          child: TextField(
            controller: _moduleMarkControllers[i - 1],
            decoration: InputDecoration(
              labelText: 'Mark',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        //SizedBox(width: 10),
      ],
    );
  }

  Row buildYearRow(int i) {
    // Create TextEditingController instances for this row if they do not exist
    if (_yearModuleControllers.length < i) {
      _yearModuleControllers.add(TextEditingController());
      _yearCreditControllers.add(TextEditingController());
      _yearMarkControllers.add(TextEditingController());
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ...
        // Assign controllers to the corresponding TextFields
        Expanded(
          child: TextField(
            controller: _yearModuleControllers[i - 1],
            decoration: InputDecoration(
              labelText: 'Module $i',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _yearCreditControllers[i - 1],
            decoration: InputDecoration(
              labelText: 'Credit',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _yearMarkControllers[i - 1],
            decoration: InputDecoration(
              labelText: 'Mark',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // ...
      ],
    );
  }

  Row buildClassificationRow(int i) {
    // Create TextEditingController instances for this row if they do not exist
    if (_classificationYearMarkControllers.length < i + 1) {
      _classificationYearMarkControllers.add(TextEditingController());
      _classificationWeightControllers.add(TextEditingController());
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: TextField(
            controller: _classificationYearMarkControllers[i],
            decoration: InputDecoration(
              labelText: 'Year ${i + 1} Mark',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _classificationWeightControllers[i],
            decoration: InputDecoration(
              labelText: 'Weight(%)',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Column buildButtons(VoidCallback onAdd, VoidCallback onRemove,
      VoidCallback onClear, VoidCallback onCalculate) {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: onAdd,
              child: Row(
                children: [
                  Icon(Icons.add), // Add icon
                  SizedBox(width: 5), // Add some space between icon and text
                  Text('Add'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
            ),
            SizedBox(width: 10), // Add some space between buttons
            ElevatedButton(
              onPressed: onRemove,
              child: Row(
                children: [
                  Icon(Icons.remove), // Add icon
                  SizedBox(width: 5), // Add some space between icon and text
                  Text('Remove'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
            ),
            SizedBox(width: 10), // Add some space between buttons
            ElevatedButton(
              onPressed: _clear,
              child: Row(
                children: [
                  Icon(Icons.clear), // Add icon
                  SizedBox(width: 5), // Add some space between icon and text
                  Text('Clear'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
            ),
          ],
        ),
        SizedBox(height: 5), // Add some space between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: onCalculate,
              child: Row(
                children: [
                  Icon(Icons.calculate), // Add icon
                  SizedBox(width: 5), // Add some space between icon and text
                  Text('Calculate'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
