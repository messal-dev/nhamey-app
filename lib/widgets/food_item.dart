import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../models/food_model.dart';
import '../../helpers/var_helper.dart';
import '../../screens/detail_screen.dart';

class FoodItem extends StatelessWidget {
  final FoodModel food;

  const FoodItem(this.food, {super.key});

  void _onClickDetail(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (context) => DetailScreen(food.code)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => _onClickDetail(context),
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(2, 2),
              color: shadowColor,
            ),
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 0),
              color: shadowColor,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                food.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
                height: size.height * 0.2,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              food.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Text(
                  "# ${food.code}",
                  style: const TextStyle(color: grayColor, fontSize: 14),
                ),
                const Spacer(),
                const Icon(CupertinoIcons.time, size: 16, color: primaryColor),
                const SizedBox(width: 8.0),
                Text(
                  food.duration,
                  style: const TextStyle(color: grayColor, fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
