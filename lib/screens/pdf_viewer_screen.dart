import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfAssetPath;
  final String title;

  const PDFViewerScreen({super.key, required this.pdfAssetPath, required this.title});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPdfFromAssets();
  }

  Future<void> _loadPdfFromAssets() async {
    final byteData = await rootBundle.load(widget.pdfAssetPath);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/${widget.pdfAssetPath.split('/').last}');
    await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

    setState(() {
      localPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: localPath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: localPath!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
            ),
    );
  }
}
