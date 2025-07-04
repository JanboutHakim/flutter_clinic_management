class Appointment {
  final String? appointmentId;
  final String? updatedAt;
  final String? notes;
  final String? cancellationReason;
  final String? createdAt;
  final DateTime? startTime;
  final String? reason;
  final DateTime? endTime;
  final String? patientId;
  final String? status;
  final String? doctorId;

  Appointment({
    this.appointmentId,
    this.updatedAt,
    this.notes,
    this.cancellationReason,
    this.createdAt,
    this.startTime,
    this.reason,
    this.endTime,
    this.patientId,
    this.status,
    this.doctorId,
  });
}
