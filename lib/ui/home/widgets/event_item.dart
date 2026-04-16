import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/AppConstants.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/remote/network/Firestoremanager.dart';
import '../../../model/event.dart';
import '../../../providers/UserProvider.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

// ...existing code...
import '../../../ui/event_delete/screen/delete_event_screen.dart';

class EventItem extends StatefulWidget {
  final Event? event;

  const EventItem({super.key, this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.event == null) {
      return SizedBox.shrink();
    }

    double height = MediaQuery.of(context).size.height;

    return Consumer<Userprovider>(
      builder: (context, myProvider, child) {
        return GestureDetector(
          onTap: () {
            if (widget.event != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DeleteEventScreen(event: widget.event!),
                ),
              );
            }
          },
          child: SizedBox(
            height: height * 0.26,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        AppConstants.getEventImage(
                          widget.event!.type!,
                          Theme.of(context).brightness == Brightness.light
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        ),
                      ),
                    ),
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
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          widget.event?.dateAndTime != null
                              ? DateFormat.MMMd().format(
                                  widget.event!.dateAndTime!.toDate(),
                                )
                              : "No date",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.event?.desc ?? "",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                bool isFavourite = checkeventFavourite(
                                  myProvider,
                                );
                                try {
                                  if (isFavourite) {
                                    myProvider.Myuser?.Favourites?.remove(widget.event!.id,);
                                    myProvider.notifyListeners();
                                    await Future.wait([Firestoremanager.deleteUserFavourite(widget.event!,),
                                      Firestoremanager.updateUserFavourite(myProvider.Myuser?.Favourites ?? [],),
                                    ]);
                                  }
                                  else {myProvider.Myuser?.Favourites?.add(widget.event!.id!,);
                                    myProvider.notifyListeners();
                                    await Future.wait([Firestoremanager.addFavourite(widget.event!,),
                                      Firestoremanager.updateUserFavourite(myProvider.Myuser?.Favourites ?? [],),]);
                                  }
                                } catch (e) {
                                  if (isFavourite) {
                                    myProvider.Myuser?.Favourites?.add(
                                      widget.event!.id!,
                                    );
                                  } else {
                                    myProvider.Myuser?.Favourites?.remove(
                                      widget.event!.id,
                                    );
                                  }
                                  myProvider.notifyListeners();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: $e")),
                                  );
                                }
                              },
                              icon: SvgPicture.asset(
                                checkeventFavourite(myProvider)
                                    ? AssetsManager.heart_selected
                                    : AssetsManager.heart,
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool checkeventFavourite(Userprovider provider) {
    if (provider.Myuser?.Favourites == null ||
        provider.Myuser!.Favourites!.isEmpty) {
      return false;
    }
    return provider.Myuser!.Favourites!.contains(widget.event?.id);
  }
}
