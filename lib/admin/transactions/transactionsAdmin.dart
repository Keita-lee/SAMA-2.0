import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/tabStyle.dart';
import 'package:sama/admin/transactions/manageProducts/manageProducts.dart';
import 'package:sama/components/AdminTable.dart';
import 'package:sama/components/TabButton.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/admin/transactions/filterRow.dart';

class TransactionsAdmin extends StatefulWidget {
  const TransactionsAdmin({super.key});

  @override
  State<TransactionsAdmin> createState() => _TransactionsAdminState();
}

class _TransactionsAdminState extends State<TransactionsAdmin> {
  int _activeTabIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _activeTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MyUtility(context).width * 0.8,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(55, 94, 144, 1)),
                ),
                Container(
                  child: Row(
                    children: [
                      TabButton(
                          title: 'Products',
                          isActive: _activeTabIndex == 0,
                          onTap: () => _onTabSelected(0)),
                      const SizedBox(
                        width: 15,
                      ),
                      TabButton(
                          title: 'Membership',
                          isActive: _activeTabIndex == 1,
                          onTap: () => _onTabSelected(1)),
                      const SizedBox(
                        width: 15,
                      ),
                      TabButton(
                          title: 'Events',
                          isActive: _activeTabIndex == 2,
                          onTap: () => _onTabSelected(2)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            FilterRowWidget(),
            const SizedBox(height: 20.0),
            Visibility(
                visible: _activeTabIndex == 0, child: const Manageproducts())
          ],
        ),
      ),
    );
  }
}
