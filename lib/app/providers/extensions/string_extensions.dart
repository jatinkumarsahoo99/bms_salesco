extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String pascalCaseToNormal() {
    return split(RegExp(r"(?=(?!^)[A-Z])"))
        .map((e) => e.capitalize())
        .toList()
        .join(" ");
  }

  String normalCaseToPascalCase(String input) {
    return input.replaceAllMapped(RegExp(r'(\w)(\w*)'),
            (match) => '${match.group(1)?.toUpperCase()}${match.group(2)?.toLowerCase()}');
  }

}
