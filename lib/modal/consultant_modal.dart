class ConsultantModal {
   bool isConsultant =  false;

  String name;
  String specialization;
  int yearsOfExp;
  double fees;
  String email;

  ConsultantModal({ required this.name, required this.email, required this.fees, required this.specialization, required this.yearsOfExp, required bool isConsultant });
}