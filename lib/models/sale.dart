import 'package:hive/hive.dart';

part "sale.g.dart";

@HiveType(typeId: 0)
class Sale extends HiveObject{
  // the model constructure
  Sale({
    required this.product,
    required this.amount,
    required this.date,
  });

  @HiveField(0) 
  String product;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime date;
  
  // @HiveField(3)
  // String time;


}