import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reader_qr/models/scan.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GpsView extends StatefulWidget {
	const GpsView({Key? key}) : super(key: key);

  	@override
  	State<GpsView> createState() => _GpsViewState();
}

class _GpsViewState extends State<GpsView> {

	final Completer<GoogleMapController> _controller = Completer();
	MapType mapType = MapType.normal;

	@override
	Widget build(BuildContext context) {
		final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

		final CameraPosition initPoint = CameraPosition(
			target: scan.getLatLbg(),
			zoom: 14.4746,
		);

		// Markers
		Set<Marker> markers = <Marker>{};
		markers.add(Marker(
				markerId: const MarkerId('geo-location'),
				position: scan.getLatLbg()
		));

		return Scaffold(
			appBar: AppBar(
				title: const Text('GPS'),
				actions: [
					IconButton(
						onPressed: () async {
							final GoogleMapController controller = await _controller.future;
							controller.animateCamera(
								CameraUpdate.newCameraPosition(
									CameraPosition( target: scan.getLatLbg(), zoom: 14.4746, )
								)
							);
						},
						icon: const Icon(Icons.location_on)
					)
				],
			),
			body: GoogleMap(
				myLocationButtonEnabled: true,
				mapType: mapType,
				markers: markers,
        zoomControlsEnabled: false,
				initialCameraPosition: initPoint,
				onMapCreated: (GoogleMapController controller) {
					_controller.complete(controller);
				},
			),
			floatingActionButton: FloatingActionButton(
				child: const Icon(Icons.layers),
				onPressed: (){
					setState(() {
					  	if(mapType == MapType.normal){
							mapType = MapType.satellite;
						} else {
							mapType = MapType.normal;
						}
					});
				},
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
		);
	}
}