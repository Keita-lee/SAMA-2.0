import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/memberManagement/ui/filterMembersRow.dart';
import 'package:sama/admin/memberManagement/legendIndicators.dart';
import 'package:sama/components/AdminTable.dart';

class ViewAllMembers extends StatefulWidget {
  final int showRowsCount;
  const ViewAllMembers({super.key, required this.showRowsCount});

  @override
  State<ViewAllMembers> createState() => _ViewAllMembersState();
}

class _ViewAllMembersState extends State<ViewAllMembers> {
  List<Map<String, dynamic>> membersList = [];
  bool _isLoading = true;
  String _searchText = "";
  final _firebase = FirebaseFirestore.instance;

  void onSearchChanged(String text) {
    setState(() {
      _searchText = text;
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
          await _firebase.collection('users').limit(widget.showRowsCount).get();

      if (members.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          membersList = members.docs
              .where((member) => member.data().containsKey('status'))
              .map((member) {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterMemberRowWidget(
          onSearch: onSearchChanged,
        ),
        const Legendindicators(),
        const SizedBox(
          height: 20,
        ),
        AdminTable(
          searchResult: _searchText,
          emptyMessage: 'No members to display',
          columnHeaders: const [
            'ID',
            'Full Name',
            'SAMA No',
            'Email',
            'Status'
          ],
          dataList: membersList,
          waiting: _isLoading,
          actions: [
            (data) => IconButton(
                  onPressed: () {},
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
      ],
    );
  }
}
