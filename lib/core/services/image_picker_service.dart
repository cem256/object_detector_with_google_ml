import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<XFile?> selectFromGallery();
  Future<XFile?> takePhoto();
}

class ImagePickerServiceImp implements ImagePickerService {
  final ImagePicker imagePicker;

  ImagePickerServiceImp({required this.imagePicker});

  @override
  Future<XFile?> selectFromGallery() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image;
    }
    return null;
  }

  @override
  Future<XFile?> takePhoto() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return image;
    }
    return null;
  }
}
