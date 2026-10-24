import 'package:flutter/material.dart';

void main() {
  runApp(const ResponsiveUnitConverterApp());
}

class ResponsiveUnitConverterApp extends StatelessWidget {
  const ResponsiveUnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Unit Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ResponsiveHome(),
    );
  }
}

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  final TextEditingController valueController = TextEditingController();

  String category = 'Length';
  String fromUnit = 'Meter';
  String toUnit = 'Kilometer';
  String result = '';

  final Map<String, List<String>> units = {
    'Length': ['Meter', 'Kilometer', 'Centimeter', 'Millimeter'],
    'Weight': ['Kilogram', 'Gram', 'Milligram'],
    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
  };

  // Change conversion category
  void changeCategory(String? value) {
    if (value == null) {
      return;
    }

    setState(() {
      category = value;
      fromUnit = units[category]![0];
      toUnit = units[category]![1];
      result = '';
    });
  }

  // Conversion function
  void convert() {
    double? value = double.tryParse(valueController.text);

    if (value == null) {
      setState(() {
        result = 'Please enter a valid number';
      });
      return;
    }

    double answer = value;

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
        answer = meters;
      } else if (toUnit == 'Kilometer') {
        answer = meters / 1000;
      } else if (toUnit == 'Centimeter') {
        answer = meters * 100;
      } else {
        answer = meters * 1000;
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
        answer = grams / 1000;
      } else if (toUnit == 'Gram') {
        answer = grams;
      } else {
        answer = grams * 1000;
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
        answer = celsius;
      } else if (toUnit == 'Fahrenheit') {
        answer = (celsius * 9 / 5) + 32;
      } else {
        answer = celsius + 273.15;
      }
    }

    setState(() {
      result = '$value $fromUnit = ${answer.toStringAsFixed(2)} $toUnit';
    });
  }

  // Reusable dropdown widget
  Widget unitDropdown(
    String label,
    String value,
    Function(String?) onChanged,
    List<String> currentUnits,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: currentUnits.map((unit) {
        return DropdownMenuItem<String>(value: unit, child: Text(unit));
      }).toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery gets the device screen width
    final double screenWidth = MediaQuery.of(context).size.width;

    final List<String> currentUnits = units[category]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Unit Converter'),
        centerTitle: true,
      ),

      // LayoutBuilder provides available screen size
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 600 px is used as the responsive breakpoint
          final bool isWideScreen = constraints.maxWidth >= 600;

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? 80 : 20,
                vertical: 20,
              ),

              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Responsive icon size
                    Icon(Icons.calculate, size: isWideScreen ? 100 : 70),

                    const SizedBox(height: 20),

                    // Responsive text size
                    Text(
                      'Unit Converter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isWideScreen ? 30 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Display screen width
                    Text(
                      'Screen Width: '
                      '${screenWidth.toStringAsFixed(0)} px',
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    // Category selection
                    DropdownButtonFormField<String>(
                      value: category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: units.keys.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: changeCategory,
                    ),

                    const SizedBox(height: 20),

                    // Value input
                    TextField(
                      controller: valueController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter Value',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Responsive From and To units
                    if (isWideScreen)
                      // Wide screen: Row layout
                      Row(
                        children: [
                          Expanded(
                            child: unitDropdown('From', fromUnit, (value) {
                              setState(() {
                                fromUnit = value!;
                              });
                            }, currentUnits),
                          ),

                          const SizedBox(width: 20),

                          const Icon(Icons.swap_horiz, size: 30),

                          const SizedBox(width: 20),

                          Expanded(
                            child: unitDropdown('To', toUnit, (value) {
                              setState(() {
                                toUnit = value!;
                              });
                            }, currentUnits),
                          ),
                        ],
                      )
                    else
                      // Small screen: Column layout
                      Column(
                        children: [
                          unitDropdown('From', fromUnit, (value) {
                            setState(() {
                              fromUnit = value!;
                            });
                          }, currentUnits),

                          const SizedBox(height: 15),

                          unitDropdown('To', toUnit, (value) {
                            setState(() {
                              toUnit = value!;
                            });
                          }, currentUnits),
                        ],
                      ),

                    const SizedBox(height: 25),

                    // Convert button
                    SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: convert,
                        child: const Text(
                          'CONVERT',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Result container
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
                            result.isEmpty ? 'Result will appear here' : result,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }
}
