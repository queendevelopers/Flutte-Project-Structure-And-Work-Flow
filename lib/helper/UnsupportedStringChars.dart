import "package:unorm_dart/unorm_dart.dart" as unorm;

class UnsupportedChars {
  String unsupportedCharsUnorm(String string) {
    var combining = RegExp(r"[\u0300-\u036F]/g");
    print("NFKD: *   ${unorm.nfkd(string).replaceAll(combining, "")}");
    return unorm.nfd(string).replaceAll(combining, "");
  }

  String stringReplacement(String string) {
    string.replaceAll('…', '...').replaceAll('–', '-');
    return string;
  }
}
