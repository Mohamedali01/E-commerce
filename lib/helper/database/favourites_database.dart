import 'package:e_commerce/constants.dart';
import 'package:e_commerce/model/cart_model.dart';
import 'package:e_commerce/model/favourite_model.dart';
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
            "CREATE TABLE $favouriteTable ( $favouriteId TEXT NOT NULL, $favouriteName TEXT NOT NULL, $favouriteImage TEXT NOT NULL, $favouritePrice TEXT NOT NULL,$favouriteIsFavourite TEXT NOT NULL)");
      });
      _database = db;
      return _database;
    }
  }

  Future<void> insert(FavouriteModel favouriteModel) async {
    Database dbHelper = await database;
    await dbHelper.insert(favouriteTable, favouriteModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(String id) async {
    Database dbHelper = await database;
    await dbHelper
        .delete(favouriteTable, where: '$favouriteId = ?', whereArgs: [id]);
  }

  Future<List<FavouriteModel>> query() async {
    Database dbHelper = await database;
    List list = await dbHelper.query(favouriteTable);
    return list.map((e) => FavouriteModel.fromJson(e)).toList();
  }

  Future<void> clear() async {
    Database dbHelper = await database;
    await dbHelper.delete(favouriteTable);
  }

  Future<void> update(FavouriteModel favouriteModel) async {
    Database dbHelper = await database;
    await dbHelper.update(favouriteTable, favouriteModel.toJson(),
        where: '$favouriteId = ?', whereArgs: [favouriteModel.favId]);
  }
}
