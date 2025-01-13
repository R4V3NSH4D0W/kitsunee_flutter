String trimRating(String rating) {
  return rating.split(' -')[0];
}

List<Map<String, DateTime>> generateDates() {
  final List<Map<String, DateTime>> dates = [];
  final now = DateTime.now();

  for (int i = 0; i < 20; i++) {
    final date = now.add(Duration(days: i));
    dates.add({'date': date});
  }

  return dates;
}
