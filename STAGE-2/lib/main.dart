
import 'package:flutter/material.dart';

void main() {
  runApp(const UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UnitConverterHome(),
    );
  }
}

class UnitConverterHome extends StatefulWidget {
  const UnitConverterHome({super.key});

  @override
  State<UnitConverterHome> createState() => _UnitConverterHomeState();
}

class _UnitConverterHomeState extends State<UnitConverterHome> {
  final TextEditingController valueController = TextEditingController();

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
    ],
    'Weight': [
      'Kilogram',
      'Gram',
      'Milligram',
    ],
    'Temperature': [
      'Celsius',
      'Fahrenheit',
      'Kelvin',
    ],
  };

  void changeCategory(String? newCategory) {
    if (newCategory == null) return;

    setState(() {
      category = newCategory;
      fromUnit = units[category]![0];
      toUnit = units[category]![1];
      result = '';
    });
  }

  void convert() {
    double? value = double.tryParse(valueController.text);

    if (value == null) {
      setState(() {
        result = 'Please enter a valid number';
      });
      return;
    }

    double convertedValue = value;

    // Length conversion
    if (category == 'Length') {
      double meters;

      if (fromUnit == 'Meter') {
        meters = value;
      } else if (fromUnit == 'Kilometer') {
        meters = value * 1000;
      } else if (fromUnit == 'Centimeter') {
        meters = value / 100;
      } else {
        meters = value / 1000;
      }

      if (toUnit == 'Meter') {
        convertedValue = meters;
      } else if (toUnit == 'Kilometer') {
        convertedValue = meters / 1000;
      } else if (toUnit == 'Centimeter') {
        convertedValue = meters * 100;
      } else {
        convertedValue = meters * 1000;
      }
    }

    // Weight conversion
    else if (category == 'Weight') {
      double grams;

      if (fromUnit == 'Kilogram') {
        grams = value * 1000;
      } else if (fromUnit == 'Gram') {
        grams = value;
      } else {
        grams = value / 1000;
      }

      if (toUnit == 'Kilogram') {
        convertedValue = grams / 1000;
      } else if (toUnit == 'Gram') {
        convertedValue = grams;
      } else {
        convertedValue = grams * 1000;
      }
    }

    // Temperature conversion
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
        convertedValue = (celsius * 9 / 5) + 32;
      } else {
        convertedValue = celsius + 273.15;
      }
    }

    setState(() {
      result =
          '$value $fromUnit = ${convertedValue.toStringAsFixed(2)} $toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentUnits = units[category]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Stack demonstrates Stack widget
            SizedBox(
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade100,
                    ),
                  ),
                  const Icon(
                    Icons.calculate,
                    size: 60,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Select Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Category',
              ),
              items: units.keys.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: changeCategory,
            ),

            const SizedBox(height: 20),

            const Text(
              'Enter Value',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter value',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Row demonstrates Row widget
            Row(
              children: [

                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: fromUnit,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                    items: currentUnits.map((String item) {
                      return DropdownMenuItem<String>(
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
                ),

                const SizedBox(width: 10),

                const Icon(
                  Icons.arrow_forward,
                  size: 30,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: toUnit,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                    items: currentUnits.map((String item) {
                      return DropdownMenuItem<String>(
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
                ),
              ],
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: convert,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'CONVERT',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                children: [

                  const Text(
                    'Result',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    result.isEmpty
                        ? 'Result will appear here'
                        : result,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}