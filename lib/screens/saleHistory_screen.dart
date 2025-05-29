import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:my_shop/providers/sale_provider.dart';
import 'package:my_shop/models/sale.dart';
import 'package:my_shop/screens/dailyRecord_screen.dart';

class SaleHistoryView extends StatelessWidget {

  const SaleHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final sales = context.watch<SalesProvider>().sales;
    final dateFormat = DateFormat('dd-MM-yyyy');
    final locale = Localizations.localeOf(context).toString();
    final currencyFormatter = NumberFormat.decimalPattern(locale);

    // Group sales by date
    final Map<String, List<Sale>> groupedSales = {};

    for (final sale in sales) {
      final dateKey = dateFormat.format(sale.date); // e.g. "28-05-2025"
      if (!groupedSales.containsKey(dateKey)) {
        groupedSales[dateKey] = [];
      }
      groupedSales[dateKey]!.add(sale);
    }

    final sortedDates = groupedSales.keys.toList()
      ..sort((a, b) => dateFormat.parse(b).compareTo(dateFormat.parse(a))); // Recent first

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales History'),
        leading: BackButton(),
      ),
      body: sales.isEmpty
          ? const Center(child: Text('No sales records found.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sortedDates.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final dateStr = sortedDates[index];
                final dateSales = groupedSales[dateStr]!;
                final total = dateSales.fold(0.0, (sum, sale) => sum + sale.amount);

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  tileColor: Colors.grey[100],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  title: Text(
                    dateStr,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Total: ₦${currencyFormatter.format(total)}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    final selectedDate = dateFormat.parse(dateStr);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DailyRecordView(selectedDate: selectedDate),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
