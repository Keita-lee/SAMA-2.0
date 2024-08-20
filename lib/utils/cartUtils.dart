import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

final _storage = FlutterSecureStorage();

Future<List<Map<String, dynamic>>> getCart() async {
  String? jsonCart = await _storage.read(key: 'cart');

  if (jsonCart != null) {
    print(List<Map<String, dynamic>>.from(jsonDecode(jsonCart)));
    return List<Map<String, dynamic>>.from(jsonDecode(jsonCart));
  } else {
    return [];
  }
}

Future<void> addProduct(
    product, quantity, Function(String, int) getProductQuantity) async {
  List<Map<String, dynamic>> cartProducts = await getCart();
  print(cartProducts);
  var productSelected = {
    "name": product['name'],
    "productPrice": 'Member Price. Includes VAT',
    "quantity": quantity != "" ? quantity : 1,
    "price": '${double.parse(product['price'])}',
    "total":
        '${double.parse(product['price']) * (quantity != "" ? quantity : 1)}',
    "id": product['id'],
    "productImage": product['imageUrl'],
  };

  var productIndex =
      (cartProducts).indexWhere((item) => item["name"] == product['name']);

  if (productIndex == -1) {
    cartProducts.add(productSelected);
  } else {
    if (quantity == "") {
      print('quantity is null');
      cartProducts[productIndex]['quantity'] =
          cartProducts[productIndex]['quantity'] + 1;

      cartProducts[productIndex]['total'] =
          '${double.parse(cartProducts[productIndex]['price']) * cartProducts[productIndex]['quantity']}';

      getProductQuantity(product['name'], 0);
    } else {
      print('quantity is $quantity');
      cartProducts[productIndex]['quantity'] += quantity;

      print(cartProducts[productIndex]['quantity']);

      cartProducts[productIndex]['total'] =
          '${double.parse(cartProducts[productIndex]['price']) * cartProducts[productIndex]['quantity']}';

      getProductQuantity(
          product['name'], cartProducts[productIndex]['quantity'] + quantity);
    }
  }

  // Store the updated cart in secure storage
  await _storage.write(key: 'cart', value: jsonEncode(cartProducts));
}

Future<void> updateProductQuantity(productName, quantity) async {
  List<Map<String, dynamic>> cartProducts = await getCart();
  var total = 0.0;
  var productIndex =
      (cartProducts).indexWhere((item) => item["name"] == productName);

  cartProducts[productIndex]['quantity'] = quantity;

  cartProducts[productIndex]['total'] =
      '${double.parse(cartProducts[productIndex]['price']) * quantity}';

  // Store the updated cart in secure storage
  await _storage.write(key: 'cart', value: jsonEncode(cartProducts));
}

Future<void> deleteProduct(
    String productName, Function(String, int) getProductQuantity) async {
  List<Map<String, dynamic>> cartProducts = await getCart();
  var productIndex =
      cartProducts.indexWhere((item) => item["name"] == productName);

  if (productIndex != -1) {
    cartProducts.removeAt(productIndex);
  }

  // Update the product quantity state if needed
  getProductQuantity(productName, 0);

  // Store the updated cart in secure storage
  await _storage.write(key: 'cart', value: jsonEncode(cartProducts));
}
