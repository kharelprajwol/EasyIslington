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
  int _moduleRows = 2;
  int _yearRows = 2;

  void _selectModule() {
    setState(() {
      _moduleSelected = true;
      _yearSelected = false;
    });
  }

  void _selectYear() {
    setState(() {
      _yearSelected = true;
      _moduleSelected = false;
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
                onPressed: () {
                  // Add logic for Classification button
                },
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
                ElevatedButton(
                  onPressed: _addModuleRow,
                  child: Text('Add'),
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
                ElevatedButton(
                  onPressed: _addYearRow,
                  child: Text('Add'),
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
}
