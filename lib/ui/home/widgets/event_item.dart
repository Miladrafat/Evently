import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height*0.2,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: height*0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme
                    .of(context)
                    .colorScheme
                    .outline
              ),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AssetsManager.birthday_light))
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: Theme
                        .of(context)
                        .colorScheme
                        .outline),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("21 Jan",style: Theme.of(context).textTheme.bodyMedium,),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(color: Theme
                          .of(context)
                          .colorScheme
                          .outline),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("This is a Birthday Party",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                        ),),
                      ),
                      SvgPicture.asset(AssetsManager.heart_selected,
                      height: 24,width: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
