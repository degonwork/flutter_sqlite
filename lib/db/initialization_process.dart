import 'package:read_file/db/product_database.dart';
import 'package:read_file/models/product.dart';

// Create product to database
Future<List<Product>> createToDB({List<Product>? products}) async {
  List<Product> lst = [];
  for (int i = 0; i < products!.length; i++) {
    if (products[i] is Product) {
      Product? resultProduct;
      resultProduct = await readFromDB(id: products[i].id);
      if (resultProduct == null) {
        Product product = await ProductsDataBase.instance.create(products[i]);
        lst.add(product);
      }
    }
  }
  return lst;
}

// Read product with id from database
Future<Product?> readFromDB({int? id}) async {
  Product? result = await ProductsDataBase.instance.readProduct(id!);
  return result;
}

// Read all product from database
Future<List<Product>> readAllFromDB() async {
  List<Product> result = [];
  result = await ProductsDataBase.instance.readAllProducts();
  return result;
}

Future<void> addListToDB(List<Product> listProducts) async {
  List<Product> listProductAdd = [];
  List<Product> allProduct = await readAllFromDB();
  allProduct.sort((a, b) => a.id! - b.id!);
  int? maxID = allProduct.last.id;
  for (int i = 0; i < listProducts.length; i++) {
    Product? product = listProducts[i].copy(id: maxID! + i + 1);
    listProductAdd.add(product);
  }
  await createToDB(products: listProductAdd);
}

// Update product from database
Future<void> updateProduct(int id, Map<String, dynamic> params) async {
  Product? product = await readFromDB(id: id);
  if (product != null) {
    String name = params['name'] ?? product.name!;
    int brand_id = params['brand_id'] ?? product.brand_id!;
    int category_id = params['category_id'] ?? product.category_id!;
    int model_year = params['model_year'] ?? product.model_year!;
    double list_price = params['list_price'] ?? product.list_price!;
    Product newProduct = Product(
        id: id,
        name: name,
        brand_id: brand_id,
        category_id: category_id,
        model_year: model_year,
        list_price: list_price);
    Product? productUpdate = newProduct.copy();
    await ProductsDataBase.instance.update(productUpdate);
  }
}

// Delete product with id from database
Future<int?> deleteFromDB({int? id}) async {
  int? i = await ProductsDataBase.instance.delete(id!);
  return i;
}
