extension StringX on String {
  bool get isUUID {
    final regex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    );
    return regex.hasMatch(this);
  }

  bool get isValidEmail {
    if (isEmpty) {
      return false;
    }

    // Regular expression for a basic email validation
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    return emailRegex.hasMatch(this);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  bool get isNumeric {
    final numericRegExp = RegExp(r'^\d+$');
    return numericRegExp.hasMatch(this);
  }

  bool get isParseObjectId {
    final parseObjectIdRegExp = RegExp(r'^[A-Za-z0-9]{10}$');
    return parseObjectIdRegExp.hasMatch(this);
  }

  String get cleanPhoneNumber {
    return replaceAll(RegExp(r'[^\d]'), '').replaceFirst('993', '8');
  }

  String get removePrefix {
    final parts = split('-');
    final numberPart = parts.length > 1 ? parts[1] : this;

    return numberPart.replaceFirst(RegExp(r'^0+'), '');
  }
}
