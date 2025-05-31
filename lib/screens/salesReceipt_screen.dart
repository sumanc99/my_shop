import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/models/sale.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

class SalesReceiptView extends StatefulWidget {
  final List<Sale> transactionSales;
  final DateTime transactionDate;

  const SalesReceiptView({
    super.key,
    required this.transactionSales,
    required this.transactionDate,
  });

  @override
  State<SalesReceiptView> createState() => _SalesReceiptViewState();
}

class _SalesReceiptViewState extends State<SalesReceiptView> {
  final ScreenshotController _screenshotController = ScreenshotController();

  double _calculateTotalAmount() {
    return widget.transactionSales.fold(0.0, (sum, item) => sum + item.amount);
  }

  String half_checker(String input) {
    if (input == "0.5") {
      return "1/2";
    }
    return input;
  }

  String formatQuantity(String input) {
    if (input == "1/2") {
      return "1/2";
    }
    double parsedDouble = double.parse(input);
    return parsedDouble.toInt().toString();
  }

  Future<void> _shareReceiptAsImage(BuildContext context) async {
    try {
      // Capture the content directly, not just the visible part of a scrollable view.
      final Uint8List? uint8List = await _screenshotController.capture();

      if (uint8List != null) {
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/receipt.png').create();
        await file.writeAsBytes(uint8List);

        await Share.shareXFiles([XFile(file.path)], text: 'Here is your sales receipt!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not capture receipt image.')),
        );
      }
    } catch (e) {
      print('Error sharing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing receipt: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm a');
    final String currentLocale = Localizations.localeOf(context).toString();
    final NumberFormat decimalFormatter = NumberFormat.decimalPattern(currentLocale);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Receipt'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView( // This SingleChildScrollView is for the user to scroll
        child: Screenshot( // The Screenshot widget now wraps the actual content (Column)
          controller: _screenshotController,
          child: Container( // Set background color for the screenshot
            color: Colors.white, // Explicitly set background to white for the screenshot
            padding: const EdgeInsets.all(16.0), // Padding applied here for the screenshot
            child: Column( // This column contains all the receipt details
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Essential: Column takes minimum height
              children: [
                // DATE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DATE: ${dateFormat.format(widget.transactionDate)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // TRANSACTION ITEMS
                if (widget.transactionSales.isEmpty)
                  const Center(
                    child: Text(
                      'No items in this transaction.',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true, // Essential for ListView.builder inside a Column
                    physics: const NeverScrollableScrollPhysics(), // Prevent inner scrolling
                    itemCount: widget.transactionSales.length,
                    itemBuilder: (context, index) {
                      final sale = widget.transactionSales[index];
                      return Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        elevation: 0.1,
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        color: Colors.white, // Ensure card background is white
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatQuantity(half_checker(sale.quantity)),
                                style: const TextStyle(fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                sale.product,
                                style: const TextStyle(fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                '₦${decimalFormatter.format(sale.amount)}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 10),

                // TOTAL AMOUNT
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total: ₦${decimalFormatter.format(_calculateTotalAmount())}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton.icon(
                  onPressed: () => _shareReceiptAsImage(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.share),
                  label: const Text(
                    'Share Receipt Image',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}