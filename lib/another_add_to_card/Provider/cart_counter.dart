import 'package:flutter/material.dart';

import '../Database/db_helper.dart';
import '../Model/data_base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCounter extends ChangeNotifier {

 int _counter = 0;
 int get counter => _counter;




   incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
      _counter = ((prefs.getInt('counter') ?? 0) + 1);
      prefs.setInt('counter', _counter);
   notifyListeners();
  }
    decrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   if(counter!=0){
      _counter = ((prefs.getInt('counter') ?? 0) - 1);
      prefs.setInt('counter', _counter);}
   notifyListeners();
  }

   loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
      _counter = (prefs.getInt('counter') ?? 0);
   notifyListeners()
;  }


//   int _counters = 0;
//   int get counters => _counters;
//   double _totalPrice = 0.0;
//   double get totalPrice => _totalPrice;

//   void _setPrefItem() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//   await  prefs.setInt('cart_item', _counter);
//    await prefs.setDouble('cart_items', _totalPrice);
//     notifyListeners();
//   }

//   void _getPrefItem() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.getInt('cart_item') ?? 0.toInt();
//    await prefs.getDouble(
//           'cart_items',
//         ) ??
//         0.0;
//     notifyListeners();
//   }

//  addCounter() {
//     _counter++;
//     _setPrefItem();
//     notifyListeners();
//   }

//   void removeCounter() {
//     _counter--;
//     _setPrefItem();
//     notifyListeners();
//   }

//   int getCounter() {
//     _getPrefItem();
//     return _counter;
//   }

//   void addTotalPrice(double productPrice) {
//     _totalPrice =_totalPrice+productPrice;
//     _setPrefItem();
//     notifyListeners();
//   }

//   void removeTotalPrice(double productPrice) {
//     _totalPrice =_totalPrice -productPrice;
//     _setPrefItem();
//     notifyListeners();
//   }

//   double getTotalPrice() {
//     _getPrefItem();
//     return _totalPrice;
//   }
}
