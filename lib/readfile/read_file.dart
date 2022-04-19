import 'package:flutter/services.dart' show rootBundle;
import 'package:read_file/models/product.dart';

Future<List<Product>?> readFileTxt(String path) async {
  List<Product> products = [];
  String response = await rootBundle.loadString(path);
  Stream<String> stringStream = Stream<String>.value(response);
  try {
    await for (String line in stringStream) {
      var lines = line.split('\n');
      for (int i = 1; i < lines.length; i++) {
        String line = lines[i].substring(1, lines[i].length - 2);
        List<String> values = line.split(",");
        Product product = Product(
            id: int.parse(values[0]),
            name: values[1].substring(1, values[1].length - 2),
            brand_id: int.parse(values[2]),
            category_id: int.parse(values[3]),
            model_year: int.parse(values[4]),
            list_price: double.parse(values[5]));
        products.add(product);
      }
      return products;
    }
  } catch (e) {
    print(e.toString());
  }
}
