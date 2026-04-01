import '../models/models.dart';

class FootballService {
  
  static List<Match> getTodaysMatches() {
    return [
      Match(id: 1, homeTeam: 'Man City', awayTeam: 'Liverpool', league: 'Premier League', homeScore: 2, awayScore: 1, status: 'Finished', dateTime: DateTime.now().subtract(const Duration(hours: 2)), over25HomeOdds: 1.72, bttsHomeOdds: 1.80),
      Match(id: 2, homeTeam: 'Arsenal', awayTeam: 'Chelsea', league: 'Premier League', status: 'Live', homeScore: 1, awayScore: 1, dateTime: DateTime.now().subtract(const Duration(minutes: 65)), over25HomeOdds: 1.65, bttsHomeOdds: 1.70),
      Match(id: 3, homeTeam: 'Barcelona', awayTeam: 'Real Madrid', league: 'La Liga', status: 'Scheduled', dateTime: DateTime.now().add(const Duration(hours: 3)), over25HomeOdds: 1.85, bttsHomeOdds: 1.75),
      Match(id: 4, homeTeam: 'Bayern Munich', awayTeam: 'Dortmund', league: 'Bundesliga', status: 'Scheduled', dateTime: DateTime.now().add(const Duration(hours: 5)), over25HomeOdds: 1.55, bttsHomeOdds: 1.65),
      Match(id: 5, homeTeam: 'Inter Milan', awayTeam: 'Juventus', league: 'Serie A', status: 'Live', homeScore: 0, awayScore: 0, dateTime: DateTime.now().subtract(const Duration(minutes: 32)), over25HomeOdds: 1.80, bttsHomeOdds: 1.85),
      Match(id: 6, homeTeam: 'PSG', awayTeam: 'Marseille', league: 'Ligue 1', status: 'Scheduled', dateTime: DateTime.now().add(const Duration(hours: 8)), over25HomeOdds: 1.70, bttsHomeOdds: 1.75),
      Match(id: 7, homeTeam: 'Ajax', awayTeam: 'Feyenoord', league: 'Eredivisie', status: 'Finished', homeScore: 3, awayScore: 2, dateTime: DateTime.now().subtract(const Duration(hours: 4)), over25HomeOdds: 1.60, bttsHomeOdds: 1.55),
      Match(id: 8, homeTeam: 'Rangers', awayTeam: 'Celtic', league: 'Scottish Premiership', status: 'Scheduled', dateTime: DateTime.now().add(const Duration(hours: 12)), over25HomeOdds: 1.95, bttsHomeOdds: 1.80),
    ];
  }

  static List<TeamStats> getTeamStats() {
    return [
      TeamStats(teamName: 'Man City', league: 'Premier League', played: 30, wins: 22, draws: 4, losses: 4, goalsFor: 71, goalsAgainst: 22, over25Percentage: 73.3, bttsPercentage: 66.7, avgGoalsScored: 2.37, avgGoalsConceded: 0.73),
      TeamStats(teamName: 'Liverpool', league: 'Premier League', played: 30, wins: 20, draws: 6, losses: 4, goalsFor: 58, goalsAgainst: 25, over25Percentage: 63.3, bttsPercentage: 60.0, avgGoalsScored: 1.93, avgGoalsConceded: 0.83),
      TeamStats(teamName: 'Arsenal', league: 'Premier League', played: 31, wins: 21, draws: 5, losses: 5, goalsFor: 62, goalsAgainst: 26, over25Percentage: 67.7, bttsPercentage: 61.3, avgGoalsScored: 2.0, avgGoalsConceded: 0.84),
      TeamStats(teamName: 'Chelsea', league: 'Premier League', played: 30, wins: 15, draws: 8, losses: 7, goalsFor: 45, goalsAgainst: 30, over25Percentage: 56.7, bttsPercentage: 53.3, avgGoalsScored: 1.5, avgGoalsConceded: 1.0),
      TeamStats(teamName: 'Bayern Munich', league: 'Bundesliga', played: 28, wins: 22, draws: 3, losses: 3, goalsFor: 79, goalsAgainst: 28, over25Percentage: 75.0, bttsPercentage: 71.4, avgGoalsScored: 2.82, avgGoalsConceded: 1.0),
      TeamStats(teamName: 'Dortmund', league: 'Bundesliga', played: 28, wins: 17, draws: 5, losses: 6, goalsFor: 60, goalsAgainst: 36, over25Percentage: 67.9, bttsPercentage: 64.3, avgGoalsScored: 2.14, avgGoalsConceded: 1.29),
      TeamStats(teamName: 'Barcelona', league: 'La Liga', played: 29, wins: 20, draws: 5, losses: 4, goalsFor: 59, goalsAgainst: 26, over25Percentage: 65.5, bttsPercentage: 58.6, avgGoalsScored: 2.03, avgGoalsConceded: 0.90),
      TeamStats(teamName: 'Real Madrid', league: 'La Liga', played: 29, wins: 19, draws: 6, losses: 4, goalsFor: 55, goalsAgainst: 28, over25Percentage: 62.1, bttsPercentage: 55.2, avgGoalsScored: 1.90, avgGoalsConceded: 0.97),
TeamStats(teamName: 'Inter Milan', league: 'Serie A', played: 30, wins: 21, draws: 4, losses: 5, goalsFor: 61, goalsAgainst: 21, over25Percentage: 60.0, bttsPercentage: 56.7, avgGoalsScored: 2.03, avgGoalsConceded: 0.70),
      TeamStats(teamName: 'Juventus', league: 'Serie A', played: 30, wins: 18, draws: 6, losses: 6, goalsFor: 45, goalsAgainst: 24, over25Percentage: 53.3, bttsPercentage: 50.0, avgGoalsScored: 1.50, avgGoalsConceded: 0.80),
      TeamStats(teamName: 'Ajax', league: 'Eredivisie', played: 28, wins: 23, draws: 2, losses: 3, goalsFor: 84, goalsAgainst: 20, over25Percentage: 82.1, bttsPercentage: 75.0, avgGoalsScored: 3.0, avgGoalsConceded: 0.71),
      TeamStats(teamName: 'Feyenoord', league: 'Eredivisie', played: 28, wins: 20, draws: 4, losses: 4, goalsFor: 70, goalsAgainst: 28, over25Percentage: 75.0, bttsPercentage: 67.9, avgGoalsScored: 2.5, avgGoalsConceded: 1.0),
      TeamStats(teamName: 'PSG', league: 'Ligue 1', played: 28, wins: 19, draws: 5, losses: 4, goalsFor: 65, goalsAgainst: 25, over25Percentage: 67.9, bttsPercentage: 60.7, avgGoalsScored: 2.32, avgGoalsConceded: 0.89),
      TeamStats(teamName: 'Marseille', league: 'Ligue 1', played: 28, wins: 15, draws: 7, losses: 6, goalsFor: 48, goalsAgainst: 32, over25Percentage: 60.7, bttsPercentage: 57.1, avgGoalsScored: 1.71, avgGoalsConceded: 1.14),
      TeamStats(teamName: 'Rangers', league: 'Scottish Premiership', played: 30, wins: 22, draws: 5, losses: 3, goalsFor: 68, goalsAgainst: 22, over25Percentage: 63.3, bttsPercentage: 56.7, avgGoalsScored: 2.27, avgGoalsConceded: 0.73),
      TeamStats(teamName: 'Celtic', league: 'Scottish Premiership', played: 30, wins: 23, draws: 4, losses: 3, goalsFor: 75, goalsAgainst: 20, over25Percentage: 70.0, bttsPercentage: 63.3, avgGoalsScored: 2.5, avgGoalsConceded: 0.67),
    ];
  }

