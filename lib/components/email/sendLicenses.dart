import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendLicenses(
    {required String email,
    required String title,
    required String name,
    required String link,
    required String licenses,
    required String product}) async {
  final serviceId = 'service_igwbojp';
  final templateId = 'template_license_resend';
  final userId = 'Jmk16IabzDvgmXBeJ';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'app_link': link,
          'license_list': licenses,
          'member_name': name,
          'user_email': email,
          'product_name': product,
          'title': title
        }
      }));

  print(response.body);
}
