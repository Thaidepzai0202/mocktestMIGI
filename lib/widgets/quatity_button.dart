import 'package:flutter/material.dart';

class QuatityButton extends StatefulWidget {
  const QuatityButton(
      {super.key, required this.quatity, required this.onPressed});
  final int quatity;
  final void Function(int) onPressed;
  @override
  State<QuatityButton> createState() => _QuatityButtonState();
}

class _QuatityButtonState extends State<QuatityButton> {
  int value = 1;
  @override
  void initState() {
    value = widget.quatity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$value'),
        ElevatedButton(
            onPressed: () {
              setState(() {
                value++;
                widget.onPressed(value);
              });
            },
            child: const Text("add")),
      ],
    );
  }
}
