import 'package:flutter/material.dart';

class CriticalResponseScreen extends StatefulWidget {
  const CriticalResponseScreen({super.key});

  @override
  State<CriticalResponseScreen> createState() => _CriticalResponseScreenState();
}

class _CriticalResponseScreenState extends State<CriticalResponseScreen> {
  int selectedPatientIndex = 0;

  final List<Map<String, dynamic>> distressPatients = [
    {
      "name": "Marcus Aurelius",
      "time": "ACTIVE 2m",
      "location": "Forum Residence, Block C-12",
      "phone": "+1 555-0101 (Emergency)",
    },
    {
      "name": "Cassius Dio",
      "time": "ACTIVE 5m",
      "location": "Public Library, Main Hall",
      "phone": "+1 555-9988 (Family)",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          color: const Color(0xFFD32F2F), // Solid red header
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 30),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("CRITICAL RESPONSE VIEW", 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("2 Active Distress Signals Detected", 
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select a patient to view emergency actions:",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 20),
            
            // Patient Alert List
            Expanded(
              child: ListView.builder(
                itemCount: distressPatients.length,
                itemBuilder: (context, index) {
                  return _buildPatientAlertCard(index);
                },
              ),
            ),

            // Bottom Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientAlertCard(int index) {
    final patient = distressPatients[index];
    bool isSelected = selectedPatientIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedPatientIndex = index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFD32F2F) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? const Color(0xFF3B1E1E) : const Color(0xFF2C2C2C),
              radius: 24,
              child: Icon(Icons.person, color: isSelected ? const Color(0xFFD32F2F) : Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(patient['name'], 
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD32F2F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(patient['time'], 
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _infoRow(Icons.location_on, patient['location']),
                  const SizedBox(height: 4),
                  _infoRow(Icons.contact_phone, patient['phone']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 14),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.phone),
          label: const Text("CALL EMERGENCY CONTACT", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF2C2C2C)),
                  backgroundColor: const Color(0xFF1E1E1E),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.visibility, color: Colors.white, size: 18),
                label: const Text("VIEW PROFILE", style: TextStyle(color: Colors.white)),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF2C2C2C)),
                  backgroundColor: const Color(0xFF1E1E1E),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 18),
                label: const Text("EXIT VIEW", style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}