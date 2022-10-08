part of 'detect_object_bloc.dart';

@freezed
class DetectObjectEvent with _$DetectObjectEvent {
  const factory DetectObjectEvent.selectFromGalleryPressed() = SelectFromGalleryPressed;
  const factory DetectObjectEvent.takePhotoPressed() = TakePhotoPressed;
}
