// screens/sales_screen.dart (your current parent widget)
import 'package:flutter/material.dart';
import 'package:my_shop/widgets/SalechatList.dart';
import 'package:my_shop/models/sales_entry.dart';
import 'package:my_shop/widgets/SalechatTotal.dart';
import 'package:my_shop/widgets/SaleinputField.dart';
import 'package:my_shop/utils/input_parser.dart';
import 'package:my_shop/screens/salesReceipt_screen.dart';
// import 'package:provider/provider';
import 'package:my_shop/models/sale.dart';
import 'package:my_shop/providers/sale_provider.dart';
import 'package:provider/provider.dart';


class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<SaleEntry> _saleEntries = [];
  final Map<dynamic, Sale> _sales_obj = {};
  final List<Sale> _sales_list = [];
  double _totalSales = 0.0;

  // --- Text Parsing Logic (Simple Example) ---
  void _processSaleEntry(String text) {
    double amount = 0.0;
    final input = text.trim();
    if (input.isEmpty) {
      Showbox(context, "Provide Input");
      return;
    }

    if (!isValidPurchaseLine(input)) {
      Showbox(context, "Invalid Input");
      return;
    } else {
      final productDetails = extract_product_info(input);
      try {
        final product_name = productDetails?["item"];
        final quantity = productDetails?["quantity"];
        final double price = productDetails?["price"];
        final double amount_sale = price * quantity;
        amount = amount_sale;

        final String key = DateTime.now().millisecondsSinceEpoch.toString();

        final item = Sale(
          product: product_name,
          amount: amount_sale,
          date: DateTime.now(),
          quantity: quantity.toString(),
        );

        _sales_obj[key] = item;
        _sales_list.add(item);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not understand the amount. Please enter a valid number!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    setState(() {
      final val = SaleEntry(rawText: text, extractedAmount: amount);
      _saleEntries.add(val);
      _totalSales += amount;
      _textEditingController.clear();
    });
  }

void _deleteSaleEntry(int index) {
  setState(() {
    // Check if index is valid for _saleEntries
    if (index >= 0 && index < _saleEntries.length) {
      // Remove from _saleEntries and update total
      final SaleEntry removedEntry = _saleEntries.removeAt(index);
      _totalSales -= removedEntry.extractedAmount;

      // Remove from _sales_list if index is valid
      if (index >= 0 && index < _sales_list.length) {
        final Sale removedSale = _sales_list.removeAt(index);

        // Remove from _sales_obj by finding the matching Sale object
        final String? keyToRemove = _sales_obj.keys.firstWhere(
          (key) => _sales_obj[key] == removedSale,
          orElse: () => null,
        );
        if (keyToRemove != null) {
          _sales_obj.remove(keyToRemove);
        }
      }
    }
  });
}
  void _resetEntries() {
    setState(() {
      _saleEntries.clear();
      _sales_obj.clear();
      _sales_list.clear(); // Clear the sales list as well
      _totalSales = 0.0;
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale Chat"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetEntries,
            tooltip: 'Reset Sales',
          ),
        ],
      ),
      body: Column(
        children: [
          // Pass the onDeleteEntry callback to Salechatlist
          Salechatlist(
            entries: _saleEntries,
            onDeleteEntry: _deleteSaleEntry, // Pass the new delete method
          ),
          Salechattotal(totalSales: _totalSales),

          if (_sales_obj.isNotEmpty)
            GestureDetector(
              onTap: () async {
                final date = DateTime.now();
                await context.read<SalesProvider>().addSales(_sales_obj);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SalesReceiptView(transactionDate: date, transactionSales: _sales_list),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.done_all_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          Saleinputfield(
            controller: _textEditingController,
            onSubmit: _processSaleEntry,
          ),
        ],
      ),
    );
  }
}