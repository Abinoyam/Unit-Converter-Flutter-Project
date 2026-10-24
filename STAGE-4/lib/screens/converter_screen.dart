import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() =>
      _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController valueController =
      TextEditingController();

  String category = 'Length';

  String fromUnit = 'Meter';

  String toUnit = 'Kilometer';

  String result = '';

  final Map<String, List<String>> units = {
    'Length': [
      'Meter',
      'Kilometer',
      'Centimeter',
      'Millimeter',
      'Mile',
      'Foot',
    ],

    'Weight': [
      'Kilogram',
      'Gram',
      'Milligram',
      'Pound',
    ],

    'Temperature': [
      'Celsius',
      'Fahrenheit',
      'Kelvin',
    ],
  };

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  void convert() {
    double? value =
        double.tryParse(valueController.text);

    if (value == null) {
      setState(() {
        result = 'Please enter a valid number';
      });
      return;
    }

    double convertedValue = value;

    // LENGTH
    if (category == 'Length') {
      double meterValue;

      if (fromUnit == 'Meter') {
        meterValue = value;
      } else if (fromUnit == 'Kilometer') {
        meterValue = value * 1000;
      } else if (fromUnit == 'Centimeter') {
        meterValue = value / 100;
      } else if (fromUnit == 'Millimeter') {
        meterValue = value / 1000;
      } else if (fromUnit == 'Mile') {
        meterValue = value * 1609.34;
      } else {
        meterValue = value * 0.3048;
      }

      if (toUnit == 'Meter') {
        convertedValue = meterValue;
      } else if (toUnit == 'Kilometer') {
        convertedValue = meterValue / 1000;
      } else if (toUnit == 'Centimeter') {
        convertedValue = meterValue * 100;
      } else if (toUnit == 'Millimeter') {
        convertedValue = meterValue * 1000;
      } else if (toUnit == 'Mile') {
        convertedValue = meterValue / 1609.34;
      } else {
        convertedValue = meterValue / 0.3048;
      }
    }

    // WEIGHT
    else if (category == 'Weight') {
      double kgValue;

      if (fromUnit == 'Kilogram') {
        kgValue = value;
      } else if (fromUnit == 'Gram') {
        kgValue = value / 1000;
      } else if (fromUnit == 'Milligram') {
        kgValue = value / 1000000;
      } else {
        kgValue = value * 0.453592;
      }

      if (toUnit == 'Kilogram') {
        convertedValue = kgValue;
      } else if (toUnit == 'Gram') {
        convertedValue = kgValue * 1000;
      } else if (toUnit == 'Milligram') {
        convertedValue = kgValue * 1000000;
      } else {
        convertedValue = kgValue / 0.453592;
      }
    }

    // TEMPERATURE
    else if (category == 'Temperature') {
      double celsius;

      if (fromUnit == 'Celsius') {
        celsius = value;
      } else if (fromUnit == 'Fahrenheit') {
        celsius = (value - 32) * 5 / 9;
      } else {
        celsius = value - 273.15;
      }

      if (toUnit == 'Celsius') {
        convertedValue = celsius;
      } else if (toUnit == 'Fahrenheit') {
        convertedValue =
            (celsius * 9 / 5) + 32;
      } else {
        convertedValue =
            celsius + 273.15;
      }
    }

    setState(() {
      result =
          '${value.toString()} $fromUnit = '
          '${convertedValue.toStringAsFixed(4)} $toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentUnits =
        units[category]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [
            const Text(
              'Select Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: category,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),

              items: units.keys.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  category = value!;

                  fromUnit =
                      units[category]!.first;

                  toUnit =
                      units[category]!.length > 1
                          ? units[category]![1]
                          : units[category]!.first;

                  result = '';
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: valueController,

              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: 'Enter Value',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'From',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: fromUnit,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),

              items: currentUnits.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  fromUnit = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'To',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: toUnit,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),

              items: currentUnits.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  toUnit = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: convert,

              icon: const Icon(Icons.swap_horiz),

              label: const Text(
                'Convert',
              ),

              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (result.isNotEmpty)
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      const Text(
                        'Result',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        result,
                        textAlign:
                            TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/history',
                );
              },

              child: const Text(
                'View History',
              ),
            ),
          ],
        ),
      ),
    );
  }
}