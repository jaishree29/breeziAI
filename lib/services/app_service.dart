import 'package:android_intent_plus/android_intent.dart';
import 'package:device_apps/device_apps.dart';

class AppService {
  Future<void> openApp(String packageName) async {
    bool isInstalled = await DeviceApps.isAppInstalled(packageName);
    if (isInstalled) {
      DeviceApps.openApp(packageName);
      print("Opening app: $packageName");
    } else {
      print("App not found: $packageName");
    }
  }

  Future<void> composeEmail(String to, String subject, String body) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {'subject': subject, 'body': body},
    );
    // This uses a general mailto intent, which lets the user choose the email app.
    final intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: emailLaunchUri.toString(),
    );
    await intent.launch();
    print("Composing email to: $to");
  }
}
