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
      builder: (_, controller) => _ComparisonSheet(scrollController: controller),
    ));
  }

  Widget _buildDashboard() {
    final valueBets = calculateValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Row(children: [
        _statBox('Live Matches', '${todaysMatches.where((m) => m.isLive).length}', Colors.orange),
        _statBox('Value Bets', '${valueBets.length}', Colors.green),
        _statBox('Teams', '${allTeams.length}', Colors.blue),
      ]),
      const SizedBox(height: 20),
      const Text('🔥 Hot Value Bets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ...valueBets.take(3).map((b) => Card(color: Colors.green.shade900.withOpacity(0.2), child: ListTile(
        title: Text(b.match), subtitle: Text('${b.market} @ ${b.odds}'),
        trailing: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
          child: Text('+${b.valuePct.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold))),
      ))),
      const SizedBox(height: 20),
      const Text('📅 Today\'s Matches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ...todaysMatches.map((m) => Card(child: ListTile(title: Text('${m.homeTeam} vs ${m.awayTeam}'), subtitle: Text(m.league), trailing: Text(m.status)))),
    ]);
  }

  Widget _statBox(String l, String v, Color c) => Expanded(child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 4), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
    child: Column(children: [Text(v, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: c)), Text(l, style: TextStyle(fontSize: 11, color: c))])));

  Widget _buildLeagues() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Leagues & Stats', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    ...allLeagues.map((l) => Card(child: ExpansionTile(leading: const Icon(Icons.flag, color: Colors.green), title: Text(l.name), subtitle: Text(l.country), children: [
      Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        Row(children: [_d('O2.5%', '${l.over25Avg.toStringAsFixed(1)}%'), _d('U2.5%', '${l.under25Avg.toStringAsFixed(1)}%'), _d('BTTS%', '${l.bttsAvg.toStringAsFixed(1)}%')]),
        Row(children: [_d('Avg Goals', l.avgGoals.toStringAsFixed(2)), _d('Form', '🔥🔥'), _d('GoalsPG', '${l.avgGoals}')]),
      ])),
    ]))),
  ]);

  Widget _d(String l, String v) => Expanded(child: Column(children: [Text(v, style: const TextStyle(fontWeight: FontWeight.bold)), Text(l, style: TextStyle(fontSize: 11, color: Colors.grey))]));

  Widget _buildTeams() {
    final filtered = _searchQuery.isEmpty ? allTeams : allTeams.where((t) => t.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Teams Analysis', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      TextField(onChanged: (v) => setState(() => _searchQuery = v), decoration: InputDecoration(hintText: 'Search teams...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      const SizedBox(height: 16),
      ...filtered.map((t) => Card(child: ExpansionTile(
        leading: CircleAvatar(backgroundColor: Colors.green.shade800, child: Text(t.name[0], style: const TextStyle(color: Colors.white))),
        title: Text(t.name), subtitle: Text(t.league),
        children: [
          Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            Row(children: [const Text('Form: ', style: TextStyle(fontWeight: FontWeight.bold)), ...t.last5Form.asMap().entries.map((e) => Container(width: 28, height: 28, margin: const EdgeInsets.only(right: 4), decoration: BoxDecoration(color: e.value == 'W' ? Colors.green : (e.value == 'D' ? Colors.orange : Colors.red), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(e.value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)))))])]),
            const Divider(),
            Row(children: [_d('Played', '${t.played}'), _d('Wins', '${t.wins}'), _d('Points', '${t.points}')]),
            Row(children: [_d('GF', '${t.goalsFor}'), _d('GA', '${t.goalsAgainst}'), _d('GD', '${t.goalDiff}')]),
            const Divider(),
            Row(children: [_d('O2.5%', '${t.over25Pct.toStringAsFixed(0)}%'), _d('U2.5%', '${t.under25Pct.toStringAsFixed(0)}%'), _d('BTTS%', '${t.bttsPct.toStringAsFixed(0)}%')]),
            const Divider(),
            const Text('Season Averages (3 Years)', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(children: [_d('Goals', t.seasonAvgGoals.toStringAsFixed(2)), _d('O2.5%', '${t.seasonAvgOver25.toStringAsFixed(0)}%'), _d('BTTS%', '${t.seasonAvgBTTS.toStringAsFixed(0)}%')]),
            const Divider(),
            Row(children: [_d('Win%', '${t.winPct.toStringAsFixed(1)}%'), _d('CleanSheet%', '${t.cleanSheetPct.toStringAsFixed(1)}%'), _d('BTTS Win%', '${t.bttsWinPct.toStringAsFixed(1)}%')]),
            Row(children: [_d('Avg Corners', t.avgCorners.toStringAsFixed(1)), _d('Possession%', '${t.avgPossession.toStringAsFixed(1)}%'), _d('PPG', t.pointsPerGame.toStringAsFixed(2))]),
            const Divider(),
            const Text('Home vs Away', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(children: [_d('Home Win%', '${t.homeWinPct.toStringAsFixed(1)}%'), _d('Home Goals', t.homeGoalsAvg.toStringAsFixed(2)), _d('Away Win%', '${t.awayWinPct.toStringAsFixed(1)}%'), _d('Away Goals', t.awayGoalsAvg.toStringAsFixed(2))]),
            const SizedBox(height: 8),
            const Text('Goal Timings', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(spacing: 4, children: [_tc('0-15', t.goalTimings[0]), _tc('16-30', t.goalTimings[1]), _tc('31-45', t.goalTimings[2] + t.goalTimings[3]), _tc('46-60', t.goalTimings[4] + t.goalTimings[5]), _tc('61-75', t.goalTimings[6] + t.goalTimings[7]), _tc('76-90+', t.goalTimings[8] + t.goalTimings[9] + t.goalTimings[10] + t.goalTimings[11] + t.goalTimings[12])]),
          ])),
        ],
      ))),
    ]);
  }

  Widget _tc(String l, int v) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.withOpacity(0.3), borderRadius: BorderRadius.circular(8)), child: Text('$l: $v%', style: const TextStyle(fontSize: 10)));

  Widget _buildValueBets() {
    final bets = calculateValueBets();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Value Bets Analysis', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      if (bets.isEmpty) const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('No value bets found')))
      else ...bets.map((b) => Card(color: Colors.green.withOpacity(0.1), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Text(b.valuePct > 15 ? '🔥🔥🔥' : '🔥', style: const TextStyle(fontSize: 24)), const Spacer(), Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)), child: Text('+${b.valuePct.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))]),
        Text(b.match, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(b.market),
        Row(children: [_d('Odds', b.odds.toStringAsFixed(2)), _d('Calc', '${b.calculatedProb.toStringAsFixed(1)}%'), _d('Impl', '${(100/b.odds).toStringAsFixed(1)}%')]),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text(b.recommendation, style: const TextStyle(fontWeight: FontWeight.bold))),
      ])))),
    ]);
  }
}

