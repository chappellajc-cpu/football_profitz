// Data models for Football ProfitZ

class TeamData {
  final String name;
  final String league;
  final int played;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final double over25Pct;
  final double under25Pct;
  final double bttsPct;
  final double avgGoalsScored;
  final double avgGoalsConceded;
  final List<int> goalTimings; // Goals by 15-min intervals
  final List<String> last5Form;

  TeamData({
    required this.name,
    required this.league,
    this.played = 0,
    this.wins = 0,
    this.draws = 0,
    this.losses = 0,
    this.goalsFor = 0,
    this.goalsAgainst = 0,
    this.over25Pct = 0,
    this.under25Pct = 0,
    this.bttsPct = 0,
    this.avgGoalsScored = 0,
    this.avgGoalsConceded = 0,
    this.goalTimings = const [],
    this.last5Form = const [],
  });

  int get goalDiff => goalsFor - goalsAgainst;
  int get points => wins * 3 + draws;
  double get pointsPerGame => played > 0 ? points / played : 0;
  double get avgGoals => avgGoalsScored + avgGoalsConceded;
}

class MatchData {
  final String homeTeam;
  final String awayTeam;
  final String league;
  final String status;
  final int? homeScore;
  final int? awayScore;
  final double? over25Odds;
  final double? bttsOdds;
  final double? drawNoBetOdds;

  MatchData({
    required this.homeTeam,
    required this.awayTeam,
    required this.league,
    this.status = 'Scheduled',
    this.homeScore,
    this.awayScore,
    this.over25Odds,
    this.bttsOdds,
    this.drawNoBetOdds,
  });

  bool get isLive => status == 'Live';
  bool get isFinished => status == 'Finished';
}

class LeagueData {
  final String name;
  final String country;
  final double over25Avg;
  final double under25Avg;
  final double bttsAvg;
  final double avgGoals;

  LeagueData({
    required this.name,
    required this.country,
    this.over25Avg = 0,
    this.under25Avg = 0,
    this.bttsAvg = 0,
    this.avgGoals = 0,
  });
}

class ValueBet {
  final String match;
  final String market;
  final double odds;
  final double calculatedProb;
  final double valuePct;
  final String recommendation;

  ValueBet({
    required this.match,
    required this.market,
    required this.odds,
    required this.calculatedProb,
    required this.valuePct,
    required this.recommendation,
  });
}

// Sample data
final List<TeamData> allTeams = [
  TeamData(name: 'Man City', league: 'Premier League', played: 30, wins: 22, draws: 4, losses: 4, goalsFor: 71, goalsAgainst: 22, over25Pct: 73.3, under25Pct: 26.7, bttsPct: 66.7, avgGoalsScored: 2.37, avgGoalsConceded: 0.73, goalTimings: [6, 10, 14, 16, 12, 9, 8, 6, 5, 4, 3, 3, 2], last5Form: ['W', 'W', 'W', 'W', 'D']),
  TeamData(name: 'Liverpool', league: 'Premier League', played: 30, wins: 20, draws: 6, losses: 4, goalsFor: 58, goalsAgainst: 25, over25Pct: 63.3, under25Pct: 36.7, bttsPct: 60.0, avgGoalsScored: 1.93, avgGoalsConceded: 0.83, goalTimings: [5, 9, 12, 14, 11, 10, 9, 7, 6, 5, 4, 4, 3], last5Form: ['W', 'W', 'D', 'W', 'W']),
  TeamData(name: 'Arsenal', league: 'Premier League', played: 31, wins: 21, draws: 5, losses: 5, goalsFor: 62, goalsAgainst: 26, over25Pct: 67.7, under25Pct: 32.3, bttsPct: 61.3, avgGoalsScored: 2.0, avgGoalsConceded: 0.84, goalTimings: [6, 10, 12, 15, 10, 9, 8, 7, 6, 5, 4, 4, 3], last5Form: ['W', 'W', 'W', 'L', 'W']),
  TeamData(name: 'Bayern', league: 'Bundesliga', played: 28, wins: 22, draws: 3, losses: 3, goalsFor: 79, goalsAgainst: 28, over25Pct: 75.0, under25Pct: 25.0, bttsPct: 71.4, avgGoalsScored: 2.82, avgGoalsConceded: 1.0, goalTimings: [5, 12, 15, 18, 8, 10, 7, 8, 6, 5, 3, 2, 1], last5Form: ['W', 'W', 'W', 'W', 'W']),
  TeamData(name: 'Dortmund', league: 'Bundesliga', played: 28, wins: 17, draws: 5, losses: 6, goalsFor: 60, goalsAgainst: 36, over25Pct: 67.9, under25Pct: 32.1, bttsPct: 64.3, avgGoalsScored: 2.14, avgGoalsConceded: 1.29, goalTimings: [6, 11, 13, 15, 10, 9, 8, 7, 6, 5, 4, 3, 2], last5Form: ['W', 'D', 'W', 'L', 'W']),
  TeamData(name: 'Barcelona', league: 'La Liga', played: 29, wins: 20, draws: 5, losses: 4, goalsFor: 59, goalsAgainst: 26, over25Pct: 65.5, under25Pct: 34.5, bttsPct: 58.6, avgGoalsScored: 2.03, avgGoalsConceded: 0.90, goalTimings: [5, 9, 12, 14, 11, 10, 9, 7, 6, 5, 4, 4, 3], last5Form: ['W', 'W', 'W', 'D', 'W']),
  TeamData(name: 'Real Madrid', league: 'La Liga', played: 29, wins: 19, draws: 6, losses: 4, goalsFor: 55, goalsAgainst: 28, over25Pct: 62.1, under25Pct: 37.9, bttsPct: 55.2, avgGoalsScored: 1.90, avgGoalsConceded: 0.97, goalTimings: [5, 8, 11, 13, 10, 10, 9, 7, 6, 5, 4, 4, 3], last5Form: ['W', 'W', 'D', 'W', 'L']),
  TeamData(name: 'Inter Milan', league: 'Serie A', played: 30, wins: 21, draws: 4, losses: 5, goalsFor: 61, goalsAgainst: 21, over25Pct: 60.0, under25Pct: 40.0, bttsPct: 56.7, avgGoalsScored: 2.03, avgGoalsConceded: 0.70, goalTimings: [6, 10, 13, 15, 11, 9, 8, 6, 6, 5, 4, 3, 2], last5Form: ['W', 'W', 'W', 'W', 'D']),
  TeamData(name: 'Ajax', league: 'Eredivisie', played: 28, wins: 23, draws: 2, losses: 3, goalsFor: 84, goalsAgainst: 20, over25Pct: 82.1, under25Pct: 17.9, bttsPct: 75.0, avgGoalsScored: 3.0, avgGoalsConceded: 0.71, goalTimings: [8, 15, 12, 15, 10, 8, 6, 5, 5, 4, 2, 2, 3], last5Form: ['W', 'W', 'W', 'W', 'W']),
  TeamData(name: 'PSG', league: 'Ligue 1', played: 28, wins: 19, draws: 5, losses: 4, goalsFor: 65, goalsAgainst: 25, over25Pct: 67.9, under25Pct: 32.1, bttsPct: 60.7, avgGoalsScored: 2.32, avgGoalsConceded: 0.89, goalTimings: [6, 11, 14, 16, 11, 9, 8, 6, 6, 5, 4, 3, 2], last5Form: ['W', 'W', 'D', 'W', 'W']),
];

