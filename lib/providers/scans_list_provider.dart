import 'package:flutter/cupertino.dart';
import 'package:reader_qr/models/scan.dart';
import 'package:reader_qr/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String typeSelected = 'http';

  Future<ScanModel> newScan (String valor) async {
    final newScan = ScanModel(valor: valor);
    final id = await DBProvider.db.scanNew(newScan);
    // Asignamos el ID de la base de datos al modelo
    newScan.id = id;

    if(typeSelected == newScan.tipo){
      scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadingScans() async {
    final allScans = await DBProvider.db.getAllScans();
    scans = [...allScans!];
    notifyListeners();
  }

  loadingScansType(String tipo) async {
    final allScans = await DBProvider.db.getTypeScans(tipo);
    scans = [...allScans!];
    typeSelected = tipo;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}