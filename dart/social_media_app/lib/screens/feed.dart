import 'package:flutter/material.dart';
import 'package:social_media_app/components/socialDrawer.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/screens/comments.dart';
import 'package:social_media_app/service/placeholder_service.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final _placeholderService = PlaceholderService();

//  List<Post> _posts = List<Post>();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildItem(BuildContext context, int index, List<Post> posts) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Comments(postId: posts[index].id)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    posts[index].title,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Text(
                posts[index].body,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Feed'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Post>>(
        future: _placeholderService.posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) =>
                  _buildItem(context, index, snapshot.data),
              itemCount: snapshot.data.length,
            );
          } else if (snapshot.hasError) {
            return Text('Error');
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      drawer: SocialDrawer(),
      backgroundColor: Colors.white70,
    );
  }
}