class _ComparisonSheet extends StatefulWidget {
  final ScrollController scrollController;
  const _ComparisonSheet({super.key, required this.scrollController});
  @override
  State<_ComparisonSheet> createState() => _ComparisonSheetState();
}

class _ComparisonSheetState extends State<_ComparisonSheet> {
  TeamData? _team1;
  TeamData? _team2;
  HeadToHead? _h2h;
  String? _selectedTeam1;
  String? _selectedTeam2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const Text('Team Comparison', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: DropdownButton<String>(
            hint: const Text('Select Team 1'),
            value: _selectedTeam1,
            isExpanded: true,
            items: allTeams.map((t) => DropdownMenuItem(value: t.name, child: Text(t.name))).toList(),
            onChanged: (v) => setState(() { _selectedTeam1 = v; _team1 = getTeam(v!); _updateH2H(); }),
          )),
          const SizedBox(width: 16),
          Expanded(child: DropdownButton<String>(
            hint: const Text('Select Team 2'),
            value: _selectedTeam2,
            isExpanded: true,
            items: allTeams.map((t) => DropdownMenuItem(value: t.name, child: Text(t.name))).toList(),
            onChanged: (v) => setState(() { _selectedTeam2 = v; _team2 = getTeam(v!); _updateH2H(); }),
          )),
        ]),
        const Divider(),
        if (_team1 != null && _team2 != null) Expanded(child: ListView(controller: widget.scrollController, children: [
          // H2H Section
          if (_h2h != null) ...[
            const Text('Head to Head', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Card(color: Colors.purple.withOpacity(0.2), child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _compStat(_team1!.name, '${_h2h!.team1Wins}', 'Wins'),
                _compStat('Draw', '${_h2h!.draws}', 'Draw'),
                _compStat(_team2!.name, '${_h2h!.team2Wins}', 'Wins'),
              ]),
              const Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _d('O2.5%', '${_h2h!.over25Pct.toStringAsFixed(1)}%'), _d('BTTS%', '${_h2h!.bttsPct.toStringAsFixed(1)}%'), _d('Games', '${_h2h!.totalGames}'),
              ]),
              const Divider(),
              Row(children: [const Text('Recent H2H Form: ', style: TextStyle(fontWeight: FontWeight.bold)), ..._h2h!.recentForm.split('').map((f) => Container(width: 24, height: 24, margin: const EdgeInsets.only(right: 4), decoration: BoxDecoration(color: f == 'W' ? Colors.green : (f == 'D' ? Colors.orange : Colors.red), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(f, style: const TextStyle(color: Colors.white, fontSize: 10))))) ]),
            ]))),
          ],
          const SizedBox(height: 16),
          // Side by Side Stats
          Row(children: [
            Expanded(child: _teamCard(_team1!, Colors.blue)),
            const SizedBox(width: 8),
            Expanded(child: _teamCard(_team2!, Colors.orange)),
          ]),
          const SizedBox(height: 16),
          // Key Metrics Comparison
          const Text('Key Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
            _compareRow('Win %', '${_team1!.winPct.toStringAsFixed(1)}%', '${_team2!.winPct.toStringAsFixed(1)}%'),
            _compareRow('O2.5 %', '${_team1!.over25Pct.toStringAsFixed(1)}%', '${_team2!.over25Pct.toStringAsFixed(1)}%'),
            _compareRow('BTTS %', '${_team1!.bttsPct.toStringAsFixed(1)}%', '${_team2!.bttsPct.toStringAsFixed(1)}%'),
            _compareRow('Clean Sheet %', '${_team1!.cleanSheetPct.toStringAsFixed(1)}%', '${_team2!.cleanSheetPct.toStringAsFixed(1)}%'),
            _compareRow('Avg Goals', _team1!.avgGoalsScored.toStringAsFixed(2), _team2!.avgGoalsScored.toStringAsFixed(2)),
            _compareRow('Avg Possession', '${_team1!.avgPossession}%', '${_team2!.avgPossession}%'),
          ]))),
        ])) else const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('Select two teams to compare'))),
      ]),
    );
  }

  Widget _compStat(String team, String v, String label) => Expanded(child: Column(children: [Text(team, style: const TextStyle(fontWeight: FontWeight.bold)), Text(v, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)), Text(label, style: TextStyle(fontSize: 11, color: Colors.grey))]));

  Widget _teamCard(TeamData t, Color c) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: Column(children: [
    Text(t.name, style: TextStyle(fontWeight: FontWeight.bold, color: c)), const Divider(),
    _d('Form', t.last5Form.join(' ')), _d('Wins', '${t.wins}'), _d('Pts', '${t.points}'),
  ]));

  Widget _compareRow(String label, String v1, String v2) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [
    Expanded(child: Text(v1, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))),
    Expanded(child: Text(label, textAlign: TextAlign.center)),
    Expanded(child: Text(v2, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))),
  ]));

  void _updateH2H() {
    if (_selectedTeam1 != null && _selectedTeam2 != null) {
      _h2h = getHeadToHead(_selectedTeam1!, _selectedTeam2!);
    }
  }
}