import 'package:flutter/material.dart';

class InstituteHomeScreen extends StatelessWidget {
  const InstituteHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black54),
        title: const Text('Institution Dashboard', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_outlined, color: Colors.black54),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary cards row
            Row(
              children: [
                _summaryCard('Total Students', '329', Icons.people_outline, Colors.blue),
                const SizedBox(width: 12),
                _summaryCard('High Risk', '14', Icons.warning_amber_outlined, Colors.red),
                const SizedBox(width: 12),
                _summaryCard('Consultants', '8', Icons.medical_services_outlined, Colors.green),
              ],
            ),
            const SizedBox(height: 24),

            // Campus Heatmap section
            _sectionHeader('Campus Heatmap'),
            const SizedBox(height: 12),
            _buildCampusHeatmap(),
            const SizedBox(height: 24),

            // Resource Load Balancer
            _sectionHeader('Consultant Load Balancer'),
            const SizedBox(height: 12),
            _buildLoadBalancer(),
            const SizedBox(height: 24),

            // Pending approvals
            _sectionHeader('Pending Approvals'),
            const SizedBox(height: 12),
            _buildPendingApprovals(),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) => Text(
    title,
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1B4332), letterSpacing: 0.8),
  );

  Widget _summaryCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildCampusHeatmap() {
    final zones = [
      {'name': 'Architecture Dept', 'risk': 0.9, 'color': Colors.red},
      {'name': 'Engineering Block', 'risk': 0.55, 'color': Colors.orange},
      {'name': 'Arts & Humanities', 'risk': 0.3, 'color': Colors.amber},
      {'name': 'Science Faculty', 'risk': 0.15, 'color': Colors.green},
      {'name': 'Dormitory B', 'risk': 0.7, 'color': Colors.deepOrange},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: zones.map((z) {
          final color = z['color'] as Color;
          final risk = z['risk'] as double;
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(z['name'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text('${(risk * 100).toInt()}%', style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: risk,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade100,
                    color: color,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLoadBalancer() {
    final consultants = [
      {'name': 'Dr. Sarah Jenkins', 'load': 0.92, 'patients': 18, 'status': 'OVERLOADED'},
      {'name': 'Dr. Michael Lee', 'load': 0.45, 'patients': 9, 'status': 'AVAILABLE'},
      {'name': 'Dr. Priya Sharma', 'load': 0.68, 'patients': 13, 'status': 'MODERATE'},
    ];

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: consultants.map((c) {
          final load = c['load'] as double;
          final color = load > 0.8 ? Colors.red : load > 0.6 ? Colors.orange : Colors.green;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(Icons.person_outline, color: color),
            ),
            title: Text(c['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: load, minHeight: 5, backgroundColor: Colors.grey.shade100, color: color),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${c['patients']}', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                Text(c['status'] as String, style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPendingApprovals() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          _approvalTile('Elena Gilbert', 'New patient registration', 'NEW'),
          const Divider(height: 1),
          _approvalTile('Stefan Salvatore', 'Consultant reassignment request', 'URGENT'),
          const Divider(height: 1),
          _approvalTile('Bethany Smith', 'Group cohort creation', 'PENDING'),
        ],
      ),
    );
  }

  Widget _approvalTile(String name, String action, String tag) {
    final tagColor = tag == 'URGENT' ? Colors.red : tag == 'NEW' ? Colors.blue : Colors.orange;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade100,
        child: Text(name[0], style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(action, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: tagColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(tag, style: TextStyle(color: tagColor, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          TextButton(onPressed: () {}, child: const Text('APPROVE', style: TextStyle(color: Color(0xFF006064), fontSize: 11, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
