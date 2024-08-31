import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/memberManagement/approveMembers.dart';
import 'package:sama/admin/memberManagement/filterMembersRow.dart';
import 'package:sama/admin/memberManagement/legendIndicators.dart';
import 'package:sama/admin/memberManagement/memberStanding.dart';
import 'package:sama/admin/memberManagement/memberTable.dart';
import 'package:sama/admin/memberManagement/viewAllMembers.dart';
import 'package:sama/components/AdminTable.dart';
import 'package:sama/components/CustomSearchBar.dart';
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
  bool _isStatusLoading = false;
  int _showRowsCount = 100;
  String _searchText = '';

  void onSearchChanged(String text) {
    setState(() {
      _searchText = text;
    });
  }

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
    int index = 0;
    String currentID = '';
    try {
      QuerySnapshot<Map<String, dynamic>> members =
          await _firebase.collection('users').limit(_showRowsCount).get();

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
            return {
              "firebaseId": member.id,
              "id": index.toString(),
              "full name": '${member['firstName']} ${member['lastName']}',
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
      print('error fetching member ${currentID}: $e');
    }
  }

  List<Map<String, dynamic>> get _newMembersList {
    List<Map<String, dynamic>> membersList = this.membersList;
    if (_searchText == '')
      return membersList;
    else
      return membersList.where((doc) => doc['status'] == 'Pending').toList();
  }

  Future<void> deleteMember({required String id}) async {}

  Future<void> declineMember({required String id}) async {}

  List<Map<String, dynamic>> get _filteredMembers {
    return membersList
        .where((doc) =>
            doc['full name'].toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
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
                      ? Text(
                          'Manage Members',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(55, 94, 144, 1)),
                        )
                      : _activeTabIndex == 1
                          ? Text(
                              'Pending Members Approval',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(55, 94, 144, 1)),
                            )
                          : Text(
                              'Member Standings',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(55, 94, 144, 1)),
                            ),
                  Row(
                    children: [
                      TabButton(
                          title: 'All Members',
                          isActive: _activeTabIndex == 0,
                          onTap: () => _onTabSelected(0)),
                      const SizedBox(
                        width: 15,
                      ),
                      TabButton(
                          title: 'Approve Members',
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
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Visibility(
                visible: _activeTabIndex == 0,
                child: ViewAllMembers(
                  showRowsCount: _showRowsCount,
                )),
            Visibility(
              visible: _activeTabIndex == 1,
              child: ApproveMembers(),
            ),
            Visibility(
              visible: _activeTabIndex == 2,
              child: const MemberStanding(),
            )
          ],
        ),
      ),
    );
  }
}
