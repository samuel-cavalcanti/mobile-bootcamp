class Comment {
  int postId;
  int id;

  String name;
  String email;
  String body;

  Comment.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        id = json['id'],
        name = json['name'],
        email = json['email'],
        body = json['body'];
}
