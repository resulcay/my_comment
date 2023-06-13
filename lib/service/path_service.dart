// ignore_for_file: constant_identifier_names

// Uygulamada resim,video vs. kullanırken hata payını en aza indirmek için oluşturduğumuz temel bir dosya yoludur.
class PathService {
  static const String IMAGE_BASE_PATH = "assets/images/";
  static String imagePathProvider(String name) => IMAGE_BASE_PATH + name;
}
