import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:my_shop/models/sale.dart';


class SalesReceiptView extends StatelessWidget {
  final List<Sale> transactionSales; // List of sales for this specific transaction
  final DateTime transactionDate; // The date/time of this transaction

  const SalesReceiptView({
    super.key,
    required this.transactionSales,
    required this.transactionDate,
  });

  double _calculateTotalAmount() {
    return transactionSales.fold(0.0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm a');

    //Get the current locale from context for money format
    final String currentLocale = Localizations.localeOf(context).toString();
    final NumberFormat decimalFormatter = NumberFormat.decimalPattern(currentLocale);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Receipt'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView( // Makes the screen scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DATE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DATE: ${dateFormat.format(transactionDate)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // TRANSACTION ITEMS
            if (transactionSales.isEmpty)
              const Center(child: Text('No items in this transaction.'))
            else
              ListView.builder(
                shrinkWrap: true, //Prevents height overflow
                physics: const NeverScrollableScrollPhysics(), // Avoid nested scrolling
                itemCount: transactionSales.length,
                itemBuilder: (context, index) {
                  final sale = transactionSales[index];
                  return Card(
                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // This removes the radius
                      ),
                      elevation: 0.1, 
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sale.product,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            '₦${decimalFormatter.format(sale.amount)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // CLOSE BUTTON
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
