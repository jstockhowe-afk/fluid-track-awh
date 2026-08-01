class OilEntry {
  final int? id;

  final String machineId;
  final String medium;
  final double liters;
  final String comment;
  final DateTime dateTime;

  const OilEntry({
    this.id,
    required this.machineId,
    required this.medium,
    required this.liters,
    required this.comment,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'machineId': machineId,
      'medium': medium,
      'liters': liters,
      'comment': comment,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory OilEntry.fromMap(Map<String, dynamic> map) {
    return OilEntry(
      id: map['id'],
      machineId: map['machineId'],
      medium: map['medium'],
      liters: (map['liters'] as num).toDouble(),
      comment: map['comment'] ?? '',
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}