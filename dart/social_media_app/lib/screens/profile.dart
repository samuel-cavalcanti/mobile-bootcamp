import 'package:flutter/material.dart';
import 'package:social_media_app/components/socialDrawer.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/service/placeholder_service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final service = PlaceholderService();

  Widget _buildProfile(User user) {
    return Column(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    user.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text('User name: ${user.username}',
                    style: TextStyle(fontSize: 20)),
                Text('Email: ${user.email}', style: TextStyle(fontSize: 20)),
                Text('Phone: ${user.phone}', style: TextStyle(fontSize: 20)),
                Text('site: ${user.website}', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Address',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Text('Street: ${user.address.street}',
                    style: TextStyle(fontSize: 20)),
                Text('Suite: ${user.address.suite}',
                    style: TextStyle(fontSize: 20)),
                Text('City: ${user.address.city}',
                    style: TextStyle(fontSize: 20)),
                Text('ZIP code: ${user.address.zipCode}',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Profile'),
        centerTitle: true,
      ),
      drawer: SocialDrawer(),
      body: FutureBuilder(
        future: service.profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildProfile(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              'Unable to load Profile',
              style: TextStyle(fontSize: 30),
            ));
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
