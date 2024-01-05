class TimeValueObject {
  final String time;

  const TimeValueObject({
    required this.time,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeValueObject && other.time == time;
  }

  @override
  int get hashCode => time.hashCode;

  @override
  String toString() {
    final miliSecTime = time.split(' ').last;
    return "${miliSecTime}";
  }
}
