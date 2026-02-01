import 'package:flutter/material.dart';

class WeeklyMoodOverviewScreen extends StatelessWidget {
  const WeeklyMoodOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Weekly Mood Overview",
          style: TextStyle(color: Color(0xFF1A1F2C), fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.verified_user_outlined, color: Colors.green.shade400, size: 20),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Chart Card
          _buildMoodChartCard(),
          const SizedBox(height: 40),
          
          // Insight Section
          const Text(
            "Insight Summary",
            style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 22, color: Color(0xFF1A1F2C), fontWeight: FontWeight.w400),
              children: [
                TextSpan(text: "Your friend has had a "),
                TextSpan(
                  text: "Stormy",
                  style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                ),
                TextSpan(text: " week."),
              ],
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Action Button
          _buildSupportButton(),
          const SizedBox(height: 12),
          const Text(
            "Sends a visual hug to their dashboard",
            style: TextStyle(color: Colors.grey, fontSize: 11, fontStyle: FontStyle.italic),
          ),
          
          const Spacer(),
          
          // Privacy Note
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 14, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Text(
                "NO DIARY OR MESSAGES ARE VISIBLE",
                style: TextStyle(color: Colors.grey.shade400, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMoodChartCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Y-Axis Labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("CALM", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1)),
                    Text("CLOUDY", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1)),
                    Text("STORMY", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1)),
                  ],
                ),
                const SizedBox(width: 12),
                // The Chart (Using a CustomPainter or Placeholder for the line)
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (index) => Divider(color: Colors.grey.shade100, thickness: 1)),
                      ),
                      // Mood Line Path placeholder
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: MoodLinePainter(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // X-Axis Labels
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("M", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("T", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("W", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("T", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("F", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("S", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("S", style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSupportButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A1F2C),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        onPressed: () {},
        icon: const Icon(Icons.favorite_border, size: 20),
        label: const Text("Send Support", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

}

// Custom Painter for the Mood Line Chart
class MoodLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6366F1)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()..color = const Color(0xFFEF4444)..style = PaintingStyle.fill;

    final path = Path();
    // Simplified coordinates for the "Stormy" week line
    path.moveTo(0, size.height * 0.2);
    path.lineTo(size.width * 0.16, size.height * 0.3);
    path.lineTo(size.width * 0.32, size.height * 0.8);
    path.lineTo(size.width * 0.48, size.height * 0.7);
    path.lineTo(size.width * 0.64, size.height * 0.4);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.lineTo(size.width, size.height * 0.75);

    canvas.drawPath(path, paint);

    // Drawing red data points as shown in the screenshot
    canvas.drawCircle(Offset(size.width * 0.32, size.height * 0.8), 4, pointPaint);
    canvas.drawCircle(Offset(size.width * 0.48, size.height * 0.7), 4, pointPaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.8), 4, pointPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}