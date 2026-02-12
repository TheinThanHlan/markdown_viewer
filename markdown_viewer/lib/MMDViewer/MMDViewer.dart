import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import './all.dart';
import 'package:winter/winter.dart';

class MMDViewer extends StatelessWidget implements WinterView {
  //late final HomeController c;
  final WinterLanguageFactory _lf;
  final MMDViewerModel _model;

  final Future<String> Function() readFile;
  MMDViewer(this._lf, this._model, this.readFile);

  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return Scaffold(
      body: Column(
        crossAxisAlignment: .stretch,
        mainAxisSize: .max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: readFile(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return SelectionArea(
                      child: Html(
                        data: snapshot.data,
                        style: {
                          //"*": Style(
                          //  //backgroundColor: Colors.red,
                          //  margin: Margins.zero,
                          //  padding: HtmlPaddings.zero,
                          //),
                          //// "img": Style(width: Width(1000, Unit.px)),
                        },
                      ),
                    );
                  }
                  return Html(data: "<h1>Loading...</h1>");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
