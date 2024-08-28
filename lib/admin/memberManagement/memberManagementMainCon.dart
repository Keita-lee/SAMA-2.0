import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/memberManagement/filterMembersRow.dart';
import 'package:sama/admin/memberManagement/memberTable.dart';
import 'package:sama/components/AdminTable.dart';
import 'package:sama/components/banner/samaBlueBanner.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/TabButton.dart';
import 'package:sama/admin/transactions/filterRow.dart';

class MemberManagementMainCon extends StatefulWidget {
  const MemberManagementMainCon({super.key});

  @override
  State<MemberManagementMainCon> createState() =>
      _MemberManagementMainConState();
}

class _MemberManagementMainConState extends State<MemberManagementMainCon> {
  int _activeTabIndex = 0;
  List<Map<String, dynamic>> membersList = [];
  final _firebase = FirebaseFirestore.instance;
  bool _isLoading = true;

  void _onTabSelected(int index) {
    setState(() {
      _activeTabIndex = index;
    });
  }

  @override
  void initState() {
    _getMembersData();
    super.initState();
  }

  void _getMembersData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> members =
          await _firebase.collection('users').get();

      if (members.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          int index = 0;
          membersList = members.docs.map((member) {
            index++;
            String lastName = "lastName";
            return {
              "id": index.toString(),
              "full name": '${member['firstName']} $lastName',
              "sama no": index.toString(),
              "email": member['email'] ?? member['emailAddress'],
              "status": member['status'],
            };
          }).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('error fetching members: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MyUtility(context).width * 0.78,
        child: Column(
          children: [
            Container(
              width: MyUtility(context).width * 0.745,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Manage Members',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(55, 94, 144, 1)),
                  ),
                  Container(
                    child: Row(
                      children: [
                        TabButton(
                            title: 'All Members',
                            isActive: _activeTabIndex == 0,
                            onTap: () => _onTabSelected(0)),
                        const SizedBox(
                          width: 15,
                        ),
                        TabButton(
                            title: 'New Members',
                            isActive: _activeTabIndex == 1,
                            onTap: () => _onTabSelected(1)),
                        const SizedBox(
                          width: 15,
                        ),
                        TabButton(
                            title: 'Member Standings',
                            isActive: _activeTabIndex == 2,
                            onTap: () => _onTabSelected(2)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            FilterMemberRowWidget(),
            SizedBox(
              height: 20,
            ),
            AdminTable(
              columnHeaders: const [
                'ID',
                'Full Name',
                'SAMA No',
                'Email',
                'Status'
              ],
              dataList: membersList,
              waiting: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
