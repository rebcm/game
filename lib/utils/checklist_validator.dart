class ChecklistValidator {
  static bool validateTitle(String title) {
    return title.length <= 72;
  }

  static bool validateDescription(String description) {
    return description.length <= 150;
  }

  static bool validateLink(String link) {
    // Implement link validation logic here
    // For now, just check if it's not empty
    return link.isNotEmpty;
  }
}
