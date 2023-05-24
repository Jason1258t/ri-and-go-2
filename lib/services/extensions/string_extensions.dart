extension Capitalize<T> on String {
  String capitalize() {
    try {
      return this[0].toUpperCase() + substring(1).toLowerCase();
    } catch (e) {
      return this;
    }
  }

  String capitalizeAll() {
    try {
      return split(' ').map((e) => e.capitalize()).toList().join(' ');
    } catch (e) {
      return this;
    }
  }
  String upperCaseFirst() {
    try {
      return this[0].toUpperCase() + substring(1);
    } catch (e) {
      return this;
    }
  }

  String upperFirstSymbolInSentence() {
    try {
      return split('. ').map((e) => e.upperCaseFirst()).toList().join('. ');
    } catch (e) {
      return this;
    }
  }
}
