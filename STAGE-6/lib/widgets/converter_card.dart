import 'package:flutter/material.dart';

class ConverterCard extends StatelessWidget {
  final String title;
  final String value;
  const ConverterCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SelectableText(value, style: Theme.of(context).textTheme.titleLarge),
        ]),
      ),
    );
  }
}
