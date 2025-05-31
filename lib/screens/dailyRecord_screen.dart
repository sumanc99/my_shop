import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

// hive and provider
  // importing the provider package
  import 'package:provider/provider.dart';
  // the structure and adapter for my data model
  // import 'package:my_shop/models/sale.dart';
  // // the provider for my data model
  import 'package:my_shop/providers/sale_provider.dart';

class DailyRecordView extends StatefulWidget {
  final DateTime selectedDate; // To display records for a specific date

  const DailyRecordView({super.key, required this.selectedDate});

  @override
  State<DailyRecordView> createState() => _DailyRecordViewState();
}

class _DailyRecordViewState extends State<DailyRecordView> {





  // check if quantity is 0.5 and turn it to 1/2
  String half_checker(String input){
    if(input == "0.5"){
      return "1/2";
    }
    
    return input;
    
  }

  // now format the quatity to remove decimal place
  String formatQuantity(input){
    if(input == "1/2"){
      return "1/2";
    }
    double parsedDouble = double.parse(input);


    return parsedDouble.toInt().toString();
  }


  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy'); // For displaying the date
    final salesRecords = context.watch<SalesProvider>().getSalesForDay(widget.selectedDate);
      //Get the current locale from context for money format
    final String currentLocale = Localizations.localeOf(context).toString();
    final NumberFormat decimalFormatter = NumberFormat.decimalPattern(currentLocale);
    // decimalFormatter.format(sale.amount)
    
    double calculateTotalAmount() {
      return salesRecords.fold(0.0, (sum, item) => sum + item.amount);
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Record view'),
        leading: IconButton( // Back button (similar to the arrow in the sketch)
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
           children: [
          // DATE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DATE: ${dateFormat.format(widget.selectedDate)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Total: ₦${decimalFormatter.format(calculateTotalAmount())}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

          // Day record
          if(salesRecords.isEmpty)
          const Center(child: Text('No Sale Made Yet Today.'))
            else
              ListView.builder(
                reverse: true,
                shrinkWrap: true, //Prevents height overflow
                physics: const NeverScrollableScrollPhysics(), // ✅ Avoid nested scrolling
                itemCount: salesRecords.length,
                itemBuilder: (context, index) {
                  final sale = salesRecords[index];
                  return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // This removes the radius
                      ),
                      elevation: 0.1, 
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatQuantity(half_checker(sale.quantity)),
                            style: const TextStyle(fontSize: 18),
                          ),Text(
                            sale.product,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            '₦${decimalFormatter.format(sale.amount)}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

            const SizedBox(height: 10),

           
            // close button section
          // Center(
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width * 0.7,
          //       child: ElevatedButton(
          //         onPressed: () {
          //           Navigator.popUntil(context, (route) => route.isFirst);
          //         },
          //         style: ElevatedButton.styleFrom(
          //           padding: const EdgeInsets.symmetric(vertical: 15),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(30.0),
          //           ),
          //           backgroundColor: Theme.of(context).primaryColor,
          //           foregroundColor: Colors.white,
          //         ),
          //         child: const Text(
          //           'Close',
          //           style: TextStyle(fontSize: 18),
          //         ),
          //       ),
          //     ),
          //   ),

           ],
        )
      ),


     
    );
  }
}





