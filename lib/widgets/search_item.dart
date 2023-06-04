import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../helpers/var_helper.dart';
import '../../screens/search_screen.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          ),
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
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
            child: Row(children: const [
              Icon(CupertinoIcons.search, color: grayColor),
              SizedBox(width: 8.0),
              Text('ស្វែងរកអាហារ...', style: TextStyle(color: grayColor))
            ]),
          ),
        ),
      ),
    );
  }
}
