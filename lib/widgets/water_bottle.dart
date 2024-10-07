import 'package:flutter/material.dart';

class WaterBottle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.8),
                Colors.blue.withOpacity(0.5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 120,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.bluetooth, color: Colors.white),
              Text('Bluetooth Receiver', style: TextStyle(color: Colors.white)),
              Icon(Icons.power, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}