import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{//storehouse for all the items added to cart
  final List<Map<String,dynamic>> cart =[];
  List<Map<String,dynamic>> get items => cart;

  void addProduct(Map<String,dynamic> product){
    cart.add(product);
    notifyListeners();
  }

  void removeProduct(Map<String,dynamic> product){
    cart.remove(product);
    notifyListeners();
  }
}