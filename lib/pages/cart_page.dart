import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_flutter/model/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  Future placeOrder(String username,String order,String totalPrice) async
  {
    await FirebaseFirestore.instance.collection('orders').add({
      'Username':username,
      'order':order,
      'total price':totalPrice,
    });
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Place Order"),
      content: Text("Order Successfully placed by ${FirebaseAuth.instance.currentUser!.email}."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showAlertDialogForAddress(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Confirm"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Place Order"),
      content: const Text(""),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
          backgroundColor: Colors.black,
        ),
        body: Consumer<CartModel>(
          builder: (context, value, child) {
            if (value.isEmpty) {
              return Center(
                child: Text(
                  'Cart is Empty! \nTry adding items!',
                  style: GoogleFonts.notoSerif(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              value.cartItems[index][2],
                              height: 36,
                            ),
                            title: Text(value.cartItems[index][0]),
                            subtitle: Text('₹${value.cartItems[index][1]}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () =>
                                  Provider.of<CartModel>(context, listen: false)
                                      .removeItemFromCart(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Price : ',
                                style: TextStyle(
                                  color: Colors.green[100],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '₹${value.calculateTotalPrice()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green.shade100),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(6),
                            child: Row(
                              children: [
                                const Text(
                                  'Pay Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    placeOrder(FirebaseAuth.instance.currentUser!.email.toString(), value.itemNameInCart.toString(), value.calculateTotalPrice());
                                    // showAlertDialog(context);
                                    showAlertDialogForAddress(context);
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                )
              ],
            );
          },
        ));
  }
}
