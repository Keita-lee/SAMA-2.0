import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendElectionUpdate({
  required String description,
  required String nomDates,
  required String acceptanceDates,
  required String election,
  required String chairDates,
  required String email,
}) async {
  final serviceId = 'service_e806g0h';
  final templateId = 'template_2tv3c3b';
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
          'description': description,
          "nomDates": nomDates,
          "acceptanceDates": acceptanceDates,
          "election": election,
          "chairDates": chairDates,
          'user_email': email,
        }
      }));

  print(response.body);
}
