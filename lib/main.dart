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
  
  final List<Map<String, dynamic>> _matches = [
    {'id': 1, 'home': 'Man City', 'away': 'Liverpool', 'league': 'Premier League', 'hScore': 2, 'aScore': 1, 'status': 'Finished', 'over25': 1.72, 'btts': 1.80},
    {'id': 2, 'home': 'Arsenal', 'away': 'Chelsea', 'league': 'Premier League', 'hScore': 1, 'aScore': 1, 'status': 'Live', 'over25': 1.65, 'btts': 1.70},
    {'id': 3, 'home': 'Barcelona', 'away': 'Real Madrid', 'league': 'La Liga', 'status': 'Scheduled', 'time': '20:00', 'over25': 1.85, 'btts': 1.75},
    {'id': 4, 'home': 'Bayern', 'away': 'Dortmund', 'league': 'Bundesliga', 'status': 'Scheduled', 'time': '19:30', 'over25': 1.55, 'btts': 1.65},
    {'id': 5, 'home': 'Inter', 'away': 'Juventus', 'league': 'Serie A', 'hScore': 0, 'aScore': 0, 'status': 'Live', 'over25': 1.80, 'btts': 1.85},
    {'id': 6, 'home': 'PSG', 'away': 'Marseille', 'league': 'Ligue 1', 'status': 'Scheduled', 'time': '20:00', 'over25': 1.70, 'btts': 1.75},
  ];
  
  final List<Map<String, dynamic>> _teams = [
    {'name': 'Man City', 'league': 'Premier League', 'played': 30, 'wins': 22, 'draws': 4, 'losses': 4, 'gf': 71, 'ga': 22, 'over25': 73.3, 'btts': 66.7},
    {'name': 'Liverpool', 'league': 'Premier League', 'played': 30, 'wins': 20, 'draws': 6, 'losses': 4, 'gf': 58, 'ga': 25, 'over25': 63.3, 'btts': 60.0},
    {'name': 'Arsenal', 'league': 'Premier League', 'played': 31, 'wins': 21, 'draws': 5, 'losses': 5, 'gf': 62, 'ga': 26, 'over25': 67.7, 'btts': 61.3},
    {'name': 'Bayern', 'league': 'Bundesliga', 'played': 28, 'wins': 22, 'draws': 3, 'losses': 3, 'gf': 79, 'ga': 28, 'over25': 75.0, 'btts': 71.4},
    {'name': 'Dortmund', 'league': 'Bundesliga', 'played': 28, 'wins': 17, 'draws': 5, 'losses': 6, 'gf': 60, 'ga': 36, 'over25': 67.9, 'btts': 64.3},
    {'name': 'Barcelona', 'league': 'La Liga', 'played': 29, 'wins': 20, 'draws': 5, 'losses': 4, 'gf': 59, 'ga': 26, 'over25': 65.5, 'btts': 58.6},
    {'name': 'Real Madrid', 'league': 'La Liga', 'played': 29, 'wins': 19, 'draws': 6, 'losses': 4, 'gf': 55, 'ga': 28, 'over25': 62.1, 'btts': 55.2},
  ];
  
  final List<Map<String, dynamic>> _leagues = [
    {'name': 'Premier League', 'country': 'England', 'over25': 62.5, 'btts': 58.2},
    {'name': 'La Liga', 'country': 'Spain', 'over25': 58.3, 'btts': 52.1},
    {'name': 'Bundesliga', 'country': 'Germany', 'over25': 65.8, 'btts': 60.5},
    {'name': 'Serie A', 'country': 'Italy', 'over25': 55.4, 'btts': 51.3},
    {'name': 'Ligue 1', 'country': 'France', 'over25': 57.8, 'btts': 53.6},
    {'name': 'Eredivisie', 'country': 'Netherlands', 'over25': 68.2, 'btts': 62.8},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Football ProfitZ'), backgroundColor: Colors.green.shade800, foregroundColor: Colors.white, actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () => setState(() {}))]),
      body: [_buildDashboard(), _buildLeagues(), _buildMatches(), _buildValueBets()][_currentIndex],
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

  Widget _buildDashboard() {
    final live = _matches.where((m) => m['status'] == 'Live').length;
    final finished = _matches.where((m) => m['status'] == 'Finished').length;
    final valueBets = _getValueBets();
    
    return ListView(padding: const EdgeInsets.all(16), children: [
      Row(children: [_statBox('Live', '$live', Colors.orange), const SizedBox(width: 8), _statBox('Value', '${valueBets.length}', Colors.green), const SizedBox(width: 8), _statBox('Done', '$finished', Colors.blue)]),
      const SizedBox(height: 20),
      Row(children: [const Icon(Icons.trending_up, color: Colors.green), const SizedBox(width: 8), const Text('Hot Value Bets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
      const SizedBox(height: 8),
      ...valueBets.map((vb) => Card(color: Colors.green.shade900.withOpacity(0.2), child: ListTile(leading: CircleAvatar(backgroundColor: Colors.green, child: Text(vb['label'])), title: Text(vb['match']), subtitle: Text('${vb['market']} @ ${vb['odds']}'), trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)), child: Text('+${vb['value']}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))))),
      const SizedBox(height: 20),
      Row(children: [const Icon(Icons.sports_soccer, color: Colors.orange), const SizedBox(width: 8), const Text('Live Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
      ..._matches.where((m) => m['status'] == 'Live').map((m) => Card(child: ListTile(title: Text('${m['home']} vs ${m['away']}'), subtitle: Text('${m['hScore']} - ${m['aScore']}'), trailing: const Text('LIVE', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold))))),
      const SizedBox(height: 20),
      Row(children: [const Icon(Icons.leaderboard, color: Colors.green), const SizedBox(width: 8), const Text('Top Teams', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
      ..._teams.take(5).map((t) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: Colors.green.shade800, child: Text(t['name'][0], style: const TextStyle(color: Colors.white))), title: Text(t['name']), subtitle: Text(t['league']), trailing: Text('O2.5: ${t['over25']}%', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))))),
    ]);
  }

  Widget _statBox(String label, String value, Color color) => Expanded(child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Column(children: [Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)), Text(label, style: TextStyle(color: color))])));

  Widget _buildLeagues() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Leagues', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    ..._leagues.map((l) => Card(child: ListTile(leading: const Icon(Icons.flag, color: Colors.green), title: Text(l['name']), subtitle: Text(l['country']), trailing: Column(mainAxisAlignment: MainAxisAlignment.end, children: [Text('O2.5: ${l['over25']}%', style: const TextStyle(color: Colors.green)), Text('BTTS: ${l['btts']}%', style: TextStyle(color: Colors.orange))]))))),
    const SizedBox(height: 20),
    const Text('Teams', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ..._teams.map((t) => Card(child: ExpansionTile(leading: CircleAvatar(backgroundColor: Colors.green.shade800, child: Text(t['name'][0], style: const TextStyle(color: Colors.white))), title: Text(t['name']), subtitle: Text(t['league']), children: [Padding(padding: const EdgeInsets.all(16), child: Column(children: [Row(children: [_stat('Played', '${t['played']}'), _stat('Wins', '${t['wins']}'), _stat('Pts', '${t['wins'] * 3 + t['draws']}')]), const SizedBox(height: 8), Row(children: [_stat('GF', '${t['gf']}'), _stat('GA', '${t['ga']}'), _stat('GD', '${t['gf'] - t['ga']}')]), const SizedBox(height: 8), Row(children: [_stat('O2.5%', '${t['over25']}%'), _stat('BTTS%', '${t['btts']}%')])]))]))),
  ]);

  Widget _stat(String l, String v) => Expanded(child: Column(children: [Text(v, style: const TextStyle(fontWeight: FontWeight.bold)), Text(l, style: TextStyle(fontSize: 11, color: Colors.grey))]));

  Widget _buildMatches() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Matches', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    const Text('Live', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
    ..._matches.where((m) => m['status'] == 'Live').map((m) => Card(child: ListTile(title: Text('${m['home']} vs ${m['away']}'), subtitle: Text('${m['hScore']} - ${m['aScore']}')))),
    const SizedBox(height: 16),
    const Text('Upcoming', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    ..._matches.where((m) => m['status'] == 'Scheduled').map((m) => Card(child: ListTile(title: Text('${m['home']} vs ${m['away']}'), subtitle: Text(m['time'] ?? 'TBC')))),
    const SizedBox(height: 16),
    const Text('Finished', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
    ..._matches.where((m) => m['status'] == 'Finished').map((m) => Card(child: ListTile(title: Text('${m['home']} vs ${m['away']}'), subtitle: Text('${m['hScore']} - ${m['aScore']}')))),
  ]);

  Widget _buildValueBets() {
    final bets = _getValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Value Bets', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      if (bets.isEmpty) const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('No value bets found')))
      else ...bets.map((vb) => Card(color: Colors.green.withOpacity(0.1), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Text(vb['label'], style: const TextStyle(fontSize: 24)), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)), child: Text('+${vb['value']}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))]),
        const SizedBox(height: 12),
        Text(vb['match'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(vb['market'], style: TextStyle(color: Colors.grey.shade400)),
        const SizedBox(height: 8),
        Row(children: [_vbStat('Odds', '${vb['odds']}'), _vbStat('Calc', '${vb['calcProb']}%'), _vbStat('Impl', '${vb['implied']}%')]),
        const SizedBox(height: 12),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text(vb['rec'], style: const TextStyle(fontWeight: FontWeight.bold))),
      ])))),
    ]);
  }

  Widget _vbStat(String l, String v) => Expanded(child: Column(children: [Text(v, style: const TextStyle(fontWeight: FontWeight.bold)), Text(l, style: TextStyle(color: Colors.grey.shade400, fontSize: 11))]));

  List<Map<String, dynamic>> _getValueBets() {
    final bets = <Map<String, dynamic>>[];
    for (final m in _matches.where((x) => x['status'] == 'Scheduled')) {
      final home = _teams.firstWhere((t) => t['name'] == m['home'], orElse: () => {});
      final away = _teams.firstWhere((t) => t['name'] == m['away'], orElse: () => {});
      if (home.isNotEmpty && m['over25'] != null) {
        final calcProb = ((home['over25'] ?? 50) + (away['over25'] ?? 50)) / 2;
        final implied = 100 / m['over25'];
        final value = calcProb - implied;
        if (value > 5) {
          bets.add({'match': '${m['home']} vs ${m['away']}', 'market': 'Over 2.5', 'odds': m['over25'], 'calcProb': calcProb.toStringAsFixed(1), 'implied': implied.toStringAsFixed(1), 'value': value.toStringAsFixed(1), 'label': value > 15 ? '🔥🔥🔥' : value > 10 ? '🔥🔥' : '🔥', 'rec': calcProb > 55 ? '✅ BACK' : '❌ LAY'});
        }
      }
    }
    return bets..sort((a, b) => double.parse(b['value']).compareTo(double.parse(a['value'])));
  }
}