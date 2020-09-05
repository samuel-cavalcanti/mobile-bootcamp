import 'package:flutter/material.dart';
import 'package:social_media_app/screens/feed.dart';
import 'package:social_media_app/screens/profile.dart';

class SocialDrawer extends StatelessWidget {
  const SocialDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Icon(
              Icons.person,
              size: 150,
            ),
          ),
          ListTile(
            title: Text('Feed', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Feed()));
            },
          ),
          ListTile(
            title: Text('Profile', style: TextStyle(fontSize: 20)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          )
        ],
      ),
    );
  }
}
