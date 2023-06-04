import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../widgets/tag_item.dart';
import '../../helpers/var_helper.dart';
import '../../screens/result_screen.dart';
import '../../providers/food_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  void _onBackHandler() {
    final provider = Provider.of<FoodProvider>(context, listen: false);
    provider.resetQuerySearch();
    Navigator.of(context).pop();
  }

  void _onSearchHandler() {
    final provider = Provider.of<FoodProvider>(context, listen: false);
    provider.setQuery(_controller.text);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SearchResultScreen()),
    );
  }

  void _onAddTagsQuery(String queryTag) {
    final provider = Provider.of<FoodProvider>(context, listen: false);
    provider.toggleQueryTag(queryTag);
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            backItemBuilder(),
            const SizedBox(width: 16.0),
            searchItemBuilder()
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Consumer<FoodProvider>(
          builder: (ctx, provider, _) {
            return Stack(
              children: [
                ListView(
                  children: [
                    const Text(
                      'ពាក្យគន្លឹះ',
                      style: TextStyle(color: grayColor, fontSize: 14),
                    ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      children: provider.tags
                          .map(
                            (tag) => Container(
                              margin: const EdgeInsets.only(
                                right: 8.0,
                                bottom: 8.0,
                              ),
                              child: TagItem(
                                tag,
                                () => _onAddTagsQuery(tag),
                                isActive: provider.queryTags.contains(tag),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
                Positioned(
                  bottom: 32,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _onSearchHandler,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: pColor100,
                        border: Border.all(width: 2, color: pColor200),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'ស្វែងរក',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: primaryColor),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded searchItemBuilder() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: shadowColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextField(
          controller: _controller,
          cursorColor: grayColor,
          cursorHeight: 20,
          style: const TextStyle(height: 1.5, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'ស្វែងរកតាមរយៈគ្រឿងទេស...',
            isDense: true,
            contentPadding: EdgeInsets.all(3.0),
            hintStyle: TextStyle(fontSize: 14),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  InkWell backItemBuilder() {
    return InkWell(
      onTap: _onBackHandler,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: shadowColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Icon(
          CupertinoIcons.back,
          color: grayColor,
          size: 24,
        ),
      ),
    );
  }
}
