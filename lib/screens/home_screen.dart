// include the material package
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNavigationCard(
              context,
              icon: Icons.point_of_sale,
              title: 'Sale',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlaceholderScreen(title: 'Sale'),
                  ),
                );
              },
            ),
            _buildNavigationCard(
              context,
              icon: Icons.today,
              title: 'Daily Record',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlaceholderScreen(title: 'Daily Record'),
                  ),
                );
              },
            ),
            _buildNavigationCard(
              context,
              icon: Icons.history,
              title: 'Sales History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlaceholderScreen(title: 'Sales History'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // /// ✅ Include this method inside _MyHomePageState:
  // Widget _buildNavigationCard(
  //     BuildContext context, {
  //     required IconData icon,
  //     required String title,
  //     required VoidCallback onTap,
  //   }) {
  //   return Card(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     elevation: 4,
  //     margin: const EdgeInsets.symmetric(vertical: 8),
  //     child: ListTile(
  //       leading: Icon(icon, color: Theme.of(context).primaryColor),
  //       title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
  //       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
  //       onTap: onTap,
  //     ),
  //   );

  Widget _buildNavigationCard(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon inside circle
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Icon(icon, size: 32, color: Colors.black),
          ),
          const SizedBox(height: 12),
          // Title text
          Text(
            title.toLowerCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

  
}




class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title Screen')),
    );
  }
}
