import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mhc/view/patient_app/consultant_screens/consultant_profile.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = ""; // State variable to hold the search query

  // NEW: initState to add a listener to the search controller
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      // Update the state with the latest search query
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  // NEW: dispose to clean up the controller
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "My Health",
        //   style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
        // ),
        title: Text(
          // "Motherly",
          "Find a Doctor",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 24,

            color: Colors.pink,
            letterSpacing: 1.2,
          ),
        ),

        backgroundColor: Colors.pink.shade50,
        elevation: 2,
        // centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: TextField(
                        // Use the new controller
                        controller: _searchController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.pink,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          hintText: "Search by name, speciality, location...",
                          hintStyle: GoogleFonts.playfairDisplay(fontSize: 14),
                          prefixIcon: const Icon(
                            Icons.search_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('DoctorData')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Lottie.asset(
                        'assets/lottie/dataNotFound.json',
                        width: 250,
                        height: 250,
                      ),
                    );
                  }

                  // Get all doctors from the snapshot
                  final allDoctors = snapshot.data!.docs;

                  // NEW: Filter the doctors based on the search query
                  final filteredDoctors = allDoctors.where((doctor) {
                    final data = doctor.data() as Map<String, dynamic>;
                    // Safely get data and convert to lowercase for case-insensitive search
                    final doctorName = (data['userName'] as String? ?? '')
                        .toLowerCase();
                    final specialization = (data['speciality'] as String? ?? '')
                        .toLowerCase();
                    final location = (data['location'] as String? ?? '')
                        .toLowerCase();
                    final searchQueryLower = _searchQuery.toLowerCase();

                    // Return true if any of the fields contain the search query
                    return doctorName.contains(searchQueryLower) ||
                        specialization.contains(searchQueryLower) ||
                        location.contains(searchQueryLower);
                  }).toList();

                  // NEW: If the filtered list is empty, show a "not found" message
                  if (filteredDoctors.isEmpty) {
                    return Center(
                      child: Text(
                        'No doctors found.',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    );
                  }

                  // Use the filtered list to build the ListView
                  return ListView.builder(
                    // MODIFIED: Use the length of the filtered list
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      // MODIFIED: Get data from the filtered list
                      final doctorDoc = filteredDoctors[index];
                      final doctorData =
                          doctorDoc.data() as Map<String, dynamic>;
                      final doctorId = doctorDoc.id;

                      final String doctorName =
                          doctorData['userName'] ?? 'No Name';
                      final String specialization =
                          doctorData['speciality'] ?? 'No Speciality';
                      final String location =
                          doctorData['location'] ?? 'No Location';
                      final String drMail = doctorData['email'] ?? 'No Email';

                      // The rest of the UI code remains the same
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return DrProfile(
                                  drName: doctorName,
                                  drSpecial: specialization,
                                  doctorId: doctorId,
                                  drMail: drMail,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(9),
                                      leading: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.pink.shade100,
                                        ),
                                        width: 60,
                                        height: 80,
                                        child: ClipOval(
                                          child:
                                              (doctorData['profilePics'] !=
                                                      null &&
                                                  doctorData['profilePics']
                                                      .toString()
                                                      .isNotEmpty)
                                              ? Image.network(
                                                  doctorData['profilePics'],
                                                  fit: BoxFit.cover,
                                                  
                                                )
                                              : Image.asset(
                                                  'assets/images/doctor.png',
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),

                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Dr. $doctorName",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            specialization,
                                            style:
                                                GoogleFonts.playfairDisplay(),
                                          ),

                                          Text(
                                            '📍 $location',
                                            style:
                                                GoogleFonts.playfairDisplay(),
                                          ),
                                          const SizedBox(height: 4),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
