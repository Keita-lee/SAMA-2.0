import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendDigitalProduct(
    {required String email,
    required String title,
    required String name,
    required String link,
    required String product}) async {
  final serviceId = 'service_igwbojp';
  final templateId = 'email_digitalprod';
  final userId = 'Jmk16IabzDvgmXBeJ';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_email': email,
          'member_name': name,
          'title': title,
          'product_download': link,
          'product_name': product,
        }
      }));

  print(response.body);
}
