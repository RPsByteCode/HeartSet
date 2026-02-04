import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mhc/modal/appointments.dart';


class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  late Future<List<Appointment>> _upcomingAppointments;
  late Future<List<Appointment>> _rejectedAppointments;
  late Future<List<Appointment>> _pendingAppointments;

  @override
  void initState() {
    super.initState();

    _upcomingAppointments = Future.value([]);
    _rejectedAppointments = Future.value([]);
    _pendingAppointments = Future.value([]);

    // refreshAppointmentLists();
  }

  final List<Color> _colors = [
    const Color(0xFFE91E63),
    const Color(0xFF3F51B5),
    const Color(0xFF009688),
    const Color(0xFFFF9800),
  ];

  final List<Color> _lightColors = [
    const Color(0xFFFFF0F3),
    const Color(0xFFE8EAF6),
    const Color(0xFFE0F2F1),
    const Color(0xFFFFF3E0),
  ];

  // Future<void> refreshAppointmentLists() async {
  //   await MotherDatabase.instance.syncAppointmentsFromFirebase();

  //   setState(() {
  //     _upcomingAppointments = MotherDatabase.instance.getAppointmentsByStatus(
  //       'approved',
  //     );
  //     _rejectedAppointments = MotherDatabase.instance.getAppointmentsByStatus(
  //       'rejected',
  //     );
  //     _pendingAppointments = MotherDatabase.instance.getAppointmentsByStatus(
  //       'pending',
  //     );
  //   });
  // }

  Widget buildAppointmentList(Future<List<Appointment>> futureAppointments) {
    return FutureBuilder<List<Appointment>>(
      future: futureAppointments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: GoogleFonts.poppins(),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Lottie.asset("assets/lottie/noData.json");
        } else {
          final appointments = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              final colorIndex = index % _colors.length;

              return appointmentContainer(
                drName: appointment.drName,
                designation: appointment.designation,
                dayDate: appointment.dayDate,
                time: appointment.time,
                typeOfAppointment: appointment.typeOfAppointment,
                status: appointment.status,
                color: _colors[colorIndex],
                lightColor: _lightColors[colorIndex],
                // drId: appointment.drId,
                // patientId: appointment.patientId,
                // patientName: appointment.patientName,
              );
            },
          );
        }
      },
    );
  }

  Widget appointmentContainer({
    required String drName,
    required String designation,
    required String dayDate,
    required String time,
    required String typeOfAppointment,
    required String status,
    required Color color,
    required Color lightColor,
    // required String drId,
    // required String patientId,
    // required String patientName,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: lightColor,
                    child: Icon(Icons.person, size: 30, color: color),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          drName,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          designation,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 30),
              detailRow(
                icon: FontAwesomeIcons.calendarCheck,
                text: dayDate,
                color: color,
              ),
              const SizedBox(height: 12),
              detailRow(icon: FontAwesomeIcons.clock, text: time, color: color),
              const SizedBox(height: 12),
              detailRow(
                icon: FontAwesomeIcons.clinicMedical,
                text: typeOfAppointment,
                color: color,
              ),
              if (status == "approved") ...[
                const Divider(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    // OutlinedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) =>
                    //             // VideoScreen(), // Your video call page
                    //       ),
                    //     );
                    //   },
                    //   style: OutlinedButton.styleFrom(
                    //     foregroundColor: Colors.green,
                    //     side: BorderSide(color: Colors.green.shade300),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(9),
                    //     ),
                    //   ),
                    //   child: Text("Video Call", style: GoogleFonts.poppins()),
                    // ),

                    const SizedBox(width: 15),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        FaIcon(icon, color: color, size: 16),
        const SizedBox(width: 15),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade800),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text("My Appointments", style: GoogleFonts.poppins()),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: DefaultTabController(
        length: 3,
        animationDuration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                indicatorColor: Colors.pink.shade400,
                labelColor: Colors.pink.shade400,
                unselectedLabelColor: Colors.grey.shade600,
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Rejected'),
                  Tab(text: 'Pending'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildAppointmentList(_upcomingAppointments),
                  buildAppointmentList(_rejectedAppointments),
                  buildAppointmentList(_pendingAppointments),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
