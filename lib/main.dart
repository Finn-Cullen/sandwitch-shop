import 'package:flutter/material.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Sandwich Counter')),
        body:ListView(
          children:const <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly , 
              children: [
                Squor(Colors.purple, 200, 200),
                Squor(Colors.orange, 200, 200),
                Squor(Colors.green, 200, 200)
              ],
            )
          ],
      ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType,{super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$quantity $itemType sandwich(es): ${'🥪' * quantity}');
  }
}

class Squor extends StatelessWidget {
  final MaterialColor color;
  final double height;
  final double width;

  const Squor(this.color, this.height, this.width,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        color: color,
        width: width,
        height: height,
        alignment: Alignment.center, // aligns text
        child: const OrderItemDisplay(2, "mean"),
      );
  }
}