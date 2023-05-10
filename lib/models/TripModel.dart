
class TripModel {
  String itemName;
  String itemDate;
  int authorId;
  int itemId;
  bool tripType;
  String image;

  TripModel(
      {required this.itemId,
        required this.itemName,
        required this.itemDate,
        required this.authorId,
        required this.tripType,
        required this.image});
}