import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_qr/providers/ui_provider.dart';

class NavigatorBar extends StatelessWidget {
  	const NavigatorBar({Key? key}) : super(key: key);

  	@override
  	Widget build(BuildContext context) {
		// Obtener el selected menu
		final uiProvider = Provider.of<UiProvider>(context);

		final currentIndex = uiProvider.selectedMenuOpt;

		return BottomNavigationBar(
			onTap: (int i) => uiProvider.selectedMenuOpt = i,
			currentIndex: currentIndex,
			elevation: 0,
			unselectedItemColor: Colors.black45,
			selectedItemColor: Colors.white,
			backgroundColor: Colors.lightBlue[800],
			items: const [
				BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Map'),
				BottomNavigationBarItem(icon: Icon(Icons.insert_link), label: 'Links')
			],
		);
  	}
}