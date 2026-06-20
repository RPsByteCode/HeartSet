class DiaryModal {
  int id;
  String title;
  String date;
  String description;

  DiaryModal({
    this.id = 0,
    required this.title,
    required this.date,
    required this.description,
  });

  /// Convert to a map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      if (id != 0) 'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  /// Create a DiaryModal from a SQLite row map
  factory DiaryModal.fromMap(Map<String, dynamic> map) {
    return DiaryModal(
      id: map['id'] as int? ?? 0,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      date: map['date'] as String? ?? '',
    );
  }

  DiaryModal copyWith({int? id, String? title, String? date, String? description}) {
    return DiaryModal(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  @override
  String toString() => 'DiaryModal(id: $id, title: $title, date: $date)';
}
