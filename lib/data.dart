// Extended data models for Football ProfitZ

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
  final List<int> goalTimings;
  final List<String> last5Form;
  
  // New historical data
  final double winPct;
  final double drawPct;
  final double lossPct;
  final double cleanSheetPct;
  final double failedToScorePct;
  final double bttsWinPct;
  final double avgCorners;
  final double avgPossession;
  
  // Home/Away breakdown
  final double homeWinPct;
  final double homeGoalsAvg;
  final double awayWinPct;
  final double awayGoalsAvg;
  
  // Last 3 seasons average
  final double seasonAvgGoals;
  final double seasonAvgOver25;
  final double seasonAvgBTTS;

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
    this.winPct = 0,
    this.drawPct = 0,
    this.lossPct = 0,
    this.cleanSheetPct = 0,
    this.failedToScorePct = 0,
    this.bttsWinPct = 0,
    this.avgCorners = 0,
    this.avgPossession = 0,
    this.homeWinPct = 0,
    this.homeGoalsAvg = 0,
    this.awayWinPct = 0,
    this.awayGoalsAvg = 0,
    this.seasonAvgGoals = 0,
    this.seasonAvgOver25 = 0,
    this.seasonAvgBTTS = 0,
  });

  int get goalDiff => goalsFor - goalsAgainst;
  int get points => wins * 3 + draws;
}

class HeadToHead {
  final String team1;
  final String team2;
  final int totalGames;
  final int team1Wins;
  final int team2Wins;
  final int draws;
  final int team1Goals;
  final int team2Goals;
  final double over25Pct;
  final double bttsPct;
  final double team1AvgGoals;
  final double team2AvgGoals;
  final String recentForm; // H2H form last 5

  HeadToHead({
    required this.team1,
    required this.team2,
    this.totalGames = 0,
    this.team1Wins = 0,
    this.team2Wins = 0,
    this.draws = 0,
    this.team1Goals = 0,
    this.team2Goals = 0,
    this.over25Pct = 0,
    this.bttsPct = 0,
    this.team1AvgGoals = 0,
    this.team2AvgGoals = 0,
    this.recentForm = '',
  });
}

