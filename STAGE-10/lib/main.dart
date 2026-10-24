import 'package:flutter/material.dart';

void main() => runApp(const TestingExperimentApp());

class TestingExperimentApp extends StatelessWidget {
  const TestingExperimentApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Experiment 10 - Testing & Debugging',
        theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
        home: const TestingHomePage(),
      );
}

double convertLength(double value, String from, String to) {
  const meters = <String, double>{
    'Meters': 1,
    'Kilometers': 1000,
    'Centimeters': 0.01,
    'Miles': 1609.344,
  };
  if (!meters.containsKey(from) || !meters.containsKey(to)) {
    throw ArgumentError('Unsupported unit');
  }
  return value * meters[from]! / meters[to]!;
}

class TestingHomePage extends StatefulWidget {
  const TestingHomePage({super.key});

  @override
  State<TestingHomePage> createState() => _TestingHomePageState();
}

class _TestingHomePageState extends State<TestingHomePage> {
  final _input = TextEditingController(text: '100');
  String _from = 'Meters';
  String _to = 'Kilometers';
  String _result = '0.1 Kilometers';

  void _convert() {
    final value = double.tryParse(_input.text.trim());
    if (value == null || !value.isFinite) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
      return;
    }
    try {
      final converted = convertLength(value, _from, _to);
      setState(() => _result = '${converted.toStringAsPrecision(7)} $_to');
    } on ArgumentError {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unsupported unit')),
      );
    }
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Experiment 10: Testing & Debugging')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(Icons.bug_report_outlined, size: 60),
            const SizedBox(height: 12),
            const Text('Testable Unit Converter',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              key: const Key('valueInput'),
              controller: _input,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(labelText: 'Value', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: const Key('fromUnit'),
              value: _from,
              decoration: const InputDecoration(labelText: 'From', border: OutlineInputBorder()),
              items: ['Meters', 'Kilometers', 'Centimeters', 'Miles']
                  .map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
              onChanged: (v) => setState(() => _from = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: const Key('toUnit'),
              value: _to,
              decoration: const InputDecoration(labelText: 'To', border: OutlineInputBorder()),
              items: ['Meters', 'Kilometers', 'Centimeters', 'Miles']
                  .map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
              onChanged: (v) => setState(() => _to = v!),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _convert, child: const Text('Convert')),
            const SizedBox(height: 16),
            Card(child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const Text('Result'),
                const SizedBox(height: 8),
                Text(_result, key: const Key('resultText'),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ]),
            )),
            const SizedBox(height: 12),
            const Text('Run flutter test in the terminal to execute the unit and widget tests.',
                textAlign: TextAlign.center),
          ],
        ),
      );
}
