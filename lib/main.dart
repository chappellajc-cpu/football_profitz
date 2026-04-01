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
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => setState(() {})),
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

  Widget _buildDashboard() {
    final valueBets = calculateValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      // Quick stats row
      Row(children: [
        _statBox('Live Matches', '${todaysMatches.where((m) => m.isLive).length}', Colors.orange),
        _statBox('Value Bets', '${valueBets.length}', Colors.green),
        _statBox('Teams', '${allTeams.length}', Colors.blue),
      ]),
      const SizedBox(height: 20),
      
      // Value Bets Section
      const Text('🔥 Hot Value Bets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ...valueBets.take(3).map((b) => Card(color: Colors.green.shade900.withOpacity(0.2), child: ListTile(
        title: Text(b.match),
        subtitle: Text('${b.market} @ ${b.odds}'),
        trailing: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
          child: Text('+${b.valuePct.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold))),
      ))),
      
      const SizedBox(height: 20),
      // Today's Matches
      const Text('📅 Today\'s Matches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ...todaysMatches.map((m) => Card(child: ListTile(
        title: Text('${m.homeTeam} vs ${m.awayTeam}'),
        subtitle: Text(m.league),
        trailing: Text(m.status),
      ))),
    ]);
  }

  Widget _statBox(String l, String v, Color c) => Expanded(child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
    child: Column(children: [Text(v, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: c)), Text(l, style: TextStyle(fontSize: 11, color: c))])));

  Widget _buildLeagues() {
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Leagues & Stats', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      ...allLeagues.map((l) => Card(child: ExpansionTile(
        leading: const Icon(Icons.flag, color: Colors.green),
        title: Text(l.name),
        subtitle: Text(l.country),
        children: [
          Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            Row(children: [_d('O2.5%', '${l.over25Avg.toStringAsFixed(1)}%'), _d('U2.5%', '${l.under25Avg.toStringAsFixed(1)}%'), _d('BTTS%', '${l.bttsAvg.toStringAsFixed(1)}%')]),
            const Divider(),
            Row(children: [_d('Avg Goals', l.avgGoals.toStringAsFixed(2)), _d('Form', '🔥🔥'), _d('GoalsPG', '${l.avgGoals}')]),
          ])),
        ],
      ))),
    ]);
  }

  Widget _d(String l, String v) => Expanded(child: Column(children: [Text(v, style: const TextStyle(fontWeight: FontWeight.bold)), Text(l, style: TextStyle(fontSize: 11, color: Colors.grey))]));

  Widget _buildTeams() {
    final filtered = _searchQuery.isEmpty 
      ? allTeams 
      : allTeams.where((t) => t.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Teams Analysis', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      // Search
      TextField(
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(hintText: 'Search teams...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
      const SizedBox(height: 16),
      ...filtered.map((t) => Card(child: ExpansionTile(
        leading: CircleAvatar(backgroundColor: Colors.green.shade800, child: Text(t.name[0], style: const TextStyle(color: Colors.white))),
        title: Text(t.name),
        subtitle: Text(t.league),
        children: [
          Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            // Form
            Row(children: [
              const Text('Form: ', style: TextStyle(fontWeight: FontWeight.bold)),
              ...t.last5Form.asMap().entries.map((e) => Container(
                width: 28, height: 28, margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(color: e.value == 'W' ? Colors.green : (e.value == 'D' ? Colors.orange : Colors.red), borderRadius: BorderRadius.circular(14)),
                child: Center(child: Text(e.value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              )),
            ]),
            const Divider(),
            // Stats
            Row(children: [_d('Played', '${t.played}'), _d('Wins', '${t.wins}'), _d('Points', '${t.points}')]),
            const SizedBox(height: 8),
            Row(children: [_d('GF', '${t.goalsFor}'), _d('GA', '${t.goalsAgainst}'), _d('GD', '${t.goalDiff}')]),
            const Divider(),
            // Over/Under/BTTS
            Row(children: [
              _d('O2.5%', '${t.over25Pct.toStringAsFixed(0)}%'),
              _d('U2.5%', '${t.under25Pct.toStringAsFixed(0)}%'),
              _d('BTTS%', '${t.bttsPct.toStringAsFixed(0)}%'),
            ]),
            const Divider(),
            // Goal timings
            const Text('Goal Timings', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(spacing: 4, children: [
              _timingChip('0-15', t.goalTimings[0]),
              _timingChip('16-30', t.goalTimings[1]),
              _timingChip('31-45', t.goalTimings[2] + t.goalTimings[3]),
              _timingChip('46-60', t.goalTimings[4] + t.goalTimings[5]),
              _timingChip('61-75', t.goalTimings[6] + t.goalTimings[7]),
              _timingChip('76-90+', t.goalTimings[8] + t.goalTimings[9] + t.goalTimings[10] + t.goalTimings[11] + t.goalTimings[12]),
            ]),
            const SizedBox(height: 8),
            Row(children: [_d('AvgGF', t.avgGoalsScored.toStringAsFixed(2)), _d('AvgGA', t.avgGoalsConceded.toStringAsFixed(2)), _d('PPG', t.pointsPerGame.toStringAsFixed(2))]),
          ])),
        ],
      ))),
    ]);
  }

  Widget _timingChip(String l, int v) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: Colors.green.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
    child: Text('$l: $v%', style: const TextStyle(fontSize: 10)),
  );

  Widget _buildValueBets() {
    final bets = calculateValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Value Bets Analysis', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      if (bets.isEmpty)
        const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('No value bets found')))
      else
        ...bets.map((b) => Card(color: Colors.green.withOpacity(0.1), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Text(b.valuePct > 15 ? '🔥🔥🔥' : '🔥', style: const TextStyle(fontSize: 24)), const Spacer(), Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)), child: Text('+${b.valuePct.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))]),
          const SizedBox(height: 12),
          Text(b.match, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(b.market),
          const SizedBox(height: 8),
          Row(children: [_d('Odds', b.odds.toStringAsFixed(2)), _d('Calc Prob', '${b.calculatedProb.toStringAsFixed(1)}%'), _d('Implied', '${(100/b.odds).toStringAsFixed(1)}%')]),
          const SizedBox(height: 12),
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text(b.recommendation, style: const TextStyle(fontWeight: FontWeight.bold))),
        ])))),
    ]);
  }
}