import 'package:flutter/material.dart';
import 'package:reader_qr/models/scan.dart';
import 'package:url_launcher/url_launcher_string.dart';

launcherURL(BuildContext context, ScanModel scan) async {
    final url = scan.valor;
    
    if(scan.tipo == 'http'){
        // Open web site
        if(await canLaunchUrlString(url)){
            await launchUrlString(url);
        } else {
            throw 'No se puedo abrir $url';
        }

    } else {
        Navigator.pushNamed(context, 'gps_view', arguments: scan);
    }
}