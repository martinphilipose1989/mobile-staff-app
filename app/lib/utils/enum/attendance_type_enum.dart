enum AttendanceTypeEnum {
  present(1),
  absent(2),
  drop(3),
  pickup(4);

  // This is a field to hold the integer value for each enum
  final int value;

  // Constructor to assign the value
  const AttendanceTypeEnum(this.value);
}
