import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late TextEditingController searchController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomField(
                isSearch: true,
                controller: searchController,
                hint: StringsManager.searchHint,
                prefixPath: AssetsManager.search,
                validation: (value) {
                  return null;
                },
            ),
            SizedBox(height: 16,),
            Expanded(child: ListView.separated(
                itemBuilder: (context, index) => EventItem(),
                separatorBuilder: (context, index) => SizedBox(height: 16,),
                itemCount: 10
            ))
          ],
        ),
      ),
    );
  }
}
