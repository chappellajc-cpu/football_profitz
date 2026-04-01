class Match {
  final int id;
  final String homeTeam;
  final String awayTeam;
  final String league;
  final int homeScore;
  final int awayScore;
  final String status;
  final int? homeHalfTime;
  final int? awayHalfTime;
  final DateTime dateTime;
  final double? over25HomeOdds;
  final double? over25AwayOdds;
  final double? bttsHomeOdds;
  final double? bttsAwayOdds;
  
  Match({required this.id, required this.homeTeam, required this.awayTeam, required this.league, this.homeScore = 0, this.awayScore = 0, this.status = 'Scheduled', this.homeHalfTime, this.awayHalfTime, required this.dateTime, this.over25HomeOdds, this.over25AwayOdds, this.bttsHomeOdds, this.bttsAwayOdds});

  bool get isLive => status == 'Live';
  bool get isFinished => status == 'Finished';
  bool get isScheduled => status == 'Scheduled';
  int get totalGoals => homeScore + awayScore;
  bool get over25 => totalGoals > 2;
  bool get btts => homeScore > 0 && awayScore > 0;
}

class TeamStats {
  final String teamName;
  final String league;
  final int played;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final double over25Percentage;
  final double bttsPercentage;
  final double avgGoalsScored;
  final double avgGoalsConceded;
  
  TeamStats({required this.teamName, required this.league, this.played = 0, this.wins = 0, this.draws = 0, this.losses = 0, this.goalsFor = 0, this.goalsAgainst = 0, this.over25Percentage = 0, this.bttsPercentage = 0, this.avgGoalsScored = 0, this.avgGoalsConceded = 0});

  int get goalDiff => goalsFor - goalsAgainst;
  double get points => (wins * 3) + draws;
}

class ValueBet {
  final String matchName;
  final String market;
  final double odds;
  final double calculatedProb;
  final double valuePercentage;
  final String recommendation;
  
  ValueBet({required this.matchName, required this.market, required this.odds, required this.calculatedProb, required this.recommendation}) : valuePercentage = calculatedProb - (100 / odds);
  
  bool get isValue => valuePercentage > 5;
  bool get isStrongValue => valuePercentage > 10;
  
  String get valueLabel {
    if (valuePercentage > 15) return '🔥🔥🔥';
    if (valuePercentage > 10) return '🔥🔥';
    if (valuePercentage > 5) return '🔥';
    return '❌';
  }
}

class League {
  final int id;
  final String name;
  final String country;
  final int matchCount;
  final double over25Average;
  final double bttsAverage;
  
  League({required this.id, required this.name, required this.country, this.matchCount = 0, this.over25Average = 0, this.bttsAverage = 0});
}

class FormData {
  final int gameNumber;
  final String result;
  final bool isWin;
  final bool isDraw;
  final bool isLoss;
  
  FormData({required this.gameNumber, required this.result, required this.isWin, required this.isDraw, required this.isLoss});
}

class GoalTiming {
  final String range;
  final int percentage;
  GoalTiming({required this.range, required this.percentage});
}

class HomeAwayStats {
  final String type;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  
  HomeAwayStats({required this.type, required this.wins, required this.draws, required this.losses, required this.goalsFor, required this.goalsAgainst});
  int get played => wins + draws + losses;
}
