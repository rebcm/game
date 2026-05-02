class DocumentationChecklist {
  final String title;
  final int maxCharacters;
  final bool hasCTA;
  final String link;

  DocumentationChecklist({required this.title, required this.maxCharacters, required this.hasCTA, required this.link});

  factory DocumentationChecklist.fromJson(Map<String, dynamic> json) {
    return DocumentationChecklist(
      title: json['title'],
      maxCharacters: json['maxCharacters'],
      hasCTA: json['hasCTA'],
      link: json['link'],
    );
  }
}
