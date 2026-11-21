/// Display formatting for people's names.
abstract final class NameFormatter {
  static const _arabicArticle = 'ال';

  /// First letter of the first two words, spaced like the design. The
  /// Arabic article "ال" is skipped, so `خالد العتيبي` → `خ ع` (not `خ ا`).
  /// `Khalid Alotaibi` → `K A`, `Khalid` → `K`.
  static String initials(String name) => name
      .trim()
      .split(' ')
      .where((word) => word.isNotEmpty)
      .take(2)
      .map((word) {
        final letters =
            word.startsWith(_arabicArticle) &&
                word.length > _arabicArticle.length
            ? word.substring(_arabicArticle.length)
            : word;
        return String.fromCharCode(letters.runes.first).toUpperCase();
      })
      .join(' ');
}
