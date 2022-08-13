import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_qr/providers/scans_list_provider.dart';
import 'package:reader_qr/providers/ui_provider.dart';
import 'package:reader_qr/views/gps.dart';
import 'package:reader_qr/views/home.dart';
import 'package:reader_qr/views/map.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
		const MyApp({Key? key}) : super(key: key);

		@override
		Widget build(BuildContext context) {
			return MultiProvider(
				providers: [
					ChangeNotifierProvider(create: (BuildContext context) => UiProvider()),
					ChangeNotifierProvider(create: (BuildContext context) => ScanListProvider()),
				],

			child: MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'QR Reader',
			initialRoute: 'home_view',
			routes: {
				'home_view' : ( BuildContext context ) => const HomeView(),
				'map_view' : ( BuildContext context ) => const MapView(),
				'gps_view' : ( BuildContext context ) => const GpsView(),
			},
			theme: ThemeData(
				colorScheme: ColorScheme.fromSwatch().copyWith(
					brightness: Brightness.light,
					primary: Colors.lightBlue[800],
					secondary: Colors.purple[600]
				),
				fontFamily: 'Georgia',
				textTheme: const TextTheme(
					headline1: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
					headline6: TextStyle(fontSize: 30.0, fontFamily: 'Ubuntu', fontStyle: FontStyle.italic),
					bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Ubuntu'),
				),
			),
		),
		);
		}
}