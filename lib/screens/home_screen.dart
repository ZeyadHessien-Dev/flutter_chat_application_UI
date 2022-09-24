import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat.dart';
import '../models/messages.dart';
import '../models/user.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/';
  List<User> user = User.users;
  List<Chat> chats = Chat.chats;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Scaffold(
        appBar: const _CustomAppBar(),
        body: Column(
          children: [
            _ChatContacts(
              user: user,
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ChatMessages(
                    chats: chats,
                  ),
                  _BottomBarNav(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
      ),
      child: AppBar(
        elevation: 0.0,
        title: Text(
          'Chat',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
              print(IconTheme.of(context).color);
            },
            icon: const Icon(
              Icons.dark_mode,
            ),
          ),
          const SizedBox(
            width: 7.5,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        56.0,
      );
}

class _ChatContacts extends StatelessWidget {
  const _ChatContacts({
    Key? key,
    required this.user,
  }) : super(key: key);
  final List<User> user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.125,
      margin: const EdgeInsets.only(
        left: 20.0,
        top: 40.0,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(
              right: 15.0,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: NetworkImage(
                    user[index].imageUrl,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user[index].name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          );
        },
        itemCount: user.length,
      ),
    );
  }
}

class _ChatMessages extends StatelessWidget {
  const _ChatMessages({
    Key? key,
    required this.chats,
  }) : super(key: key);

  final List<Chat> chats;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          // Get the other user profile
          User user = chats[index].users!.where((user) => user.id != '1').first;

          // Sort the messages based on the creation time
          chats[index].messages!.sort(
                (a, b) => b.createdAt.compareTo(a.createdAt),
              );
          // Get the last message for the chat preview
          Message lastMessage = chats[index].messages!.first;

          return ListTile(
            onTap: () {
              Get.toNamed(
                '/chat',
                arguments: [user, chats[index]],
              );
            },
            // contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            title: Text(
              '${user.name} ${user.surname}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              lastMessage.text,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              '${lastMessage.createdAt.hour}:${lastMessage.createdAt.minute}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        },
      ),
    );
  }
}

class _BottomBarNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.40,
        margin: const EdgeInsets.only(bottom: 80.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withAlpha(
                150,
              ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.message_rounded,
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.person_add_rounded,
              ),
            )
          ],
        ),
      ),
    );
  }
}
