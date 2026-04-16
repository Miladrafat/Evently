import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_field.dart';
import '../../../../../core/remote/network/Firestoremanager.dart';
import 'package:flutter/material.dart';

import '../../../../model/event.dart';
import '../../widgets/event_item.dart';
import '../../widgets/eventlist.dart';

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
            Expanded(child:StreamBuilder(stream:Firestoremanager.getFavouriteStream(),
              builder:(context, snapshot) {
                if (snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()));
                }

                List<Event>?events=snapshot.data??[];
                if (events.isEmpty){
                  return Center(child: Text("No data Available"));
                }
                return ListView.separated(
                    itemBuilder: (context, index) => EventItem(event: events[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 16,),
                    itemCount: events.length
                );

              },))
          ],
        ),
      ),
    );
  }
}
