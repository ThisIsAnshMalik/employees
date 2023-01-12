import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAvatar extends StatelessWidget {
  Color color;
  String url;
  CustomAvatar({Key? key, required this.color, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.deepPurple),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 10))
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(url)))),
      Positioned(
          bottom: -6,
          right: -0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.045,
            width: MediaQuery.of(context).size.width * 0.045,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.deepPurple),
              color: color,
              shape: BoxShape.circle,
            ),
          ))
    ]);
  }
}
