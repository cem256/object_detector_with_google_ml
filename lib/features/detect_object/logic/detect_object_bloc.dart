import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/services/image_picker_service.dart';
import '../../../core/services/object_detector_service.dart';

part 'detect_object_bloc.freezed.dart';
part 'detect_object_event.dart';
part 'detect_object_state.dart';

class DetectObjectBloc extends Bloc<DetectObjectEvent, DetectObjectState> {
  final ImagePickerService imagePickerService;
  final ObjectDetectorService objectDetectorService;
  DetectObjectBloc({
    required this.imagePickerService,
    required this.objectDetectorService,
  }) : super(const DetectObjectState.initial()) {
    on<SelectFromGalleryPressed>(_onSelectFromGalleryPressed);
    on<TakePhotoPressed>(_onTakePhotoPressed);
  }
  Future<void> _onSelectFromGalleryPressed(SelectFromGalleryPressed event, Emitter<DetectObjectState> emit) async {
    final image = await imagePickerService.selectFromGallery();
    if (image != null) {
      List<ImageLabel> predictions = await objectDetectorService.processImage(
        inputImage: InputImage.fromFilePath(image.path),
      );
      if (predictions.isEmpty) {
        emit(const DetectObjectState.detectionUnsuccessful());
      } else {
        emit(DetectObjectState.detectionSuccessful(predictions: predictions, image: image));
      }
    }
  }

  Future<void> _onTakePhotoPressed(TakePhotoPressed event, Emitter<DetectObjectState> emit) async {
    final image = await imagePickerService.takePhoto();
    if (image != null) {
      List<ImageLabel> predictions =
          await objectDetectorService.processImage(inputImage: InputImage.fromFilePath(image.path));
      if (predictions.isEmpty) {
        emit(const DetectObjectState.detectionUnsuccessful());
      } else {
        emit(DetectObjectState.detectionSuccessful(predictions: predictions, image: image));
      }
    }
  }
}
