class Validation {
  final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter valid email address.';
    }
    return null;
  }

  String? isEmptyValidation(value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
  }
}
