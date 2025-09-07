// lib/controllers/agent_controller.dart
import 'dart:convert';
import '../models/instruction_response_model.dart'; // Adjust path if needed
import '../models/agent_specific_model.dart'; // Adjust path if needed
import '../services/bluetooth_service.dart';
import '../services/app_service.dart';
import '../services/phone_service.dart';

class AgentController {
  // Instantiate your services
  final BluetoothService _bluetoothService = BluetoothService();
  final AppService _appService = AppService();
  final PhoneService _phoneService = PhoneService();

  // This map holds your mock JSON responses
  final Map<String, String> mockLLMResponses = {
    'turn_on_bluetooth': '''
      {
        "instruction": "Turn on Bluetooth",
        "response": {
          "text": "Bluetooth has been enabled.",
          "actions": [
            { "type": "toggle_bluetooth", "parameters": { "state": "on" } }
          ]
        }
      }
    ''',
    'open_gmail': '''
      {
        "instruction": "Open Gmail",
        "response": {
          "text": "Opening Gmail app.",
          "actions": [
            { "type": "open_app", "parameters": { "packageName": "com.google.android.gm" } }
          ]
        }
      }
    ''',
    'send_email': '''
      {
        "instruction": "Send an email to John",
        "response": {
          "text": "Composing an email to John.",
          "actions": [
            {
              "type": "compose_email",
              "parameters": {
                "packageName": "com.google.android.gm",
                "to": "john@example.com",
                "subject": "Meeting Update",
                "body": "Let's catch up at 3 PM tomorrow."
              }
            }
          ]
        }
      }
    ''',
    'make_call': '''
      {
        "instruction": "Call Mom",
        "response": {
          "text": "Calling Mom.",
          "actions": [
            { "type": "make_call", "parameters": { "phoneNumber": "+911234567890" } }
          ]
        }
      }
    ''',
    'send_sms': '''
      {
        "instruction": "Send message to Dad",
        "response": {
          "text": "Sending SMS to Dad.",
          "actions": [
            {
              "type": "send_sms",
              "parameters": {
                "phoneNumber": "+919876543210",
                "message": "Hi Dad, I’ll be home soon."
              }
            }
          ]
        }
      }
    ''',
  };

  // This is the main function the View will call
  Future<void> processCommand(String commandKey) async {
    final jsonString = mockLLMResponses[commandKey];
    if (jsonString == null) {
      print("Error: No mock response found for command '$commandKey'");
      return;
    }

    // 1. Decoding the JSON string into a Map
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    // 2. Parsing the Map into the Dart Model
    final instructionResponse = InstructionResponse.fromJson(jsonMap);

    print("Instruction: ${instructionResponse.instruction}");
    print("Response Text: ${instructionResponse.response.text}");

    // 3. Looping through actions and executing them
    for (final action in instructionResponse.response.actions) {
      await _executeAction(action);
    }
  }

  // Private helper to execute a single action
  Future<void> _executeAction(ActionData action) async {
    switch (action.type) {
      case 'toggle_bluetooth':
        final params = BluetoothParams.fromJson(action.parameters);
        await _bluetoothService.toggle(params.state);
        break;
      case 'open_app':
        final params = AppParams.fromJson(action.parameters);
        await _appService.openApp(params.packageName);
        break;
      case 'compose_email':
        final params = EmailParams.fromJson(action.parameters);
        await _appService.composeEmail(params.to, params.subject, params.body);
        break;
      case 'make_call':
        final params = CallParams.fromJson(action.parameters);
        await _phoneService.makeCall(params.phoneNumber);
        break;
      case 'send_sms':
        final params = SmsParams.fromJson(action.parameters);
        await _phoneService.sendSms(params.phoneNumber, params.message);
        break;
      default:
        print("Error: Unknown action type '${action.type}'");
    }
  }
}
