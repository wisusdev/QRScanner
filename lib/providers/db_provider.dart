import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reader_qr/models/scan.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
	static Database ?_database;
	static final DBProvider db = DBProvider._();

	DBProvider._();

	Future<Database?> get database async {
		if (_database != null){
			return _database;
		}

		_database = await initDB();

		return _database;
	}

	Future<Database?> initDB() async {
		// Path de la base de datos
		Directory documentsDirectory = await getApplicationDocumentsDirectory();
		final path = join(documentsDirectory.path, 'ScansDB.db');

		// Create database
		return await openDatabase(
			path,
			version: 1,
			onOpen: (db){},
			onCreate: (Database db, int version) async {
				await db.execute(''' CREATE TABLE Scans( id INTEGER PRIMARY KEY, tipo TEXT, valor TEXT ) ''');
			}
		);
	}

	Future<int> newScanRaw(ScanModel newScan) async {
		final id 		= newScan.id;
		final tipo 	= newScan.tipo;
		final valor = newScan.valor;

		final db = await database;
		final response = await db!.rawInsert(''' INSERT INTO Scans (id, tipo, valor) VALUES ($id, '$tipo', '$valor') ''');
    return response;
	}

  Future<int> scanNew(ScanModel newScan) async {
    final db = await database;
    final response = await db!.insert('Scans', newScan.toJson());
    // Se retorna el ultimo ID
    return response;
  }

  Future<ScanModel?> getScanById(int id) async {
		final db = await database;
		final response = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
		return response.isNotEmpty ? ScanModel.fromJson(response.first) : null;
	}

	Future<List<ScanModel>?> getAllScans() async {
		final db = await database;
		final response = await db!.query('Scans');
		return response.isNotEmpty ? response.map((scan) => ScanModel.fromJson(scan)).toList() : [];
	}

	Future<List<ScanModel>?> getTypeScans(String tipo) async {
		final db = await database;
		final response = await db!.rawQuery(''' SELECT * FROM Scans WHERE tipo = '$tipo' ''');
		return response.isNotEmpty ? response.map((scan) => ScanModel.fromJson(scan)).toList() : [];
	}

	Future<int> updateScan(ScanModel newScan) async {
		final db = await database;
		final response = await db!.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);
		return response;
	}

	Future<int> deleteScan(int id) async {
		final db = await database;
		final response = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
		return response;
	}

	Future<int> deleteAllScan() async {
		final db = await database;
		final response = await db!.delete('Scans');
		return response;
	}
}