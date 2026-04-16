import 'package:evently_c18/ui/login/screen/login_screen.dart';
import 'package:evently_c18/core/remote/local/prefs_manager.dart';
import 'package:flutter/material.dart';
import '../../core/asset_manager.dart';
import '../../core/resources/AssetsManager.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "OnboardingScreen";
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<_OnboardData> _pages = [
    _OnboardData(
      imageKey: 'assets/images/illusration.png',
      title: 'Find Events That Inspire You',
      description:
          'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.',
      primaryButton: 'Next',
    ),
    _OnboardData(
      imageKey: 'assets/images/illustration_1.png',
      title: 'Effortless Event Planning',
      description:
          'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we\'ve got you covered. Plan with ease and focus on what matters — creating an unforgettable experience for you and your guests.',
      primaryButton: 'Next',
    ),
    _OnboardData(
      imageKey: 'assets/images/illustraion_2.png',
      title: 'Connect with Friends & Share Moments',
      description:
          'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
      primaryButton: 'Get started',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _pages.length - 1) {
      _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      PrefsManager.setOnboardingShown();
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }

  }

  void _skip() {
    PrefsManager.setOnboardingShown();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

   @override
   Widget build(BuildContext context) {
     final theme = Theme.of(context);
     final isDarkMode = theme.brightness == Brightness.dark;
     return Scaffold(
       body: SafeArea(
         child: Column(
           mainAxisAlignment: .center,
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   _page > 0
                     ? IconButton(
                         icon: Icon(
                           Icons.arrow_back,
                           color: isDarkMode ? Colors.white : Colors.blue,
                         ),
                         onPressed: () {
                           _controller.previousPage(
                             duration: Duration(milliseconds: 300),
                             curve: Curves.ease,
                           );
                         },
                       )
                     : SizedBox(width: 48),
                   // Logo
                   SizedBox(
                     height: 50,
                     width: 100,
                     child: Image.asset(
                       isDarkMode
                         ? AssetsManager.OnboardingHeaderdark
                         : AssetsManager.OnboardingHeaderLight,
                       fit: BoxFit.contain,
                     ),
                   ),
                   // Skip button
                   TextButton(
                     onPressed: _skip,
                     child: Text(
                       'Skip',
                       style: TextStyle(
                         color: isDarkMode ? Colors.white : Colors.blue,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             Expanded(
               child: PageView.builder(
                 controller: _controller,
                 itemCount: _pages.length,
                 onPageChanged: (i) => setState(() => _page = i),
                 itemBuilder: (context, index) {
                   final p = _pages[index];
                   return Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
                     child: _OnboardingPage(
                       data: p,
                       showPreferences: p.showPreferences,
                     ),
                   );
                 },
               ),
             ),

             Padding(
               padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: List.generate(_pages.length, (i) {
                       return AnimatedContainer(
                         duration: Duration(milliseconds: 200),
                         margin: EdgeInsets.symmetric(horizontal: 4),
                         width: _page == i ? 20 : 8,
                         height: 8,
                         decoration: BoxDecoration(
                           color: _page == i ? theme.primaryColor : theme.dividerColor,
                           borderRadius: BorderRadius.circular(6),
                         ),
                       );
                     }),
                   ),
                   SizedBox(height: 12),
                   SizedBox(
                     width: double.infinity,
                     child: ElevatedButton(
                       onPressed: _next,
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.blue,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         padding: EdgeInsets.symmetric(vertical: 14),
                       ),
                       child: Text(_pages[_page].primaryButton, style: TextStyle(color: Colors.white)),
                     ),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardData {
  final String imageKey;
  final String title;
  final String description;
  final String primaryButton;
  final bool showPreferences;

  _OnboardData({
    required this.imageKey,
    required this.title,
    required this.description,
    required this.primaryButton,
    this.showPreferences = false,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardData data;
  final bool showPreferences;

  const _OnboardingPage({required this.data, this.showPreferences = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: Image.asset(AssetManager.getOnboardingImage(data.imageKey), fit: BoxFit.contain),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(data.description, style: theme.textTheme.bodyMedium, textAlign: TextAlign.left),
              SizedBox(height: 12),
              if (showPreferences) ...[
                Text('Language', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Row(children: [
                  OutlinedButton(onPressed: () {}, child: Text('English')),
                  SizedBox(width: 8),
                  OutlinedButton(onPressed: () {}, child: Text('Arabic')),
                ]),
                SizedBox(height: 12),
                Text('Theme', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Row(children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.wb_sunny)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.nightlight_round)),
                ]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
