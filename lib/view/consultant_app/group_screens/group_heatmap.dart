import 'package:flutter/material.dart';

class GroupHeatmapScreen extends StatelessWidget {
  const GroupHeatmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black54),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Group Heatmap", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
            Text("SAINT JUDE MEDICAL CENTER • COHORT A", style: TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
        actions: [IconButton(icon: const Icon(Icons.filter_list, color: Colors.black54), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLegend(),
            const SizedBox(height: 16),
            _buildHeatmapCard(),
            const SizedBox(height: 24),
            const Text("STUDENT DIRECTORY", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            _buildStudentTile("Marcus Aurelius", "3 URGENT ALERTS THIS WEEK", Colors.red),
            _buildStudentTile("Elena Gilbert", "STABLE WITH MINOR FLUCTUATIONS", Colors.amber),
            _buildStudentTile("David Goggins", "CONSISTENT STABILITY", Colors.green, isSelected: true),
            _buildStudentTile("Cassius Dio", "RECOVERING FROM DISTRESS", Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _legendItem(Colors.green, "STABLE"),
        const SizedBox(width: 12),
        _legendItem(Colors.amber, "ELEVATED"),
        const SizedBox(width: 12),
        _legendItem(Colors.red, "CRITICAL"),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
      ],
    );
  }

  Widget _buildHeatmapCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          _buildDaysHeader(),
          const SizedBox(height: 10),
          _buildHeatmapRow("Marcus A.", [1, 1, 2, 3, 3, 2, 3]),
          _buildHeatmapRow("Elena G.", [1, 1, 1, 1, 2, 1, 1]),
          _buildHeatmapRow("David G.", [1, 1, 1, 1, 1, 1, 1], highlight: true),
          _buildHeatmapRow("Cassius D.", [2, 3, 3, 1, 2, 1, 2]),
        ],
      ),
    );
  }

  Widget _buildDaysHeader() {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      children: [
        const SizedBox(width: 80, child: Text("STUDENT", style: TextStyle(fontSize: 10, color: Colors.grey))),
        ...days.map((d) => Expanded(child: Center(child: Text(d, style: const TextStyle(fontSize: 10, color: Colors.grey))))),
      ],
    );
  }

  Widget _buildHeatmapRow(String name, List<int> statuses, {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: highlight ? BoxDecoration(border: Border.all(color: const Color(0xFF006064), width: 1.5), borderRadius: BorderRadius.circular(8)) : null,
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
          ...statuses.map((s) => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: s == 1 ? Colors.green : s == 2 ? Colors.amber : Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildStudentTile(String name, String sub, Color statusColor, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE0F2F1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isSelected ? Border.all(color: const Color(0xFF006064), width: 1) : null,
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 18, backgroundColor: statusColor.withOpacity(0.1), child: Icon(Icons.person, color: statusColor, size: 20)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sub, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.circle, color: statusColor, size: 10),
        ],
      ),
    );
  }
}