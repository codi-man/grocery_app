class BeveragesModel {
  final String name;
  final String size;
  final String price;
  final String imagePath;

  BeveragesModel({
    required this.name,
    required this.size,
    required this.price,
    required this.imagePath,
  });

  static List<BeveragesModel> beverages = [
    BeveragesModel(
      name: "Diet Coke",
      size: "355ml",
      price: "\$1.99",
      imagePath: "assets/images/beverages_images/diet_coke.png",
    ),
    BeveragesModel(
      name: "Sprite Can",
      size: "325ml",
      price: "\$1.50",
      imagePath: "assets/images/beverages_images/sprite.png",
    ),
    BeveragesModel(
      name: "Apple Juice",
      size: "2L",
      price: "\$15.99",
      imagePath: "assets/images/beverages_images/apple_and_grape_juice.png",
    ),
    BeveragesModel(
      name: "Orange Juice",
      size: "2L",
      price: "\$1.50",
      imagePath: "assets/images/beverages_images/orange_juice.png",
    ),
    BeveragesModel(
      name: "Coca Cola Can",
      size: "325ml",
      price: "\$4.99",
      imagePath: "assets/images/beverages_images/coca_cola.png",
    ),
    BeveragesModel(
      name: "Pepsi Can",
      size: "330ml",
      price: "\$4.99",
      imagePath: "assets/images/beverages_images/pepsi.png",
    ),
  ];
}