import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class MessangerChats extends StatelessWidget {
  const MessangerChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(156.0),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.white.withOpacity(0.8),
              child: SafeArea(
                child: Column(
                  children: [
                    _buildTopBar(context),
                    _buildSearchBar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildStoriesSection(),
          _buildChatList(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/287_84.png'),
          ),
          const SizedBox(width: 12),
          Text(
            'Chats',
            style: GoogleFonts.sFProDisplay(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          _buildIconButton(Icons.camera_alt_outlined),
          const SizedBox(width: 12),
          _buildIconButton(Icons.edit_outlined),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: 22),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Icon(Icons.search, color: const Color(0xFF8E8E93)),
            const SizedBox(width: 6),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.sFProText(
                    color: const Color(0xFF8E8E93),
                    fontSize: 17,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoriesSection() {
    final stories = [
      {'name': 'Your story', 'image': null, 'isOnline': false, 'isAdd': true},
      {'name': 'Joshua', 'image': 'assets/images/287_62.png', 'isOnline': true, 'isAdd': false},
      {'name': 'Martin', 'image': 'assets/images/287_67.png', 'isOnline': true, 'isAdd': false},
      {'name': 'Karen', 'image': 'assets/images/287_72.png', 'isOnline': true, 'isAdd': false},
      {'name': 'Martha', 'image': 'assets/images/287_77.png', 'isOnline': true, 'isAdd': false},
    ];

    return Container(
      height: 106,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: story['isAdd'] as bool ? Colors.black.withOpacity(0.04) : Colors.transparent,
                      ),
                      child: story['isAdd'] as bool
                          ? const Icon(Icons.add, color: Colors.black, size: 28)
                          : ClipOval(
                              child: Image.asset(
                                story['image'] as String,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    if (story['isOnline'] as bool)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF5AD439),
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  story['name'] as String,
                  style: GoogleFonts.sFProText(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatList(BuildContext context) {
    final chatData = [
      {
        'name': 'Martin Randolph',
        'message': 'You: What’s man! · 9:40 AM',
        'image': 'assets/images/287_10.png',
        'isRead': true,
      },
      {
        'name': 'Andrew Parker',
        'message': 'You: Ok, thanks! · 9:25 AM',
        'image': 'assets/images/287_19.png',
        'isRead': true,
      },
      {
        'name': 'Karen Castillo',
        'message': 'You: Ok, See you in To… · Fri',
        'image': 'assets/images/287_29.png',
        'isRead': true,
      },
      {
        'name': 'Maisy Humphrey',
        'message': 'Have a good day, Maisy! · Fri',
        'image': 'assets/images/287_44.png',
        'isRead': false,
      },
      {
        'name': 'Joshua Lawrence',
        'message': 'The business plan loo… · Thu',
        'image': 'assets/images/287_39.png',
        'isRead': false,
      },
      {
        'name': 'Maximillian Jacobson',
        'message': 'Messenger UI · Thu',
        'image': 'assets/images/287_5.png',
        'isRead': false,
      },
    ];

    return Column(
      children: [
        ...chatData.map((data) => _ChatItem(
              onTap: () => context.go('/messanger_swipe_actions'),
              name: data['name'] as String,
              message: data['message'] as String,
              imageUrl: data['image'] as String,
              isRead: data['isRead'] as bool,
            )),
        _AdItem(onTap: () => context.go('/messanger_swipe_actions')),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    // Using GoRouterState to determine the current route for styling
    final String currentRoute = GoRouterState.of(context).uri.toString();

    // Example logic: '/messanger_chats' is one of the main routes.
    // This is just a placeholder path for demonstration. In a real app,
    // you would have a list of main routes.
    final bool isChatsActive = currentRoute.startsWith('/messanger');

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 86.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: const Border(
                top: BorderSide(color: Color(0x333C3C43), width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.chat_bubble, color: isChatsActive ? Colors.black : const Color(0xFFa4a9b2)),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.people_alt, color: Color(0xFFa4a9b2)),
                    Positioned(
                      top: -4,
                      right: -8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF5AD439),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '2',
                          style: GoogleFonts.sFProText(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.settings, color: Color(0xFFa4a9b2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String imageUrl;
  final bool isRead;
  final VoidCallback onTap;

  const _ChatItem({
    required this.name,
    required this.message,
    required this.imageUrl,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.sFProText(
                      fontSize: 17,
                      fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.sFProText(
                      fontSize: 14,
                      fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
                      color: isRead ? Colors.black.withOpacity(0.5) : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (!isRead)
               Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFF007AFF),
                    shape: BoxShape.circle,
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ClipOval(
                  child: Image.asset(
                    imageUrl,
                    width: 16,
                    height: 16,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AdItem extends StatelessWidget {
  final VoidCallback onTap;
  const _AdItem({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/287_108.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Pixsellz',
                        style: GoogleFonts.sFProText(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          'Ad',
                          style: GoogleFonts.sFProText(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Make design process easier…',
                    style: GoogleFonts.sFProText(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'View More',
                    style: GoogleFonts.sFProText(
                      color: const Color(0xFF0084FE),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/287_115.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}