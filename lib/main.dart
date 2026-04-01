import 'package:flutter/material.dart';

void main() => runApp(const FootballProfitZApp());

class FootballProfitZApp extends StatelessWidget {
  const FootballProfitZApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Football ProfitZ',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
    darkTheme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark)),
    themeMode: ThemeMode.dark,
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Map<String, dynamic>> matches = [
    {'home': 'Man City', 'away': 'Liverpool', 'status': 'Finished', 'hScore': 2, 'aScore': 1},
    {'home': 'Arsenal', 'away': 'Chelsea', 'status': 'Live', 'hScore': 1, 'aScore': 1},
    {'home': 'Bayern', 'away': 'Dortmund', 'status': 'Scheduled'},
    {'home': 'Barcelona', 'away': 'Real Madrid', 'status': 'Scheduled'},
  ];
  
  final List<Map<String, dynamic>> valueBets = [
    {'match': 'Bayern vs Dortmund', 'market': 'Over 2.5', 'odds': 1.55, 'value': 12.5},
    {'match': 'Barcelona vs Real Madrid', 'market': 'BTTS', 'odds': 1.75, 'value': 8.2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Football ProfitZ'), backgroundColor: Colors.green.shade800),
      body: [dashboard, leagues, matchesTab, valueTab][_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Leagues'),
          NavigationDestination(icon: Icon(Icons.sports_soccer), label: 'Matches'),
          NavigationDestination(icon: Icon(Icons.trending_up), label: 'Value Bets'),
        ],
      ),
    );
  }

  Widget get dashboard => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    Row(children: [
      statBox('Live', '2', Colors.orange),
      statBox('Value', '2', Colors.green),
      statBox('Done', '1', Colors.blue),
    ]),
    const SizedBox(height: 20),
    const Text('Value Bets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    ...valueBets.map((b) => Card(color: Colors.green.shade900.withOpacity(0.2),
      child: ListTile(title: Text(b['match']), subtitle: Text('${b['market']} @ ${b['odds']}'),
        trailing: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
          child: Text('+${b['value']}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))))),
  ]);

  Widget statBox(String l, String v, Color c) => Expanded(child: Container(
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
    child: Column(children: [Text(v, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: c)), Text(l, style: TextStyle(color: c))])));

  Widget get leagues => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Leagues', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    const Card(child: ListTile(leading: Icon(Icons.flag), title: Text('Premier League'), trailing: Text('O2.5: 62%'))),
    const Card(child: ListTile(leading: Icon(Icons.flag), title: Text('Bundesliga'), trailing: Text('O2.5: 66%'))),
    const Card(child: ListTile(leading: Icon(Icons.flag), title: Text('Serie A'), trailing: Text('O2.5: 55%'))),
  ]);

  Widget get matchesTab => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Matches', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    const Text('Live', style: TextStyle(fontSize: 18, color: Colors.orange)),
    ...matches.where((m) => m['status'] == 'Live').map((m) => Card(child: ListTile(title: Text('${m['home']} vs ${m['away']}'), subtitle: Text('${m['hScore']} - ${m['aScore']}')))),
    const SizedBox(height: 16),
    const Text('Upcoming', style: TextStyle(fontSize: 18)),
    ...matches.where((m) => m['status'] == 'Scheduled').map((m) => Card(child: ListTile(title: Text('${m['home']} vs ${m['away']}')))),
  ]);

  Widget get valueTab => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Value Bets', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    ...valueBets.map((b) => Card(color: Colors.green.withOpacity(0.1),
      child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Text('🔥', style: TextStyle(fontSize: 24)), const Spacer(), Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)), child: Text('+${b['value']}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))]),
        const SizedBox(height: 12),
        Text(b['match'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(b['market']),
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: const Text('✅ BACK', style: TextStyle(fontWeight: FontWeight.bold))),
      ])))),
  ]);
}