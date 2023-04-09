import 'package:flutter/material.dart';

class GradeCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grade Calculator')),
      body: GradeCalculator(),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Calculate for'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _selectModule,
                child: Text('Module'),
              ),
              ElevatedButton(
                onPressed: _selectYear,
                child: Text('Year'),
              ),
              ElevatedButton(
                onPressed: _selectClassification,
                child: Text('Classification'),
              ),
            ],
          ),
          if (_moduleSelected)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Coursework'),
                    Text('Weight(%)'),
                    Text('Marks'),
                  ],
                ),
                for (int i = 0; i < _moduleRows; i++) buildModuleRow(i),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Target'),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Enter value'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _addModuleRow,
                      child: Text('Add'),
                    ),
                    ElevatedButton(
                      onPressed: _removeModuleRow,
                      child: Text('Remove'),
                    ),
                  ],
                ),
              ],
            ),
          if (_yearSelected)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Module Name'),
                    Text('Credit'),
                    Text('Marks'),
                  ],
                ),
                for (int i = 0; i < _yearRows; i++) buildYearRow(i),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Target'),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Enter value'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _addYearRow,
                      child: Text('Add'),
                    ),
                    ElevatedButton(
                      onPressed: _removeYearRow,
                      child: Text('Remove'),
                    ),
                  ],
                ),
              ],
            ),
          if (_classificationSelected)
            Column(
              children: [
                for (int i = 0; i < _classificationRows; i++)
                  buildClassificationRow(i),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Target'),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Enter value'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _addClassificationRow,
                      child: Text('Add'),
                    ),
                    ElevatedButton(
                      onPressed: _removeClassificationRow,
                      child: Text('Remove'),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Row buildModuleRow(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Coursework $i'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Weight(%)'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Marks'),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Row buildYearRow(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Module Name $i'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Credit'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Marks'),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Row buildClassificationRow(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Year ${i + 1}'),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(labelText: 'Enter value'),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