  static List<League> getLeagues() {
    return [
      League(id: 1, name: 'Premier League', country: 'England', matchCount: 10, over25Average: 62.5, bttsAverage: 58.2),
      League(id: 2, name: 'La Liga', country: 'Spain', matchCount: 8, over25Average: 58.3, bttsAverage: 52.1),
      League(id: 3, name: 'Bundesliga', country: 'Germany', matchCount: 9, over25Average: 65.8, bttsAverage: 60.5),
      League(id: 4, name: 'Serie A', country: 'Italy', matchCount: 10, over25Average: 55.4, bttsAverage: 51.3),
      League(id: 5, name: 'Ligue 1', country: 'France', matchCount: 10, over25Average: 57.8, bttsAverage: 53.6),
      League(id: 6, name: 'Eredivisie', country: 'Netherlands', matchCount: 10, over25Average: 68.2, bttsAverage: 62.8),
    ];
  }

  static List<FormData> getTeamForm(String teamName) {
    final forms = {'Man City': ['W', 'W', 'W', 'W', 'D'], 'Liverpool': ['W', 'W', 'D', 'W', 'W'], 'Arsenal': ['W', 'W', 'W', 'L', 'W'], 'Bayern Munich': ['W', 'W', 'W', 'W', 'W'], 'Barcelona': ['W', 'W', 'W', 'D', 'W'], 'Real Madrid': ['W', 'W', 'D', 'W', 'L'], 'Ajax': ['W', 'W', 'W', 'W', 'W'],};
    final form = forms[teamName] ?? ['-', '-', '-', '-', '-'];
    return form.asMap().entries.map((e) => FormData(gameNumber: e.key + 1, result: e.value, isWin: e.value == 'W', isDraw: e.value == 'D', isLoss: e.value == 'L')).toList();
  }

  static List<GoalTiming> getGoalTimings(String teamName) {
    final timings = {'Bayern Munich': [5, 12, 15, 18, 8, 10], 'Ajax': [8, 15, 12, 15, 10, 8], 'Man City': [6, 10, 14, 16, 12, 9]};
    final data = timings[teamName] ?? [5, 8, 10, 12, 10, 8];
    return [GoalTiming(range: '0-15', percentage: data[0]), GoalTiming(range: '16-30', percentage: data[1]), GoalTiming(range: '31-45', percentage: data[2]), GoalTiming(range: '46-60', percentage: data[3]), GoalTiming(range: '61-75', percentage: data[4]), GoalTiming(range: '76-90+', percentage: data[5])];
  }

  static List<ValueBet> getValueBets() {
    final matches = getTodaysMatches();
    final teams = getTeamStats();
    final valueBets = <ValueBet>[];
    for (final match in matches.where((m) => m
.status == 'Scheduled')) {
final homeTeam = teams.where((t) => t.teamName == match.homeTeam).firstOrNull;
      final awayTeam = teams.where((t) => t.teamName == match.awayTeam).firstOrNull;
      if (homeTeam != null && match.over25HomeOdds != null) {
        final calcProb = (homeTeam.over25Percentage + (100 - (awayTeam?.over25Percentage ?? 50))) / 2;
        final vb = ValueBet(matchName: '${match.homeTeam} vs ${match.awayTeam}', market: 'Over 2.5', odds: match.over25HomeOdds!, calculatedProb: calcProb, recommendation: calcProb > 55 ? '✅ BACK' : '❌ LAY');
        if (vb.isValue) valueBets.add(vb);
      }
    }
    return valueBets..sort((a, b) => b.valuePercentage.compareTo(a.valuePercentage));
  }
}
