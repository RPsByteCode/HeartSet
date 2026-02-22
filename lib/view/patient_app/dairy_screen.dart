import 'package:flutter/material.dart';
import 'package:mhc/modal/diary_modal/diary_modal.dart';
import 'package:mhc/modal/diary_modal/diary_notes.dart';
import 'package:mhc/widgets/bottomSheet.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  static get BTM_list => null;

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  bool isLocked = true;
  static List<DiaryModal> BTM_list = [];

  void _handleSubmission({required bool isEdit, DiaryModal? oldObj, required DiaryModal newObj}) {
    setState(() {
      if (isEdit && oldObj != null) {
        oldObj.title = newObj.title;
        oldObj.description = newObj.description;
        oldObj.date = newObj.date;
        DiaryNotes().updateToDoItem({
          "title": newObj.title,
          "description": newObj.description,
          "date": newObj.date
        });
      } else {
        BTM_list.add(newObj);
        DiaryNotes().insertToDoItem({
          "title": newObj.title,
          "description": newObj.description,
          "date": newObj.date
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("YOUR DIARY", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(isLocked ? Icons.lock_outline : Icons.lock_open_rounded, color: Colors.blueAccent),
            onPressed: () => setState(() => isLocked = !isLocked),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView( 
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              _buildMainBanner(),
              const SizedBox(height: 20),
              ...BTM_list.map((entry) => GestureDetector(
                onLongPress: () => ModalBottomSheet.show(
                  context: context,
                  isEdit: true,
                  existingEntry: entry,
                  onSumbit: (newDate) => _handleSubmission(isEdit: true, oldObj: entry, newObj: newDate),
                ),
                child: diaryCard(entry),
              )).toList(),
              const SizedBox(height: 10),
              shareConsultantCard(),
              const SizedBox(height: 100),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF7B32FF),
              onPressed: () => ModalBottomSheet.show(
                context: context,
                isEdit: false,
                onSumbit: (newDate) => _handleSubmission(isEdit: false, newObj: newDate),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainBanner() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF8E86FF), Color(0xFF7B32FF)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isLocked ? Icons.lock_outline : Icons.lock_open, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(isLocked ? "PRIVACY PROTECTED" : "JOURNAL OPEN",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        ],
      ),
    );
  }

  Widget diaryCard(DiaryModal entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.notes, color: Colors.purpleAccent),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(entry.date, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const Spacer(),
              if (isLocked) const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 15),
          isLocked
              ? Center(child: TextButton(onPressed: () => setState(() => isLocked = false), child: const Text("Tap to Unlock")))
              : Text(entry.description, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  Widget shareConsultantCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2C),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.vpn_key_outlined, color: Colors.grey),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Share with Consultant", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("SECURE ACCESS LINK", style: TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("A 7 - X 9 2 - K 0", style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2)),
                Row(
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Colors.green),
                    SizedBox(width: 5),
                    Text("ACTIVE", style: TextStyle(color: Colors.green, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}