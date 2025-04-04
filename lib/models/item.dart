class Item {
  String name;
  String category;
  String? description;
  String imageLink;
  int price;
  int id;
  Map? specifications = {};

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.imageLink,
    this.description,
    required this.price,
    this.specifications,
  });
}
