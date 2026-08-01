class Machine {
  final String id;
  final String name;
  final String costCenter;

  final String imagePath;
  final String hydraulicOil;
  final String guidewayOil;
  final String coolant;

  final int hydraulicTank;
  final int coolantTank;

  final String qrCode;
  final String notes;

  const Machine({
    required this.id,
    required this.name,
    required this.costCenter,
    this.imagePath = '',
    this.hydraulicOil = '',
    this.guidewayOil = '',
    this.coolant = '',
    this.hydraulicTank = 0,
    this.coolantTank = 0,
    this.qrCode = '',
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'costCenter': costCenter,
      'imagePath': imagePath,
      'hydraulicOil': hydraulicOil,
      'guidewayOil': guidewayOil,
      'coolant': coolant,
      'hydraulicTank': hydraulicTank,
      'coolantTank': coolantTank,
      'qrCode': qrCode,
      'notes': notes,
    };
  }

  factory Machine.fromMap(Map<String, dynamic> map) {
    return Machine(
      id: map['id'],
      name: map['name'],
      costCenter: map['costCenter'],
      imagePath: map['imagePath'] ?? '',
      hydraulicOil: map['hydraulicOil'] ?? '',
      guidewayOil: map['guidewayOil'] ?? '',
      coolant: map['coolant'] ?? '',
      hydraulicTank: map['hydraulicTank'] ?? 0,
      coolantTank: map['coolantTank'] ?? 0,
      qrCode: map['qrCode'] ?? '',
      notes: map['notes'] ?? '',
    );
  }

  Machine copyWith({
    String? id,
    String? name,
    String? costCenter,
    String? imagePath,
    String? hydraulicOil,
    String? guidewayOil,
    String? coolant,
    int? hydraulicTank,
    int? coolantTank,
    String? qrCode,
    String? notes,
  }) {
    return Machine(
      id: id ?? this.id,
      name: name ?? this.name,
      costCenter: costCenter ?? this.costCenter,
      imagePath: imagePath ?? this.imagePath,
      hydraulicOil: hydraulicOil ?? this.hydraulicOil,
      guidewayOil: guidewayOil ?? this.guidewayOil,
      coolant: coolant ?? this.coolant,
      hydraulicTank: hydraulicTank ?? this.hydraulicTank,
      coolantTank: coolantTank ?? this.coolantTank,
      qrCode: qrCode ?? this.qrCode,
      notes: notes ?? this.notes,
    );
  }
}