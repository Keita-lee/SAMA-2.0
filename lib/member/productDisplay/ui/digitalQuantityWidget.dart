import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/member/productDisplay/productFullViewDigital.dart';
import 'package:sama/utils/cartUtils.dart';

class DigitalQuantityWidget extends StatefulWidget {
  int productQuantity;
  String title;
  bool? canDelete;
  Function(String, int)? getProductQuantity;
  Function(String, int, String?)? getProductQuantityCheckout;
  Function(String)? deleteProduct;
  List<Map<String, dynamic>>? priceList;
  final int? initialActivePriceIndex;
  PriceUtils? utils;
  DigitalQuantityWidget(
      {super.key,
      required this.productQuantity,
      required this.title,
      this.priceList,
      this.getProductQuantity,
      this.getProductQuantityCheckout,
      this.initialActivePriceIndex,
      this.utils,
      this.canDelete,
      this.deleteProduct});

  @override
  State<DigitalQuantityWidget> createState() => _DigitalQuantityWidgetState();
}

class _DigitalQuantityWidgetState extends State<DigitalQuantityWidget> {
  int _amount = 1;
  bool _canDelete = false;
  late int currentActivePriceIndex;
  void _incrementAmount() {
    setState(() {
      _amount++;
      checkPriceList(false);
      if (widget.utils != null) {
        widget.utils!.addToTotalPrice(
            widget.priceList![currentActivePriceIndex]['price']);
      }
      if (widget.getProductQuantity != null) {
        widget.getProductQuantity!(widget.title, _amount);
      }
    });
  }

  void _decrementAmount() {
    if (_amount > 1) {
      setState(() {
        _amount--;
        checkPriceList(true);
        if (widget.getProductQuantity != null) {
          widget.getProductQuantity!(widget.title, _amount);
        }
      });
      if (widget.utils != null) widget.utils!.subtractFromPrice();
    } else {
      if (_canDelete && widget.deleteProduct != null) {
        widget.deleteProduct!(widget.title);
      }
    }
  }

  void checkPriceList(bool isDecrement) async {
    if (widget.utils != null) {
      String lowerBound = '0';
      String upperBound = '1';
      if (widget.priceList![currentActivePriceIndex]['description']
          .contains('-')) {
        upperBound = widget.priceList![currentActivePriceIndex]['description']
            .split(' - ')[1];
        lowerBound = widget.priceList![currentActivePriceIndex]['description']
            .split(' - ')[0];
      }

      print('upperbound:  $upperBound, lowerBound: $lowerBound,');

      if (isDecrement) {
        if (_amount < int.parse(lowerBound) &&
            currentActivePriceIndex - 1 >= widget.initialActivePriceIndex!) {
          currentActivePriceIndex--;
          widget.utils!.updateActivePriceIndex(currentActivePriceIndex);
        }
      } else {
        if (upperBound == 'unlimited') {
          return;
        } else if (_amount > int.parse(upperBound) &&
            currentActivePriceIndex + 1 < widget.priceList!.length) {
          currentActivePriceIndex++;
          widget.utils!.updateActivePriceIndex(currentActivePriceIndex);
        }
      }
      //widget.getProductQuantity(widget.title, _amount);
    } else {
      print('updating quantity');
      List cart = await getCart();
      Map<String, dynamic> product =
          cart.where((el) => el['name'] == widget.title).first;
      if (product.isEmpty) return;
      int index = 0;
      String lowerBound = '0';
      String upperBound = '1';
      for (int i = 0; i < product['priceList']!.length; i++) {
        if (product['priceList'][i]['description'].contains(' - ')) {
          upperBound = product['priceList'][i]['description'].split(' - ')[1];
          lowerBound = product['priceList'][i]['description'].split(' - ')[0];
          if (_amount >= int.parse(lowerBound) && upperBound == 'unlimited') {
            index = i;
            break;
          }
          if (_amount >= int.parse(lowerBound) &&
              _amount <= int.parse(upperBound)) {
            index = i;
            break;
          }
        }
      }
      if (_amount > 1) {
        String lowerBound = '0';
        String upperBound = '1';

        for (int i = 0; i < product['priceList'].length; i++) {
          if (product['priceList'][i]['description'].contains(' - ')) {
            upperBound = product['priceList'][i]['description'].split(' - ')[1];
            lowerBound = product['priceList'][i]['description'].split(' - ')[0];
            print('upperbound:  $upperBound, lowerBound: $lowerBound,');
            if (upperBound == 'unlimited') {
              if (_amount >= int.parse(lowerBound)) {
                if (isDecrement) {
                  widget.getProductQuantityCheckout!(
                      widget.title, _amount, null);
                } else {
                  widget.getProductQuantityCheckout!(widget.title, _amount,
                      product['priceList']![index]['price']);
                }
                break;
              }
            } else if (_amount >= int.parse(lowerBound) &&
                _amount <= int.parse(upperBound)) {
              print('upperbound:  $upperBound, lowerBound: $lowerBound,');
              if (isDecrement) {
                widget.getProductQuantityCheckout!(widget.title, _amount, null);
              } else {
                widget.getProductQuantityCheckout!(widget.title, _amount,
                    product['priceList']![index]['price']);
              }
              break;
            }
          }
        }
      } else {
        if (isDecrement) {
          widget.getProductQuantityCheckout!(widget.title, _amount, null);
        } else {
          widget.getProductQuantityCheckout!(
              widget.title, _amount, product['priceList']![index]['price']);
        }
      }
      // if (isDecrement) {
      //   if (_amount < int.parse(lowerBound) &&
      //       currentActivePriceIndex - 1 >= 0) {
      //     currentActivePriceIndex--;

      //   }
      // } else {
      //   if (upperBound == 'unlimited') {
      //     return;
      //   } else if (_amount > int.parse(upperBound)) {
      //     currentActivePriceIndex++;
      //     widget.utils!.updateActivePriceIndex(currentActivePriceIndex);
      //     widget.getProductQuantityCheckout!(widget.title, _amount,
      //         double.parse(product['priceList']![index]['price']));
      //   }
      // }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      currentActivePriceIndex = widget.initialActivePriceIndex ?? 0;
    });
    widget.canDelete != null
        ? _canDelete = widget.canDelete!
        : _canDelete = false;
    _amount = widget.productQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Qty',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: _decrementAmount,
                  child: Center(
                    child: Icon(Icons.remove),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '$_amount',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: _incrementAmount,
                    child: Icon(Icons.add)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
