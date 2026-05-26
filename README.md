import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProfitVideoApp());
}

class ProfitVideoApp extends StatelessWidget {
  const ProfitVideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ربح من الفيديوهات',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 0.0;
  int watchedVideos = 0;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getDouble('balance') ?? 0.0;
      watchedVideos = prefs.getInt('watchedVideos') ?? 0;
    });
  }

  Future<void> _saveBalance() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
    await prefs.setInt('watchedVideos', watchedVideos);
  }

  void _watchVideo() async {
    setState(() {
      balance += 0.5;
      watchedVideos += 1;
    });
    await _saveBalance();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('مبروك! ربحت 0.5 جنيه')),
    );
  }

  void _withdraw() {
    if (balance >= 50) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('سحب الأرباح'),
          content: Text('تم طلب سحب ${balance.toStringAsFixed(2)} جنيه'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الحد الأدنى للسحب 50 جنيه')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تطبيق الربح من الفيديوهات'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(Icons.account_balance_wallet, size: 60, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text(
                      '${balance.toStringAsFixed(2)} جنيه',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const Text('رصيدك الحالي'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'فيديوهات تمت مشاهدتها: $watchedVideos',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _watchVideo,
              icon: const Icon(Icons.play_circle_fill),
              label: const Text('شاهد فيديو واربح # -
للربح البسيط