// Extended sample data with more stats
final List<TeamData> allTeams = [
  TeamData(
    name: 'Man City', league: 'Premier League', 
    played: 30, wins: 22, draws: 4, losses: 4, goalsFor: 71, goalsAgainst: 22,
    over25Pct: 73.3, under25Pct: 26.7, bttsPct: 66.7, 
    avgGoalsScored: 2.37, avgGoalsConceded: 0.73,
    goalTimings: [6, 10, 14, 16, 12, 9, 8, 6, 5, 4, 3, 3, 2], 
    last5Form: ['W', 'W', 'W', 'W', 'D'],
    winPct: 73.3, drawPct: 13.3, lossPct: 13.3,
    cleanSheetPct: 46.7, failedToScorePct: 13.3, bttsWinPct: 66.7,
    avgCorners: 6.5, avgPossession: 68.5,
    homeWinPct: 82.4, homeGoalsAvg: 2.71, awayWinPct: 64.7, awayGoalsAvg: 2.06,
    seasonAvgGoals: 2.41, seasonAvgOver25: 70.0, seasonAvgBTTS: 65.0,
  ),
  TeamData(
    name: 'Liverpool', league: 'Premier League', 
    played: 30, wins: 20, draws: 6, losses: 4, goalsFor: 58, goalsAgainst: 25,
    over25Pct: 63.3, under25Pct: 36.7, bttsPct: 60.0,
    avgGoalsScored: 1.93, avgGoalsConceded: 0.83,
    goalTimings: [5, 9, 12, 14, 11, 10, 9, 7, 6, 5, 4, 4, 3],
    last5Form: ['W', 'W', 'D', 'W', 'W'],
    winPct: 66.7, drawPct: 20.0, lossPct: 13.3,
    cleanSheetPct: 43.3, failedToScorePct: 20.0, bttsWinPct: 60.0,
    avgCorners: 5.8, avgPossession: 62.0,
    homeWinPct: 76.5, homeGoalsAvg: 2.24, awayWinPct: 58.8, awayGoalsAvg: 1.59,
    seasonAvgGoals: 1.98, seasonAvgOver25: 62.0, seasonAvgBTTS: 58.0,
  ),
  TeamData(
    name: 'Arsenal', league: 'Premier League', 
    played: 31, wins: 21, draws: 5, losses: 5, goalsFor: 62, goalsAgainst: 26,
    over25Pct: 67.7, under25Pct: 32.3, bttsPct: 61.3,
    avgGoalsScored: 2.0, avgGoalsConceded: 0.84,
    goalTimings: [6, 10, 12, 15, 10, 9, 8, 7, 6, 5, 4, 4, 3],
    last5Form: ['W', 'W', 'W', 'L', 'W'],
    winPct: 67.7, drawPct: 16.1, lossPct: 16.1,
    cleanSheetPct: 38.7, failedToScorePct: 22.6, bttsWinPct: 61.3,
    avgCorners: 5.2, avgPossession: 58.0,
    homeWinPct: 73.3, homeGoalsAvg: 2.33, awayWinPct: 62.1, awayGoalsAvg: 1.67,
    seasonAvgGoals: 2.05, seasonAvgOver25: 65.0, seasonAvgBTTS: 60.0,
  ),
  TeamData(
    name: 'Bayern', league: 'Bundesliga', 
    played: 28, wins: 22, draws: 3, losses: 3, goalsFor: 79, goalsAgainst: 28,
    over25Pct: 75.0, under25Pct: 25.0, bttsPct: 71.4,
    avgGoalsScored: 2.82, avgGoalsConceded: 1.0,
    goalTimings: [5, 12, 15, 18, 8, 10, 7, 8, 6, 5, 3, 2, 1],
    last5Form: ['W', 'W', 'W', 'W', 'W'],
    winPct: 78.6, drawPct: 10.7, lossPct: 10.7,
    cleanSheetPct: 35.7, failedToScorePct: 10.7, bttsWinPct: 71.4,
    avgCorners: 6.8, avgPossession: 68.0,
    homeWinPct: 85.7, homeGoalsAvg: 3.36, awayWinPct: 71.4, awayGoalsAvg: 2.29,
    seasonAvgGoals: 2.85, seasonAvgOver25: 78.0, seasonAvgBTTS: 72.0,
  ),
  TeamData(
    name: 'Dortmund', league: 'Bundesliga', 
    played: 28, wins: 17, draws: 5, losses: 6, goalsFor: 60, goalsAgainst: 36,
    over25Pct: 67.9, under25Pct: 32.1, bttsPct: 64.3,
    avgGoalsScored: 2.14, avgGoalsConceded: 1.29,
    goalTimings: [6, 11, 13, 15, 10, 9, 8, 7, 6, 5, 4, 3, 2],
    last5Form: ['W', 'D', 'W', 'L', 'W'],
    winPct: 60.7, drawPct: 17.9, lossPct: 21.4,
    cleanSheetPct: 28.6, failedToScorePct: 21.4, bttsWinPct: 64.3,
    avgCorners: 5.5, avgPossession: 58.0,
    homeWinPct: 71.4, homeGoalsAvg: 2.57, awayWinPct: 50.0, awayGoalsAvg: 1.71,
    seasonAvgGoals: 2.20, seasonAvgOver25: 68.0, seasonAvgBTTS: 65.0,
  ),
  TeamData(
    name: 'Barcelona', league: 'La Liga', 
    played: 29, wins: 20, draws: 5, losses: 4, goalsFor: 59, goalsAgainst: 26,
    over25Pct: 65.5, under25Pct: 34.5, bttsPct: 58.6,
    avgGoalsScored: 2.03, avgGoalsConceded: 0.90,
    goalTimings: [5, 9, 12, 14, 11, 10, 9, 7, 6, 5, 4, 4, 3],
    last5Form: ['W', 'W', 'W', 'D', 'W'],
    winPct: 69.0, drawPct: 17.2, lossPct: 13.8,
    cleanSheetPct: 41.4, failedToScorePct: 17.2, bttsWinPct: 58.6,
    avgCorners: 5.0, avgPossession: 65.0,
    homeWinPct: 80.0, homeGoalsAvg: 2.47, awayWinPct: 58.6, awayGoalsAvg: 1.60,
    seasonAvgGoals: 2.10, seasonAvgOver25: 66.0, seasonAvgBTTS: 58.0,
  ),
  TeamData(
    name: 'Real Madrid', league: 'La Liga', 
    played: 29, wins: 19, draws: 6, losses: 4, goalsFor: 55, goalsAgainst: 28,
    over25Pct: 62.1, under25Pct: 37.9, bttsPct: 55.2,
    avgGoalsScored: 1.90, avgGoalsConceded: 0.97,
    goalTimings: [5, 8, 11, 13, 10, 10, 9, 7, 6, 5, 4, 4, 3],
    last5Form: ['W', 'W', 'D', 'W', 'L'],
    winPct: 65.5, drawPct: 20.7, lossPct: 13.8,
    cleanSheetPct: 37.9, failedToScorePct: 20.7, bttsWinPct: 55.2,
    avgCorners: 4.8, avgPossession: 60.0,
    homeWinPct: 73.3, homeGoalsAvg: 2.13, awayWinPct: 57.1, awayGoalsAvg: 1.67,
    seasonAvgGoals: 1.95, seasonAvgOver25: 62.0, seasonAvgBTTS: 55.0,
  ),
  TeamData(
    name: 'Inter Milan', league: 'Serie A', 
    played: 30, wins: 21, draws: 4, losses: 5, goalsFor: 61, goalsAgainst: 21,
    over25Pct: 60.0, under25Pct: 40.0, bttsPct: 56.7,
    avgGoalsScored: 2.03, avgGoalsConceded: 0.70,
    goalTimings: [6, 10, 13, 15, 11, 9, 8, 6, 6, 5, 4, 3, 2],
    last5Form: ['W', 'W', 'W', 'W', 'D'],
    winPct: 70.0, drawPct: 13.3, lossPct: 16.7,
    cleanSheetPct: 50.0, failedToScorePct: 16.7, bttsWinPct: 56.7,
    avgCorners: 5.3, avgPossession: 57.0,
    homeWinPct: 80.0, homeGoalsAvg: 2.40, awayWinPct: 60.0, awayGoalsAvg: 1.67,
    seasonAvgGoals: 2.05, seasonAvgOver25: 62.0, seasonAvgBTTS: 58.0,
  ),
  TeamData(
    name: 'Ajax', league: 'Eredivisie', 
    played: 28, wins: 23, draws: 2, losses: 3, goalsFor: 84, goalsAgainst: 20,
    over25Pct: 82.1, under25Pct: 17.9, bttsPct: 75.0,
    avgGoalsScored: 3.0, avgGoalsConceded: 0.71,
    goalTimings: [8, 15, 12, 15, 10, 8, 6, 5, 5, 4, 2, 2, 3],
    last5Form: ['W', 'W', 'W', 'W', 'W'],
    winPct: 82.1, drawPct: 7.1, lossPct: 10.7,
    cleanSheetPct: 57.1, failedToScorePct: 7.1, bttsWinPct: 75.0,
    avgCorners: 7.2, avgPossession: 70.0,
    homeWinPct: 92.9, homeGoalsAvg: 3.71, awayWinPct: 71.4, awayGoalsAvg: 2.29,
    seasonAvgGoals: 3.05, seasonAvgOver25: 85.0, seasonAvgBTTS: 78.0,
  ),
  TeamData(
    name: 'PSG', league: 'Ligue 1', 
    played: 28, wins: 19, draws: 5, losses: 4, goalsFor: 65, goalsAgainst: 25,
    over25Pct: 67.9, under25Pct: 32.1, bttsPct: 60.7,
    avgGoalsScored: 2.32, avgGoalsConceded: 0.89,
    goalTimings: [6, 11, 14, 16, 11, 9, 8, 6, 6, 5, 4, 3, 2],
    last5Form: ['W', 'W', 'D', 'W', 'W'],
    winPct: 67.9, drawPct: 17.9, lossPct: 14.3,
    cleanSheetPct: 39.3, failedToScorePct: 14.3, bttsWinPct: 60.7,
    avgCorners: 5.5, avgPossession: 65.0,
    homeWinPct: 78.6, homeGoalsAvg: 2.79, awayWinPct: 57.1, awayGoalsAvg: 1.86,
    seasonAvgGoals: 2.35, seasonAvgOver25: 70.0, seasonAvgBTTS: 62.0,
  ),
];

