extension StringExtensions on String {
  String getInitials() {
    List<String> nameParts = trim().split(' ');
    if (nameParts.length >= 2) {
      return nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
    }
    return nameParts[0][0].toUpperCase(); // Handle single names
  }
}
