import 'package:flutter/material.dart';

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 10.0),
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: AssetImage('assets/story1.jpg'), fit: BoxFit.cover)),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/story2.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/story3.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/story4.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/story5.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/story6.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/story8.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          const SizedBox(width: 15.0),
        ],
      ),
    );
  }
}
