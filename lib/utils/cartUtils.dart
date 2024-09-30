import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:html';

Future<List<Map<String, dynamic>>> getCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    String? jsonCart = prefs.getString('cart');
    print('json: ${jsonDecode(jsonCart ?? "")}');
    if (jsonCart != null) {
      return (jsonDecode(jsonCart) as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
    } else {
      await prefs.setString('cart', '[]');
      return [];
    }
  } catch (e) {
    await prefs.setString('cart', '[]');
    print('Error fetching cart: $e');
    return [];
  }
}

Future<void> addProduct(product, quantity,
    Function(String, int) getProductQuantity, double totalPrice) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonCart = prefs.getString('cart');
    List<Map<String, dynamic>> cartProducts = jsonCart != null
        ? List<Map<String, dynamic>>.from(jsonDecode(jsonCart))
        : [];

    print('cart $cartProducts');

    // var productSelected = {
    //   "name": product['name'],
    //   "productPrice": 'Member Price. Includes VAT',
    //   "quantity": quantity != "" ? quantity : 1,
    //   "price": '${double.parse(product['price'])}',
    //   "total":
    //       '${double.parse(product['price']) * (quantity != "" ? quantity : 1)}',
    //   "id": product['id'],
    //   "productImage": product['imageUrl'],
    // };
    print('product : $product, quantity : $quantity, totalPrice : $totalPrice');
    var productSelected = {
      "name": product['name'],
      "productPrice": 'Member Price. Includes VAT',
      "quantity": quantity != "" ? quantity : 1,
      // "price": '${double.parse(product['price'])}',
      "total": totalPrice.toStringAsFixed(2),
      "priceList": product['priceList'],
      "id": product['id'],
      "productImage": product['imageUrl'],
    };

    var productIndex =
        cartProducts.indexWhere((item) => item["name"] == product['name']);

    if (productIndex == -1) {
      cartProducts.add(productSelected);
    } else {
      if (quantity == "") {
        print('quantity is null');
        cartProducts[productIndex]['quantity'] =
            cartProducts[productIndex]['quantity'] + 1;

        cartProducts[productIndex]['total'] =
            (double.parse(cartProducts[productIndex]['total']) + totalPrice)
                .toStringAsFixed(2);

        getProductQuantity(product['name'], 0);
      } else {
        print('quantity is $quantity');
        cartProducts[productIndex]['quantity'] += quantity;

        print(cartProducts[productIndex]['quantity']);

        cartProducts[productIndex]['total'] =
            (double.parse(cartProducts[productIndex]['total']) + totalPrice)
                .toStringAsFixed(2);

        getProductQuantity(
            product['name'], cartProducts[productIndex]['quantity']);
      }
    }

    // Store the updated cart in SharedPreferences
    await prefs.setString('cart', jsonEncode(cartProducts));
  } catch (e) {
    print('Error adding product to cart: $e');
  }
}

Future<int> getProductQuantity(String productName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> cartProducts = await getCart();
  if (cartProducts.isEmpty) {
    return 0;
  }
  print(productName);
  var productIndex =
      (cartProducts).indexWhere((item) => item["name"] == productName);
  if (productIndex == -1) {
    return 0;
  }
  return cartProducts[productIndex]['quantity'];
}

Future<List<Map<String, dynamic>>> updateProductQuantity(
    productName, quantity) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> cartProducts = await getCart();
  var total = 0.0;
  var productIndex =
      (cartProducts).indexWhere((item) => item["name"] == productName);

  cartProducts[productIndex]['quantity'] = quantity;

  cartProducts[productIndex]['total'] =
      '${double.parse(cartProducts[productIndex]['price']) * quantity}';
  print('cart: $cartProducts');
  // Store the updated cart in SharedPreferences
  await prefs.setString('cart', jsonEncode(cartProducts));
  print(
      'updating product list. Quanitity ${cartProducts[productIndex]['quantity']}, total ${cartProducts[productIndex]['total']}');

  return cartProducts;
}

Future<List<Map<String, dynamic>>> updateProductTotal(
    productName, quantity, totalPrice) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> cartProducts = await getCart();
  var total = 0.0;
  var productIndex =
      (cartProducts).indexWhere((item) => item["name"] == productName);

  cartProducts[productIndex]['quantity'] = quantity;

  cartProducts[productIndex]['total'] =
      (double.parse(cartProducts[productIndex]['total']) +
              double.parse(totalPrice))
          .toStringAsFixed(2);
  print('cart: $cartProducts');
  // Store the updated cart in SharedPreferences
  await prefs.setString('cart', jsonEncode(cartProducts));
  print(
      'updating product list. Quanitity ${cartProducts[productIndex]['quantity']}, total ${cartProducts[productIndex]['total']}');

  return cartProducts;
}

Future<void> deleteProduct(
    String productName, Function(String, int) getProductQuantity) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonCart = prefs.getString('cart');
    List<Map<String, dynamic>> cartProducts = jsonCart != null
        ? List<Map<String, dynamic>>.from(jsonDecode(jsonCart))
        : [];

    var productIndex =
        cartProducts.indexWhere((item) => item["name"] == productName);

    if (productIndex != -1) {
      cartProducts.removeAt(productIndex);
    }

    // Update the product quantity state if needed
    getProductQuantity(productName, 0);

    // Store the updated cart in SharedPreferences
    await prefs.setString('cart', jsonEncode(cartProducts));
  } catch (e) {
    print('Error deleting product from cart: $e');
  }
}
