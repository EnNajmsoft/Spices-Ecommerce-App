import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.title,
    required this.value,
    this.titleColor = const Color.fromARGB(255, 255, 37, 37),
    this.valueColor = Colors.black,
    this.titleFontWeight = FontWeight.normal,
    this.valueFontWeight = FontWeight.bold,
  });

  final String title;
  final String value;
  final Color titleColor;
  final Color valueColor;
  final FontWeight titleFontWeight;
  final FontWeight valueFontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: titleColor,
                  fontWeight: titleFontWeight,
                ),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: valueColor,
                  fontWeight: valueFontWeight,
                ),
          ),
        ],
      ),
    );
  }
}
