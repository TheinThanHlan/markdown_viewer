import 'MMDViewer.dart';
import 'package:winter/winter.dart';
import "dart:io";
import "package:path/path.dart";
import 'all.dart';

class MMDViewerController implements WinterController {
  final MMDViewerModel _model;
  late final MMDViewer _view;
  final WinterLanguageFactory _lf;
  //final module = getIt<GetIt>(instanceName:);
  MMDViewerController(this._lf, this._model) {
    //this._view.c=this;
    _view = MMDViewer(_lf, _model, readFile);
  }
  void reset() {}
  WinterView getView() {
    return this._view;
  }

  Future<String> readFile() async {
    var fileName = basename(_model.file_path);
    bool result = convertMMDToHtml();
    if (result == true) {
      var compiledHtmlFile = File("/tmp/$fileName.html");
      return compiledHtmlFile.readAsString();
    } else {
      return "<h1>File Not Found</h1>";
    }
  }

  bool convertMMDToHtml() {
    if (!File(_model.file_path).existsSync()) {
      return false;
    }
    var fileName = basename(_model.file_path);
    var result = Process.runSync("pandoc", [
      "-f",
      "markdown_mmd",
      "-t",
      "html",
      _model.file_path,
      "-F",
      "mermaid-filter",
      "-o",
      "/tmp/$fileName.html",
    ]);
    if (result.exitCode == 0) {
      return true;
    }
    return false;
  }
}
