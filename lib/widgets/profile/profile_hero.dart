import 'package:flutter/material.dart';
import '../../utils/custom_color_scheme.dart';

class ProfileHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        height: 150,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.purple),
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: ListTile(
            onTap: () {},
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.white.withOpacity(.9),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(.8)),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Bobby Brown',
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(.8)),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: null,
          ),
        ),
      ),
    );
  }
}
