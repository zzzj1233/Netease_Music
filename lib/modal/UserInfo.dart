class UserInfo{
  final String account;
  final String passWord;

  UserInfo(this.account, this.passWord);

  Map toJson(){
    Map map = new Map();
    map["account"] = account;
    map["passWord"] = passWord;
    return map;
  }
}
