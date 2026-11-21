import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

/// Where to take a photo from.
enum ImagePickSource { camera, gallery }

/// Takes a photo with the camera or picks one from the gallery (wraps
/// `image_picker`, so cubits can be tested with a fake). The plugin asks for
/// the camera / photo permission itself, using the usage strings in
/// `Info.plist` on iOS.
@lazySingleton
class ImagePickerService {
  ImagePickerService() : _picker = ImagePicker();

  final ImagePicker _picker;

  /// Max edge of the saved image; enough for an avatar and keeps the
  /// upload small.
  static const double _maxDimension = 1024;

  /// Returns the picked file's path, or null when the courier cancels.
  Future<String?> pick(ImagePickSource source) async {
    final file = await _picker.pickImage(
      source: switch (source) {
        ImagePickSource.camera => ImageSource.camera,
        ImagePickSource.gallery => ImageSource.gallery,
      },
      maxWidth: _maxDimension,
      maxHeight: _maxDimension,
      imageQuality: 85,
      preferredCameraDevice: CameraDevice.front,
    );
    return file?.path;
  }
}
