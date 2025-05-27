import 'package:flutter/material.dart';
import 'package:my_shop/models/sales_entry.dart';
import 'package:my_shop/widgets/chatBubble.dart';

class Salechatlist extends StatelessWidget{

  final List<SaleEntry> entries;

  const Salechatlist({super.key, required this.entries});

  @override
  Widget build(BuildContext context){
    return // the chat space
          Expanded(
            // use listview builder to hold user chat as an infinite scroll
            child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: entries.length,
                itemBuilder: (context,index){
                  // ensure the list is access in reverse
                  final entry = entries[entries.length - 1 - index];
                  return Chatbubble(entry: entry);

                },
            )
          );


  }
}