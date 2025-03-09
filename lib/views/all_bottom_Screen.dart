import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color(0xffF66743),
      ),
      body: Center(
        child: Text(
          "Welcome to Home Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xffF66743),
      ),
      body: Center(
        child: Text(
          "Welcome to Profile Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Favorites"),
        backgroundColor: Color(0xffF66743),
      ),
      body: Center(
        child: Text(
          "Your Favorite Items",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
