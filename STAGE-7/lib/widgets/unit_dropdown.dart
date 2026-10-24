import 'package:flutter/material.dart';

class UnitDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> units;
  final ValueChanged<String?> onChanged;

  const UnitDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.units,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      items: units.map((unit) => DropdownMenuItem(value: unit, child: Text(unit))).toList(),
      onChanged: onChanged,
    );
  }
}
