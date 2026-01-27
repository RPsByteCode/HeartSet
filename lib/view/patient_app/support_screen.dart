import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  // Data for the Safety Team
  final List<Map<String, dynamic>> safetyTeam = [
    {"name": "Sarah (Guardian)", "status": "ALERTS ENABLED", "isActive": true},
    {"name": "Dr. Michael Smith", "status": "ALERTS PAUSED", "isActive": false},
    {"name": "James (Guardian)", "status": "ALERTS ENABLED", "isActive": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text("Safety & Support", 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1F2C))),
                  const Text("Help is always within reach.", 
                    style: TextStyle(color: Colors.grey)),
                  
                  const SizedBox(height: 30),
                  _buildSectionHeader("My Safety Team", showEdit: true),
                  _buildSafetyTeamCard(),
                  
                  const SizedBox(height: 30),
                  const Text("Immediate Help", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildActionTile(Icons.phone_in_talk_outlined, "Call Crisis Helpline", "Available 24/7 for you", Colors.green.shade50),
                  _buildActionTile(Icons.location_on_outlined, "Nearest Hospital", "Find emergency care nearby", Colors.blue.shade50),
                  
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text("Calm Down", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Icon(Icons.info_outline, size: 16, color: Colors.grey.shade400),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildBreathingExercise(),
                  const SizedBox(height: 100), 
                ],
              ),
            ),
          ),
          
          // Emergency Floating Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {},
              child: const Icon(Icons.report_problem_outlined, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showEdit = false}) {
    return Row(
      children: [
        const Icon(Icons.verified_user_outlined, size: 20, color: Color(0xFF7B32FF)),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Spacer(),
        if (showEdit) TextButton(onPressed: () {}, child: const Text("EDIT", style: TextStyle(fontSize: 12))),
      ],
    );
  }

  Widget _buildSafetyTeamCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        children: safetyTeam.map((member) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: const Icon(Icons.person_outline, color: Colors.blueGrey),
            ),
            title: Text(member['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(member['status'], style: const TextStyle(fontSize: 10, letterSpacing: 1)),
            trailing: Switch(
              value: member['isActive'],
              activeColor: const Color(0xFF7B32FF),
              onChanged: (val) {},
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String sub, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.black54),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBreathingExercise() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Color(0xFFCCD9FF),
            child: Text("2", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1F2C))),
          ),
          const SizedBox(height: 20),
          const Text("Breathe In...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1F2C))),
          const SizedBox(height: 5),
          const Text("Fill your lungs slowly", style: TextStyle(color: Colors.blueAccent)),
        ],
      ),
    );
  }
}