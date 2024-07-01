import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class ProductListTop extends StatelessWidget {
  const ProductListTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.black,),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 30,
                child: Text('State'),
              ),
              SizedBox(
                width: MyUtility(context).width * 0.27,
                height: 30,
                child: Text(
                  'Title',
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: MyUtility(context).width * 0.14,
                height: 30,
                child: Text('Type'),
              ),
              SizedBox(
                width: 140,
                height: 30,
                child: Text('Actions'),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.black,),
      ],
    );
  }
}
