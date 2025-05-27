import 'package:flutter/material.dart';

class Salechattotal extends StatelessWidget{

  final double totalSales;

  const Salechattotal({super.key, required this.totalSales});

  @override
  Widget build(BuildContext context){
    return // shows total of sale enteries by user
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight, 
              child: Text(
                'Total: ₦${totalSales.toStringAsFixed(2)}',
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