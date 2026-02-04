import 'package:get/get.dart';

enum UserType { patient, consultant, institute, guardian }

class UserController extends GetxController {
  var selectedType = UserType.patient.obs;

  void updateUserType(UserType type) {
    selectedType.value = type;
  }
}