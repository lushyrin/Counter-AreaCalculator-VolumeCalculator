import 'package:flutter/material.dart';

class AreaCalculatorScreen extends StatefulWidget {
  const AreaCalculatorScreen({Key? key}) : super(key: key);

  @override
  _AreaCalculatorScreenState createState() => _AreaCalculatorScreenState();
}

class _AreaCalculatorScreenState extends State<AreaCalculatorScreen> {
  String _selectedShape = 'Square';
  double _dimension1 = 0;
  double _dimension2 = 0;
  double _area = 0;

  void _calculateArea() {
    setState(() {
      if (_selectedShape == 'Square') {
        _area = _dimension1 * _dimension1;
      } else if (_selectedShape == 'Circle') {
        _area = 3.14159 * _dimension1 * _dimension1;
      } else if (_selectedShape == 'Triangle') {
        _area = 0.5 * _dimension1 * _dimension2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Area Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Shape:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedShape,
              items: ['Square', 'Circle', 'Triangle']
                  .map((shape) => DropdownMenuItem(
                        value: shape,
                        child: Text(shape),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedShape = value!;
                  _dimension1 = 0;
                  _dimension2 = 0;
                  _area = 0;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText:
                    _selectedShape == 'Square' || _selectedShape == 'Circle'
                        ? 'Enter side/radius (cm)'
                        : 'Enter base (cm)',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _dimension1 = double.tryParse(value) ?? 0;
              },
            ),
            if (_selectedShape == 'Triangle') ...[
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter height (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _dimension2 = double.tryParse(value) ?? 0;
                },
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateArea,
              child: const Text('Calculate Area'),
            ),
            const SizedBox(height: 20),
            Text(
              'Area: $_area cm²',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
