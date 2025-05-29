// lib/screens/home_page.dart (or wherever MyHomePage is)
import 'package:flutter/material.dart';
import 'package:my_shop/screens/saleHistory_screen.dart';
import "package:my_shop/widgets/SectionCard.dart";
import 'package:my_shop/screens/sale_screen.dart';
import 'package:my_shop/screens/dailyRecord_screen.dart';

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
        padding: const EdgeInsets.all(13.0),
        // Use GridView.count or GridView.builder
        child: GridView.count(
          crossAxisCount: 1, // One item per row (since they're full width)
          mainAxisSpacing: 30.0, // Vertical spacing between cards
          childAspectRatio: 1.9, // Adjust this ratio to control card height relative to width
          shrinkWrap: true, // Important: Allows GridView to take only the space it needs
          physics: const NeverScrollableScrollPhysics(), // If you don't want it to scroll internally

                           
          children: [
            // section for sale
            Sectioncard( // Sectioncard here should NOT return Expanded internally
              icon: Icons.shopping_bag_outlined,
              text: "Sale",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SaleScreen()),
                );
              },
            ),
            // Daily Record
            Sectioncard( // Sectioncard here should NOT return Expanded internally
              icon: Icons.list,
              text: "Daily Record",
              onTap: () {
                final date = DateTime.now();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DailyRecordView(selectedDate: date,)),
                );
              },
            ),
            // section for sale history
            Sectioncard( // Sectioncard here should NOT return Expanded internally
              icon: Icons.history,
              text: "Sale History",
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SaleHistoryView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}