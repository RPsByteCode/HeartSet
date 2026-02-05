import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mhc/view/institutional_app/institute_nav_bar.dart';
import 'package:mhc/view/patient_app/consultant_screens/appointment_list.dart';

class ConfirmedSplash extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String drName, drSpeacial, aptType;

  const ConfirmedSplash({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.drName,
    required this.drSpeacial,
    required this.aptType,
  });

  @override
  State<ConfirmedSplash> createState() => _ConfirmedSplashState();
}

class _ConfirmedSplashState extends State<ConfirmedSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/doctor.json',
                width: 250,
                height: 250,
                repeat: true,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Appointment Requested",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 320,
                child: Text(
                  "You will be notified when your appointment with ${widget.drName} is confirmed",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${DateFormat('EEE, MMM d').format(widget.selectedDate)} at ${widget.selectedTime}",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.8, color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Add to Calendar",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return AppointmentsPage();
                      },
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8, color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "View My Appointments",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) {
                        return PatientNavBar();
                      },
                    ),
                    (route) => false,
                  );
                },
                child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Done",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
