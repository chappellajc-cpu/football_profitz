import 'package:flutter/material.dart';
import 'data.dart';

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
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football ProfitZ'),
        backgroundColor: Colors.green.shade800,
        actions: [
          IconButton(icon: const Icon(Icons.compare_arrows), onPressed: () => _showComparison(context)),
        ],
      ),
      body: [_buildDashboard(), _buildLeagues(), _buildTeams(), _buildValueBets()][_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Leagues'),
          NavigationDestination(icon: Icon(Icons.groups), label: 'Teams'),
          NavigationDestination(icon: Icon(Icons.trending_up), label: 'Value Bets'),
        ],
      ),
    );
  }

  void _showComparison(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, builder: (ctx) => DraggableScrollableSheet(
      initialChildSize: 0.9, minChildSize: 0.5, maxChildSize: 0.95, expand: false,
      builder: (_, controller) => ComparisonSheet(scrollController: controller),
    ));
  }

  Widget _buildDashboard() {
    final valueBets = calculateValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Row(children: [
        _statBox('Live', '2', Colors.orange),
        _statBox('Value', '${valueBets.length}', Colors.green),
        _statBox('Teams', '${allTeams.length}', Colors.blue),
      ]),
      const SizedBox(height: 20),
      const Text('Value Bets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ...valueBets.take(3).map((b) => Card(color: Colors.green.shade900.withOpacity(0.2), child: ListTile(title: Text(b.match), trailing: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)), child: Text('+${b.valuePct.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold)))))),
    ]);
  }

  Widget _statBox(String l, String v, Color c) => Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Column(children: [Text(v, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: c)), Text(l, style: TextStyle(color: c))])));

  Widget _buildLeagues() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Leagues', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    ...allLeagues.map((l) => Card(child: ExpansionTile(leading: const Icon(Icons.flag, color: Colors.green), title: Text(l.name), subtitle: Text(l.country), children: [Padding(padding: const EdgeInsets.all(16), child: Column(children: [Row(children: [_col('O2.5', '${l.over25Avg}%'), _col('BTTS', '${l.bttsAvg}%')])])))]))),
  ]);

  Widget _col(String l, String v) => Expanded(child: Column(children: [Text(v, style: const TextStyle(fontWeight: FontWeight.bold)), Text(l, style: TextStyle(fontSize: 11, color: Colors.grey))]));

  Widget _buildTeams() {
    final filtered = _searchQuery.isEmpty ? allTeams : allTeams.where((t) => t.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Teams', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      TextField(onChanged: (v) => setState(() => _searchQuery = v), decoration: InputDecoration(hintText: 'Search...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      const SizedBox(height: 16),
      ...filtered.map((t) => Card(child: ExpansionTile(leading: CircleAvatar(backgroundColor: Colors.green.shade800, child: Text(t.name[0])), title: Text(t.name), subtitle: Text(t.league), children: [
        Padding(padding: const EdgeInsets.all(16), child: Column(children: [
          Row(children: [Text('Form: ', style: const TextStyle(fontWeight: FontWeight.bold)), ...t.last5Form.map((f) => Container(width: 24, height: 24, margin: const EdgeInsets.only(right: 4), decoration: BoxDecoration(color: f == 'W' ? Colors.green : (f == 'D' ? Colors.orange : Colors.red), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(f, style: const TextStyle(color: Colors.white, fontSize: 10)))))],
          const Divider(),
          Row(children: [_col('O2.5%', '${t.over25Pct.toStringAsFixed(0)}%'), _col('BTTS%', '${t.bttsPct.toStringAsFixed(0)}%'), _col('Pts', '${t.points}')]),
          const Divider(),
          Row(children: [_col('3-Yr Avg', t.seasonAvgGoals.toStringAsFixed(2)), _col('O2.5', '${t.seasonAvgOver25.toStringAsFixed(0)}%'), _col('BTTS', '${t.seasonAvgBTTS.toStringAsFixed(0)}%')]),
          const Divider(),
          Row(children: [_col('CleanSh', '${t.cleanSheetPct.toStringAsFixed(0)}%'), _col('Corners', t.avgCorners.toStringAsFixed(1)), _col('Possess', '${t.avgPossession.toStringAsFixed(0)}%')]),
        ])),
      ]))),
    ]);
  }

  Widget _buildValueBets() {
    final bets = calculateValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Value Bets', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ...bets.map((b) => Card(color: Colors.green.withOpacity(0.1), child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        Row(children: [Text(b.valuePct > 10 ? '🔥' : '⭐', style: const TextStyle(fontSize: 24)), const Spacer(), Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)), child: Text('+${b.valuePct.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold)))],
        Text(b.match, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('Odds: ${b.odds} | Calc: ${b.calculatedProb.toStringAsFixed(1)}%'),
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text(b.recommendation)),
      ])))),
    ]);
  }
}

