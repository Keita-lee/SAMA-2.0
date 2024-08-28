import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendPaymentConfirmation({
  required String email,
  required String customerName,
  required String totalPrice,
  required String refNo,
}) async {
  final serviceId = 'service_t6d1ynn';

  final templateId = 'template_z17ehqk';
  final userId = 'Jmk16IabzDvgmXBeJ';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': customerName,
          'user_email': email,
          'order_total': totalPrice,
          'order_ref': refNo
        }
      }));

  print(response.body);
}
