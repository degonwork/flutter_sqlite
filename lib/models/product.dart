final String tableProducts = 'products';

class ProductField {
  static final List<String> values = [
    id,
    name,
    brand_id,
    category_id,
    model_year,
    list_price
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String brand_id = 'brand_id';
  static final String category_id = 'category_id';
  static final String model_year = 'model_year';
  static final String list_price = 'list_price';
}

class Product {
  final int? id;
  final String? name;
  final int? brand_id;
  final int? category_id;
  final int? model_year;
  final double? list_price;

  const Product(
      {this.id,
      required this.name,
      required this.brand_id,
      required this.category_id,
      required this.model_year,
      required this.list_price});

  Product copy(
          {int? id,
          String? name,
          int? brand_id,
          int? category_id,
          int? model_year,
          double? list_price}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        brand_id: brand_id ?? this.brand_id,
        category_id: category_id ?? this.category_id,
        model_year: model_year ?? this.model_year,
        list_price: list_price ?? this.list_price,
      );

  static Product fromJson(Map<String, Object?> json) => Product(
        id: json[ProductField.id] as int,
        name: json[ProductField.name] as String,
        brand_id: json[ProductField.brand_id] as int,
        category_id: json[ProductField.category_id] as int,
        model_year: DateTime(json[ProductField.model_year] as int).year,
        list_price: json[ProductField.list_price] as double,
      );

  Map<String, Object?> toMap() {
    return {
      ProductField.id: id,
      ProductField.name: name,
      ProductField.brand_id: brand_id,
      ProductField.category_id: category_id,
      ProductField.model_year: model_year,
      ProductField.list_price: list_price
    };
  }
}
