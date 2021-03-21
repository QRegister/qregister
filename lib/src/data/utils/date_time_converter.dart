class DateTimeConverter {
  static String convertDateToString(DateTime date) {
    // MDY Style date printing, will be changed if project goes global
    return '${date.month}.${date.day}.${date.year}';
  }
}
