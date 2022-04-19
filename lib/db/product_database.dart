import 'package:read_file/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductsDataBase {
  ProductsDataBase._init();
  //create instance ProductDatabaset
  static final ProductsDataBase instance = ProductsDataBase._init();
  static Database? _dataBase;
  Future<Database> get database async {
    if (_dataBase != null) return _dataBase!;
    _dataBase = await _initDB('products.db');
    return _dataBase!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';
    await db.execute('''
CREATE TABLE $tableProducts (
  ${ProductField.id} $idType,
  ${ProductField.name} $textType,
  ${ProductField.brand_id} $integerType,
  ${ProductField.category_id} $integerType,
  ${ProductField.model_year} $integerType,
  ${ProductField.list_price} $doubleType
  )
''');
  }

  Future<Product> create(Product product) async {
    final db = await instance.database;
    final map = product.toMap();
    final id = await db.insert(tableProducts, map);
    return product.copy(id: id);
  }

  Future<Product?> readProduct(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableProducts,
      columns: ProductField.values,
      where: '${ProductField.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Product>> readAllProducts() async {
    final db = await instance.database;
    final orderBy = '${ProductField.list_price} ASC';
    final result = await db.query(tableProducts, orderBy: orderBy);
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<int> update(Product product) async {
    final db = await instance.database;
    return db.update(
      tableProducts,
      product.toMap(),
      where: '${ProductField.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableProducts,
      where: '${ProductField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
