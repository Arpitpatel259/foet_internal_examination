// ignore: camel_case_extensions
// ignore_for_file: unnecessary_null_comparison, camel_case_extensions, duplicate_ignore

extension extString on String {
  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^[0-9]{9}$'); // Regular expression for exactly 9 digits
    return phoneRegExp.hasMatch(this);
  }

}
