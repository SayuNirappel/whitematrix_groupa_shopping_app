import 'package:flutter/material.dart';

class ParameterTest extends StatelessWidget {
  final List dbList;
  final int passedIndex;
  const ParameterTest(
      {required this.dbList, required this.passedIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 220,
              width: 160,
              child: Image(image: NetworkImage(dbList[passedIndex]["image"])),
            ),
            Text(passedIndex.toString())
          ],
        ),
      ),
    );
  }
}
