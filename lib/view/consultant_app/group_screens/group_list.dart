import 'package:flutter/material.dart';

class GroupsListScreen extends StatelessWidget {
  const GroupsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black54),
        title: const Text("Groups", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: const [
          Icon(Icons.search, color: Colors.black54),
          SizedBox(width: 16),
          Icon(Icons.add, color: Colors.black54),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text("MY INSTITUTIONS & COHORTS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey, letterSpacing: 1.2)),
          const SizedBox(height: 16),
          _buildInstitutionCard(
            "Saint Jude Medical Center",
            "Academic Institution • 12 Cohorts",
            Icons.domain,
            const Color(0xFFE0F2F1),
            "2 HIGH RISK PATIENTS",
            "142 TOTAL",
            Colors.red,
          ),
          const SizedBox(height: 16),
          _buildInstitutionCard(
            "Anxiety Support Group A",
            "Managed Cohort • Active since Jan 2023",
            Icons.group,
            const Color(0xFFF3E5F5),
            "STABLE",
            "18 TOTAL",
            Colors.green,
            isSelected: true,
          ),
          const SizedBox(height: 16),
          _buildInstitutionCard(
            "University Counseling",
            "Student Wellness • 8 Cohorts",
            Icons.school,
            const Color(0xFFE8EAF6),
            "5 ALERTS PENDING",
            "89 TOTAL",
            Colors.orange,
          ),
          const SizedBox(height: 30),
          _buildArchiveButton(),
        ],
      ),
    );
  }

  Widget _buildInstitutionCard(String title, String sub, IconData icon, Color iconBg, String badgeText, String totalText, Color badgeColor, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: const Color(0xFF006064), width: 1.5) : Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.blueGrey.shade700)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: badgeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    if (badgeColor == Colors.green) const Icon(Icons.check_circle, size: 12, color: Colors.green)
                    else if (badgeColor == Colors.red) const Icon(Icons.priority_high, size: 12, color: Colors.red)
                    else const Icon(Icons.bolt, size: 12, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(badgeText, style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.people_outline, size: 14, color: Colors.grey.shade400),
              const SizedBox(width: 4),
              Text(totalText, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildArchiveButton() {
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.archive_outlined, color: Color(0xFF006064), size: 18),
        label: const Text("VIEW ARCHIVED GROUPS", style: TextStyle(color: Color(0xFF006064), fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }
}