import 'package:get/state_manager.dart';
import 'package:mhc/modal/patient_modal.dart';

class PatientController extends GetxController {

  Rx<PatientModal> patient = PatientModal(name: "", email: "", age: 0 , isPatient: false ,  emContact: 0 ).obs;

  void fetchData(String pName , String name, int age,  String email ){
    patient.update((obj){
      obj!.name= pName ;
      obj.email = email;
      obj.age = age;
    });
  }
}