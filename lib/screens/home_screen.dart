import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/food_model.dart';
import '../../helpers/var_helper.dart';
import '../../providers/food_provider.dart';

import './result_screen.dart';
import '../../widgets/tag_item.dart';
import '../../widgets/food_item.dart';
import '../../widgets/appbar_item.dart';
import '../../widgets/search_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _onClickTag(String tag) async {
    final provider = Provider.of<FoodProvider>(context, listen: false);

    provider.setQuery(tag);

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SearchResultScreen()),
    );

    await Future.delayed(const Duration(seconds: 2));
    provider.resetQuerySearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const AppBarItem(),
      ),
      body: FutureBuilder(
        future: context.read<FoodProvider>().fetch(),
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
              return CustomScrollView(
                slivers: [
                  const SearchItem(),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: provider.tags
                            .take(15)
                            .map((tag) => Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  child: TagItem(tag, () => _onClickTag(tag)),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(provider.foods
                          .map((food) => foodItemBuilder(food))
                          .toList()),
                    ),
                  )
                ],
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
}
