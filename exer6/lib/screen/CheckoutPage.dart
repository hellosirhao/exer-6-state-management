import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    // list of products
    List<Item> products = context.watch<ShoppingCart>().cart;

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body:
        // if list of shopping cart items is empty, no items to checkout
        products.isEmpty
        ?
          const Column(
          children: [
            Text("Item Details"),
            Divider(),
            Text("No items to checkout!")
            ]
          )
        : 
        // else, show items, total, and pay now
        Column(
          children: [
          const Text("Item Details"),
          const Divider(),
          Flexible(child:
              ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(products[index].name),
                    trailing: Text("${products[index].price}"),
                  );
                })
              ),
            const Divider(),
            computeCost(),
            ElevatedButton(
              onPressed: () {
                context.read<ShoppingCart>().removeAll();
                Navigator.pushNamed(context, "/products");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Payment Successful!")), 
                );
              },
              child: const Text("Pay Now!"),
            ),
          ]
        ) 

          
    );
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
       return Text("Total Cost to Pay: ${cart.cartTotal}");
    });
  }
}