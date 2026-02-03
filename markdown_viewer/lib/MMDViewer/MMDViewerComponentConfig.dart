import "all.dart";
import 'languages/JapanLanguageMap.dart';
import 'package:flutter/foundation.dart';
import 'package:winter/winter.dart';

class MMDViewerComponentConfig implements Configurer {
  //please write sub component configurations here
  Future<void> _preConfig() async {}

  Future<void> config({String? instanceName}) async {
    await _preConfig();

    //Lazy Singleton injection
    //getIt.registerLazySingleton(instanceName:instanceName,()=>HomeController(
    //  //Home(),
    // WinterLanguageFactory(
    //  getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
    //  {"jp":JapanLanguageMap()},
    //  ),
    //  HomeModel()
    // ));
    //
    //Factory injection with parameter
    getIt.registerFactoryParam<MMDViewerController, MMDViewerModel, Null>(
      instanceName: instanceName,
      (p1, p2) => MMDViewerController(
        //Home(),
        WinterLanguageFactory(
          getIt<ValueNotifier<String>>(instanceName: "currentLanguage"),
          {"jp": JapanLanguageMap()},
        ),
        p1,
      ),
    );

    await _postConfig();
  }

  //please write the tasks you want to do after config here
  Future<void> _postConfig() async {
    debugPrint("\t~>\tHomeComponent injected;");
  }
}
