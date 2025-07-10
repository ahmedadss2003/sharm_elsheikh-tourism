class TransportationModel {
  final int id;
  final String typeBus;
  final double price;
  final String description;

  TransportationModel({
    required this.id,
    required this.typeBus,
    required this.price,
    required this.description,
  });

  factory TransportationModel.fromJson(Map<String, dynamic> json) {
    return TransportationModel(
      id: json['id'],
      typeBus: json['type_bus'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_bus': typeBus,
      'price': price,
      'description': description,
    };
  }
}
