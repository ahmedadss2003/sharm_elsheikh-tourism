class TransportationModel {
  final int id;
  final String typeBus;
  final double price;
  final String description;
  final String image;

  TransportationModel({
    required this.image,
    required this.id,
    required this.typeBus,
    required this.price,
    required this.description,
  });

  factory TransportationModel.fromJson(Map<String, dynamic> json) {
    return TransportationModel(
      image: json['image'],
      id: json['id'],
      typeBus: json['type_bus'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
    );
  }
}
