import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendLicenses(
    {required String email,
    required String name,
    required String licenses}) async {
  final serviceId = 'service_igwbojp';
  // TO DO: add template id
  final templateId = '';
  final userId = 'Jmk16IabzDvgmXBeJ';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'licenses': licenses,
          'member_name': name,
          'user_email': email,
        }
      }));

  print(response.body);
}
