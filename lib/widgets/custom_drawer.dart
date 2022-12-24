// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../features/presentation/screens/bookmark_screen.dart';

class CustomerDrawer extends StatelessWidget {
  const CustomerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff1f1f23),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Dickens C'),
            accountEmail: const Text('Dickensclaud13@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              child: ClipOval(
                child: Image.asset('assets/images/users/01.jpg'),
                // child: CachedNetworkImage(
                //   cacheManager: CacheConfig.customCacheManager,
                //   key: UniqueKey(),
                //   imageUrl:
                //       'https://st4.depositphotos.com/4157265/41100/i/450/depositphotos_411005388-stock-photo-profile-picture-of-smiling-30s.jpg',
                //   height: MediaQuery.of(context).size.height * .12,
                //   width: MediaQuery.of(context).size.width * .25,
                //   fit: BoxFit.cover,
                //   errorWidget: (context, url, error) {
                //     return Container();
                //   },
                //   placeholder: (context, url) {
                //     return Shimmer.fromColors(
                //       baseColor: Colors.grey.withOpacity(.3),
                //       highlightColor: Colors.white.withOpacity(.2),
                //       child: Container(
                //         height: MediaQuery.of(context).size.height * .12,
                //         width: MediaQuery.of(context).size.width * .25,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8),
                //           color: Colors.grey,
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
          ),
          ListTile(
            leading: const Icon(Ionicons.bookmark, color: Colors.white),
            title:
                const Text('Bookmark', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const BookmarkScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Ionicons.notifications, color: Colors.white),
            title: const Text('Notification',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Navigator.of(context).pop()},
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Ionicons.share_social, color: Colors.white),
            title: const Text('Share', style: TextStyle(color: Colors.white)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Divider(color: Colors.grey.withOpacity(.2)),
          ),
          ListTile(
            leading: const Icon(Ionicons.cog, color: Colors.white),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigator.pushNamed(context, SettingScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Ionicons.document_text, color: Colors.white),
            title:
                const Text('Policies', style: TextStyle(color: Colors.white)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Ionicons.help_circle, color: Colors.white),
            title: const Text('Help & Support',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Ionicons.star, color: Colors.white),
            title: const Text(
              'Rate us',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          const Divider(),
          ListTile(
            title:
                const Text('Sign out', style: TextStyle(color: Colors.white)),
            leading: const Icon(Ionicons.log_out, color: Colors.white),
            onTap: () async {},
          ),
        ],
      ),
    );
  }
}
