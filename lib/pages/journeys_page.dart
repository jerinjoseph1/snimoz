import 'package:flutter/material.dart';

class JourneysPage extends StatefulWidget {
  @override
  _JourneysPageState createState() => _JourneysPageState();
}

class _JourneysPageState extends State<JourneysPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.indigo[900],
              Colors.indigo[800],
              Colors.indigo[400]
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FancyFab()
    );
  }
}
