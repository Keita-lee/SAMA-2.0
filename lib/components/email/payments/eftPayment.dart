import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendEftUpdate({
  required String name,
  required String email,
  required String invno,
}) async {
  final serviceId = 'service_igwbojp';
  final templateId = 'template_7zcyne4';
  final userId = 'Jmk16IabzDvgmXBeJ';

  // createOtpVerification(email, otp);
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'member_name': name,
          'user_email': email,
          'invno': invno
        }
      }));
}
