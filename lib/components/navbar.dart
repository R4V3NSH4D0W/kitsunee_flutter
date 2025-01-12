import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Image(
              image: AssetImage('assets/logo.png'),
              width: 50,
              height: 50,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Kitsunee",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
          child: Icon(
            Icons.search,
            size: 26,
          ),
        )
      ],
    );
  }
}
