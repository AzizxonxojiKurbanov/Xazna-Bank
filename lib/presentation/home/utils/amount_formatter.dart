String formatAmount(num amount) {
  final fixed = amount.toStringAsFixed(2);
  final parts = fixed.split('.');
  final whole = parts.first;
  final buffer = StringBuffer();

  for (var index = 0; index < whole.length; index++) {
    final reverseIndex = whole.length - index;
    buffer.write(whole[index]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write(' ');
    }
  }

  return '${buffer.toString()}.${parts.last}';
}
