import 'package:flutter/material.dart';
import 'package:social_media_app/models/comment.dart';
import 'package:social_media_app/service/placeholder_service.dart';

class Comments extends StatefulWidget {
  final int postId;

  const Comments({Key key, this.postId}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState(postId);
}

class _CommentsState extends State<Comments> {
  final int postId;
  final _service = PlaceholderService();

  _CommentsState(this.postId);

  Widget _buildCommentsBody(List<Comment> comments) {
    return ListView.builder(
      itemCount: comments.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Center(
                child: Text(
                  comments[index].name,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              subtitle: Center(child: Text(comments[index].email)),
            ),
            Text(
              comments[index].body,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Comments'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _service.getComments(postId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildCommentsBody(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Unable to recive Comments',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
