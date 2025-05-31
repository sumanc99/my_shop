import 'package:flutter/material.dart';
import 'package:my_shop/screens/saleHistory_screen.dart';
import "package:my_shop/widgets/SectionCard.dart";
import 'package:my_shop/screens/sale_screen.dart';
import 'package:my_shop/screens/dailyRecord_screen.dart';

// Imports for CSV Export
import 'package:hive_flutter/hive_flutter.dart'; // For Hive operations
import 'package:intl/intl.dart'; // For date formatting in CSV
import 'package:my_shop/models/sale.dart'; // Your Sale model
import 'package:my_shop/providers/sale_provider.dart'; // Your SalesProvider
import 'package:provider/provider.dart'; // For Provider
import 'package:csv/csv.dart'; // For CSV conversion
import 'package:share_plus/share_plus.dart'; // For sharing

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // --- CSV Export Logic ---
  Future<void> _exportSalesAsCsvText() async {
    try {
      // 1. Get all sales from Hive Box
      // Ensure the 'sales' box is open before calling this (it's opened in main.dart)
      final salesBox = Hive.box<Sale>('sales');
      final List<Sale> sales = salesBox.values.toList();

      if (sales.isEmpty) {
        if (mounted) { // Check if the widget is still in the tree
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No sales data to export.')),
          );
        }
        return;
      }

      // 2. Prepare data for CSV
      List<List<dynamic>> rows = [];
      // Add CSV headers
      rows.add(['Date', 'Product', 'Quantity', 'Amount']);

      // Add sales data
      for (var sale in sales) {
        final String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(sale.date);
        rows.add([
          formattedDate,
          sale.product,
          _formatQuantityForCsv(sale.qunatity), // Helper for quantity
          sale.amount.toStringAsFixed(2) // Format amount to 2 decimal places
        ]);
      }

      // 3. Convert to CSV string
      String csvText = const ListToCsvConverter().convert(rows);

      // 4. Share the CSV text
      await Share.share(csvText, subject: 'Sales Data Export (CSV)');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sales data exported as text.')),
        );
      }

    } catch (e) {
      print('Error exporting sales data as text: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to export sales data: $e')),
        );
      }
    }
  }

  // Helper to format quantity for CSV (e.g., "1/2" for "0.5")
  String _formatQuantityForCsv(String quantity) {
    if (quantity == "0.5") {
      return "1/2";
    }
    // Try to parse as double and convert to int if it's a whole number
    try {
      double parsedDouble = double.parse(quantity);
      if (parsedDouble == parsedDouble.toInt().toDouble()) {
        return parsedDouble.toInt().toString();
      }
    } catch (_) {
      // If parsing fails, return as is
    }
    return quantity;
  }
  // --- End CSV Export Logic ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share), // Share icon for export
            onPressed: _exportSalesAsCsvText, // Call the export method
            tooltip: 'Export Sales Data as Text',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 30.0,
          childAspectRatio: 1.9,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
                           
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
            // Daily Record
            Sectioncard(
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
            Sectioncard(
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