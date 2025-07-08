int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  print("wordCount: $wordCount");
  final readingTime = wordCount / 225;
  return readingTime.ceil();
}
