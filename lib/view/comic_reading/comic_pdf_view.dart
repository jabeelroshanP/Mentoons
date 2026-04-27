import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ComicPdfViewer extends StatelessWidget {
  final String pdfPath;

  const ComicPdfViewer({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comic")),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}
