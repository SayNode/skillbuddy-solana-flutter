/// the Block and chapters the user has in progress
class StatisticProgress {
  StatisticProgress();

  StatisticProgress.fromJson(Map<String, dynamic> json)
      : blockName = json['block_name'] ?? '',
        blockId = json['block_id'] ?? '',
        categoryName = json['category_name'] ?? '',
        categoryId = json['category_id'] ?? '',
        chapterName = json['chapter_name'] ?? '',
        chapterId = json['chapter_id'] ?? '',
        isNotStarted = json['isNotStarted'] ?? true,
        nextClass = json['next_class'] ?? '';
  int id = -1;
  String blockName = '';
  int blockId = -1;
  String categoryName = '';
  int categoryId = -1;
  String chapterName = '';
  int chapterId = -1;
  bool isNotStarted = true;
  String nextClass = '';

  Map<String, dynamic> toJson() => <String, dynamic>{
        'block_name': blockName,
        'block_id': blockId,
        'category_name': categoryName,
        'category_id': categoryId,
        'chapter_name': chapterName,
        'chapter_id': chapterId,
        'isNotStarted': isNotStarted,
        'next_class': nextClass,
      };
}
