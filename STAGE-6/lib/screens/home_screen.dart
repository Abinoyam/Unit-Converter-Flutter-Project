import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool darkMode;
  const HomeScreen({super.key, required this.onToggleTheme, required this.darkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        actions: [
          IconButton(
            tooltip: darkMode ? 'Switch to light theme' : 'Switch to dark theme',
            onPressed: onToggleTheme,
            icon: Icon(darkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Align(alignment: Alignment.bottomLeft, child: Text('Unit Converter', style: TextStyle(color: Colors.white, fontSize: 24))),
          ),
          ListTile(leading: const Icon(Icons.home), title: const Text('Home'), onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/'); }),
          ListTile(leading: const Icon(Icons.swap_horiz), title: const Text('Converter'), onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/converter'); }),
          ListTile(leading: const Icon(Icons.history), title: const Text('History'), onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/history'); }),
          ListTile(leading: const Icon(Icons.info), title: const Text('About'), onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/about'); }),
        ]),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.swap_horiz, size: 90, color: Colors.blue),
            const SizedBox(height: 16),
            const Text('Unit Converter', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Convert length, weight, and temperature with ease.', textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton.icon(onPressed: () => Navigator.pushNamed(context, '/converter'), icon: const Icon(Icons.arrow_forward), label: const Text('Start Converting')),
          ]),
        ),
      ),
    );
  }
}
