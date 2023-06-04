import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/food_model.dart';
import '../helpers/var_helper.dart';

import '../screens/detail_screen.dart';

class FoodItemTile extends StatefulWidget {
  final FoodModel food;

  const FoodItemTile(this.food, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FoodItemTileState createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DetailScreen(widget.food.code)),
      ),
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                widget.food.thumbnail,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                width: 72,
                height: 72,
                margin: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '#${widget.food.code}',
                          style:
                              const TextStyle(color: grayColor, fontSize: 14),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.time,
                          size: 16,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          widget.food.duration,
                          style:
                              const TextStyle(color: grayColor, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
