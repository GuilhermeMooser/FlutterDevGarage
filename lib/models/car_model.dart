class Car {
  final int? id;
  final String name;
  final String brand;
  final String year;
  final String imageUrl;

  Car({
    this.id,
    required this.name,
    required this.brand,
    required this.year,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'year': year,
      'imageUrl': imageUrl,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      year: map['year'],
      imageUrl: map['imageUrl'],
    );
  }
}
