import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:mhc/controller/user_Controller.dart';
import 'package:mhc/modal/user_modal.dart';
import 'dart:math' as math;

import 'package:mhc/signUpScreen.dart';

class SelectUserTypeScreen extends StatefulWidget {
  const SelectUserTypeScreen({super.key});

  @override
  State<SelectUserTypeScreen> createState() => _SelectUserTypeScreenState();
}

class _SelectUserTypeScreenState extends State<SelectUserTypeScreen> {
  // Inject the controller to manage selected state
  final UserController usrCtr = Get.put(UserController());

  // Data mapping for each user type
  final Map<UserType, UserTypeData> _userData = {
    UserType.patient: UserTypeData(
      title: "Patient Account",
      description: "Access your health records, book appointments, and track your wellness journey.",
      icon: Icons.person_outline,
      color: const Color(0xFF4285F4),
      btnText: "Continue as Patient",
    ),
    UserType.consultant: UserTypeData(
      title: "Consultant Account",
      description: "Manage your patient list, provide expert advice, and review medical cases.",
      icon: Icons.medical_services_outlined,
      color: const Color(0xFF10B981),
      btnText: "Continue as Consultant",
    ),
    UserType.institute: UserTypeData(
      title: "Institute Account",
      description: "Coordinate healthcare staff, manage facilities, and oversee organizational analytics.",
      icon: Icons.apartment_outlined,
      color: const Color(0xFFAC58F5),
      btnText: "Continue as Institute",
    ),
    UserType.guardian: UserTypeData(
      title: "Guardian Account",
      description: "Monitor health metrics for family members and manage care schedules.",
      icon: Icons.groups_outlined,
      color: const Color(0xFFF59E0B),
      btnText: "Continue as Guardian",
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final activeType = usrCtr.selectedType.value;
          final activeData = _userData[activeType]!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Select User Type",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Choose your role to get started",
                  style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
                ),
                const Spacer(),
                
                // Interactive Circular Selector
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Orbital Path
                      Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade200, width: 2),
                        ),
                      ),
                      
                      // Central Selected Icon
                      _buildCentralCircle(activeData),

                      // Satellite Icons
                      _buildSatelliteIcon(UserType.patient, -math.pi / 2),
                      _buildSatelliteIcon(UserType.consultant, 0),
                      _buildSatelliteIcon(UserType.institute, math.pi / 2),
                      _buildSatelliteIcon(UserType.guardian, math.pi),
                    ],
                  ),
                ),
                
                const Spacer(),

                // Animated Text Section
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                  child: Column(
                    key: ValueKey(activeType),
                    children: [
                      Text(
                        activeData.title,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: activeData.color),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        activeData.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15, color: Color(0xFF475569), height: 1.5),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),

                // Action Button with Navigation Arguments (Option B)
                _buildConfirmButton(activeData, activeType),
                const SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCentralCircle(UserTypeData data) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: data.color.withOpacity(0.5), width: 3),
        boxShadow: [
          BoxShadow(
            color: data.color.withOpacity(0.3),
            blurRadius: 25,
            spreadRadius: 2,
          )
        ],
      ),
      child: Icon(data.icon, size: 40, color: data.color),
    );
  }

  Widget _buildSatelliteIcon(UserType type, double angle) {
    final isSelected = usrCtr.selectedType.value == type;
    final data = _userData[type]!;
    
    double x = 110 * math.cos(angle);
    double y = 110 * math.sin(angle);

    return Transform.translate(
      offset: Offset(x, y),
      child: GestureDetector(
        onTap: () => usrCtr.updateUserType(type),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? data.color : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey.shade200,
                ),
              ),
              child: Icon(
                data.icon,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                size: 28,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              type.name.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? data.color : const Color(0xFF94A3B8),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(UserTypeData data, UserType type) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Get.to(
            () => const SignUpScreen(),
            arguments: type, // Passing the Enum
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 600),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: data.color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: data.color.withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data.btnText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 24),
          ],
        ),
      ),
    );
  }
}