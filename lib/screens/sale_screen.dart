// include the material package
import 'package:flutter/material.dart';
// import the chat widget
import 'package:my_shop/widgets/SalechatList.dart';
// import the sale entry class
import 'package:my_shop/models/sales_entry.dart';
// import sale chat total widget
import 'package:my_shop/widgets/SalechatTotal.dart';
// import the sale chat input widget
import 'package:my_shop/widgets/SaleinputField.dart';
// import sale chat input parser
import 'package:my_shop/utils/input_parser.dart';

import 'package:my_shop/screens/salesReceipt_screen.dart';

// hive and provider
  // importing the provider package
  import 'package:provider/provider.dart';
  // the structure and adapter for my data model
  import 'package:my_shop/models/sale.dart';
  // // the provider for my data model
  import 'package:my_shop/providers/sale_provider.dart';

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
  final Map<dynamic,Sale> _sales_obj= {};
  final List<Sale> _sales_list= [];
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
        // fields
        // item name
        final product_name = productDetails?["item"];
        // quantity
        final quantity = productDetails?["quantity"];
        // price
        final double price = productDetails?["price"];
        // the amount which is price * quantity
        final double amount_sale = price * quantity;
        // the amount to be added to total chat
         amount = amount_sale;

        final item = Sale(
          product:product_name ,
          amount:amount_sale,
          date:DateTime.now(),
        );
        // what will be save to the hive
        final String key = DateTime.now().millisecondsSinceEpoch.toString();
      _sales_obj[key] = item;
      // what the user will see in receipt
       _sales_list.add(item);  
      //  print(_sales_obj);
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
// reset what user type for mistakes
  void _resetEntries() {
    setState(() {
      _saleEntries.clear();
      _sales_obj.clear();
      _totalSales = 0.0;
      _textEditingController.clear();
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text("Sale Chat"),

        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetEntries,
            tooltip: 'Reset Sales',
          ),
        ],
      ),
      body:
      Column(
        children: [

          // show the list of enteries user enter
          Salechatlist(entries: _saleEntries),
          // shows total of sale enteries by user
          Salechattotal(totalSales: _totalSales),

          // show save icon if user enter something
          if(_sales_obj.isNotEmpty)
          GestureDetector(
                onTap: () async{
                final date = DateTime.now();
                await context.read<SalesProvider>().addSales(_sales_obj); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SalesReceiptView(transactionDate:date,transactionSales:  _sales_list),
                )
                );
              },
               child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                    Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child:const Icon(
                      Icons.done_all_outlined, // Send icon
                      color: Colors.white,
                    ),
                  ),
                  )
                  // )
            ),
          // shows textfield and send button
          Saleinputfield(
            controller: _textEditingController, 
            onSubmit: _processSaleEntry
          ),
           
        ],
      ),
    );
  }
}