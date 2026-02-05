import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Appointment {
  final int? id;
  final String drName;
  final String designation;
  final String dayDate;
  final String time;
  final String typeOfAppointment;
  final String status;

  Appointment({
    this.id,
    required this.drName,
    required this.designation,
    required this.dayDate,
    required this.time,
    required this.typeOfAppointment,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'drName': drName,
      'designation': designation,
      'dayDate': dayDate,
      'time': time,
      'typeOfAppointment': typeOfAppointment,
      'status': status,
    };
  }

  static Appointment fromMap(Map<String, dynamic> map) {
    if (map.containsKey('dayDate') && map.containsKey('time')) {
      return Appointment(
        id: map['id'],
        drName: map['drName'] ?? 'N/A',
        designation: map['designation'] ?? 'Doctor',
        dayDate: map['dayDate'], 
        time: map['time'],       
        typeOfAppointment: map['typeOfAppointment'] ?? 'Consultation',
        status: map['status'] ?? 'pending',
      );
    }
    else {
      DateTime appointmentDateTime;
      if (map['appointmentTimestamp'] is Timestamp) {
        appointmentDateTime = (map['appointmentTimestamp'] as Timestamp).toDate();
      } else {
        appointmentDateTime = DateTime.now();
      }

      return Appointment(
        id: map['id'],
        drName: map['doctorName'] ?? 'N/A',
        designation: map['designation'] ?? 'Doctor',
        dayDate: DateFormat('EEE, MMM d, yyyy').format(appointmentDateTime),
        time: DateFormat('h:mm a').format(appointmentDateTime),
        typeOfAppointment: map['type'] ?? 'Consultation', 
        status: map['status'] ?? 'pending',
      );
    }
  }
}
