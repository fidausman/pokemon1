import 'dart:convert';

class DailyCheckin {
  final DateTime joinDate;
  final List<History> history;
  DailyCheckin({
    required this.joinDate,
    required this.history,
  });

  DailyCheckin copyWith({
    DateTime? joinDate,
    List<History>? history,
  }) {
    return DailyCheckin(
      joinDate: joinDate ?? this.joinDate,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'joinDate': joinDate,
      'history': history.map((x) => x.toMap()).toList(),
    };
  }

  factory DailyCheckin.fromMap(Map<String, dynamic> map) {
    return DailyCheckin(
      joinDate: DateTime.parse(map['joinDate'] as String),
      history: List<History>.from(
        (map['history'] as List<dynamic>).map<History>(
          (x) => History.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyCheckin.fromJson(String source) =>
      DailyCheckin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DailyCheckin(joinDate: $joinDate, history: $history)';

  @override
  int get hashCode => joinDate.hashCode ^ history.hashCode;
}

class History {
  final String id;
  final String user;
  final bool isCheckedIn;
  final bool isCreatedByCron;
  final DateTime createdAt;
  final int v;
  History({
    required this.id,
    required this.user,
    required this.isCheckedIn,
    required this.isCreatedByCron,
    required this.createdAt,
    required this.v,
  });

  History copyWith({
    String? id,
    String? user,
    bool? isCheckedIn,
    bool? isCreatedByCron,
    DateTime? createdAt,
    int? v,
  }) {
    return History(
      id: id ?? this.id,
      user: user ?? this.user,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
      isCreatedByCron: isCreatedByCron ?? this.isCreatedByCron,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'user': user,
      'isCheckedIn': isCheckedIn,
      'isCreatedByCron': isCreatedByCron,
      'createdAt': createdAt,
      '__v': v,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['_id'] as String,
      user: map['user'] as String,
      isCheckedIn: map['isCheckedIn'] as bool,
      isCreatedByCron: map['isCreatedByCron'] as bool,
      createdAt: DateTime.parse(map['createdAt'] as String),
      v: map['__v'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source) as Map<String, dynamic>);
}
