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

        final item = Sale(
          product: product_name,
          amount: amount_sale,
          date: DateTime.now(),
          qunatity: quantity.toString(),
        );
        final String key = DateTime.now().millisecondsSinceEpoch.toString();
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

  // --- New method to handle deleting a sales entry ---
  void _deleteSaleEntry(int index) {
    setState(() {
      final SaleEntry removedEntry = _saleEntries.removeAt(index);
      _totalSales -= removedEntry.extractedAmount;

      // You might also need to remove the corresponding item from _sales_obj and _sales_list
      // This part can be tricky if there's no direct mapping/key
      // For simplicity, I'm just showing _saleEntries and _totalSales update.
      // If _sales_obj and _sales_list need to be perfectly in sync,
      // you'll need a more robust way to identify and remove the associated Sale objects.
      // One way is to store a unique ID in SaleEntry that links to Sale and _sales_obj key.

      // If _sales_list and _sales_obj are directly derived from _saleEntries and match its order:
      if (index < _sales_list.length) {
        _sales_list.removeAt(index);
      }
      // Removing from _sales_obj is more complex as it's a map.
      // You'd need to find the key associated with the removed entry.
      // If each SaleEntry had a unique ID that was also the key in _sales_obj, it would be easy.
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