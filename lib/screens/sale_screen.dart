// include the material package
import 'package:flutter/material.dart';

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
  final List<String> _saleEntries= [];
  // hold the totals sales enter by the user
  double _totalSales = 0.0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text("Sale Chat"),
      ),
      body:
      Column(
        children: [
          // the chat space
          Expanded(
            // use listview builder to hold user chat as an infinite scroll
            child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _saleEntries.length,
                itemBuilder: (context,index){
                  // ensure the list is access in reverse
                  final entry = _saleEntries[_saleEntries.length - 1 - index];
                  return Align(
                    // align the entry like a chat
                    alignment: Alignment.centerRight,
                    // hold the entry
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                      color: Colors.blue.shade100, // Light blue for sent messages
                      borderRadius: BorderRadius.circular(12.0),
                      ),
                      // decorate the entry 
                      child: Column(
                        // push chat to the right of the screen
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            // entry.rawText,
                            "Suman",
                            style: const TextStyle(fontSize: 16),
                          ),
                          // show particular entry total
                          // if (entry.extractedAmount > 0)
                          // Text(
                          //   'Amount: ₦${entry.extractedAmount.toStringAsFixed(2)}',
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.grey[600],
                          //   ),
                          // ),
                        ]
                      ),
                    ),
                  );

                },
            )
          ),

          // shows total of sale enteries by user
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight, 
              child: Text(
                'Total: ₦${_totalSales.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Darker color for emphasis
                ),
              ),
            )
          ),

          // shows textfield and send button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child:Row(
              children: [
                Expanded(
                   child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextField(
                        // control for the field
                        // controller: _textController,
                        decoration: InputDecoration(
                        hintText: 'Type sale details...',
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        // onSubmitted: _processSaleEntry, 
                      ),
                      ),
                   ),
                ),
                // space between inputfield and send button
                const SizedBox(width: 8.0),
                // the send button
                GestureDetector(
                  // onTap: () => _processSaleEntry(_textController.text),
                  child:Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child:const Icon(
                      Icons.send, // Send icon
                      color: Colors.white,
                    ),
                  )
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}