class CheckPhoneExistsModal {
  int _exist;
  String _nickname;
  bool _hasPassword;

  bool get exist => _exist != -1;

  String get nickname => _nickname;

  bool get hasPassword => _hasPassword;

  CheckPhoneExistsModal.fromMap(Map map) {
    this._exist = map["exist"];
    this._nickname = map["nickname"];
    this._hasPassword = map["hasPassword"];
  }

  @override
  String toString() {
    return 'CheckPhoneExistsModal{_exist: $_exist, _nickname: $_nickname, _hasPassword: $_hasPassword}';
  }
}
