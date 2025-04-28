import 'package:flutter/material.dart';

class VolumeCalculatorScreen extends StatefulWidget {
  const VolumeCalculatorScreen({Key? key}) : super(key: key);

  @override
  _VolumeCalculatorScreenState createState() => _VolumeCalculatorScreenState();
}

class _VolumeCalculatorScreenState extends State<VolumeCalculatorScreen> {
  String _selectedShape = 'Rectangular Prism';
  double _dimension1 = 0;
  double _dimension2 = 0;
  double _dimension3 = 0;
  double _volume = 0;

  void _calculateVolume() {
    setState(() {
      if (_selectedShape == 'Rectangular Prism') {
        _volume =
            _dimension1 * _dimension2 * _dimension3; // length * width * height
      } else if (_selectedShape == 'Pyramid') {
        _volume = (1 / 3) *
            _dimension1 *
            _dimension2 *
            _dimension3; // 1/3 * base area * height
      } else if (_selectedShape == 'Cylinder') {
        _volume = 3.14159 * _dimension1 * _dimension1 * _dimension2; // πr²h
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Volume Calculator'),
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
              items: ['Rectangular Prism', 'Pyramid', 'Cylinder']
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
                  _dimension3 = 0;
                  _volume = 0;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: _selectedShape == 'Cylinder'
                    ? 'Enter radius (cm)'
                    : 'Enter length/base (cm)',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _dimension1 = double.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: _selectedShape == 'Cylinder'
                    ? 'Enter height (cm)'
                    : 'Enter width (cm)',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _dimension2 = double.tryParse(value) ?? 0;
              },
            ),
            if (_selectedShape != 'Cylinder') ...[
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter height (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _dimension3 = double.tryParse(value) ?? 0;
                },
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateVolume,
              child: const Text('Calculate Volume'),
            ),
            const SizedBox(height: 20),
            Text(
              'Volume: $_volume cm³',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
