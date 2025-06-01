class ItemModel {
  int id;
  String name;
  String category;
  String description;
  List imageLinks;
  int price;

  ItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageLinks,
    required this.price,
  });
}
