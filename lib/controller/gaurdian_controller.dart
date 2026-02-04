import 'package:get/state_manager.dart';
import 'package:mhc/modal/gaurdian_modal.dart';

class ConsultantController extends GetxController {

  Rx<GaurdianModal> patient = GaurdianModal(name: "", email: "", phNo:0 , isGaurdian: false , relToPatient: "", emailPatient: '' ).obs;

  void fetchData(String pName , String name, String relToPatient, int phNo,  String email ){
    patient.update((obj){
      obj!.name= pName ;
      obj.email = email;
      obj.phNo = phNo;
      obj.relToPatient = relToPatient;
    });
  }
}
