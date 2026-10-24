import 'package:flutter/material.dart';
import '../widgets/converter_card.dart';
import '../widgets/unit_dropdown.dart';

class ConverterScreen extends StatefulWidget {
  final ValueChanged<String> onConverted;
  const ConverterScreen({super.key, required this.onConverted});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _category = 'Length';
  String _from = 'Meter';
  String _to = 'Kilometer';
  String? _result;

  final Map<String, List<String>> _units = {
    'Length': ['Meter', 'Kilometer', 'Centimeter', 'Millimeter'],
    'Weight': ['Kilogram', 'Gram', 'Milligram', 'Pound'],
    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
  };

  double _convert(double value) {
    if (_category == 'Length') {
      const factors = {'Meter': 1.0, 'Kilometer': 1000.0, 'Centimeter': 0.01, 'Millimeter': 0.001};
      return value * factors[_from]! / factors[_to]!;
    }
    if (_category == 'Weight') {
      const factors = {'Kilogram': 1.0, 'Gram': 0.001, 'Milligram': 0.000001, 'Pound': 0.45359237};
      return value * factors[_from]! / factors[_to]!;
    }
    double celsius;
    if (_from == 'Celsius') {
      celsius = value;
    } else if (_from == 'Fahrenheit') {
      celsius = (value - 32) * 5 / 9;
    } else {
      celsius = value - 273.15;
    }
    if (_to == 'Celsius') return celsius;
    if (_to == 'Fahrenheit') return celsius * 9 / 5 + 32;
    return celsius + 273.15;
  }

  String _format(double value) {
    if (value.abs() < 0.00000001 && value != 0) return value.toStringAsExponential(4);
    if (value == value.roundToDouble()) return value.toInt().toString();
    return value.toStringAsPrecision(8).replaceFirst(RegExp(r'\.?0+$'), '');
  }

  String? _validateInput(String? text) {
    if (text == null || text.trim().isEmpty) return 'Please enter a value.';
    final value = double.tryParse(text.trim());
    if (value == null || !value.isFinite) return 'Enter a valid number.';
    if (_category == 'Temperature') {
      if (_from == 'Kelvin' && value < 0) return 'Kelvin cannot be below absolute zero (0 K).';
      if (_from == 'Celsius' && value < -273.15) return 'Celsius cannot be below -273.15 °C.';
      if (_from == 'Fahrenheit' && value < -459.67) return 'Fahrenheit cannot be below -459.67 °F.';
    }
    return null;
  }

  void _changeCategory(String? value) {
    if (value == null) return;
    setState(() {
      _category = value;
      _from = _units[value]!.first;
      _to = _units[value]![1];
      _result = null;
    });
  }

  void _convertNow() {
    if (!_formKey.currentState!.validate()) return;
    final value = double.parse(_controller.text.trim());
    final answer = _convert(value);
    setState(() => _result = '${_format(value)} $_from = ${_format(answer)} $_to');
    widget.onConverted(_result!);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final units = _units[_category]!;
    return Scaffold(
      appBar: AppBar(title: const Text('Converter')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _units.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: _changeCategory,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controller,
              validator: _validateInput,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(labelText: 'Enter value', border: OutlineInputBorder(), prefixIcon: Icon(Icons.edit)),
            ),
            const SizedBox(height: 16),
            UnitDropdown(label: 'From', value: _from, units: units,
              onChanged: (v) => setState(() { _from = v!; _result = null; })),
            const SizedBox(height: 12),
            Center(
              child: IconButton.filledTonal(
                tooltip: 'Swap units',
                onPressed: () => setState(() { final old = _from; _from = _to; _to = old; _result = null; }),
                icon: const Icon(Icons.swap_vert),
              ),
            ),
            const SizedBox(height: 12),
            UnitDropdown(label: 'To', value: _to, units: units,
              onChanged: (v) => setState(() { _to = v!; _result = null; })),
            const SizedBox(height: 20),
            FilledButton.icon(onPressed: _convertNow, icon: const Icon(Icons.calculate), label: const Text('Convert')),
            if (_result != null) ...[
              const SizedBox(height: 20),
              ConverterCard(title: 'Result', value: _result!),
            ],
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/history'),
              icon: const Icon(Icons.history), label: const Text('View Conversion History'),
            ),
          ],
        ),
      ),
    );
  }
}
