import 'package:flutter/material.dart';
import 'package:sama/components/checkBox.dart';
import 'package:sama/components/customCheckbox.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class FilterRowWidget extends StatelessWidget {
  const FilterRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Search Field
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Search"),
                    const SizedBox(height: 4),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),

              // Payment Type Dropdown
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Payment Type"),
                    const SizedBox(height: 2),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 12),
                      ),
                      value: 'All',
                      onChanged: (String? newValue) {},
                      items: <String>['All', 'Credit Card', 'Cash', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Product Dropdown
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Product"),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                      ),
                      value: 'All',
                      onChanged: (String? newValue) {},
                      items: <String>[
                        'All',
                        'Product A',
                        'Product B',
                        'Product C'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Voided Checkbox
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Voided"),
                    const SizedBox(height: 4),
                    CustomCheckbox(
                      width: 30,
                      height: 30,
                      value: true,
                      onChanged: (bool? value) {},
                    )
                  ],
                ),
              ),

              // Order Voided Checkbox
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Order Voided"),
                    const SizedBox(height: 4),
                    CustomCheckbox(
                      width: 30,
                      height: 30,
                      value: true,
                      onChanged: (bool? value) {},
                    )
                  ],
                ),
              ),

              // Dates Range
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Dates"),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("to"),
                        ),
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Rows Dropdown
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Rows"),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                      ),
                      value: 100,
                      onChanged: (int? newValue) {},
                      items: <int>[10, 25, 50, 100]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Legend Indicators
          Center(
            child: Container(
              width: MyUtility(context).width * 0.76,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        _buildLegendIndicator(
                            Color(0xff0c6e08), "Payment Confirmed"),
                        _buildLegendIndicator(
                            Color.fromARGB(255, 175, 0, 0), "Order Voided"),
                        _buildLegendIndicator(Color(0xffd1d1d1), "Pending"),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StyleButton(
                            description: 'Filter',
                            height: 40,
                            width: 50,
                            onTap: () {}),
                        const SizedBox(width: 16),
                        StyleButton(
                            description: 'Excel Export',
                            height: 40,
                            width: 40,
                            onTap: () {}),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          // Buttons
        ],
      ),
    );
  }

  Widget _buildLegendIndicator(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 6,
            backgroundColor: color,
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
