import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/conversion_provider.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController valueController = TextEditingController();

  String category = 'Length';

  String fromUnit = 'Meter';

  String toUnit = 'Kilometer';

  String result = '';

  final Map<String, List<String>> units = {
    'Length': ['Meter', 'Kilometer', 'Centimeter', 'Millimeter'],

    'Weight': ['Kilogram', 'Gram', 'Milligram', 'Pound'],

    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
  };

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  void convert() {
    final double? value = double.tryParse(valueController.text);

    if (value == null) {
      setState(() {
        result = 'Please enter a valid number';
      });

      return;
    }

    double convertedValue = value;

    // Length
    if (category == 'Length') {
      if (fromUnit == 'Meter' && toUnit == 'Kilometer') {
        convertedValue = value / 1000;
      } else if (fromUnit == 'Kilometer' && toUnit == 'Meter') {
        convertedValue = value * 1000;
      } else if (fromUnit == 'Meter' && toUnit == 'Centimeter') {
        convertedValue = value * 100;
      } else if (fromUnit == 'Centimeter' && toUnit == 'Meter') {
        convertedValue = value / 100;
      } else if (fromUnit == 'Meter' && toUnit == 'Millimeter') {
        convertedValue = value * 1000;
      } else if (fromUnit == 'Millimeter' && toUnit == 'Meter') {
        convertedValue = value / 1000;
      }
    }
    // Weight
    else if (category == 'Weight') {
      if (fromUnit == 'Kilogram' && toUnit == 'Gram') {
        convertedValue = value * 1000;
      } else if (fromUnit == 'Gram' && toUnit == 'Kilogram') {
        convertedValue = value / 1000;
      } else if (fromUnit == 'Kilogram' && toUnit == 'Milligram') {
        convertedValue = value * 1000000;
      } else if (fromUnit == 'Milligram' && toUnit == 'Kilogram') {
        convertedValue = value / 1000000;
      }
    }
    // Temperature
    else if (category == 'Temperature') {
      if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
        convertedValue = (value * 9 / 5) + 32;
      } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
        convertedValue = (value - 32) * 5 / 9;
      } else if (fromUnit == 'Celsius' && toUnit == 'Kelvin') {
        convertedValue = value + 273.15;
      } else if (fromUnit == 'Kelvin' && toUnit == 'Celsius') {
        convertedValue = value - 273.15;
      }
    }

    final conversion =
        '${value.toString()} $fromUnit = '
        '${convertedValue.toStringAsFixed(2)} $toUnit';

    setState(() {
      result = conversion;
    });

    // Provider
    Provider.of<ConversionProvider>(
      context,
      listen: false,
    ).addConversion(conversion);
  }

  @override
  Widget build(BuildContext context) {
    final currentUnits = units[category]!;

    return Scaffold(
      appBar: AppBar(title: const Text('Converter')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            DropdownButtonFormField<String>(
              value: category,

              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),

              items: units.keys.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  category = value!;

                  fromUnit = units[category]!.first;

                  toUnit = units[category]!.length > 1
                      ? units[category]![1]
                      : units[category]!.first;

                  result = '';
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: valueController,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: 'Enter Value',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: fromUnit,

              decoration: const InputDecoration(
                labelText: 'From Unit',
                border: OutlineInputBorder(),
              ),

              items: currentUnits.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  fromUnit = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: toUnit,

              decoration: const InputDecoration(
                labelText: 'To Unit',
                border: OutlineInputBorder(),
              ),

              items: currentUnits.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  toUnit = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            ElevatedButton(onPressed: convert, child: const Text('Convert')),

            const SizedBox(height: 25),

            if (result.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Text(
                    result,
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },

              child: const Text('View Conversion History'),
            ),
          ],
        ),
      ),
    );
  }
}
