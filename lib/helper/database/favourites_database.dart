import 'package:e_commerce/constants.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavouritesDatabase {
  FavouritesDatabase._();

  static final FavouritesDatabase favouritesDatabase = FavouritesDatabase._();
  Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    else {
      String path = join(await getDatabasesPath(), 'favourites.db');
      Database db =
          await openDatabase(path, version: 1, onCreate: (dataB, _) async {
        await dataB.execute(
            "CREATE TABLE $favouriteTable ( $favouriteId TEXT NOT NULL, $favouriteName TEXT NOT NULL, $favouriteImage TEXT NOT NULL, $favouritePrice TEXT NOT NULL, $favouriteQuantity INTEGER NOT NULL)");
      });
      _database = db;
      return _database;
    }
  }

  Future<void> insert(CartModel cartModel) async {
    Database dbHelper = await database;
    await dbHelper.insert(favouriteTable, cartModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(String id) async {
    Database dbHelper = await database;
    await dbHelper
        .delete(favouriteTable, where: '$favouriteId = ?', whereArgs: [id]);
  }

  // Future<void> update(CartModel cartModel)async{
  //   Database dbHelper = await database;
  //   await dbHelper.update(favouriteTable, cartModel.toJson(),where: '$favouriteId = ?',whereArgs: [cartModel.cartId]);
  //
  // }

  Future<List<CartModel>> query() async {
    Database dbHelper = await database;
    List list = await dbHelper.query(favouriteTable);
    return list.map((e) => CartModel.fromJson(e)).toList();
  }
}
