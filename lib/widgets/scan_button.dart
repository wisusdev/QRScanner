import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:reader_qr/providers/scans_list_provider.dart';
import 'package:reader_qr/utils/url_launcher.dart';

class ScanButton extends StatelessWidget {
		const ScanButton({Key? key}) : super(key: key);

		@override
		Widget build(BuildContext context) {
			return FloatingActionButton(
			child: const Icon(Icons.qr_code_scanner),
			onPressed: () async {
				String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3d8bef', 'Cancelar', false, ScanMode.QR);
        if(barcodeScanRes == '-1'){
        	return;
				}
				final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
				final newScan = await scanListProvider.newScan(barcodeScanRes);

				launcherURL(context, newScan);
			}
		);
		}
}