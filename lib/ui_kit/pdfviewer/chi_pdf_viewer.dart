part of '../local_pub.dart';

class CHIPdfViewer extends StatelessWidget {
  const CHIPdfViewer({
    this.pdfUrl,
    this.localPdfPath,
    required this.pdfType,
    this.pdfViewerKey,
    super.key,
  });
  final GlobalKey? pdfViewerKey;
  final String? pdfUrl;
  final String? localPdfPath;
  final PDFType? pdfType;

  @override
  Widget build(BuildContext context) {
    File? pdfFile;
    if (pdfType == PDFType.local) {
      pdfFile = File(localPdfPath!);
    }
    return pdfType == PDFType.local
        ? SfPdfViewer.file(pdfFile!)
        : pdfType == PDFType.assets
            ? SfPdfViewer.asset(localPdfPath!)
            : SfPdfViewer.network(
                pdfUrl!,
                key: pdfViewerKey,
              );
  }
}

enum PDFType { local, network, assets }
