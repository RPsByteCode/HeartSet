import 'package:flutter/material.dart';

class PatientDetailScreen extends StatelessWidget {
  const PatientDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Marcus Aurelius", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
            Text("CASE #8821-XP", style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
          ],
        ),
        actions: [
          _buildHighRiskAlert(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006064),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {},
              child: const Text("START SESSION", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            _buildProfileCard(),
            const SizedBox(height: 16),
            
            // Section Label
            const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 8),
              child: Text("DEMOGRAPHICS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey, letterSpacing: 1.2)),
            ),

            // Clinical Session Notes Card
            _buildClinicalNotesCard(),
            const SizedBox(height: 16),

            // Patient Companion Card
            _buildCompanionCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHighRiskAlert() {
    return Row(
      children: [
        const Icon(Icons.ac_unit, color: Colors.red, size: 18), // Using ac_unit as placeholder for star icon
        const SizedBox(width: 4),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("HIGH RISK", style: TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.bold)),
            Text("ALERT", style: TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.person, color: Colors.redAccent),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Marcus Aurelius", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("42 Years Old • Male", style: TextStyle(color: Colors.grey.shade500)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.red.shade50.withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: const [
                Icon(Icons.error, color: Colors.red, size: 14),
                SizedBox(width: 8),
                Text("Risk Factor: Critical (92/100)", style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildClinicalNotesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("CLINICAL SESSION NOTES", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                child: const Text("AUTOSAVED 12:45 PM", style: TextStyle(fontSize: 9, color: Colors.grey)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Enter a note here...",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF9FBFA),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.format_bold, color: Colors.grey),
              const SizedBox(width: 16),
              const Icon(Icons.format_italic, color: Colors.grey),
              const SizedBox(width: 16),
              const Icon(Icons.format_list_bulleted, color: Colors.grey),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006064),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
                child: const Text("FINALIZE NOTE", style: TextStyle(fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCompanionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFE0F7F9).withOpacity(0.5), Colors.white],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text("PATIENT COMPANION", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF00796B), letterSpacing: 1)),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.network("https://cdn-icons-png.flaticon.com/512/616/616408.png"), // Dog icon placeholder
                ),
              ),
              const CircleAvatar(radius: 8, backgroundColor: Colors.white, child: CircleAvatar(radius: 6, backgroundColor: Colors.green)),
            ],
          ),
          const SizedBox(height: 16),
          const Text("\"Barnaby\" is feeling happy!", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1F2C))),
        ],
      ),
    );
  }
}