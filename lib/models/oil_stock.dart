class OilStock {
  final String name;
  final double amount;
  final double minimum;

  const OilStock({
    required this.name,
    required this.amount,
    required this.minimum,
  });

  OilStock copyWith({
    String? name,
    double? amount,
    double? minimum,
  }) {
    return OilStock(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      minimum: minimum ?? this.minimum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'minimum': minimum,
    };
  }

  factory OilStock.fromMap(Map<String, dynamic> map) {
    return OilStock(
      name: map['name'],
      amount: (map['amount'] as num).toDouble(),
      minimum: (map['minimum'] as num).toDouble(),
    );
  }
}