class ComparisonSheet extends StatefulWidget {
  final ScrollController scrollController;
  const ComparisonSheet({super.key, required this.scrollController});
  @override
  State<ComparisonSheet> createState() => _ComparisonSheetState();
}

class _ComparisonSheetState extends State<ComparisonSheet> {
  String? _t1;
  String? _t2;
  TeamData? _team1;
  TeamData? _team2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const Text('Compare Teams', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: DropdownButton<String>(hint: const Text('Team 1'), value: _t1, isExpanded: true, items: allTeams.map((t) => DropdownMenuItem(value: t.name, child: Text(t.name))).toList(), onChanged: (v) => setState(() { _t1 = v; _team1 = getTeam(v!); }))),
          const SizedBox(width: 16),
          Expanded(child: DropdownButton<String>(hint: const Text('Team 2'), value: _t2, isExpanded: true, items: allTeams.map((t) => DropdownMenuItem(value: t.name, child: Text(t.name))).toList(), onChanged: (v) => setState(() { _t2 = v; _team2 = getTeam(v!); }))),
        ]),
        if (_team1 != null && _team2 != null) Expanded(child: ListView(scrollController: widget.scrollController, children: [
          const Divider(),
          Row(children: [
            Expanded(child: Column(children: [Text(_team1!.name, style: const TextStyle(fontWeight: FontWeight.bold)), Text('W: ${_team1!.winPct.toStringAsFixed(0)}%'), Text('O2.5: ${_team1!.over25Pct.toStringAsFixed(0)}%')])),
            const Text('VS'),
            Expanded(child: Column(children: [Text(_team2!.name, style: const TextStyle(fontWeight: FontWeight.bold)), Text('W: ${_team2!.winPct.toStringAsFixed(0)}%'), Text('O2.5: ${_team2!.over25Pct.toStringAsFixed(0)}%')])),
          ]),
          const Divider(),
          Row(children: [_col('GF', '${_team1!.goalsFor}'), _col('GF', '${_team2!.goalsFor}')]),
          Row(children: [_col('GA', '${_team1!.goalsAgainst}'), _col('GA', '${_team2!.goalsAgainst}')]),
          Row(children: [_col('O2.5%', '${_team1!.over25Pct.toStringAsFixed(0)}%'), _col('O2.5%', '${_team2!.over25Pct.toStringAsFixed(0)}%')]),
          Row(children: [_col('BTTS%', '${_team1!.bttsPct.toStringAsFixed(0)}%'), _col('BTTS%', '${_team2!.bttsPct.toStringAsFixed(0)}%')]),
          Row(children: [_col('Clean%', '${_team1!.cleanSheetPct.toStringAsFixed(0)}%'), _col('Clean%', '${_team2!.cleanSheetPct.toStringAsFixed(0)}%')]),
          const Divider(),
          Row(children: [_col('Home W%', '${_team1!.homeWinPct.toStringAsFixed(0)}%'), _col('Home W%', '${_team2!.homeWinPct.toStringAsFixed(0)}%')]),
          Row(children: [_col('Away W%', '${_team1!.awayWinPct.toStringAsFixed(0)}%'), _col('Away W%', '${_team2!.awayWinPct.toStringAsFixed(0)}%')]),
        ])) else const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('Select two teams'))),
      ]),
    );
  }

  Widget _col(String l, String v) => Expanded(child: Column(children: [Text(v, style: const TextStyle(fontWeight: FontWeight.bold)), Text(l, style: TextStyle(fontSize: 10, color: Colors.grey))]));
}