import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenPDF extends StatelessWidget {
  String pdfLink;

  var _isLoading;
  OpenPDF(String link) {
    this.pdfLink = link;
    _isLoading = true.obs;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: Center(
        child: SfPdfViewer.network(
          pdfLink,
          key: _pdfViewerKey,
        ),
      ),
    ));
  }
}
