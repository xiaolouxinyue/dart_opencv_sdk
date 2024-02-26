import 'package:dart_opencv_sdk/src/morphological/morphological.dart';
import 'package:image/image.dart';

import '../core/functions.dart';

class Dilating implements MorpHological {
  final int iterations;
  final Color? color;

  final CoreFunctions coreFunctions;

  Dilating({this.iterations = 1, this.color}) : coreFunctions = CoreFunctions();
  @override
  Image applyFilter(Image image) {
    final dilatedImage = Image.from(image);

    for (var iteration = 0; iteration < iterations; iteration++) {
      for (var y = 1; y < image.height - 1; y++) {
        for (var x = 1; x < image.width - 1; x++) {
          final pixel = image.getPixel(x, y);

          final neighbor1 = image.getPixel(x - 1, y);
          final neighbor2 = image.getPixel(x + 1, y);
          final neighbor3 = image.getPixel(x, y - 1);
          final neighbor4 = image.getPixel(x, y + 1);

          final target = color ?? ColorFloat64.rgb(255, 255, 255);
          if (pixel.r == target.r ||
              neighbor1.r == target.r ||
              neighbor2.r == target.r ||
              neighbor3.r == target.r ||
              neighbor4.r == target.r) {
            dilatedImage.setPixel(x, y, target);
          }
        }
      }

      image = Image.from(dilatedImage);
    }

    return dilatedImage;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}