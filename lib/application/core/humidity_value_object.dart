class HumidityValueObject {
  final double value;

  const HumidityValueObject({required this.value});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HumidityValueObject && other.value == value;
  }

  @override
  int get hashCode => value.hashCode ^ value.hashCode;
}
