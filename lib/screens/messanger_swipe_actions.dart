import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessangerSwipeActions extends StatelessWidget {
  const MessangerSwipeActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(108.0),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.8),
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/287_286.png'),
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
                        _buildAppBarButton(Icons.camera_alt_outlined, () {}),
                        const SizedBox(width: 8),
                        _buildAppBarButton(Icons.edit, () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 22),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        splashRadius: 20,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final chatItems = [
      _ChatItemData(
          image: 'assets/images/287_242.png',
          name: 'Martin Randolph',
          message: 'You: What’s man! · 9:40 AM',
          isRead: true),
      _ChatItemData(
          image: 'assets/images/287_207.png',
          name: 'Andrew Parker',
          message: 'You: Ok, thanks! · 9:25 AM',
          isRead: true),
      _ChatItemData(
          image: 'assets/images/287_217.png',
          name: 'Maisy Humphrey',
          message: 'Have a good day, Jacob! · Fri',
          isRead: true),
      _ChatItemData(
          image: 'assets/images/287_227.png',
          name: 'Karen Castillo',
          message: 'You: Ok, See you in To… · Fri',
          isRead: true),
      _ChatItemData(
          image: 'assets/images/287_251.png',
          name: 'Joshua Lawrence',
          message: 'The business plan loo… · Thu',
          isRead: false),
      const _ChatItemData(isAd: true),
      _ChatItemData(
          image: 'assets/images/287_237.png',
          name: 'Maximillian Jacobson',
          message: 'Messenger UI · Thu',
          isRead: false),
    ];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 52,
          flexibleSpace: _buildSearchBar(),
        ),
        SliverToBoxAdapter(child: _buildStoriesSection()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = chatItems[index];
              if (item.isAd) {
                return _AdItem();
              }
              return _ChatListItem(item: item);
            },
            childCount: chatItems.length,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: GoogleFonts.sFProText(
            color: const Color(0xFF8E8E93),
            fontSize: 17,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF8E8E93)),
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildStoriesSection() {
    final stories = [
      _StoryData(
          image: 'assets/images/287_264.png', name: 'Joshua', isOnline: true),
      _StoryData(
          image: 'assets/images/287_269.png', name: 'Martin', isOnline: true),
      _StoryData(
          image: 'assets/images/287_274.png', name: 'Karen', isOnline: true),
      _StoryData(
          image: 'assets/images/287_279.png', name: 'Martha', isOnline: true),
      _StoryData(
          image: 'assets/images/287_5.png', name: 'Steven', isOnline: false),
      _StoryData(
          image: 'assets/images/287_10.png', name: 'Anna', isOnline: true),
    ];

    return Container(
      height: 106,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _StoryItem(
            isAddStory: true,
            data: _StoryData(image: '', name: 'Your story'),
          ),
          ...stories.map((story) => _StoryItem(data: story)).toList(),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 83,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 0.5),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'People',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: 'Discover',
              ),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final _ChatItemData item;

  const _ChatListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(item.name),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFF0084FD),
            foregroundColor: Colors.white,
            icon: Icons.camera_alt,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black,
            icon: Icons.call,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black,
            icon: Icons.videocam,
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black,
            icon: Icons.more_horiz,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black,
            icon: Icons.notifications_off_outlined,
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFFFD294D),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => context.go('/messanger_chats'),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(item.image),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.sFProText(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.sFProText(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                if (item.isRead)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.grey,
                    size: 16,
                  )
                else
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AdItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/287_310.png'),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            'Ad',
                            style: GoogleFonts.sFProText(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Make design process easier…',
                      style: GoogleFonts.sFProText(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'View More',
                      style: GoogleFonts.sFProText(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0084FD),
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/287_317.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final _StoryData data;
  final bool isAddStory;

  const _StoryItem({required this.data, this.isAddStory = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        width: 65,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                if (isAddStory)
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 28),
                  )
                else
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(data.image),
                  ),
                if (data.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5AD439),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              data.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.sFProText(
                fontSize: 13,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatItemData {
  final String image;
  final String name;
  final String message;
  final bool isRead;
  final bool isAd;

  const _ChatItemData({
    this.image = '',
    this.name = '',
    this.message = '',
    this.isRead = false,
    this.isAd = false,
  });
}

class _StoryData {
  final String image;
  final String name;
  final bool isOnline;

  _StoryData({required this.image, required this.name, this.isOnline = false});
}