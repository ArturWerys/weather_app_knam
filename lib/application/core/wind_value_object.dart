enum WindSpeedUnit {
  mile,
  kilometr;

  const WindSpeedUnit();

  @override
  String toString() => switch (this) {
        WindSpeedUnit.mile => 'mph',
        WindSpeedUnit.kilometr => 'km/h',
      };
}

class WindValueObject {
  final double value;
  final WindSpeedUnit unit;
  final String direction;

  const WindValueObject({
    required this.value,
    required this.unit,
    required this.direction,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WindValueObject &&
        other.value == value &&
        other.unit == unit &&
        other.direction == direction;
  }

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;
}
