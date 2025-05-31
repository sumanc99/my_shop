import 'package:flutter/material.dart';

// //check if input is valid 
// bool isValidPurchaseLine(String input) {
//   // final pattern = RegExp(
//   //   r'^('
//   //   r'(?:[1-9]\d*\s+[a-zA-Z]+\s+[1-9]\d*)|'    // quantity item price
//   //   r'(?:[a-zA-Z]+\s+[1-9]\d*\s+[1-9]\d*)|'    // item quantity price
//   //   r'(?:[1-9]\d*\s+[1-9]\d*\s+[a-zA-Z]+)|'    // price quantity item
//   //   r'(?:[a-zA-Z]+\s+[1-9]\d*)|'               // item price → default quantity = 1
//   //   r'(?:[1-9]\d*\s+[a-zA-Z]+)'                // price item → default quantity = 1
//   //   r')$'
//   // );
//   final pattern = RegExp(
//     // 3-word patterns (quantity/item/price in any order)
//     r'\b(?<item>[a-zA-Z]+)\b.*\b(?<quantity>\d+)\b.*\b(?<price>\d+(?:\.\d+)?|\d+/\d+)\b|'
//     r'\b(?<quantity2>\d+)\b.*\b(?<item2>[a-zA-Z]+)\b.*\b(?<price2>\d+(?:\.\d+)?|\d+/\d+)\b|'
//     r'\b(?<quantity3>\d+)\b.*\b(?<price3>\d+(?:\.\d+)?|\d+/\d+)\b.*\b(?<item3>[a-zA-Z]+)\b|'
//     // 2-word patterns (no quantity, default to 1)
//     r'\b(?<item4>[a-zA-Z]+)\b\s+\b(?<price4>\d+(?:\.\d+)?|\d+/\d+)\b|'
//     r'\b(?<price5>\d+(?:\.\d+)?|\d+/\d+)\b\s+\b(?<item5>[a-zA-Z]+)\b'
//   );




//   return pattern.hasMatch(input);
// }

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
// Map<String, dynamic>? extract_product_info(String input){

//   final String? item;
//   final String? quantityStr;
//   final String? priceStr;

//    final pattern = RegExp(
//     // 3-word patterns (with quantity and price)
//     r'\b(?<item>[a-zA-Z]+)\b.*\b(?<quantity>\d+)\b.*\b(?<price>\d+)\b|'
//     r'\b(?<quantity2>\d+)\b.*\b(?<item2>[a-zA-Z]+)\b.*\b(?<price2>\d+)\b|'
//     r'\b(?<quantity3>\d+)\b.*\b(?<price3>\d+)\b.*\b(?<item3>[a-zA-Z]+)\b|'
//     // 2-word patterns (no quantity, default to 1)
//     r'\b(?<item4>[a-zA-Z]+)\b\s+\b(?<price4>\d+)\b|'
//     r'\b(?<price5>\d+)\b\s+\b(?<item5>[a-zA-Z]+)\b'
//   );

//   final match = pattern.firstMatch(input);
//     if (match == null) return null;

// //  checking for item name that is product
//  item = match.namedGroup('item') ??
//       match.namedGroup('item2') ??
//       match.namedGroup('item3') ??
//       match.namedGroup('item4') ??
//       match.namedGroup('item5');
// // checking for qunatity
//   quantityStr = match.namedGroup('quantity') ??
//       match.namedGroup('quantity2') ??
//       match.namedGroup('quantity3');
// // checking for price
//   priceStr = match.namedGroup('price') ??
//       match.namedGroup('price2') ??
//       match.namedGroup('price3') ??
//       match.namedGroup('price4') ??
//       match.namedGroup('price5');

    
//     if (item != null && priceStr != null) {
//       // hold the values of price and qunatity
//        final double price = double.parse(priceStr);
//        double quantity = 1; // default

//       // check if quantity is not empty
//       if (quantityStr != null) {
//         // assing the value if not empty
//         final double qtyParsed = double.parse(quantityStr);
//         // swap if quantity was probably mistaken for price
//         if (qtyParsed > price) {
//           // return a full map if all 3 are present
//           return {
//             'item': item,
//             'quantity': price,
//             'price': qtyParsed,
//           };
//         }
//         // update the value from 1
//         quantity = qtyParsed;
//       }
//       // return full map if all 3 are present
//       return {
//       'item': item,
//       'quantity': quantity,
//       'price': price,
//       };
//     }
      
      

//   return null;
// }
// double parseNumberOrFraction(String input) {
//   if (input.contains('/')) {
//     final parts = input.split('/');
//     final num = double.tryParse(parts[0]);
//     final den = double.tryParse(parts[1]);
//     if (num != null && den != null && den != 0) {
//       return num / den;
//     }
//   }
//   return double.tryParse(input) ?? 0.0;
// }


// Map<String, dynamic>? extract_product_info(String input) {
//   final String? item;
//   final String? quantityStr;
//   final String? priceStr;

