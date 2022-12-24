class Utilities {
  String remove91(String with91) {
    String without91 = with91.substring(4);
    return without91;
  }

  String add91(String without91) {
    return "+91 ${without91}";
  }
}
