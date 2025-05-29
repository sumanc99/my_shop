import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_shop/models/sale.dart';

class SalesProvider extends ChangeNotifier {

  final Box<Sale> _salesBox = Hive.box<Sale>('sales');

  List<Sale> get sales => _salesBox.values.toList();

// get the sales for a particular date
List<Sale> getSalesForDay(DateTime day) {
  return sales.where((sale) =>
      sale.date.year == day.year &&
      sale.date.month == day.month &&
      sale.date.day == day.day
  ).toList();
}

// select data for a particular day
Future<List<Sale>> getSalesForDate(DateTime date) async {

  return sales.where((sale) =>
    sale.date.year == date.year &&
    sale.date.month == date.month &&
    sale.date.day == date.day
  ).toList();
}


// void debugPrintSales() {
//   final allSales = _salesBox.values.toList();
//   for (var sale in allSales) {
//     print('Product: ${sale.product}, Amount: ${sale.amount}, Date: ${sale.date}');
//   }
// }


  // add single sale object
  void addSale(Sale sale) async{
    await _salesBox.add(sale);
    notifyListeners();
  }

  Future<void> addSales(Map<dynamic, Sale>  sales) async{
    await _salesBox.putAll(sales);
    notifyListeners();
  }

  void deleteSale(int index) async{
    await _salesBox.deleteAt(index);
    notifyListeners();
  }


  Future<void> clearSales() async {
  await _salesBox.clear();
    notifyListeners();
  }
  
}
