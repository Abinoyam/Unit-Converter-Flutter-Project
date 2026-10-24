import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter'), centerTitle: true),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),

              child: Text(
                'Unit Converter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),

              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),

            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Converter'),

              onTap: () {
                Navigator.pushNamed(context, '/converter');
              },
            ),

            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),

              onTap: () {
                Navigator.pushNamed(context, '/history');
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),

              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Icon(Icons.swap_horiz, size: 90, color: Colors.blue),

            const SizedBox(height: 20),

            const Text(
              'Unit Converter',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/converter');
              },

              child: const Text('Start Converting'),
            ),
          ],
        ),
      ),
    );
  }
}
