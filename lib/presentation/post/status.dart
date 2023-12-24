// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusScreen extends StatefulWidget {
  final String initialStatus;
  final Function(String, IconData) onStatusChanged;

  const StatusScreen(
      {super.key, required this.initialStatus, required this.onStatusChanged});

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final String emotionText;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AntiFakebook'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Cảm xúc'),
            Tab(text: 'Hoạt động'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildEmotionTab(),
          buildActivityTab(),
        ],
      ),
    );
  }

  Widget buildEmotionTab() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: buildEmotionColumn(),
          ),
          const VerticalDivider(thickness: 1.0, color: Colors.black),
          Expanded(
            child: buildEmotionColumn2(),
          ),
        ],
      ),
    );
  }

  Widget buildActivityTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: buildActivityColumn(),
          ),
          const VerticalDivider(
              thickness: 1.0, color: Colors.grey), // Viền giữa các cột
          Expanded(
            child: buildActivityColumn2(),
          ),
        ],
      ),
    );
  }

  Widget buildEmotionColumn() {
    return Column(
      children: [
        buildEmotionItem(FontAwesomeIcons.faceLaughBeam, 'Hạnh phúc'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceGrinHearts, 'Đang yêu'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceFrown, 'Buồn'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceDizzy, 'Hào hứng'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceLaughSquint, 'Sung Sướng'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceRollingEyes, 'Thất vọng'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceGrimace, 'Hồi hộp'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceGrinBeamSweat, 'Ngại ngùng'),
      ],
    );
  }

  Widget buildEmotionColumn2() {
    return Column(
      children: [
        buildEmotionItem(FontAwesomeIcons.faceAngry, 'Tức giận'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceSurprise, 'Bất ngờ'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceTired, 'Mệt mỏi'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceGrinSquint, 'Vui vẻ'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceFlushed, 'Hoang mang'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceGrinSquintTears, 'Hài hước'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceMeh, 'Ngẩn Ngơ'),
        const Divider(),
        buildEmotionItem(FontAwesomeIcons.faceMehBlank, 'Cạn lời'),
      ],
    );
  }

  Widget buildActivityColumn() {
    return Column(
      children: [
        buildActivityItem(FontAwesomeIcons.cakeCandles, 'Đang chúc mừng'),
        const Divider(),
        buildActivityItem(FontAwesomeIcons.utensils, 'Đang ăn'),
        const Divider(),
        buildActivityItem(FontAwesomeIcons.calendarDay, 'Đang tham gia'),
        const Divider(),
        buildActivityItem(FontAwesomeIcons.headphones, 'Đang nghe'),
        const Divider(),
        buildActivityItem(FontAwesomeIcons.cloud, 'Đang nghĩ về'),
      ],
    );
  }

  Widget buildActivityColumn2() {
    return Column(
      children: [
        buildActivityItem(FontAwesomeIcons.glasses, 'Đang xem'),
        const Divider(),
        buildActivityItem(FontAwesomeIcons.martiniGlass, 'Đang uống'),
        const Divider(),
        buildActivityItem(FontAwesomeIcons.plane, 'Shared your post'),
        const Divider(),
        buildActivityItem(FontAwesomeIcons.magnifyingGlass, 'Đang tìm'),
        const Divider(),
        buildActivityItem(FontAwesomeIcons.readme, 'Đang đọc'),
      ],
    );
  }

  Widget buildEmotionItem(IconData icon, String text) {
    return InkWell(
      onTap: () {
        widget.onStatusChanged(text, icon);
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Center(
            child: FaIcon(
              icon,
              size: 45.0,
              color: const Color.fromARGB(255, 211, 191, 10),
            ),
          ),
          const SizedBox(
            width: 8.0,
            height: 45,
          ),
          Text(text),
        ],
      ),
    );
  }

  Widget buildActivityItem(IconData icon, String text) {
    return InkWell(
      onTap: () {
        widget.onStatusChanged(text, icon);
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Center(
            child: FaIcon(
              icon,
              size: 45.0,
              color: const Color.fromARGB(255, 11, 227, 65),
            ),
          ),
          const SizedBox(
            width: 8.0,
            height: 45,
          ),
          Text(text),
        ],
      ),
    );
  }
}
