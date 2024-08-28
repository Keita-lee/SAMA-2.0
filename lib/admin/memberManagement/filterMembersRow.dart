import 'package:flutter/material.dart';
import 'package:sama/components/checkBox.dart';
import 'package:sama/components/customCheckbox.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class FilterMemberRowWidget extends StatelessWidget {
  const FilterMemberRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width * 0.745,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Search Field
              Flexible(
                flex: 4,
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
              SizedBox(
                width: 20,
              ),
              // Payment Type Dropdown
              Flexible(
                flex: 1,
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
              SizedBox(
                width: 20,
              ),
              // Product Dropdown
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Status"),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                      ),
                      value: 'All',
                      onChanged: (String? newValue) {},
                      items: <String>['All', 'Active', 'Inactive', 'Pending']
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
              SizedBox(
                width: 20,
              ),
              // Rows Dropdown
              Flexible(
                flex: 1,
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
              width: MyUtility(context).width * 0.745,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        _buildLegendIndicator(Color(0xff0c6e08), "Active"),
                        _buildLegendIndicator(
                            Color.fromARGB(255, 175, 0, 0), "Inactive"),
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
