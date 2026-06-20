class PatientModal {
  final int? id;
  String name;
  String email;
  int age;
  String emContact;   // stored as String to handle country codes like +91...
  bool isPatient;

  PatientModal({
    this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.emContact,
    this.isPatient = true,
  });

  /// Convert to a map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'age': age,
      'emContact': emContact,
      'isPatient': isPatient ? 1 : 0,
    };
  }

  /// Create a PatientModal from a SQLite row map
  factory PatientModal.fromMap(Map<String, dynamic> map) {
    return PatientModal(
      id: map['id'] as int?,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      age: map['age'] as int? ?? 0,
      emContact: map['emContact'] as String? ?? '',
      isPatient: (map['isPatient'] as int? ?? 1) == 1,
    );
  }

  /// Create a copy with optional field overrides
  PatientModal copyWith({
    int? id,
    String? name,
    String? email,
    int? age,
    String? emContact,
    bool? isPatient,
  }) {
    return PatientModal(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      emContact: emContact ?? this.emContact,
      isPatient: isPatient ?? this.isPatient,
    );
  }

  @override
  String toString() =>
      'PatientModal(id: $id, name: $name, email: $email, age: $age)';
}
