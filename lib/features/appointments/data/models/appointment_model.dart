import 'package:doclib/features/appointments/domain/appointments.dart';

class AppointmentModel extends Appointment {
  AppointmentModel({
    super.appointmentId,
    super.updatedAt,
    super.notes,
    super.cancellationReason,
    super.createdAt,
    super.startTime,
    super.reason,
    super.endTime,
    super.patientId,
    super.status,
    super.doctorId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        appointmentId: json['id']?.toString(),
        updatedAt: json['updatedAt'],
        notes: json['notes'],
        cancellationReason: json['cancellationReason'],
        createdAt: json['createdAt'],
        startTime: json['startTime'],
        reason: json['reason'],
        endTime: json['endTime'],
        patientId: json['patient'],
        status: json['status'],
        doctorId: json['doctor'],
      );

  Map<String, dynamic> toJson() => {
    'appointmentId ': appointmentId,
    'updatedAt': updatedAt,
    'notes': notes,
    'cancellationReason': cancellationReason,
    'createdAt': createdAt,
    'startTime': startTime,
    'reason': reason,
    'endTime': endTime,
    'patient': patientId,
    'status': status,
    'doctor': doctorId,
  };
}
