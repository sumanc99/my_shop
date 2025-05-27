// include the material package
import 'package:flutter/material.dart';
import "package:my_shop/widgets/SectionCard.dart";
import 'package:my_shop/screens/sale_screen.dart';

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
        child: Column(
          children: [
            // section for sale
            Sectioncard(
              icon: Icons.shopping_bag_outlined,
             text: "Sale", 
             onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SaleScreen()),
                );
              },
             ),
             const SizedBox(height:16.0),
            // Daily Record
            Sectioncard(
              icon: Icons.list,
             text: "Daily Record", 
             onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sale section tapped!')),
                );
              },
             ),
             const SizedBox(height:16.0),
             // section for sale history
            Sectioncard(
              icon: Icons.history,
             text: "Sale History", 
             onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sale section tapped!')),
                );
              },
             ),
             const SizedBox(height:16.0)
          ]
        ),
      )
    );
  }


 
}

  



