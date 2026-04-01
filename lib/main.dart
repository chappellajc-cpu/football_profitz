import 'package:flutter/material.dart';
import 'data.dart';

void main() => runApp(const FPA());

class FPA extends StatelessWidget {
  const FPA({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Football ProfitZ',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
    darkTheme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark)),
    themeMode: ThemeMode.dark,
    home: const HS(),
  );
}

class HS extends StatefulWidget {
  const HS({super.key});
  @override
  State<HS> createState() => _HSState();
}

class _HSState extends State<HS> {
  int _idx = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Football ProfitZ'), backgroundColor: Colors.green.shade800),
      body: [_dash(), _leagues(), _teams(), _bets()][_idx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dash'),
          NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Leagues'),
          NavigationDestination(icon: Icon(Icons.groups), label: 'Teams'),
          NavigationDestination(icon: Icon(Icons.trending_up), label: 'Bets'),
        ],
      ),
    );
  }

  Widget _dash() {
    final b = calculateValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Dashboard', style: TextStyle(fontSize: 24)),
      Row(children: [
        _sb('Live', '${todaysMatches.where((m) => m.isLive).length}', Colors.orange),
        _sb('Value', '${b.length}', Colors.green),
      ]),
      const Text('Value Bets', style: TextStyle(fontSize: 18)),
      ...b.map((x) => Card(child: ListTile(title: Text(x.match), trailing: Text('+${x.valuePct.toStringAsFixed(1)}%')))),
    ]);
  }

  Widget _sb(String l, String v, Color c) => Expanded(child: Container(
    padding: const EdgeInsets.all(12), color: c.withOpacity(0.2), child: Column(children: [Text(v, style: TextStyle(fontSize: 24, color: c)), Text(l, style: TextStyle(color: c))])));

  Widget _leagues() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Leagues'),
    ...allLeagues.map((l) => Card(child: ListTile(leading: const Icon(Icons.flag), title: Text(l.name), subtitle: Text('O2.5: ${l.over25Avg.toStringAsFixed(0)}%')))),
  ]);

  Widget _teams() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Teams'),
    ...allTeams.map((t) => Card(child: ExpansionTile(
      leading: CircleAvatar(backgroundColor: Colors.green.shade800, child: Text(t.name[0])),
      title: Text(t.name), subtitle: Text(t.league),
      children: [Padding(padding: const EdgeInsets.all(12), child: Column(children: [
        Text('Wins: ${t.wins} | Points: ${t.points}'),
        Text('O2.5: ${t.over25Pct.toStringAsFixed(0)}% | BTTS: ${t.bttsPct.toStringAsFixed(0)}%'),
        Text('Clean Sheet: ${t.cleanSheetPct.toStringAsFixed(0)}%'),
      ])))],
    ))),
  ]);

  Widget _bets() {
    final b = calculateValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Value Bets'),
      ...b.map((x) => Card(color: Colors.green.withOpacity(0.1), child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(x.match, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('${x.market} @ ${x.odds} | Value: +${x.valuePct.toStringAsFixed(1)}%'),
        Text(x.recommendation),
      ])))),
    ];
  }
}