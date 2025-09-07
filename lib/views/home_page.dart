import 'package:breeziai/controllers/agent_controller.dart';
import 'package:breeziai/widgets/command_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AgentController _controller = AgentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BreeziAI')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CommandButton(
            title: 'Turn ON Bluetooth',
            onPressed: () => _controller.processCommand('turn_on_bluetooth'),
          ),
          CommandButton(
            title: 'Open Gmail',
            onPressed: () => _controller.processCommand('open_gmail'),
          ),
          CommandButton(
            title: 'Send Test Email',
            onPressed: () => _controller.processCommand('send_email'),
          ),
          CommandButton(
            title: 'Call Mom',
            onPressed: () => _controller.processCommand('make_call'),
          ),
          CommandButton(
            title: 'Send SMS to Dad',
            onPressed: () => _controller.processCommand('send_sms'),
          ),
        ],
      ),
    );
  }
}
