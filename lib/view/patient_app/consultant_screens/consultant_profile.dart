import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:mhc/view/patient_app/consultant_screens/book_appointment.dart';

class DrProfile extends StatefulWidget {
  final String drName, drMail;

  final String drSpecial;

  final String doctorId;

  const DrProfile({
    super.key,

    required this.drName,

    required this.drMail,

    required this.drSpecial,

    required this.doctorId,
  });

  @override
  State<DrProfile> createState() => _DrProfileState();
}

class _DrProfileState extends State<DrProfile> {
  int idx = 0;
  bool _isVerified = false;

  List<Color> colorList = [
    const Color.fromARGB(255, 227, 83, 131),

    const Color.fromARGB(255, 134, 178, 253),

    const Color.fromARGB(255, 236, 129, 255),

    const Color.fromARGB(255, 146, 252, 201),
  ];

  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  Future<void> _checkVerificationStatus() async {
    if (widget.doctorId.isEmpty) return;

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('DoctorData')
          .doc(widget.doctorId)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['verificationStatus'] == 'approved') {
          if (mounted) {
            setState(() {
              _isVerified = true;
            });
          }
        }
      }
    } catch (e) {
      print("Error fetching doctor verification status: $e");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),

            child: Icon(Icons.share_outlined, size: 25),
          ),
        ],

        title: Text("Doctor's Profile", style: GoogleFonts.playfairDisplay()),

        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Element 1
                  SizedBox(
                    child: Row(
                      children: [
                        //1
                        Padding(
                          padding: const EdgeInsets.all(10.0),

                          child: Container(
                            width: 120,

                            height: 120,

                            decoration: BoxDecoration(
                              color: Colors.blue,

                              shape: BoxShape.circle,
                            ),

                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/doctor.png",

                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 5),

                        //2
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              widget.drName,

                              style: GoogleFonts.playfairDisplay(
                                fontSize: 25,

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //Used "widget." to access the variables of DrProfile Class...
                            Text(
                              widget.drSpecial,

                              style: GoogleFonts.playfairDisplay(fontSize: 20),
                            ),

                            if (_isVerified)
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(165, 241, 132, 0.5),

                                  borderRadius: BorderRadius.circular(60),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,

                                    right: 10,

                                    top: 3,

                                    bottom: 3,
                                  ),

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,

                                    children: [
                                      Icon(
                                        Icons.check_circle,

                                        color: Colors.green,

                                        size: 15,
                                      ),

                                      Text(
                                        "Verified By Motherly",

                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Element 2
                  Container(
                    height: 70,

                    width: 400,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,

                          spreadRadius: 1,

                          blurRadius: 4,

                          offset: Offset(4, 4),
                        ),
                      ],

                      border: Border.all(color: Colors.grey),

                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.business_center_outlined,

                                color: Colors.pink,

                                size: 30,
                              ),

                              SizedBox(width: 5),

                              Column(
                                children: [
                                  Text(
                                    "12+ Years",

                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 15,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    "Gynecologist",

                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 30),

                              SizedBox(width: 5),

                              Column(
                                children: [
                                  Text(
                                    "4.9 Stars",

                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 15,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    "Rating",

                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.red, size: 30),

                              SizedBox(width: 5),

                              Column(
                                children: [
                                  Text(
                                    "5000+",

                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 15,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    "Patients",

                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Element 3
                  SizedBox(height: 20),

                  Container(
                    width: 400,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,

                          spreadRadius: 1,

                          blurRadius: 4,

                          offset: Offset(4, 4),
                        ),
                      ],

                      border: Border.all(color: Colors.grey),

                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          Text(
                            "About Dr. ${widget.drName}",

                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          SizedBox(
                            width: 300,

                            child: Text(
                              "My goal is to provide compassionate, personalized care to support women through all stages of life, with a special focus on pregnancy and maternal health...",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Element 4
                  SizedBox(height: 20),

                  Container(
                    width: 400,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,

                          spreadRadius: 1,

                          blurRadius: 4,

                          offset: Offset(4, 4),
                        ),
                      ],

                      border: Border.all(color: Colors.grey),

                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Text("Services"),
                        ),

                        Divider(height: 20, color: Colors.grey),

                        Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Video Consultation (15 min)",

                                    style: GoogleFonts.playfairDisplay(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text("₹800"),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Book Now",

                                    style: GoogleFonts.playfairDisplay(
                                      fontWeight: FontWeight.bold,

                                      color: Colors.pink,
                                    ),
                                  ),

                                  Icon(
                                    Icons.arrow_forward_ios_outlined,

                                    size: 12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Divider(height: 20, color: Colors.grey),

                        Padding(
                          padding: const EdgeInsets.all(8.0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Routine Check-up (In Clinic)",

                                    style: GoogleFonts.playfairDisplay(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text("₹1000"),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    "View Slots",

                                    style: GoogleFonts.playfairDisplay(
                                      fontWeight: FontWeight.bold,

                                      color: Colors.pink,
                                    ),
                                  ),

                                  Icon(
                                    Icons.arrow_forward_ios_outlined,

                                    size: 12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  //Element 5
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Text(
                        "Helpful Tips From Dr. Priya Sharma",

                        style: GoogleFonts.playfairDisplay(
                          fontSize: 15,

                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            "See All",

                            style: GoogleFonts.playfairDisplay(
                              fontWeight: FontWeight.bold,

                              color: Colors.pink,
                            ),
                          ),

                          Icon(Icons.arrow_forward_ios_outlined, size: 12),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: SizedBox(
                      child: Row(
                        children: List.generate(7, (context) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 30,

                              top: 10,

                              bottom: 10,
                            ),

                            child: Container(
                              width: 180,

                              height: 120,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),

                                color: colorList[idx],
                              ),

                              child: Center(
                                child: Text(
                                  "Video",

                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 50,

                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Element 6 - Patient Reviews (NEW)
                  Container(
                    width: 400,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,

                          spreadRadius: 1,

                          blurRadius: 4,

                          offset: Offset(4, 4),
                        ),
                      ],

                      border: Border.all(color: Colors.grey),

                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(12.0),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                "Patient Reviews",

                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 18,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "See All (128) >",

                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.pink,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Review 1
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,

                                      (index) => const Icon(
                                        Icons.star,

                                        color: Colors.amber,

                                        size: 18,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    "Anjali R.",

                                    style: GoogleFonts.playfairDisplay(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              Text(
                                '"Incredibly patient and answered all my questions..."',

                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // Review 2
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,

                                      (index) => const Icon(
                                        Icons.star,

                                        color: Colors.amber,

                                        size: 18,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    "Neha S.",

                                    style: GoogleFonts.playfairDisplay(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              Text(
                                '"The best doctor for my entire pregnancy journey."',

                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return BookApointment(
                      drName: widget.drName,

                      drSpecial: widget.drSpecial,

                      doctorId: widget.doctorId,

                      drMail: widget.drMail,
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
                      "Book Appointment",

                      style: GoogleFonts.playfairDisplay(
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
    );
  }
}
