import 'package:flutter/material.dart';
import 'package:mhc/modal/diary_modal/diary_modal.dart';
import 'package:mhc/modal/diary_modal/diary_notes.dart';
import 'package:mhc/widgets/bottomSheet.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  bool isLocked = true;
  List<DiaryModal> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  // ── Load all entries from SQLite on screen open ───────────────────────────
  Future<void> _loadEntries() async {
    final entries = await DiaryNotes.instance.getAllEntries();
    if (mounted) setState(() => _entries = entries);
  }

  // ── Handle add / edit submission ──────────────────────────────────────────
  Future<void> _handleSubmission({
    required bool isEdit,
    DiaryModal? oldObj,
    required DiaryModal newObj,
  }) async {
    if (isEdit && oldObj != null) {
      // Preserve the original id when updating
      final updated = newObj.copyWith(id: oldObj.id);
      await DiaryNotes.instance.updateEntry(updated);
    } else {
      await DiaryNotes.instance.insertEntry(newObj);
    }
    // Reload from DB so list stays in sync
    await _loadEntries();
  }

  // ── Delete a single entry ─────────────────────────────────────────────────
  Future<void> _deleteEntry(DiaryModal entry) async {
    await DiaryNotes.instance.deleteEntry(entry.id);
    await _loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('YOUR DIARY',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(
              isLocked ? Icons.lock_outline : Icons.lock_open_rounded,
              color: const Color(0xFF7B32FF),
            ),
            onPressed: () => setState(() => isLocked = !isLocked),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildMainBanner(),
                const SizedBox(height: 20),
                if (_entries.isEmpty)
                  _buildEmptyState(),
                ..._entries.map((entry) => _buildDiaryCard(entry)),
                const SizedBox(height: 10),
                _buildShareConsultantCard(),
                const SizedBox(height: 100),
              ],
            ),

          // Add entry FAB
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF7B32FF),
              onPressed: () => ModalBottomSheet.show(
                context: context,
                isEdit: false,
                onSumbit: (newEntry) => _handleSubmission(isEdit: false, newObj: newEntry),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ── Privacy banner ────────────────────────────────────────────────────────
  Widget _buildMainBanner() {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF8E86FF), Color(0xFF7B32FF)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isLocked ? Icons.lock_outline : Icons.lock_open, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            isLocked ? 'PRIVACY PROTECTED' : 'JOURNAL OPEN',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          if (!isLocked) ...[
            const SizedBox(height: 6),
            Text(
              '${_entries.length} ${_entries.length == 1 ? 'entry' : 'entries'}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  // ── Empty state ───────────────────────────────────────────────────────────
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: const [
          Icon(Icons.book_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 12),
          Text('No entries yet', style: TextStyle(color: Colors.grey, fontSize: 16)),
          SizedBox(height: 4),
          Text('Tap + to write your first thought', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  // ── Diary card ────────────────────────────────────────────────────────────
  Widget _buildDiaryCard(DiaryModal entry) {
    return GestureDetector(
      // Long-press → edit
      onLongPress: () => ModalBottomSheet.show(
        context: context,
        isEdit: true,
        existingEntry: entry,
        onSumbit: (updated) => _handleSubmission(isEdit: true, oldObj: entry, newObj: updated),
      ),
      child: Dismissible(
        key: Key('diary_${entry.id}'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.red.shade400,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
        ),
        confirmDismiss: (_) async {
          return await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Delete Entry'),
              content: const Text('This entry will be permanently removed.'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                TextButton(onPressed: () => Navigator.pop(context, true),  child: const Text('Delete', style: TextStyle(color: Colors.red))),
              ],
            ),
          ) ?? false;
        },
        onDismissed: (_) => _deleteEntry(entry),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.notes, color: Colors.purpleAccent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(entry.date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  if (isLocked) const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
                ],
              ),
              if (!isLocked && entry.description.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(entry.description, style: TextStyle(color: Colors.grey.shade700, height: 1.4)),
              ],
              if (isLocked) ...[
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () => setState(() => isLocked = false),
                    child: const Text('Tap to Unlock', style: TextStyle(color: Color(0xFF7B32FF))),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ── Share with consultant card ────────────────────────────────────────────
  Widget _buildShareConsultantCard() {
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
                  Text('Share with Consultant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('SECURE ACCESS LINK', style: TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('A 7 - X 9 2 - K 0',
                    style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2)),
                Row(
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Colors.green),
                    SizedBox(width: 5),
                    Text('ACTIVE', style: TextStyle(color: Colors.green, fontSize: 10)),
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
