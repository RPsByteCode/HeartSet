import 'package:get/get.dart';
import 'package:mhc/modal/patient_modal.dart';

class PatientController extends GetxController {
  // Reactive patient object — default empty state
  final Rx<PatientModal> patient = PatientModal(
    name: '',
    email: '',
    age: 0,
    emContact: '',
  ).obs;

  // ── Load a patient from a map (e.g. after login / DB read) ────────────────
  void loadFromMap(Map<String, dynamic> map) {
    patient.value = PatientModal.fromMap(map);
  }

  // ── Update individual fields ───────────────────────────────────────────────
  void updateName(String name)       => patient.update((p) => p!.name = name);
  void updateEmail(String email)     => patient.update((p) => p!.email = email);
  void updateAge(int age)            => patient.update((p) => p!.age = age);
  void updateContact(String contact) => patient.update((p) => p!.emContact = contact);

  // ── Convenience getters ───────────────────────────────────────────────────
  String get name  => patient.value.name;
  String get email => patient.value.email;
  int    get age   => patient.value.age;

  // ── Clear on logout ───────────────────────────────────────────────────────
  void clear() {
    patient.value = PatientModal(name: '', email: '', age: 0, emContact: '');
  }
}
