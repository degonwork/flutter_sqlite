import 'package:get/get.dart';
import 'package:read_file/db/initialization_process.dart';
import 'package:read_file/db/product_database.dart';
import 'package:read_file/readfile/read_file.dart';

class ProductController extends GetxController {
  var productList = [];
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    database();
  }

  @override
  void dispose() {
    super.dispose();
    ProductsDataBase.instance.close();
  }

  Future database() async {
    await dbProcessed();
  }

  Future dbProcessed() async {
    final products = await readFileTxt('text_note/my_text.txt');
    if (products!.isNotEmpty) {
      await createToDB(products: products);

      /* Read file from db */
      // Product? result = await readFromDB(id: 2);
      // print(result!.name);
      // print(result.list_price);
      // print(result.model_year);

      /* Read All From db */
      // List<Product>? results = await readAllProduct();
      // for (int i = 0; i < results!.length; i++) {
      //   print(results[i].name);
      // }

      /* Add list product to db*/
      // List<Product>? productlist = [
      //   Product(
      //     name: 'Batman',
      //     brand_id: 6,
      //     category_id: 9,
      //     model_year: 2019,
      //     list_price: 800.0,
      //   ),
      //   Product(
      //     name: 'Avengers: Infiniti',
      //     brand_id: 3,
      //     category_id: 2,
      //     model_year: 2020,
      //     list_price: 850.0,
      //   )
      // ];
      // await addListToDB(productlist);
      // Product? result = await readFromDB(id: 322);
      // print(result!.name);

      /* Update product from database*/
      // var map = {
      //   'name': 'Wonder Women',
      //   'list_price': 840.0,
      // };
      // await updateProduct(2, map);

      /* Delete Product from database*/
      // await deleteProduct(id: 321);
    }
  }
}
