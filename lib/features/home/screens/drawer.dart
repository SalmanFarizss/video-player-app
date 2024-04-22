import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/features/auth/controller/auht_controller.dart';
import 'package:lilac_task_app/features/auth/screens/phone_no_screen.dart';
import 'package:lilac_task_app/models/user_model.dart';
import 'package:lilac_task_app/theme/palette.dart';
import '../../auth/screens/splash_screen.dart';
import 'home_screen.dart';

class HomeDrawer extends ConsumerWidget {
  final UserModel user;
  const HomeDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Text(
            'profile',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              viewProfile(user: user, context: context);
            },
            child: Container(
              height: height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).cardColor),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Profile'), Icon(Icons.person)],
                ),
              )),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          Text(
            'settings',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).cardColor),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark mode'),
                    Consumer(builder: (context, ref, child) {
                      return Switch(
                          value: ref.watch(darkThemeProvider),
                          onChanged: (value) => ref
                              .read(darkThemeProvider.notifier)
                              .update((state) => !state));
                    })
                  ],
                ),
              )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          const Divider(),
          Text(
            'more',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              logoutAlert(context: context);
            },
            child: Container(
              height: height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).cardColor),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Logout'), Icon(Icons.logout)],
                ),
              )),
            ),
          ),
        ],
      ),
    ));
  }

  void viewProfile({required UserModel user, required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'My Profile',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CircleAvatar(
                        radius: width * 0.12,
                        backgroundImage: NetworkImage(user.imageUrl)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: Text('Name',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Text(user.name,
                            style: Theme.of(context).textTheme.bodyMedium,)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: Text('Email',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Text(user.email,
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: Text('Phone',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Text(user.phone,
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: Text('DOB',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Text(
                            '${user.dateOfBirth.day} - ${user.dateOfBirth.month} - ${user.dateOfBirth.year}',
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'CLOSE',
                      style: Theme.of(context).textTheme.labelSmall,
                    ))
              ],
            ));
  }

  void logoutAlert({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Text('Are you sure you want to logout..',
                  style: Theme.of(context).textTheme.bodyMedium),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'CANCEL',
                      style: Theme.of(context).textTheme.labelSmall,
                    )),
                Consumer(
                  builder: (context,ref,child) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                          ref.read(authControllerProvider.notifier).signOut();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PhoneNoScreen(),));
                        },
                        child: Text(
                          'LOGOUT',
                          style: Theme.of(context).textTheme.labelSmall,
                        ));
                  }
                ),
              ],
            ));
  }
}
