class Picture {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Picture.fromJson(Map<String, dynamic> json)
      : albumId = json['albumId'],
        id = json['id'],
        title = json['title'],
        url = json['url'],
        thumbnailUrl = json['thumbnailUrl'];
}
