import 'package:animated_custom_appbar/animated_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:mhc/modal/mood_log_db.dart';
import 'package:mhc/modal/mood_log_modal.dart';
import 'package:mhc/widgets/bottomSheet.dart';
import 'package:mhc/widgets/sos_overlay.dart';
import 'package:mhc/widgets/virtual_pet/virtual_pet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMood = "";
  PetState _petState = PetState.idle;

  // ─── Map mood name → PetState ─────────────────────────────────────────────
  PetState _moodToPetState(String moodName) {
    switch (moodName) {
      case "HAPPY":    return PetState.happy;
      case "SAD":      return PetState.sad;
      case "ANXIOUS":  return PetState.anxious;
      case "CALM":     return PetState.calm;
      case "OKAY":     return PetState.okay;
      default:         return PetState.idle;
    }
  }

  // ─── Mood selector item ───────────────────────────────────────────────────
  Widget _buildMoodItem({
    required String moodName,
    required IconData iconName,
    required Color color,
  }) {
    final isSelected = selectedMood == moodName;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = moodName;
          _petState = _moodToPetState(moodName);
        });
        // Save mood to local DB
        MoodLogDB.instance.insertLog(MoodLogModal(
          mood: moodName,
          date: DateTime.now().toIso8601String(),
        ));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(50) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(iconName, size: isSelected ? 45 : 35, color: isSelected ? color : Colors.blueGrey),
            const SizedBox(height: 5),
            Text(
              moodName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? color : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Mood tag rows ────────────────────────────────────────────────────────
  Widget _buildMoodDetailWidget(String mood) {
    final Map<String, List<String>> tags = {
      "HAPPY":   ["Joyful", "Excited", "Productive", "Social"],
      "SAD":     ["Lonely", "Tired", "Grief", "Low Energy"],
      "ANXIOUS": ["Restless", "Panicked", "Stressed", "Worried"],
      "CALM":    ["Peaceful", "Mindful", "Content", "Rested"],
      "OKAY":    ["Bored", "Uncertain", "Neutral", "Quiet"],
    };

    final list = tags[mood];
    if (list == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SELECT TAGS THAT DESCRIBE YOUR $mood MOOD:",
          style: const TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 0.5),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            spacing: 10,
            children: list
                .map((tag) => ElevatedButton(
                      onPressed: () {
                        ModalBottomSheet.callSheet(title: tag, context: context);
                        // Save mood log with the selected sub-tag
                        MoodLogDB.instance.insertLog(MoodLogModal(
                          mood: mood,
                          tag: tag,
                          date: DateTime.now().toIso8601String(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF7B32FF),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Color(0xFF7B32FF), width: 1),
                        ),
                      ),
                      child: Text(tag),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedCustomAppBar(
        profileIcon: const Icon(Icons.person),
        minHeight: 50,
        maxHeight: 120,
        centerWidget: RichText(
          text: const TextSpan(
            text: "Good Morning, User!",
            style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "\nWe're so glad you're here.",
                style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        children: [
          // ── Virtual Pet Card ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 6,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    // The animated cat — replaces all 11 GIFs
                    VirtualPetWidget(
                      state: _petState,
                      size: 260,
                      onTap: () {
                        // Tap the cat → pet interaction
                        setState(() => _petState = PetState.pet);
                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) {
                            setState(() => _petState = _moodToPetState(selectedMood));
                          }
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Interaction buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPetActionButton(
                          icon: Icons.mic_none_outlined,
                          label: "Talk",
                          onTap: () {
                            setState(() => _petState = PetState.listen);
                            Future.delayed(const Duration(seconds: 3), () {
                              if (mounted) setState(() => _petState = _moodToPetState(selectedMood));
                            });
                          },
                        ),
                        const SizedBox(width: 32),
                        _buildPetActionButton(
                          icon: Icons.card_giftcard,
                          label: "Gift",
                          onTap: () {
                            setState(() => _petState = PetState.gift);
                            Future.delayed(const Duration(seconds: 2), () {
                              if (mounted) setState(() => _petState = _moodToPetState(selectedMood));
                            });
                          },
                        ),
                        const SizedBox(width: 32),
                        _buildPetActionButton(
                          icon: Icons.pets,
                          label: "Pet",
                          onTap: () {
                            setState(() => _petState = PetState.pet);
                            Future.delayed(const Duration(seconds: 2), () {
                              if (mounted) setState(() => _petState = _moodToPetState(selectedMood));
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        _petStateLabel(_petState),
                        key: ValueKey(_petState),
                        style: const TextStyle(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Mood Check-In Card ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: Card(
              elevation: 6,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "How are you feeling today?",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1F2C)),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMoodItem(moodName: "HAPPY",   iconName: Icons.sentiment_satisfied_alt_outlined, color: Colors.orange),
                        _buildMoodItem(moodName: "SAD",     iconName: Icons.sentiment_dissatisfied,           color: Colors.blue),
                        _buildMoodItem(moodName: "ANXIOUS", iconName: Icons.warning_amber_outlined,           color: Colors.red),
                        _buildMoodItem(moodName: "CALM",    iconName: Icons.air,                              color: Colors.green),
                        _buildMoodItem(moodName: "OKAY",    iconName: Icons.sentiment_neutral,                color: Colors.amber),
                      ],
                    ),
                    if (selectedMood.isNotEmpty) ...[
                      const Divider(height: 24),
                      _buildMoodDetailWidget(selectedMood),
                    ],
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),

      // SOS floating button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => showSosOverlay(context),
        shape: const CircleBorder(),
        child: const Icon(Icons.warning_amber, size: 30, color: Colors.white),
      ),
    );
  }

  // ─── Helper: pet action button ────────────────────────────────────────────
  Widget _buildPetActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFF0F4FF),
            child: Icon(icon, color: const Color(0xFF7B32FF)),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  // ─── Helper: label shown below the cat ───────────────────────────────────
  String _petStateLabel(PetState state) {
    switch (state) {
      case PetState.idle:    return "Tap to interact with me!";
      case PetState.happy:   return "I'm so happy today! 🎉";
      case PetState.sad:     return "I'm here with you 💙";
      case PetState.anxious: return "Let's breathe together...";
      case PetState.calm:    return "Feeling peaceful 🌿";
      case PetState.okay:    return "Just taking it one step at a time.";
      case PetState.listen:  return "Listening closely...";
      case PetState.gift:    return "A treat for you! 🎁";
      case PetState.pet:     return "That feels nice~ 😊";
      case PetState.feed:    return "Yummy! Thank you!";
      case PetState.hungry:  return "I could use a snack...";
    }
  }
}
