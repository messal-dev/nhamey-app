import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../widgets/food_item.dart';
import '../../widgets/food_item_tile.dart';

import '../../models/food_model.dart';
import '../../helpers/var_helper.dart';
import '../../providers/food_provider.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  Future<void> _onClickRandom() async {
    // ignore: use_build_context_synchronously
    final provider = Provider.of<FoodProvider>(context, listen: false);
    provider.filter(
      provider.query,
      queryTags: provider.queryTags,
      isRandom: true,
    );

    await showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });

        return const CupertinoAlertDialog(
          title: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('លទ្ធផល'),
        actions: [
          IconButton(
            onPressed: _onClickRandom,
            icon: const Icon(
              CupertinoIcons.square_line_vertical_square_fill,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: context.read<FoodProvider>().filter(
              context.read<FoodProvider>().query,
              queryTags: context.read<FoodProvider>().queryTags,
            ),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          return Consumer<FoodProvider>(
            builder: (ctx, provider, _) {
              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: provider.searchFoods.map((food) {
                  if (provider.searchFoods.indexOf(food) > 0) {
                    return foodItemTileBuilder(food);
                  } else {
                    return foodItemBuilder(food);
                  }
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Container foodItemBuilder(FoodModel food) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: FoodItem(food),
    );
  }

  Container foodItemTileBuilder(FoodModel food) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: FoodItemTile(food),
    );
  }
}
