import 'package:flutter/material.dart';
import 'package:reader_qr/widgets/scans_list.dart';

class AddressView extends StatelessWidget {
		const AddressView({Key? key}) : super(key: key);

		@override
		Widget build(BuildContext context) {
			return const ScansList(type: 'http');
		}
}