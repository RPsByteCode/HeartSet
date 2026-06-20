import 'package:flutter/material.dart';

/// Full-screen SOS emergency overlay.
/// Shows a slide-to-confirm gesture, then dispatches the alert.
class SosOverlay extends StatefulWidget {
  const SosOverlay({super.key});

  @override
  State<SosOverlay> createState() => _SosOverlayState();
}

class _SosOverlayState extends State<SosOverlay> with SingleTickerProviderStateMixin {
  double _slideValue = 0.0;
  bool _confirmed = false;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _onConfirm() {
    setState(() => _confirmed = true);
    _pulseCtrl.stop();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).pop(true); // returns true = alert sent
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A0A),
      body: SafeArea(
        child: _confirmed ? _buildDispatched() : _buildConfirmView(),
      ),
    );
  }

  // ─── Pre-confirm view ─────────────────────────────────────────────────────
  Widget _buildConfirmView() {
    return Column(
      children: [
        // Top cancel bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel', style: TextStyle(color: Colors.white54, fontSize: 16)),
              ),
            ],
          ),
        ),

        const Spacer(),

        // Pulsing warning icon
        ScaleTransition(
          scale: _pulseAnim,
          child: Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withValues(alpha: 0.15),
              border: Border.all(color: Colors.red.withValues(alpha: 0.5), width: 2),
            ),
            child: const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 60),
          ),
        ),

        const SizedBox(height: 32),
        const Text(
          'Emergency Alert',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'This will immediately notify your Consultant and Guardians.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 15, height: 1.5),
          ),
        ),

        const Spacer(),

        // Slide to confirm
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: _buildSlider(),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSlider() {
    const double trackHeight = 64;
    const double thumbSize = 56;
    final double trackWidth = MediaQuery.of(context).size.width - 64;
    final double maxSlide = trackWidth - thumbSize - 8;

    return Container(
      height: trackHeight,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(trackHeight / 2),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Label
          Center(
            child: AnimatedOpacity(
              opacity: _slideValue < maxSlide * 0.3 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const Text(
                'SLIDE TO CONFIRM',
                style: TextStyle(color: Colors.white38, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ),
          ),
          // Thumb
          Positioned(
            left: 4 + _slideValue,
            child: GestureDetector(
              onHorizontalDragUpdate: (d) {
                setState(() {
                  _slideValue = (_slideValue + d.delta.dx).clamp(0, maxSlide);
                });
              },
              onHorizontalDragEnd: (_) {
                if (_slideValue >= maxSlide * 0.85) {
                  _onConfirm();
                } else {
                  setState(() => _slideValue = 0);
                }
              },
              child: Container(
                width: thumbSize, height: thumbSize,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: const Icon(Icons.chevron_right, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Post-confirm dispatched view ─────────────────────────────────────────
  Widget _buildDispatched() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100, height: 100,
            decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
            child: const Icon(Icons.verified_user, color: Colors.white, size: 50),
          ),
          const SizedBox(height: 28),
          const Text('Alert Dispatched', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Your Consultant and Active Guardians have been notified of your location.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 14, height: 1.5),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statusChip(Icons.person_outline, 'Consultant', 'Dr. Smith'),
              const SizedBox(width: 16),
              _statusChip(Icons.group_outlined, 'Guardians', 'Active (3)'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white54, size: 20),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}

/// Helper to show the SOS overlay from anywhere
Future<bool?> showSosOverlay(BuildContext context) {
  return Navigator.of(context).push<bool>(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black87,
      pageBuilder: (_, __, ___) => const SosOverlay(),
      transitionsBuilder: (_, a, __, child) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: child,
      ),
    ),
  );
}
