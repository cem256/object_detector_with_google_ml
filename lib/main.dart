import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/strings.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/observers/app_bloc_observer.dart';
import 'features/detect_object/presentation/view/detect_object_view.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  Bloc.observer = AppBlocObserver();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const ObjectDetector());
}

class ObjectDetector extends StatelessWidget {
  const ObjectDetector({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: getIt<AppTheme>().appTheme,
      debugShowCheckedModeBanner: false,
      home: const DetectObjectView(),
    );
  }
}
