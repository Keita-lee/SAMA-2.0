import 'package:flutter/material.dart';
import 'package:sama/components/CustomSearchBar.dart';
import 'package:sama/components/checkBox.dart';
import 'package:sama/components/customCheckbox.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class FilterMemberRowWidget extends StatelessWidget {
  final Function(String) onSearch;
  const FilterMemberRowWidget({Key? key, required this.onSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width * 0.745,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Search Field
              Flexible(
                flex: 6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomSearchBar(
                      onSearch: onSearch,
                      width: 400,
                      borderColor: Colors.black,
                      backgroundColor: Colors.white,
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

          // Buttons
        ],
      ),
    );
  }
}
