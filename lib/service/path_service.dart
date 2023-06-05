// ignore_for_file: constant_identifier_names

class PathService {
  static const String IMAGE_BASE_PATH = "assets/images/";
  static String imagePathProvider(String name) => IMAGE_BASE_PATH + name;
}
