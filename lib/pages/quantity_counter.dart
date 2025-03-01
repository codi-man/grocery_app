import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged; // Callback for quantity change

  const QuantityCounter({
    super.key,
    this.initialQuantity = 1,
    required this.onQuantityChanged, // Required callback
  });

  @override
  _QuantityCounterState createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
    widget.onQuantityChanged(_quantity); // Call the callback with the new quantity
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
      widget.onQuantityChanged(_quantity); // Call the callback with the new quantity
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrement,
          padding: EdgeInsets.zero,
        ),
        Container(
          width: 50,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '$_quantity',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _increment,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}