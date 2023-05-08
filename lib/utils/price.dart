
// class to deal with price related things
class Price {

  // Return a price formatted for display taking into account Free prices.
  static String formatPriceForDisplay(double? price) {
    if (price == null) {
      return '';
    }
    if (price == 0.0) {
      return 'Free';
    }
    return '\$' + price.toString();
  }
}