// Head to head data
final List<HeadToHead> headToHeads = [
  HeadToHead(team1: 'Man City', team2: 'Liverpool', totalGames: 12, team1Wins: 5, team2Wins: 3, draws: 4, team1Goals: 18, team2Goals: 12, over25Pct: 58.3, bttsPct: 50.0, team1AvgGoals: 1.75, team2AvgGoals: 1.25, recentForm: 'WDWWW'),
  HeadToHead(team1: 'Bayern', team2: 'Dortmund', totalGames: 15, team1Wins: 9, team2Wins: 3, draws: 3, team1Goals: 35, team2Goals: 20, over25Pct: 73.3, bttsPct: 66.7, team1AvgGoals: 2.73, team2AvgGoals: 1.53, recentForm: 'WWWLW'),
  HeadToHead(team1: 'Barcelona', team2: 'Real Madrid', totalGames: 18, team1Wins: 8, team2Wins: 6, draws: 4, team1Goals: 30, team2Goals: 28, over25Pct: 72.2, bttsPct: 61.1, team1AvgGoals: 1.83, team2AvgGoals: 1.72, recentForm: 'WLWWL'),
  HeadToHead(team1: 'Ajax', team2: 'Feyenoord', totalGames: 10, team1Wins: 6, team2Wins: 2, draws: 2, team1Goals: 22, team2Goals: 10, over25Pct: 80.0, bttsPct: 70.0, team1AvgGoals: 2.40, team2AvgGoals: 1.20, recentForm: 'WWWWW'),
];

TeamData? getTeam(String name) => allTeams.where((t) => t.name == name).firstOrNull;
HeadToHead? getHeadToHead(String t1, String t2) {
  return headToHeads.where((h) => 
    (h.team1 == t1 && h.team2 == t2) || (h.team1 == t2 && h.team2 == t1)
  ).firstOrNull;
}