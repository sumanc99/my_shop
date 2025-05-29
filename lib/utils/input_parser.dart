import 'package:flutter/material.dart';

//check if input is valid 
bool isValidPurchaseLine(String input) {
  final pattern = RegExp(
    r'^('
    r'(?:[1-9]\d*\s+[a-zA-Z]+\s+[1-9]\d*)|'    // quantity item price
    r'(?:[a-zA-Z]+\s+[1-9]\d*\s+[1-9]\d*)|'    // item quantity price
    r'(?:[1-9]\d*\s+[1-9]\d*\s+[a-zA-Z]+)|'    // price quantity item
    r'(?:[a-zA-Z]+\s+[1-9]\d*)|'               // item price → default quantity = 1
    r'(?:[1-9]\d*\s+[a-zA-Z]+)'                // price item → default quantity = 1
    r')$'
  );

  return pattern.hasMatch(input);
}

// show a dialog box when user make a mistake
void Showbox(context,text){
  showDialog(
        context: context,
        builder: (BuildContext dialogContext) { // Use a different context name to avoid confusion
          return AlertDialog(
            title: const Text('Input Error'),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss the dialog
                },
              ),
              // You could add more actions, like a "Help" button
            ],
          );
        },
    );
}

// now after the input is valid it extract the item,price and quantity
Map<String, dynamic>? extract_product_info(String input){

  final String? item;
  final String? quantityStr;
  final String? priceStr;

   final pattern = RegExp(
    // 3-word patterns (with quantity and price)
    r'\b(?<item>[a-zA-Z]+)\b.*\b(?<quantity>\d+)\b.*\b(?<price>\d+)\b|'
    r'\b(?<quantity2>\d+)\b.*\b(?<item2>[a-zA-Z]+)\b.*\b(?<price2>\d+)\b|'
    r'\b(?<quantity3>\d+)\b.*\b(?<price3>\d+)\b.*\b(?<item3>[a-zA-Z]+)\b|'
    // 2-word patterns (no quantity, default to 1)
    r'\b(?<item4>[a-zA-Z]+)\b\s+\b(?<price4>\d+)\b|'
    r'\b(?<price5>\d+)\b\s+\b(?<item5>[a-zA-Z]+)\b'
  );

  final match = pattern.firstMatch(input);
    if (match == null) return null;

//  checking for item name that is product
 item = match.namedGroup('item') ??
      match.namedGroup('item2') ??
      match.namedGroup('item3') ??
      match.namedGroup('item4') ??
      match.namedGroup('item5');
// checking for qunatity
  quantityStr = match.namedGroup('quantity') ??
      match.namedGroup('quantity2') ??
      match.namedGroup('quantity3');
// checking for price
  priceStr = match.namedGroup('price') ??
      match.namedGroup('price2') ??
      match.namedGroup('price3') ??
      match.namedGroup('price4') ??
      match.namedGroup('price5');

    
    if (item != null && priceStr != null) {
      // hold the values of price and qunatity
       final double price = double.parse(priceStr);
       int quantity = 1; // default

      // check if quantity is not empty
      if (quantityStr != null) {
        // assing the value if not empty
        final int qtyParsed = int.parse(quantityStr);
        // swap if quantity was probably mistaken for price
        if (qtyParsed > price) {
          // return a full map if all 3 are present
          return {
            'item': item,
            'quantity': price,
            'price': qtyParsed,
          };
        }
        // update the value from 1
        quantity = qtyParsed;
      }
      // return full map if all 3 are present
      return {
      'item': item,
      'quantity': quantity,
      'price': price,
      };
    }
      
      

  return null;
}
