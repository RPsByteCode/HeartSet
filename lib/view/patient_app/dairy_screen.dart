import 'package:flutter/material.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  // Toggle this to switch between the two screenshots
  bool isLocked = true;

  final List<Map<String, dynamic>> entries = [
    {"date": "Oct 24, 2023", "text": "Today I practiced the breathing exercises...", "icon": Icons.air, "color": Colors.blue},
    {"date": "Oct 23, 2023", "text": "The virtual pet reward really cheered me up...", "icon": Icons.sentiment_satisfied_alt, "color": Colors.green},
    {"date": "Oct 22, 2023", "text": "Felt a bit overwhelmed by the project deadline...", "icon": Icons.error_outline, "color": Colors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Your Diary", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(isLocked ? Icons.lock_outline : Icons.lock_open_rounded, color: Colors.blueAccent),
            onPressed: () => setState(() => isLocked = !isLocked),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Main Banner
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF8E86FF), Color(0xFF7B32FF)]),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(isLocked ? Icons.lock_outline : Icons.lock_open, size: 40, color: Colors.white),
                        const SizedBox(height: 10),
                        Text(
                          isLocked ? "PRIVACY PROTECTED" : "JOURNAL OPEN",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Diary Entries
                  ...entries.map((entry) => diaryCard(entry)).toList(),
                  
                  // Share Section
                  const SizedBox(height: 10),
                  shareConsultantCard(),
                  const SizedBox(height: 100), // Space for the bottom nav
                ],
              ),
            ),
          ),
          
          // Floating Emergency Button
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

  Widget diaryCard(Map<String, dynamic> entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(entry['icon'], color: entry['color']),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("ENTRY DATE", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text(entry['date'], style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const Spacer(),
              if (isLocked) const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 15),
          isLocked 
            ? Center(child: TextButton(onPressed: () {}, child: const Text("Tap to Unlock")))
            : Text(entry['text'], style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  Widget shareConsultantCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2C),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.vpn_key_outlined, color: Colors.grey),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Share with Consultant", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("SECURE ACCESS LINK", style: TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("A 7 - X 9 2 - K 0", style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2)),
                Row(
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Colors.green),
                    SizedBox(width: 5),
                    Text("ACTIVE", style: TextStyle(color: Colors.green, fontSize: 10)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}