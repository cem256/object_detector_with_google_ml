import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

abstract class ObjectDetectorService {
  Future<List<ImageLabel>> processImage({required InputImage inputImage});
}

class ObjectDetectorServiceImpl implements ObjectDetectorService {
  final ImageLabeler imageLabeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.75));

  @override
  Future<List<ImageLabel>> processImage({required InputImage inputImage}) async {
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    return labels;
  }
}
