import 'package:flutter/material.dart';

class EmergencyAlertScreen extends StatelessWidget {
  const EmergencyAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark theme for high contrast
      appBar: AppBar(
        backgroundColor: const Color(0xFFC62828), // Urgent Red
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "EMERGENCY ALERT",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Live Map View Section
          _buildLiveMapSection(),
          
          // Action Buttons
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  _buildActionButton("Call Patient", Icons.phone, Colors.white, Colors.black),
                  const SizedBox(height: 12),
                  _buildActionButton("Call Emergency (911)", Icons.phone_in_talk, const Color(0xFFD32F2F), Colors.white),
                  const SizedBox(height: 12),
                  _buildActionButton("Navigate to Location", Icons.near_me_outlined, const Color(0xFF2C2C2C), Colors.white),
                  
                  const SizedBox(height: 24),
                  
                  // Status Info Cards
                  _buildStatusCard(
                    "PROFESSIONAL SUPPORT", 
                    "Consultant Notified", 
                    Icons.person_search_outlined, 
                    Colors.greenAccent
                  ),
                  const SizedBox(height: 12),
                  _buildStatusCard(
                    "TIME ELAPSED", 
                    "02:45 since SOS trigger", 
                    Icons.access_time, 
                    Colors.white70
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveMapSection() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        image: DecorationImage(
          image: NetworkImage("https://placeholder_for_dark_grid_map_background"), // Replace with actual map provider
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Grid lines effect
          CustomPaint(painter: MapGridPainter(), size: Size.infinite),
          
          // User Location Marker
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Color(0xFFD32F2F), shape: BoxShape.circle),
                child: const Icon(Icons.location_on, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: const Text("USER LIVE LOCATION", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
          
          // Coordinates Label
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
              child: const Text(
                "34.0522° N, 118.2437° W",
                style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'monospace'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: textColor, size: 20),
        label: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String sub, IconData icon, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              const SizedBox(height: 4),
              Text(sub, style: TextStyle(color: accentColor, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          if (accentColor == Colors.greenAccent)
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
        ],
      ),
    );
  }

}

class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white10..strokeWidth = 1;
    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}