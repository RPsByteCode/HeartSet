import 'package:flutter/material.dart';

class GuardianModeScreen extends StatefulWidget {
  const GuardianModeScreen({super.key});

  @override
  State<GuardianModeScreen> createState() => _GuardianModeScreenState();
}

class _GuardianModeScreenState extends State<GuardianModeScreen> {
  // State to track if Guardian Priority is active
  bool isPriorityOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const Spacer(flex: 2),
            _buildMainToggle(),
            const SizedBox(height: 30),
            _buildStatusIndicator(),
            const SizedBox(height: 40),
            _buildContextDescription(),
            const Spacer(flex: 2),
            _buildPrivacyCard(),
            const SizedBox(height: 20),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Guardian Mode",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1A1F2C)),
          ),
          SizedBox(height: 4),
          Text(
            "I am available for emergencies",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildMainToggle() {
    return GestureDetector(
      onTap: () => setState(() => isPriorityOn = !isPriorityOn),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 160,
        height: 85,
        decoration: BoxDecoration(
          color: isPriorityOn ? const Color(0xFF10B981) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(6),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: isPriorityOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 73,
            height: 73,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Column(
      children: [
        const Text(
          "Active Watch",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1F2C)),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.circle, size: 8, color: isPriorityOn ? const Color(0xFF10B981) : Colors.grey),
            const SizedBox(width: 8),
            Text(
              isPriorityOn ? "GUARDIAN PRIORITY ON" : "PRIORITY SUSPENDED",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: isPriorityOn ? Colors.black87 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContextDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        isPriorityOn 
          ? "You will be prioritized as a first responder during emergency events."
          : "You are currently excluded from immediate emergency alerts.",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
      ),
    );
  }

  Widget _buildPrivacyCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Privacy Note: Monitoring is passive. No personal diary or activity logs are shared. You will only be notified during emergencies.",
              style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Column(
      children: [
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(Icons.visibility, "WATCH", true),
              _navItem(Icons.notifications_none, "ALERTS", false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.black : Colors.grey.shade400),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? Colors.black : Colors.grey.shade400)),
      ],
    );
  }
}