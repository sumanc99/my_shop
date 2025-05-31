// widgets/SalechatList.dart
import 'package:flutter/material.dart';
import 'package:my_shop/models/sales_entry.dart';
import 'package:my_shop/widgets/chatBubble.dart';

class Salechatlist extends StatelessWidget {
  final List<SaleEntry> entries;
  // This is the callback that will be triggered when an item is deleted
  final Function(int) onDeleteEntry;

  const Salechatlist({
    super.key,
    required this.entries,
    required this.onDeleteEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          // ensure the list is access in reverse
          final entry = entries[entries.length - 1 - index];
          return Chatbubble(
            entry: entry,
            onDelete: () {
              // Calculate the actual index in the original list
              // This is crucial because `ListView.builder` is reversed.
              final originalIndex = entries.length - 1 - index;
              onDeleteEntry(originalIndex); // Call the parent's delete function
            },
          );
        },
      ),
    );
  }
}