import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../widgets/tag_item.dart';

import '../models/food_model.dart';
import '../helpers/var_helper.dart';
import '../providers/food_provider.dart';

class DetailScreen extends StatefulWidget {
  final String code;

  const DetailScreen(this.code, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: context.read<FoodProvider>().findByCode(widget.code),
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
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      floating: true,
                      expandedHeight: 300.0,
                      backgroundColor: primaryColor,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          provider.food!.thumbnail,
                          fit: BoxFit.fill,
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(50),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: grayLightColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            titleInfoBuilder(provider.food),
                            const SizedBox(height: 16.0),
                            ingredientsBuilder(provider.food),
                            const SizedBox(height: 16.0),
                            const Text(
                              'របៀបធ្វើ',
                              style: TextStyle(color: grayColor, fontSize: 14),
                            ),
                            const SizedBox(height: 16.0),
                            ...provider.food!.description
                                .map((fd) => stepBuilder(
                                    fd, provider.food!.description.indexOf(fd)))
                                .toList()
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
        ));
  }

  Container stepBuilder(String description, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: index.isEven ? pColor50 : sColor50,
        border:
            Border.all(width: 1, color: index.isEven ? pColor100 : sColor100),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ជំហានទី ${index + 1}',
            style: TextStyle(
              fontSize: 14.0,
              color: index.isEven ? primaryColor : secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Column ingredientsBuilder(FoodModel? food) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'គ្រឿងផ្សំ',
          style: TextStyle(color: grayColor, fontSize: 14),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          children: food!.ingredients
              .map((fd) => Container(
                    margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: TagItem(fd, null),
                  ))
              .toList(),
        )
      ],
    );
  }

  Widget titleInfoBuilder(FoodModel? food) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              food!.name,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(CupertinoIcons.time, size: 16, color: primaryColor),
            const SizedBox(width: 8.0),
            Text(
              food.duration,
              style: const TextStyle(color: grayColor, fontSize: 14),
            ),
          ],
        ),
        Text(
          '#${food.code}',
          style: const TextStyle(color: grayColor, fontSize: 14),
        ),
      ],
    );
  }
}
