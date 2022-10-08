part of 'detect_object_bloc.dart';

@freezed
class DetectObjectState with _$DetectObjectState {
  const factory DetectObjectState.initial() = _Initial;
  const factory DetectObjectState.detectionUnsuccessful() = _DetectionUnsuccessful;
  const factory DetectObjectState.detectionSuccessful({
    @Default([]) List predictions,
    XFile? image,
  }) = _DetectionSuccessful;
}
