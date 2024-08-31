import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendSamaNumber({
  required String samaNumber,
  required String email,
}) async {
  final serviceId = 'service_igwbojp';
  final templateId = 'template_sama_no_otp';
  final userId = '282VyjdH5FOLIffwK';
  // createOtpVerification(email, otp);
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'number': samaNumber,
          'user_email': email,
        }
      }));

  print(response.body);
}
