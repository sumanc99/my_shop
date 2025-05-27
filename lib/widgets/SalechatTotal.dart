import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Salechattotal extends StatelessWidget{

  final double totalSales;

  const Salechattotal({super.key, required this.totalSales});

  @override
  Widget build(BuildContext context){
    //Get the current locale from context
    final String currentLocale = Localizations.localeOf(context).toString();
    //Create the formatter with the current locale
    final NumberFormat decimalFormatter = NumberFormat.decimalPattern(currentLocale);

    return // shows total of sale enteries by user
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight, 
              child: Text(
                
                'Total: ₦${decimalFormatter.format(totalSales)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Darker color for emphasis
                ),
              ),
            )
          );
  }
}