class OwnCar {
  String name;
  String fuelType;
  int kilometers;
  int year;
  double price;
  String chassis;
  String gearbox;
  int engineSize;
  int horsepower;
  double buyPrice;
  double spent;
  double sellPrice;
  String imagePath;

  OwnCar({
    required this.name,
    required this.fuelType,
    required this.kilometers,
    required this.year,
    required this.price,
    required this.chassis,
    required this.gearbox,
    required this.engineSize,
    required this.horsepower,
    required this.buyPrice,
    required this.spent,
    required this.sellPrice,
    required this.imagePath
  });

  factory OwnCar.fromJson(Map<String, dynamic> json) {
    return OwnCar(
      name: json['model'] as String,
      kilometers: json['km'] as int,
      year: json['year'] as int,
      fuelType: json['combustible'] as String,
      gearbox: json['gearbox'] as String,
      chassis: json['body_type'] as String,
      engineSize: json['engine_size'] as int,
      horsepower: json['power'] as int,
      price: (json['selling_for'] as num).toDouble(),
      buyPrice: (json['bought_for'] as num?)?.toDouble() ?? 0.0,
      sellPrice: (json['sold_for'] as num?)?.toDouble() ?? 0.0,
      spent: (json['spent_on'] as num?)?.toDouble() ?? 0.0,
      imagePath: json['img_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': name,
      'km': kilometers,
      'year': year,
      'combustible': fuelType,
      'gearbox': gearbox,
      'body_type': chassis,
      'engine_size': engineSize,
      'power': horsepower,
      'selling_for': price,
      'bought_for': buyPrice,
      'sold_for': sellPrice,
      'spent_on': spent,
      'img_url': imagePath,
    };
  }
}