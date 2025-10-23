import 'package:flutter/material.dart';

// how to push file

// cd = C:\UNIVERSITY_WORK\LV_5\programming_applications_programming_languages\fuck
// git init
// git add "file name"
// git commit -m "Set Up the Project"
// git push

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

enum sandwitches{
  footlong("footlong"),mean("mean"),sixinch("six inch"),subway("subway");

  const sandwitches(this.label);
  final String label;
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  String sandwitch = "footlong";
  sandwitches sw = sandwitches.footlong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemDisplay(
              _quantity,
              sandwitch,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ret_col(Colors.purple,true),
                  ),
                  onPressed: _increaseQuantity,
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ret_col(Colors.green,false),
                  ),
                  onPressed: _decreaseQuantity,
                  child: const Text('Remove'),
                ),
              ],
            ),
            
            SegmentedButton<sandwitches>(
              segments: const <ButtonSegment<sandwitches>>[
                ButtonSegment<sandwitches>(
                  value: sandwitches.footlong,
                  label: Text('footlong'),
                  icon: Icon(Icons.safety_check)),
                ButtonSegment<sandwitches>(
                  value: sandwitches.sixinch,
                  label: Text('six inch'),
                  icon: Icon(Icons.eight_k)),
                ButtonSegment<sandwitches>(
                  value: sandwitches.mean,
                  label: Text('mean'),
                  icon: Icon(Icons.beach_access_sharp)),
                ButtonSegment<sandwitches>(
                  value: sandwitches.subway,
                  label: Text('subway'),
                  icon: Icon(Icons.ramen_dining)),
                ],
              selected: <sandwitches>{sw},
            
              onSelectionChanged: (Set<sandwitches> newSelection){
                setState(() {
                  sw = newSelection.first;
                  sandwitch = sw.label;
                });
              }
            
            )

          ],
        ),
      ),
    );
  }

  MaterialColor ret_col(MaterialColor col, bool great){
    if(!great){if(_quantity <= 0){col = Colors.grey;}}
    if(great){if(_quantity >= widget.maxQuantity){col = Colors.grey;}}
    return col;
  }

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
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