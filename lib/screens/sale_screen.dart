// include the material package
import 'package:flutter/material.dart';
import 'package:my_shop/widgets/SalechatList.dart';
import 'package:my_shop/models/sales_entry.dart';
import 'package:my_shop/widgets/SalechatTotal.dart';
import 'package:my_shop/widgets/SaleinputField.dart';
import 'package:my_shop/utils/input_parser.dart';

class SaleScreen extends StatefulWidget{
  // tell three that we have a new widget
  const SaleScreen({super.key});

  // create state for the sale chat screen
  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen>{

  // give us full control on the textfield and what user enters
  final TextEditingController _textEditingController = TextEditingController();
  // hold the entries enter by the user
  final List<SaleEntry> _saleEntries= [];
  // hold the totals sales enter by the user
  double _totalSales = 0.0;


// --- Text Parsing Logic (Simple Example) ---
void _processSaleEntry(String text) {
    double amount = 0.0;
    final input = text.trim();
    if (input.isEmpty) {
      Showbox(context,"Provide Input");
      return;
    }

    // check if input is not valid
    if(!isValidPurchaseLine(input)){
      Showbox(context,"Invalid Input");
      return;
    }else{
      final productDetails = extract_product_info(input);
      try {
       amount = productDetails?["price"];
      } catch (e) {
        // Handle parsing errors if necessary
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not understand the amount. Please enter a valid number!'),
              backgroundColor: Colors.red, // Make it stand out as an error
            ),
        );
      }
    }

      setState(() {
        final val = SaleEntry(rawText: text, extractedAmount: amount);
        _saleEntries.add(val);
        _totalSales += amount;
        _textEditingController.clear(); // Clear the input field after adding
      });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text("Sale Chat"),
      ),
      body:
      Column(
        children: [

          // show the list of enteries user enter
          Salechatlist(entries: _saleEntries),
          // shows total of sale enteries by user
          Salechattotal(totalSales: _totalSales),
          // shows textfield and send button
          Saleinputfield(
            controller: _textEditingController, 
            onSubmit: _processSaleEntry
          )

        ],
      ),
    );
  }
}