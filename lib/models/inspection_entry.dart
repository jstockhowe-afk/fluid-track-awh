class InspectionEntry {
  final int? id;

  final String machineId;

  final double hydraulicOil;
  final double guidewayOil;

  final double waterMeter;
  final double concentration;

  final String comment;

  final DateTime dateTime;

  const InspectionEntry({
    this.id,
    required this.machineId,
    required this.hydraulicOil,
    required this.guidewayOil,
    required this.waterMeter,
    required this.concentration,
    required this.comment,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'machineId': machineId,
      'hydraulicOil': hydraulicOil,
      'guidewayOil': guidewayOil,
      'waterMeter': waterMeter,
      'concentration': concentration,
      'comment': comment,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory InspectionEntry.fromMap(
    Map<String, dynamic> map,
  ) {
    return InspectionEntry(
      id: map['id'],
      machineId: map['machineId'],
      hydraulicOil:
          (map['hydraulicOil'] as num).toDouble(),
      guidewayOil:
          (map['guidewayOil'] as num).toDouble(),
      waterMeter:
          (map['waterMeter'] as num).toDouble(),
      concentration:
          (map['concentration'] as num).toDouble(),
      comment: map['comment'] ?? '',
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}