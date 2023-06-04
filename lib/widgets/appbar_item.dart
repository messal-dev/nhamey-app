import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../screens/random_foods_screen.dart';

import '../../helpers/var_helper.dart';

class AppBarItem extends StatelessWidget {
  const AppBarItem({super.key});

  void _onClickRandom(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (context) => const RandomFoodsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          foregroundImage: NetworkImage(
            'https://scontent.fpnh8-2.fna.fbcdn.net/v/t39.30808-6/309625059_2899358810370427_4323201255497773168_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFvd2YRsmlHo15NZer3-oTn6BOQISP_F_voE5AhI_8X-xAlB58aJMFZNL6dZBqksOgiUWAxz-acNCtllG9nBvNU&_nc_ohc=Nr0jz87CDL0AX_K9ewC&_nc_zt=23&_nc_ht=scontent.fpnh8-2.fna&oh=00_AfB3bTTadCN5M5XCk_837vOSfn_kAy7cE7NngK-ONdPsLQ&oe=64803C84',
          ),
          radius: 20,
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Nham Ey',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 22,
                  fontFamily: 'Teko',
                ),
              ),
              Text(
                'ញាំអីក៏បាន',
                style: TextStyle(
                  color: grayColor,
                  fontSize: 12,
                  fontFamily: 'Chrieng',
                ),
              ),
            ],
          ),
        ),
        IconButton(
          // ignore: avoid_print
          onPressed: () => _onClickRandom(context),
          icon: const Icon(
            CupertinoIcons.square_line_vertical_square_fill,
            color: grayColor,
          ),
        )
      ],
    );
  }
}
