enum AttendanceTypeEnum {
  present(1),
  absent(2),
  dropall(3),
  pickupall(4),
  drop(5),
  pickup(6);

  // This is a field to hold the integer value for each enum
  final int value;

  // Constructor to assign the value
  const AttendanceTypeEnum(this.value);
}

enum TripRouteStatus {
  inProcess("Inprocess"),
  completed("Completed");

  final String status;
  const TripRouteStatus(this.status);
}
