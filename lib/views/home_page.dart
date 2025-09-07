import 'package:breeziai/controllers/agent_controller.dart';
import 'package:breeziai/utils/colours.dart';
import 'package:breeziai/widgets/action_card.dart';
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
      appBar: AppBar(
        surfaceTintColor: MyColours.background,
        backgroundColor: Colors.transparent,
        elevation: 2,
        title: Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.blue.shade700),
            const SizedBox(width: 8),
            const Text(
              'BreeziAI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A202C),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildWelcomeHeader(),
              const SizedBox(height: 24),
              _buildSectionTitle('What can I help you with?'),
              const SizedBox(height: 16),
              _buildActionGrid(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      // This bottom bar establishes the core AI interaction point for the future
      // bottomNavigationBar: BottomAppBar(
      //   color: MyColours.primary,
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 8.0,
      //   child: Container(height: 60.0),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // In the future, this will trigger voice recognition
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Voice command feature coming soon!')),
      //     );
      //   },
      //   backgroundColor: Colors.blue.shade600,
      //   child: const Icon(Icons.mic, color: Colors.white),
      // ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your personal agent is ready to assist you.',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4A5568),
      ),
    );
  }

  Widget _buildActionGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 20,
      mainAxisSpacing: 10,
      children: [
        ActionCard(
          title: 'Bluetooth On',
          icon: Icons.bluetooth,
          color: Colors.blue,
          onPressed: () => _controller.processCommand('turn_on_bluetooth'),
        ),
        ActionCard(
          title: 'Open Gmail',
          icon: Icons.email,
          color: Colors.red,
          onPressed: () => _controller.processCommand('open_gmail'),
        ),
        ActionCard(
          title: 'Compose Email',
          icon: Icons.edit,
          color: Colors.orange,
          onPressed: () => _controller.processCommand('send_email'),
        ),
        ActionCard(
          title: 'Make a Call',
          icon: Icons.call,
          color: Colors.green,
          onPressed: () => _controller.processCommand('make_call'),
        ),
        ActionCard(
          title: 'Send SMS',
          icon: Icons.sms,
          color: Colors.teal,
          onPressed: () => _controller.processCommand('send_sms'),
        ),
        ActionCard(
          title: 'More...',
          icon: Icons.more_horiz,
          color: Colors.grey,
          onPressed: () {},
        ),
      ],
    );
  }
}
