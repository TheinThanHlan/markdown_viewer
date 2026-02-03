import 'package:flutter/material.dart';
import 'package:markdown_viewer/MMDViewer/all.dart';
import 'ApplicationConfig.dart';
import 'package:winter/winter.dart';

void main(List<String> args) {
  if (args.isNotEmpty) {
    ApplicationConfig().config().then((a) {
      runApp(
        MaterialApp(
          home: ValueListenableBuilder(
            valueListenable: getIt<ValueNotifier<String>>(
              instanceName: "currentLanguage",
            ),
            builder: (context, _, _) {
              return getIt<MMDViewerController>(
                param1: MMDViewerModel(args[0]),
              ).getView();
            },
          ),
        ),
      );
    });
  } else {
    print("please define the file path.");
  }
}
