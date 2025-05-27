import 'package:flutter/material.dart';
import 'package:my_shop/models/sales_entry.dart';

// widget for single sale entry
class Chatbubble extends StatelessWidget{
  
  final SaleEntry entry;

  const Chatbubble({super.key, required this.entry});

  @override
  Widget build(BuildContext context){
    return Align(
      // aling the entry like chat
       alignment: Alignment.centerRight,
      //  hold the entry
       child:Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
          color:Colors.grey[200], // Light blue for sent messages
          borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            // push chat to the right of the screen
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                entry.rawText,
                style: const TextStyle(fontSize: 17,color: Color.fromARGB(255, 22, 8, 8)),
                
                // show particular entry total if price is present
                
              ),
              if(entry.extractedAmount > 0)
                Text(
                  'Amount: ₦${entry.extractedAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
            ]
          ),
       ),
    );
  }

}