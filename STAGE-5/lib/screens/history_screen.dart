import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/conversion_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConversionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History'),

        actions: [
          if (provider.history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),

              onPressed: () {
                provider.clearHistory();
              },
            ),
        ],
      ),

      body: provider.history.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(Icons.history, size: 80),

                  SizedBox(height: 15),

                  Text('No conversion history', style: TextStyle(fontSize: 20)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),

              itemCount: provider.history.length,

              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.swap_horiz)),

                    title: Text(provider.history[index]),

                    subtitle: Text('Conversion ${index + 1}'),
                  ),
                );
              },
            ),
    );
  }
}
