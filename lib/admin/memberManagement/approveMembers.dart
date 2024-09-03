import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/memberManagement/filterMembersRow.dart';
import 'package:sama/components/AdminTable.dart';

import 'memberProfile.dart';

class ApproveMembers extends StatefulWidget {
  const ApproveMembers({super.key});

  @override
  State<ApproveMembers> createState() => _ApproveMembersState();
}

class _ApproveMembersState extends State<ApproveMembers> {
  final _firestore = FirebaseFirestore.instance;
  bool _isLoading = true;
  List<Map<String, dynamic>> _membersList = [];
  String _searchText = '';
  Future<void> updateMemberStatus(
      String id, currentStatus, String status) async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (status == 'Active') {
        if (currentStatus == 'Pending') {
          status = 'Active no email sent';
        } else if (currentStatus == 'Pending email sent') {
          status = 'Active';
        }
      } else if (status == 'Inactive') {
        if (currentStatus == 'Pending') {
          status = 'Inactive no email sent';
        } else if (currentStatus == 'Pending email sent') {
          status = 'Inactive';
        }
      } else {
        if (currentStatus == 'Inactive no email sent' ||
            currentStatus == 'Active no email sent') {
          status = 'Pending';
        }
      }

      await _firestore.collection('users').doc(id).update({
        'status': status,
      });

      setState(() {
        _membersList
            .where((member) => member['firebaseId'] == id)
            .first['status'] = status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('error updating member status: $e');
    }
  }

  void onSearchChanged(String text) {
    setState(() {
      _searchText = text;
    });
  }

  void _getPendingMembers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> pendingMembersSnapshot =
          await _firestore.collection('users').where('status', whereIn: [
        'Pending',
        'Active no email sent',
        'Pending email sent'
      ]).get();
      if (pendingMembersSnapshot.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _membersList = pendingMembersSnapshot.docs.map((member) {
          String samaNumber = '';
          if (member.data().containsKey('samaNumber')) {
            samaNumber = member['samaNumber'];
          }

          return {
            "firebaseId": member.id,
            "full name": '${member['firstName']} ${member['lastName']}',
            "sama no": samaNumber,
            "email": member['email'] ?? member['emailAddress'],
            "status": member['status'],
          };
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('error fetching pending members: $e');
    }
  }

  void showDynamicDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onContinue,
    required VoidCallback onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF174486)),
              ),
              onPressed: onCancel,
            ),
            ElevatedButton(
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(Color(0xFF174486))),
              onPressed: onContinue,
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _getPendingMembers();
    super.initState();
  }

  void _sendEmail(String id, String status) {
    if (status == 'Active no email sent') {
      // TO DO: Send approved email to user
    } else if (status == 'Inactive no email sent') {
      // TO DO: Send rejected email to user
    }
  }

  //view member profile
  //Dialog for benifits
  Future openMemberProfile(id) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: MemberProfile(
          id: id,
          closeDialog: () => Navigator.pop(context!),
        ));
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterMemberRowWidget(
          onSearch: onSearchChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        AdminTable(
          emptyMessage: 'No pending members to approve',
          columnHeaders: const ['Full Name', 'SAMA No', 'Email', 'Status'],
          dataList: _membersList,
          waiting: _isLoading,
          actions: [
            (data) => PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (String result) {
                    switch (result) {
                      case 'approve':
                        showDynamicDialog(
                          context: context,
                          title: 'Confirmation',
                          content:
                              'Are you sure you want to approve this user?',
                          onContinue: () {
                            updateMemberStatus(
                                data['firebaseId'], data['status'], 'Active');
                            Navigator.of(context).pop();
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                        );
                        break;
                      case 'decline':
                        showDynamicDialog(
                          context: context,
                          title: 'Confirmation',
                          content:
                              'Are you sure you want to decline this user?',
                          onContinue: () {
                            updateMemberStatus(
                                data['firebaseId'], data['status'], 'Inactive');
                            Navigator.of(context).pop();
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                        );
                        break;
                      case 'send_email':
                        _sendEmail(data['firebaseId'], data['status']);
                        break;
                      case 'set_pending':
                        showDynamicDialog(
                          context: context,
                          title: 'Confirmation',
                          content:
                              'Are you sure you want to set pending this user status?',
                          onContinue: () {
                            updateMemberStatus(
                                data['firebaseId'], data['status'], 'Pending');
                            Navigator.of(context).pop();
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                        );
                        break;
                      case 'profile':
                        openMemberProfile(data['firebaseId']);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    List<PopupMenuEntry<String>> menuItems = [];
                    menuItems.add(const PopupMenuItem<String>(
                      value: 'profile',
                      child: Text('View Profile'),
                    ));
                    // Dynamically add menu items based on the user's status
                    if (data['status'] == 'Pending') {
                      menuItems.add(const PopupMenuItem<String>(
                        value: 'approve',
                        child: Text('Approve Member'),
                      ));
                      menuItems.add(const PopupMenuItem<String>(
                        value: 'decline',
                        child: Text('Decline Member'),
                      ));
                    } else if (data['status'] == 'Active no email sent' ||
                        data['status' == 'Inactive no email sent']) {
                      menuItems.add(const PopupMenuItem<String>(
                        value: 'send_email',
                        child: Text('Send Email'),
                      ));
                    } else if (data['status'] != 'Pending') {
                      menuItems.add(const PopupMenuItem<String>(
                        value: 'set_pending',
                        child: Text('Set Pending Status'),
                      ));
                    }

                    return menuItems;
                  },
                )
          ],
          searchResult: '',
        ),
      ],
    );
  }
}
