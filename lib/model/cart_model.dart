import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  //list of items on sale
  final List _shopItems = [
    //[itemName, itemPrice, imagePath, color]
    ["Avocado", "30.00", "images/avocado.png", Colors.green],
    ["Banana", "10.50", "images/banana.png", Colors.yellow],
    ["Chicken", "100.00", "images/chicken.png", Colors.brown],
    ["Water", "20.00", "images/water.png", Colors.blue],
    ["Bell Pepper", "25.00", "images/bell_pepper.png", Colors.red],
    ["Carrot", "15.00", "images/carrot.png", Colors.deepOrange],
    ["Cauliflower", "23.00", "images/cauliflower.png", Colors.yellow],
    ["Ginger", "12.00", "images/ginger.png", Colors.brown],
    ["Lamb Meat", "120.00", "images/lamb_meat.png", Colors.brown],
    ["Lotus", "50.00", "images/lotus.png", Colors.pinkAccent],
    ["Pumpkin", "30.00", "images/pumpkin.png", Colors.yellow],
    ["Spinach", "25.00", "images/spinach.png", Colors.green],
    ["Tomato", "40.00", "images/tomatoes.png", Colors.redAccent],
  ];

  final List _cartItems = [];

  get shopItems => _shopItems;

  get cartItems => _cartItems;

  get itemNameInCart{
    List result = [];
    for (int i = 0; i < _cartItems.length; i++) {
      result.add(_cartItems[i][0]);
    }
    return result;
  }

  //add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  //remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  //calculate total price
  String calculateTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }

  //check if cart is empty or not
  bool get isEmpty => _cartItems.isEmpty;
}
