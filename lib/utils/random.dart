// Contains helper random function

import 'dart:math';

T getRandomElement<T>(List<T> elements) {
  final random = Random();
  final index = random.nextInt(elements.length);
  return elements[index];
}
