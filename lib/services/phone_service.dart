import 'package:url_launcher/url_launcher.dart';

class PhoneService {
  Future<void> makeCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      print("Making call to: $phoneNumber");
    } else {
      print("Could not make call to $phoneNumber");
    }
  }

  Future<void> sendSms(String phoneNumber, String message) async {
    final Uri url = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      print("Sending SMS to: $phoneNumber");
    } else {
      print("Could not send SMS to $phoneNumber");
    }
  }
}
