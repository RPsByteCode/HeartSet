

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'confirmed_splash.dart';

class ConfirmAppointment extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String drName, drSpecial, aptType;

  ConfirmAppointment({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.drName,
    required this.drSpecial,
    required this.aptType,
  });

  @override
  State<ConfirmAppointment> createState() => _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends State<ConfirmAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm Your Appointment",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    width: 380,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.normal,
                          color: Colors.grey.shade700,
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade300,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  "assets/images/doctor.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.drName,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  Text(
                                    widget.aptType,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal, fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 30,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined),
                                  SizedBox(width: 10),
                                  Text(
                                    "Date",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500, fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    DateFormat('yyyy-MM-dd').format(widget.selectedDate),
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time),
                                  SizedBox(width: 10),
                                  Text(
                                    "Time",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500, fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    "${widget.selectedTime}",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 380,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.normal,
                          color: Colors.grey.shade700,
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Details",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Consultation Fee",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal, fontSize: 15),
                              ),
                              Text(
                                (widget.aptType == "Video Consultation (15 min)")
                                    ? "₹800"
                                    : "₹1000",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Booking Fee",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal, fontSize: 15),
                              ),
                              Text(
                                "₹50",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          ),
                          Divider(
                            height: 30,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Payable",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                (widget.aptType == "Video Consultation (15 min)")
                                    ? "₹850"
                                    : "₹1050",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 380,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.normal,
                          color: Colors.grey.shade700,
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.payment),
                              SizedBox(width: 10),
                              Text(
                                "Pay with UPI / RazorPay",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined, size: 22)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ConfirmedSplash(
                          drName: widget.drName,
                          drSpeacial: widget.drSpecial,
                          aptType: widget.aptType,
                          selectedDate: widget.selectedDate,
                          selectedTime: widget.selectedTime,
                        );
                      },
                    ),
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
                          "Pay ${widget.aptType == "Video Consultation (15 min)" ? "850" : "1050"} Securely",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
