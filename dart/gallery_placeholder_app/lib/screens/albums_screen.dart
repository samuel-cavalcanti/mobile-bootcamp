import 'package:flutter/material.dart';
import 'package:gallery_placeholder_app/models/album.dart';
import 'package:gallery_placeholder_app/screens/pictures_screen.dart';
import 'package:gallery_placeholder_app/services/json_placeholder_service.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  final service = JsonPlaceholderService();

  Widget _albumsList(List<Album> albums) {
    return ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          albums[index].title,
          style: TextStyle(fontSize: 25),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PicturesScreen(
                        albumId: albums[index].id,
                      )));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: FutureBuilder(
        future: service.albums,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _albumsList(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: TextStyle(fontSize: 30),
            ));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
