import 'package:flutter/material.dart';

import '../helpers/var_helper.dart';

class TagItem extends StatelessWidget {
  final String tag;
  final Function()? onClick;
  final bool isActive;

  const TagItem(this.tag, this.onClick, {super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          color: isActive ? pColor50 : accentColor,
          border: isActive ? Border.all(width: 1, color: pColor100) : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          tag,
          style: TextStyle(
            fontSize: 12.0,
            color: isActive ? primaryColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
