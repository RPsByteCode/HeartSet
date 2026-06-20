import 'package:flutter/material.dart';

class CohortOrchestratorScreen extends StatefulWidget {
  const CohortOrchestratorScreen({super.key});

  @override
  State<CohortOrchestratorScreen> createState() => _CohortOrchestratorScreenState();
}

class _CohortOrchestratorScreenState extends State<CohortOrchestratorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  final List<Map<String, dynamic>> _students = [
    {'name': 'Marcus Aurelius', 'consultant': 'Dr. Jenkins', 'group': 'Anxiety Support A', 'risk': Colors.red},
    {'name': 'Elena Gilbert', 'consultant': 'Dr. Jenkins', 'group': 'Post-Trauma Cohort', 'risk': Colors.orange},
    {'name': 'David Goggins', 'consultant': 'Dr. Lee', 'group': 'Anxiety Support A', 'risk': Colors.green},
    {'name': 'Cassius Dio', 'consultant': 'Dr. Sharma', 'group': 'Exam Stress Group', 'risk': Colors.orange},
    {'name': 'Bethany Smith', 'consultant': 'Dr. Lee', 'group': 'Dorm B Residents', 'risk': Colors.green},
  ];

  final List<Map<String, dynamic>> _groups = [
    {'name': 'Anxiety Support A', 'members': 12, 'consultant': 'Dr. Jenkins', 'color': Colors.purple},
    {'name': 'Post-Trauma Cohort', 'members': 8, 'consultant': 'Dr. Jenkins', 'color': Colors.blue},
    {'name': 'Exam Stress Group', 'members': 15, 'consultant': 'Dr. Sharma', 'color': Colors.teal},
    {'name': 'Dorm B Residents', 'members': 20, 'consultant': 'Dr. Lee', 'color': Colors.orange},
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Cohort Orchestrator', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.upload_file_outlined, color: Colors.black54), onPressed: _showImportDialog),
          IconButton(icon: const Icon(Icons.add, color: Colors.black54), onPressed: _showCreateGroupDialog),
        ],
        bottom: TabBar(
          controller: _tabCtrl,
          labelColor: const Color(0xFF006064),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF006064),
          tabs: const [Tab(text: 'Students'), Tab(text: 'Groups')],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [_buildStudentList(), _buildGroupList()],
      ),
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _students.length,
      itemBuilder: (_, i) {
        final s = _students[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: (s['risk'] as Color).withValues(alpha: 0.1),
                child: Text((s['name'] as String)[0], style: TextStyle(color: s['risk'] as Color, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('${s['consultant']} • ${s['group']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Icon(Icons.circle, color: s['risk'] as Color, size: 10),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.swap_horiz, color: Colors.blueGrey, size: 20),
                onPressed: () {},
                tooltip: 'Reassign',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGroupList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _groups.length,
      itemBuilder: (_, i) {
        final g = _groups[i];
        final color = g['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.group_outlined, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(g['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('${g['members']} members • ${g['consultant']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.grey), onPressed: () {}),
            ],
          ),
        );
      },
    );
  }

  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Bulk Import Students'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Upload a CSV file with student data.\nFormat: Name, Email, Group'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006064), foregroundColor: Colors.white),
              icon: const Icon(Icons.upload_file),
              label: const Text('Choose CSV File'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))],
      ),
    );
  }

  void _showCreateGroupDialog() {
    final nameCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Create New Group'),
        content: TextField(
          controller: nameCtrl,
          decoration: InputDecoration(
            labelText: 'Group Name',
            hintText: 'e.g. Exam Stress Group',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF006064), foregroundColor: Colors.white),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                setState(() => _groups.add({'name': nameCtrl.text, 'members': 0, 'consultant': 'Unassigned', 'color': Colors.teal}));
              }
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
