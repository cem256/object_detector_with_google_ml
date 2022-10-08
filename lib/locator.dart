import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'core/services/image_picker_service.dart';
import 'core/services/object_detector_service.dart';
import 'core/theme/app_theme.dart';
import 'features/detect_object/logic/detect_object_bloc.dart';

// Global service locator
final getIt = GetIt.instance;

void initServices() {
  //blocs
  getIt.registerFactory(
    () => DetectObjectBloc(
      imagePickerService: getIt(),
      objectDetectorService: getIt(),
    ),
  );

  //services
  getIt.registerLazySingleton<ImagePickerService>(
    () => ImagePickerServiceImp(
      imagePicker: getIt(),
    ),
  );

  getIt.registerLazySingleton<ObjectDetectorService>(
    () => ObjectDetectorServiceImpl(),
  );

  //service dependencies
  getIt.registerLazySingleton(
    () => ImagePicker(),
  );

  //theme
  getIt.registerSingleton(
    AppTheme(),
  );
}
