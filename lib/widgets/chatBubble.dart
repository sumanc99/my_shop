import 'package:flutter/material.dart';
import 'package:my_shop/models/sales_entry.dart';
import 'package:intl/intl.dart';

class Chatbubble extends StatelessWidget {
  final SaleEntry entry;
  final VoidCallback onDelete; // Callback for when the delete icon is pressed

  const Chatbubble({super.key, required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final String currentLocale = Localizations.localeOf(context).toString();
    final NumberFormat decimalFormatter = NumberFormat.decimalPattern(currentLocale);

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Wrap content horizontally
          crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically in the center
          children: [
            // Delete Icon
            GestureDetector(
              onTap: onDelete,
              // Increased the padding to make the tap area larger
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10), // Adjust padding for icon size and tap area
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 18, // Slightly larger icon for better visibility
                ),
              ),
            ),
            const SizedBox(width: 8.0), // Space between icon and chat bubble
            // Chat Bubble Content
            Flexible( // Use Flexible to allow the chat bubble to take available space but not overflow
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      entry.rawText,
                      style: const TextStyle(fontSize: 17, color: Color.fromARGB(255, 22, 8, 8)),
                    ),
                    if (entry.extractedAmount > 0)
                      Text(
                        'Amount: ₦${decimalFormatter.format(entry.extractedAmount)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}