final List<LeagueData> allLeagues = [
  LeagueData(name: 'Premier League', country: 'England', over25Avg: 62.5, under25Avg: 37.5, bttsAvg: 58.2, avgGoals: 2.87),
  LeagueData(name: 'La Liga', country: 'Spain', over25Avg: 58.3, under25Avg: 41.7, bttsAvg: 52.1, avgGoals: 2.53),
  LeagueData(name: 'Bundesliga', country: 'Germany', over25Avg: 65.8, under25Avg: 34.2, bttsAvg: 60.5, avgGoals: 3.15),
  LeagueData(name: 'Serie A', country: 'Italy', over25Avg: 55.4, under25Avg: 44.6, bttsAvg: 51.3, avgGoals: 2.83),
  LeagueData(name: 'Ligue 1', country: 'France', over25Avg: 57.8, under25Avg: 42.2, bttsAvg: 53.6, avgGoals: 2.73),
  LeagueData(name: 'Eredivisie', country: 'Netherlands', over25Avg: 68.2, under25Avg: 31.8, bttsAvg: 62.8, avgGoals: 3.42),
];

final List<MatchData> todaysMatches = [
  MatchData(homeTeam: 'Bayern', awayTeam: 'Dortmund', league: 'Bundesliga', status: 'Scheduled', over25Odds: 1.55, bttsOdds: 1.65),
  MatchData(homeTeam: 'Barcelona', awayTeam: 'Real Madrid', league: 'La Liga', status: 'Scheduled', over25Odds: 1.85, bttsOdds: 1.75),
  MatchData(homeTeam: 'Ajax', awayTeam: 'Feyenoord', league: 'Eredivisie', status: 'Scheduled', over25Odds: 1.60, bttsOdds: 1.55),
  MatchData(homeTeam: 'Man City', awayTeam: 'Liverpool', league: 'Premier League', status: 'Scheduled', over25Odds: 1.72, bttsOdds: 1.80),
];

// Calculate value bets
List<ValueBet> calculateValueBets() {
  final bets = <ValueBet>[];
  
  for (final match in todaysMatches) {
    final home = allTeams.where((t) => t.name == match.homeTeam).firstOrNull;
    final away = allTeams.where((t) => t.name == match.awayTeam).firstOrNull;
    
    if (home != null && away != null && match.over25Odds != null) {
      final calcProb = (home.over25Pct + away.over25Pct) / 2;
      final impliedProb = (1 / match.over25Odds!) * 100;
      final value = calcProb - impliedProb;
      
      if (value > 5) {
        bets.add(ValueBet(
          match: '${match.homeTeam} vs ${match.awayTeam}',
          market: 'Over 2.5',
          odds: match.over25Odds!,
          calculatedProb: calcProb,
          valuePct: value,
          recommendation: calcProb > 55 ? 'BACK' : 'LAY',
        ));
      }
    }
  }
  
  return bets..sort((a, b) => b.valuePct.compareTo(a.valuePct));
}