//   final pattern = RegExp(
//     // 3-word patterns (with quantity and price)
//     r'\b(?<item>[a-zA-Z]+)\b.*\b(?<quantity>\d+)\b.*\b(?<price>\d+(?:\.\d+)?|\d+/\d+)\b|'
//     r'\b(?<quantity2>\d+)\b.*\b(?<item2>[a-zA-Z]+)\b.*\b(?<price2>\d+(?:\.\d+)?|\d+/\d+)\b|'
//     r'\b(?<quantity3>\d+)\b.*\b(?<price3>\d+(?:\.\d+)?|\d+/\d+)\b.*\b(?<item3>[a-zA-Z]+)\b|'
//     // 2-word patterns (no quantity, default to 1)
//     r'\b(?<item4>[a-zA-Z]+)\b\s+\b(?<price4>\d+(?:\.\d+)?|\d+/\d+)\b|'
//     r'\b(?<price5>\d+(?:\.\d+)?|\d+/\d+)\b\s+\b(?<item5>[a-zA-Z]+)\b'
//   );

//   final match = pattern.firstMatch(input);
//   if (match == null) return null;

//   // extract item
//   item = match.namedGroup('item') ??
//          match.namedGroup('item2') ??
//          match.namedGroup('item3') ??
//          match.namedGroup('item4') ??
//          match.namedGroup('item5');

//   // extract quantity
//   quantityStr = match.namedGroup('quantity') ??
//                 match.namedGroup('quantity2') ??
//                 match.namedGroup('quantity3');

//   // extract price
//   priceStr = match.namedGroup('price') ??
//              match.namedGroup('price2') ??
//              match.namedGroup('price3') ??
//              match.namedGroup('price4') ??
//              match.namedGroup('price5');

//   if (item != null && priceStr != null) {
//     final double price = double.parse(priceStr);
//     double quantity = 1;

//     if (quantityStr != null) {
//       final double qtyParsed = parseNumberOrFraction(quantityStr);
//       if (qtyParsed > price) {
//         final double qtyParsed = parseNumberOrFraction(priceStr);
//         final double price = double.parse(quantityStr);
//         return {
//           'item': item,
//           'quantity': price,
//           'price': qtyParsed,
//         };
//       }
//       quantity = qtyParsed;
//     }

//     return {
//       'item': item,
//       'quantity': quantity,
//       'price': price,
//     };
//   }

//   return null;
// }


// Check if input is valid
bool isValidPurchaseLine(String input) {
  final pattern = RegExp(
    r'^('
      r'(\d+/\d+|\d+)\s+[a-zA-Z]+\s+\d+|'       // quantity item price
      r'[a-zA-Z]+\s+(\d+/\d+|\d+)\s+\d+|'       // item quantity price
      r'(\d+/\d+|\d+)\s+\d+\s+[a-zA-Z]+|'       // quantity price item
      r'[a-zA-Z]+\s+\d+|'                       // item price (default quantity = 1)
      r'\d+\s+[a-zA-Z]+'                        // price item (default quantity = 1)
    r')$'
  );
  return pattern.hasMatch(input.trim());
}


// Extract item, price, and quantity from valid input
Map<String, dynamic>? extract_product_info(String input) {
  final pattern = RegExp(
    r'^('
      r'(?<q1>\d+/\d+|\d+)\s+(?<item1>[a-zA-Z]+)\s+(?<p1>\d+)|'     // 2 bread 1000
      r'(?<item2>[a-zA-Z]+)\s+(?<q2>\d+/\d+|\d+)\s+(?<p2>\d+)|'     // bread 2 1000
      r'(?<q3>\d+/\d+|\d+)\s+(?<p3>\d+)\s+(?<item3>[a-zA-Z]+)|'     // 2 1000 bread
      r'(?<item4>[a-zA-Z]+)\s+(?<p4>\d+)|'                          // bread 1000
      r'(?<p5>\d+)\s+(?<item5>[a-zA-Z]+)'                           // 1000 bread
    r')$'
  );

  final match = pattern.firstMatch(input.trim());
  if (match == null) return null;

  String? item = match.namedGroup('item1') ??
                 match.namedGroup('item2') ??
                 match.namedGroup('item3') ??
                 match.namedGroup('item4') ??
                 match.namedGroup('item5');

  String? priceStr = match.namedGroup('p1') ??
                     match.namedGroup('p2') ??
                     match.namedGroup('p3') ??
                     match.namedGroup('p4') ??
                     match.namedGroup('p5');

  String? quantityStr = match.namedGroup('q1') ??
                        match.namedGroup('q2') ??
                        match.namedGroup('q3');

  if (item != null && priceStr != null) {
    final double price = double.parse(priceStr);
    double quantity = 1; // default

    if (quantityStr != null) {
      if (quantityStr.contains('/')) {
        final parts = quantityStr.split('/');
        final numerator = double.parse(parts[0]);
        final denominator = double.parse(parts[1]);
        if (denominator == 0) return null;
        quantity = numerator / denominator;
      } else {
        quantity = double.parse(quantityStr);
      }

      // Fix if quantity looks like price and vice versa
      if (quantity > price) {
        return {
          'item': item,
          'quantity': price,
          'price': quantity,
        };
      }
    }

    return {
      'item': item,
      'quantity': quantity,
      'price': price,
    };
  }

  return null;
}
