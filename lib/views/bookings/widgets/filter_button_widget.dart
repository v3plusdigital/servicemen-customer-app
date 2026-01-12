import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
   const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: buildButton("By Category")),
          const SizedBox(width: 12),
          Expanded(child: buildButton("By Date")),
        ],
      ),
    );


  }

  Widget buildButton(String title){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), const Icon(Icons.keyboard_arrow_down)],
      ),
    );
  }
}