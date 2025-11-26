int calculateReadingTime(String content) {
  final wordCount = content
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .length;
  final readingSpeed = 225;

  final readingTime = wordCount / readingSpeed;

  return readingTime.ceil();
}
