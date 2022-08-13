import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_qr/providers/scans_list_provider.dart';
import 'package:reader_qr/providers/ui_provider.dart';
import 'package:reader_qr/views/address.dart';
import 'package:reader_qr/views/gps.dart';
import 'package:reader_qr/views/map.dart';
import 'package:reader_qr/widgets/scan_button.dart';
import 'package:reader_qr/widgets/navigator_bar.dart';

class HomeView extends StatelessWidget {
  	const HomeView({Key? key}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				elevation: 0,
				title: const Text('Historial'),
				actions: [
					IconButton(
						onPressed: (){
							Provider.of<ScanListProvider>(context, listen: false).deleteAllScans();
						},
						icon: const Icon(Icons.delete_forever)
					)
				],
			),
			body: const _HomePageBody(),
			bottomNavigationBar: const NavigatorBar(),
			floatingActionButton: const ScanButton(),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
		);
  	}
}

class _HomePageBody extends StatelessWidget {
  	const _HomePageBody({ Key? key }) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
		// Obtener el selected menu
		final uiProvider = Provider.of<UiProvider>(context);

		// Pagina actual
		final curentIndex = uiProvider.selectedMenuOpt;

		// Use ScanListProvider
		final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

		switch(curentIndex) {
			case 0:
				scanListProvider.loadingScansType('geo');
				return const MapView();
			case 1:
				scanListProvider.loadingScansType('http');
				return const AddressView();
			default:
				return const GpsView();
		}
  	}
}