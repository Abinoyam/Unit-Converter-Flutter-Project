import 'package:flutter/material.dart';

void main() => runApp(const AnimationExperimentApp());

class AnimationExperimentApp extends StatelessWidget {
  const AnimationExperimentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 08 - Animations',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const AnimationHomePage(),
    );
  }
}

class AnimationHomePage extends StatefulWidget {
  const AnimationHomePage({super.key});

  @override
  State<AnimationHomePage> createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage> {
  final _input = TextEditingController(text: '100');
  String _from = 'Meters';
  String _to = 'Kilometers';
  double? _result;
  bool _showResult = false;

  final Map<String, double> _metersPerUnit = {
    'Meters': 1,
    'Kilometers': 1000,
    'Centimeters': 0.01,
    'Miles': 1609.344,
  };

  void _convert() {
    final value = double.tryParse(_input.text.trim());
    if (value == null || !value.isFinite) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid number.')),
      );
      return;
    }
    setState(() {
      _result = value * _metersPerUnit[_from]! / _metersPerUnit[_to]!;
      _showResult = true;
    });
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experiment 08: Animations')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.animation, size: 64),
          const SizedBox(height: 12),
          const Text('Animated Unit Converter',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          TextField(
            controller: _input,
            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: const InputDecoration(labelText: 'Value', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _from,
            decoration: const InputDecoration(labelText: 'From', border: OutlineInputBorder()),
            items: _metersPerUnit.keys.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
            onChanged: (v) => setState(() => _from = v!),
          ),
          const SizedBox(height: 12),
          IconButton(
            tooltip: 'Swap units',
            onPressed: () => setState(() { final old = _from; _from = _to; _to = old; }),
            icon: const Icon(Icons.swap_vert, size: 32),
          ),
          DropdownButtonFormField<String>(
            value: _to,
            decoration: const InputDecoration(labelText: 'To', border: OutlineInputBorder()),
            items: _metersPerUnit.keys.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
            onChanged: (v) => setState(() => _to = v!),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(onPressed: _convert, icon: const Icon(Icons.calculate), label: const Text('Convert')),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, .12), end: Offset.zero).animate(animation),
                child: child,
              ),
            ),
            child: _showResult
                ? Card(
                    key: ValueKey('$_result-$_from-$_to'),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(children: [
                        const Text('Converted Result'),
                        const SizedBox(height: 8),
                        Text('${_result!.toStringAsPrecision(7)} $_to',
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  )
                : const Card(
                    key: ValueKey('empty'),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('Your animated result will appear here.', textAlign: TextAlign.center),
                    ),
                  ),
          ),
          const SizedBox(height: 18),
          const Text('Experiment: AnimatedSwitcher transitions the result card when the value changes.',
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
