import 'package:flutter/material.dart';

class ConsultantDashboard extends StatefulWidget {
  const ConsultantDashboard({super.key});

  @override
  State<ConsultantDashboard> createState() => _ConsultantDashboardState();
}

class _ConsultantDashboardState extends State<ConsultantDashboard> {
  
  @override
  void initState() {
    super.initState();
    // Logic to show the emergency dialog shortly after build
    Future.delayed(const Duration(seconds: 1), () => _showDistressDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text("Consultant Dashboard", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.shield_outlined, color: Colors.teal),
          )
        ],
        // The red alert banner at the very top
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: const Color(0xFFD32F2F),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.white),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    "Distress Signal: Marcus Aurelius (10:42 AM)",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("ACTION REQUIRED", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("DAILY SCHEDULE", "Oct 24, 2023"),
            _buildScheduleCard(),
            const SizedBox(height: 24),
            
            _buildSectionHeader("PENDING REQUESTS", ""),
            _buildRequestsCard(),
            const SizedBox(height: 24),
            
            _buildSectionHeader("PATIENT RISK OVERVIEW", ""),
            _buildRiskOverviewCard(),
          ],
        ),
      )
    );
  }

  // Helper for Section Headers
  Widget _buildSectionHeader(String title, String trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B4332), letterSpacing: 1)),
          Text(trailing, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  // Schedule Section
  Widget _buildScheduleCard() {
    return _whiteCard(
      child: Column(
        children: [
          _scheduleTile("09:00", "Bethany Smith", "CBT Session - Week 4", Icons.videocam, Colors.teal),
          const Divider(),
          _scheduleTile("10:30", "Marcus Aurelius", "Emergency Follow-up", Icons.priority_high, Colors.red),
          const Divider(),
          _scheduleTile("12:00", "David Goggins", "", null, Colors.grey),
        ],
      ),
    );
  }

  Widget _scheduleTile(String time, String name, String sub, IconData? icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Column(children: [Text(time, style: const TextStyle(fontWeight: FontWeight.bold)), const Text("AM", style: TextStyle(fontSize: 10))]),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                if (sub.isNotEmpty) Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          if (icon != null) Icon(icon, color: iconColor, size: 18),
        ],
      ),
    );
  }

  // Pending Requests Section
  Widget _buildRequestsCard() {
    return _whiteCard(
      child: Column(
        children: [
          _requestTile("Elena Gilbert", "Requested 2h ago", "NEW", Colors.blue),
          const Divider(),
          _requestTile("Stefan Salvatore", "Requested 5h ago", "URGENT", Colors.orange),
        ],
      ),
    );
  }

  Widget _requestTile(String name, String time, String tag, Color tagColor) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: tagColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
          child: Text(tag, style: TextStyle(color: tagColor, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        TextButton(onPressed: () {}, child: const Text("APPROVE", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
      ],
    );
  }

  // Risk Overview Section
  Widget _buildRiskOverviewCard() {
    return _whiteCard(
      child: Column(
        children: [
          _riskTile("MA", "Marcus Aurelius", 0.9, "HIGH", Colors.red),
          _riskTile("EG", "Elena Gilbert", 0.5, "MED", Colors.orange),
          _riskTile("DG", "David Goggins", 0.2, "LOW", Colors.green),
        ],
      ),
    );
  }

  Widget _riskTile(String initials, String name, double progress, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), radius: 18, child: Text(initials, style: TextStyle(color: color, fontSize: 12))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade200, color: color, minHeight: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Card Wrapper
  Widget _whiteCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  // The Active Distress Overlay (Screenshot 2)
  void _showDistressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFD32F2F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: const Column(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 48),
                  SizedBox(height: 16),
                  Text("Active Distress", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  Text("Marcus Aurelius triggered a panic alert.", style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _dialogRow("Contact Number:", "+1 (555) 0123"),
                  _dialogRow("Location Access:", "Enabled", valueColor: Colors.teal),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.phone),
                    label: const Text("START EMERGENCY CALL"),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("DISMISS", style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dialogRow(String label, String value, {Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: valueColor)),
        ],
      ),
    );
  }
}