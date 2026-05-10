import 'package:flutter/material.dart';
import 'cat_painter.dart';
import 'pet_state.dart';

/// A fully animated virtual cat widget that replaces all 11 GIF files.
///
/// Usage:
/// ```dart
/// VirtualPetWidget(state: PetState.happy, size: 300)
/// ```
class VirtualPetWidget extends StatefulWidget {
  final PetState state;
  final double size;
  final VoidCallback? onTap;

  const VirtualPetWidget({
    super.key,
    this.state = PetState.idle,
    this.size = 280,
    this.onTap,
  });

  @override
  State<VirtualPetWidget> createState() => _VirtualPetWidgetState();
}

class _VirtualPetWidgetState extends State<VirtualPetWidget>
    with TickerProviderStateMixin {
  // ─── Controllers ──────────────────────────────────────────────────────────
  late AnimationController _breathCtrl;
  late AnimationController _blinkCtrl;
  late AnimationController _tailCtrl;
  late AnimationController _earCtrl;
  late AnimationController _bounceCtrl;

  // ─── Animations ───────────────────────────────────────────────────────────
  late Animation<double> _breathAnim;
  late Animation<double> _blinkAnim;
  late Animation<double> _tailAnim;
  late Animation<double> _earAnim;
  late Animation<double> _bounceAnim;

  PetState _currentState = PetState.idle;

  @override
  void initState() {
    super.initState();
    _currentState = widget.state;

    // Breathing — slow 3-second cycle
    _breathCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))
      ..repeat();
    _breathAnim = Tween<double>(begin: 0, end: 1).animate(_breathCtrl);

    // Blink — 4-second cycle
    _blinkCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000))
      ..repeat();
    _blinkAnim = Tween<double>(begin: 0, end: 1).animate(_blinkCtrl);

    // Tail wag — 1.5-second cycle
    _tailCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat();
    _tailAnim = Tween<double>(begin: 0, end: 1).animate(_tailCtrl);

    // Ear twitch — 2-second cycle
    _earCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))
      ..repeat();
    _earAnim = Tween<double>(begin: 0, end: 1).animate(_earCtrl);

    // Bounce — for happy/gift states
    _bounceCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _bounceAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeInOut),
    );

    _applyStateAnimations(_currentState);
  }

  @override
  void didUpdateWidget(VirtualPetWidget old) {
    super.didUpdateWidget(old);
    if (old.state != widget.state) {
      setState(() => _currentState = widget.state);
      _applyStateAnimations(widget.state);
    }
  }

  void _applyStateAnimations(PetState state) {
    switch (state) {
      case PetState.happy:
      case PetState.gift:
      case PetState.pet:
        _tailCtrl.duration = const Duration(milliseconds: 600);
        _bounceCtrl.repeat(reverse: true);
        break;
      case PetState.sad:
        _tailCtrl.duration = const Duration(milliseconds: 3000);
        _bounceCtrl.stop();
        break;
      case PetState.anxious:
        _tailCtrl.duration = const Duration(milliseconds: 400);
        _bounceCtrl.stop();
        break;
      case PetState.calm:
        _tailCtrl.duration = const Duration(milliseconds: 2500);
        _breathCtrl.duration = const Duration(milliseconds: 4000);
        _bounceCtrl.stop();
        break;
      default:
        _tailCtrl.duration = const Duration(milliseconds: 1500);
        _breathCtrl.duration = const Duration(milliseconds: 3000);
        _bounceCtrl.stop();
    }
    _tailCtrl
      ..stop()
      ..repeat();
  }

  @override
  void dispose() {
    _breathCtrl.dispose();
    _blinkCtrl.dispose();
    _tailCtrl.dispose();
    _earCtrl.dispose();
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _breathAnim,
          _blinkAnim,
          _tailAnim,
          _earAnim,
          _bounceAnim,
        ]),
        builder: (context, _) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: CatPainter(
                state: _currentState,
                breathValue: _breathAnim.value,
                blinkValue: _blinkAnim.value,
                tailValue: _tailAnim.value,
                earValue: _earAnim.value,
                bounceValue: _bounceAnim.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
