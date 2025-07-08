class PreloadModuleImages {
  PreloadModuleImages();

  PreloadModuleImages.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? -1,
        sequence = json['sequence'] ?? -1,
        illustrationImage = json['illustration_image'] ?? '',
        imageUrl = json['image_url'] ?? '';
  int id = -1;
  int sequence = -1;
  String illustrationImage = '';
  String imageUrl = '';
}
