class CloudinessValueObject {
  final double cValue;

  const CloudinessValueObject({required this.cValue});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CloudinessValueObject && other.cValue == cValue;
  }

  bool operator <(CloudinessValueObject other) {
    return other.cValue < cValue;
  }

  bool operator >(CloudinessValueObject other) {
    return other.cValue > cValue;
  }

  bool operator <=(CloudinessValueObject other) {
    return other.cValue <= cValue;
  }

  bool operator >=(CloudinessValueObject other) {
    return other.cValue >= cValue;
  }

  @override
  int get hashCode => cValue.hashCode ^ cValue.hashCode;
}
