import 'package:flutter/material.dart';
import '../components/appbar_actions.dart'; // pastikan path benar
import 'pdf_viewer_screen.dart';

class MateriScreen extends StatelessWidget {
  final List<Map<String, String>> daftarMateri = List.generate(
    14,
    (index) => {
      'judul': 'Pertemuan ${index + 1}: Materi pertemuan ke-${index + 1}',
      'file': 'assets/pdfs/materi${index + 1}.pdf',
    },
  );

  MateriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Materi'),
        actions: const [AppBarActions()],
      ),
      body: ListView.builder(
        itemCount: daftarMateri.length,
        itemBuilder: (context, index) {
          final materi = daftarMateri[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(materi['judul']!),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PDFViewerScreen(
                    title: materi['judul']!,
                    pdfAssetPath: materi['file']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
