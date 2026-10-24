import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<String> history;
  final VoidCallback onClear;
  const HistoryScreen({super.key, required this.history, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History'),
        actions: [if (history.isNotEmpty) IconButton(tooltip: 'Clear history', onPressed: onClear, icon: const Icon(Icons.delete_outline))],
      ),
      body: history.isEmpty
          ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.history, size: 64, color: Colors.grey),
              SizedBox(height: 12),
              Text('No conversion history'),
            ]))
          : ListView.separated(
              itemCount: history.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.calculate)),
                title: Text(history[index]),
                subtitle: Text('Conversion ${history.length - index}'),
              ),
            ),
    );
  }
}
