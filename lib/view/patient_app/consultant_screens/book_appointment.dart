
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BookApointment extends StatefulWidget {
  
  final String drName,drMail, drSpecial, doctorId;

  const BookApointment({
    super.key,
    required this.drName,
    required this.drMail,
    required this.drSpecial,
    required this.doctorId, 
  });

  @override
  State<BookApointment> createState() => _BookApointmentState();
}

class _BookApointmentState extends State<BookApointment> {
  // Use nullable String? for the selected type, it's cleaner than two booleans
  String? _selectedAptType;

  @override
  Widget build(BuildContext context) {
    // Determine if the "Next" button should be enabled
    final bool isNextButtonEnabled = _selectedAptType != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book With ${widget.drName}",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Service",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                // Option 1: Video Consultation
                _buildServiceOption(
                  title: "Video Consultation (15 min)",
                  price: "₹800",
                  value: "Video Consultation (15 min)", // Use a consistent value
                ),
                const SizedBox(height: 20),

                // Option 2: Routine Check-Up
                _buildServiceOption(
                  title: "Routine Check-Up (In Clinic)",
                  price: "₹1000",
                  value: "Routine Check-Up (In Clinic)", // Use a consistent value
                ),
              ],
            ),

            // "Next" Button
            // GestureDetector(
            //   onTap: isNextButtonEnabled
            //       ? () {
            //           Navigator.of(context).pushReplacement(
            //             MaterialPageRoute(
            //               builder: (context) => SelectSlot(
            //                 drName: widget.drName,
            //                 drSpecial: widget.drSpecial,
            //                 aptType: _selectedAptType!, 
            //                 doctorId: widget.doctorId, drMail: widget.drMail, 
            //               ),
            //             ),
            //           );
            //         }
            //       : null, // Disable if no type is selected
            //   child: Container(
            //     width: MediaQuery.of(context).size.width * 0.8,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       color: isNextButtonEnabled ? Colors.pink : Colors.grey, // Change color when disabled
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Next",
            //         style: GoogleFonts.poppins(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  /// Helper Widget to build each selectable service option.
  Widget _buildServiceOption({
    required String title,
    required String price,
    required String value,
  }) {
    bool isSelected = _selectedAptType == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAptType = value; // Set the selected type
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.grey.shade300,
            width: isSelected ? 2 : 1, // Highlight border if selected
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.pink : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}