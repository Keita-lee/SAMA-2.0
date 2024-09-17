import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/adminManagement/createAdmin.dart';
import 'package:sama/admin/adminManagement/permissions/updatePermissions.dart';
import 'package:sama/components/AdminTable.dart';
import 'package:sama/components/TabButton.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/homePage/dashboard/menu/PostLoginLeft.dart';

class AdminManagement extends StatefulWidget {
  const AdminManagement({super.key});

  @override
  State<AdminManagement> createState() => _AdminManagementState();
}

class _AdminManagementState extends State<AdminManagement> {
  final _firestore = FirebaseFirestore.instance;
  int _activeTabIndex = 0;
  List<Map<String, dynamic>> membersList = [];
  String _searchText = '';
  bool _isLoading = true;
  Map<String, dynamic> selectedMember = {};
  void onSearchChanged(String text) {
    setState(() {
      _searchText = text;
    });
  }

  void changeActiveIndex(int index) {
    setState(() {
      _activeTabIndex = index;
    });
  }

  void _getMembersData() async {
    int index = 0;
    String currentID = '';

    try {
      QuerySnapshot<Map<String, dynamic>> members = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'Admin')
          .get();

      if (members.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          membersList = members.docs.map((member) {
            index++;
            currentID = member.id;
            final role = member['permissions'].first['permission'] == true
                ? 'Super Admin'
                : 'Admin';
            return {
              "firebaseId": member.id,
              "full name": '${member['firstName']} ${member['lastName']}',
              "email": member['email'] ?? member['emailAddress'],
              "role": role,
              "permissions": member['permissions'],
            };
          }).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('error fetching member ${currentID}: $e');
    }
  }

  @override
  void initState() {
    _getMembersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MyUtility(context).width * 0.78,
        child: Column(
          children: [
            SizedBox(
              width: MyUtility(context).width * 0.745,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _activeTabIndex == 0
                      ? const Text(
                          'All Admin Members',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(55, 94, 144, 1)),
                        )
                      : const Text(
                          'View Member Permissions',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(55, 94, 144, 1)),
                        ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Row(
                      children: [
                        TabButton(
                            title: 'View Admins',
                            isActive: _activeTabIndex == 0,
                            onTap: () => changeActiveIndex(0)),
                        const SizedBox(
                          width: 15,
                        ),
                        _activeTabIndex == 2
                            ? const SizedBox.shrink()
                            : TabButton(
                                title: 'Create Admin',
                                isActive: _activeTabIndex == 1,
                                onTap: () {
                                  if (activeIndex == 2) {
                                    changeActiveIndex(0);
                                  }
                                  changeActiveIndex(1);
                                  setState(() {
                                    selectedMember = {};
                                  });
                                }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Visibility(
              visible: _activeTabIndex == 0,
              child: AdminTable(
                searchResult: _searchText,
                columnHeaders: const ['Full Name', 'Email', 'Role'],
                dataList: membersList,
                waiting: _isLoading,
                actions: [
                  (data) => IconButton(
                        onPressed: () {
                          print('member data: $data');
                          setState(() {
                            _activeTabIndex = 2;
                            selectedMember = data;
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 22.0,
                        ),
                      ),
                  (data) => IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete, size: 24.0),
                      ),
                ],
              ),
            ),
            Visibility(
              visible: _activeTabIndex == 1 || _activeTabIndex == 2,
              child: Createadmin(
                  memberData: selectedMember,
                  changePageIndex: changeActiveIndex),
            ),
          ],
        ),
      ),
    );
  }
}
