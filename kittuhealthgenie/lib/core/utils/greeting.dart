String getGreeting(String name) {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return "Good Morning, $name ☀️";
  } else if (hour < 17) {
    return "Good Afternoon, $name 🌤️";
  } else {
    return "Good Evening, $name 🌙";
  }
}
