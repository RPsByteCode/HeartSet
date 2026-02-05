import 'package:get/state_manager.dart';
import 'package:mhc/modal/consultant_modal.dart';

class ConsultantController extends GetxController {

  Rx<ConsultantModal> patient = ConsultantModal(name: "", email: "", fees:0 , isConsultant: false , specialization: "" , yearsOfExp: 0 ).obs;

  void fetchData(String pName , String name, String specialization, int yearsOfExp,  double fees,  String email ){
    patient.update((obj){
      obj!.name= pName ;
      obj.email = email;
      obj.fees = fees;
      obj.specialization = specialization;
      obj.yearsOfExp = yearsOfExp;
    });
  }
}