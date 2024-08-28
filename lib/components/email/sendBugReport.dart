import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendReportIssueEmail({
  required String email,
  required String reportType,
  required String description,
}) async {
  final serviceId = 'service_t6d1ynn';

  final templateId = 'template_562138w';
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
          'report_type': reportType,
          'description': description
        }
      }));

  print(response.body);
}
