import 'dart:convert';
import 'package:http/http.dart' as http;

Future sendOrderTrackingDetails({
  required String email,
  required String trackingNmr,
  required String title,
  required String name,
}) async {
  final serviceId = 'service_igwbojp';
  final templateId = 'email_prodphysical';
  final userId = 'Jmk16IabzDvgmXBeJ';
  var url = 'https://api.emailjs.com/api/v1.0/email/send';
  var response = await http.post(
    Uri.parse(url),
    headers: {'origin': 'http://localhost', 'Content-Type': 'application/json'},
    body: json.encode(
      {
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'member_name': name,
          'user_email': email,
          'tracking_number': trackingNmr,
          'title': title
        }
      },
    ),
  );

  print(response.body);
}
