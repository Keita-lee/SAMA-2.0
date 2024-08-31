import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sama/components/CustomSearchBar.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/login/popups/validateDialog.dart';
import 'package:sama/utils/tokenManager.dart';

class MemberStanding extends StatefulWidget {
  const MemberStanding({super.key});

  @override
  State<MemberStanding> createState() => _MemberStandingState();
}

class _MemberStandingState extends State<MemberStanding> {
  final _firebase = FirebaseFirestore.instance;
  bool _isLoading = false;
  String _samaMemberStatus = '';
  final TextEditingController _samaNoController = TextEditingController();

  void _onSearch(String value) {}

  @override
  void dispose() {
    // TODO: implement dispose
    _samaNoController.dispose();
    super.dispose();
  }

  bool validateSamaNo() {
    final String text = _samaNoController.text;
    if (text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                child: ValidateDialog(
                    description: 'Please enter a sama number to check',
                    closeDialog: () => Navigator.pop(context!)));
          });
      return false;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                child: ValidateDialog(
                    description: 'Please enter a valid sama number',
                    closeDialog: () => Navigator.pop(context!)));
          });
      return false;
    }

    return true;
  }

  void _checkSamaNo() async {
    if (!validateSamaNo()) return;

    final TokenManager tokenManager = TokenManager();
    final TokenStorage storage = TokenStorage();
    // Ensure the token is valid or refresh it if needed
    await tokenManager.refreshTokenIfNeeded();
    // Get the valid token
    String? token = await storage.getToken();

    if (token == null || token == '') {
      print('error getting token');
      return;
    }

    http.get(
        Uri.parse(
            'http://41.217.246.121:8080/ords/ordssama/web-clients/clients/${_samaNoController.text}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }).then((response) {
      final data = jsonDecode(response.body);
      List items = data['items'];
      if (items.isNotEmpty) {
        print(items[0]);
        if (items[0]['membership_paid'] == 'Y') {
          setState(() {
            _isLoading = false;
            _samaMemberStatus = 'Good Standing';
          });
        } else {
          setState(() {
            _isLoading = false;
            _samaMemberStatus = 'Not Good Standing';
          });
        }
      } else {
        print(response.body);
        setState(() {
          _isLoading = false;
          _samaMemberStatus = 'Not Good Standing';
        });
      }
    }).catchError((e) {
      print('error checking sama no: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MyUtility(context).width * 0.745,
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      color: const Color.fromARGB(255, 51, 51, 51),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: TextFormField(
                    controller: _samaNoController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              _isLoading
                  ? StyleButton(
                      description: "Loading...",
                      height: 55,
                      width: 160,
                      onTap: () {})
                  : StyleButton(
                      description: "Lookup Sama No",
                      height: 55,
                      width: 160,
                      onTap: () {
                        _checkSamaNo();
                      },
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _samaMemberStatus != ''
            ? Container(
                width: MyUtility(context).width * 0.745,
                height: 50,
                decoration: BoxDecoration(
                    color: _samaMemberStatus == 'Good Standing'
                        ? Color.fromARGB(255, 134, 246, 143)
                        : Color.fromARGB(255, 255, 134, 134),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: _samaMemberStatus == 'Good Standing'
                      ? const Text(
                          'Member is in good standing',
                        )
                      : const Text(
                          'Member is not in good standing',
                        ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
