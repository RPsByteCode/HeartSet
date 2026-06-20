/// Represents a single mood check-in saved by the patient.
class MoodLogModal {
  final int? id;
  final String mood;       // e.g. "HAPPY", "SAD", "ANXIOUS", "CALM", "OKAY"
  final String tag;        // e.g. "Joyful", "Restless" (descriptive sub-tag)
  final String date;       // stored as ISO-8601 string: "2024-10-24T09:30:00"
  final String note;       // optional free-text note from voice/text input

  const MoodLogModal({
    this.id,
    required this.mood,
    this.tag = '',
    required this.date,
    this.note = '',
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'mood': mood,
      'tag': tag,
      'date': date,
      'note': note,
    };
  }

  factory MoodLogModal.fromMap(Map<String, dynamic> map) {
    return MoodLogModal(
      id: map['id'] as int?,
      mood: map['mood'] as String? ?? '',
      tag: map['tag'] as String? ?? '',
      date: map['date'] as String? ?? '',
      note: map['note'] as String? ?? '',
    );
  }

  MoodLogModal copyWith({
    int? id, String? mood, String? tag, String? date, String? note,
  }) {
    return MoodLogModal(
      id: id ?? this.id,
      mood: mood ?? this.mood,
      tag: tag ?? this.tag,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  @override
  String toString() => 'MoodLogModal(id: $id, mood: $mood, tag: $tag, date: $date)';
}
