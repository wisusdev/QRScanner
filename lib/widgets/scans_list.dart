import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_qr/providers/scans_list_provider.dart';
import 'package:reader_qr/utils/url_launcher.dart';

class ScansList extends StatelessWidget {
  final String type;

  const ScansList({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final scanListProvider = Provider.of<ScanListProvider>(context);
			final scans = scanListProvider.scans;

			return ListView.builder(
				itemCount: scans.length,
				itemBuilder: (BuildContext context, item) => Dismissible(
						key: UniqueKey(),
						background: Container(
							color: Colors.red,
						),
						onDismissed: (DismissDirection direction){
							Provider.of<ScanListProvider>(context, listen: false).deleteScanById(scans[item].id!);
						},
						child: ListTile(
							leading: Icon(type == 'http' ? Icons.link_rounded : Icons.map_outlined, color: Theme.of(context).primaryColor,),
							title: Text(scans[item].valor),
							subtitle: Text(scans[item].id.toString()),
							trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.green,),
							onTap: () => launcherURL(context, scans[item]),
					),
				),
      );
  }
}
