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

  void _clear() {}

  @override
  void initState() {
    super.initState();
    _selectModule();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
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
                            labelText: 'Target Mark (optional)',
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
                            labelText: 'Target Mark (optional)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildButtons(_addYearRow, _removeYearRow, _calculate, _clear),
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
                        if (i != _classificationRows - 1) SizedBox(height: 10),
                      ],
                    ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Target Mark (optional)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildButtons(_addClassificationRow, _removeClassificationRow,
                      _calculate, _clear),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Row buildModuleRow(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //SizedBox(width: 10),
        Expanded(
          flex: 2, // Give the first TextField twice the width of the others
          child: TextField(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Module $i',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Credit',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
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

  Row buildClassificationRow(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Year ${i + 1} Mark',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
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
            ),
            SizedBox(width: 10), // Add some space between buttons
            ElevatedButton(
              onPressed: onClear,
              child: Row(
                children: [
                  Icon(Icons.clear), // Add icon
                  SizedBox(width: 5), // Add some space between icon and text
                  Text('Clear'),
                ],
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
            ),
          ],
        ),
      ],
    );
  }
}
