import 'package:flutter/material.dart';
import 'package:mentoons/view/comic_reading/comic_pdf_view.dart';
import 'package:mentoons/widgets/app_text.dart';

class ComicReading extends StatelessWidget {
    ComicReading({super.key});

  final List<String> comics = [
    "assets/do_you_know_comic.jpg",
    "assets/electronic_gadget_comic.jpg",
    "assets/how_to_handle_comic.jpg",
  ];

  final List<String> comicPdfs = [
    "assets/comicPdf/do_you_know_pdf.pdf",
    "assets/comicPdf/electronic_pdf.pdf",
    "assets/comicPdf/how_to_handle.pdf",
  ];



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: AppBar(
        title: const AppText(text: "Comic Reading"),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: comics.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return InkWell(onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ComicPdfViewer(
                      pdfPath: comicPdfs[index],
                    ),
                  ),);
            },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    comics[index],
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
