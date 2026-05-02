class DocumentationCriteria {
  final int characterLimit;
  final List<String> seoKeywords;
  final String toneOfVoice;

  DocumentationCriteria({required this.characterLimit, required this.seoKeywords, required this.toneOfVoice});

  factory DocumentationCriteria.fromJson(Map<String, dynamic> json) {
    return DocumentationCriteria(
      characterLimit: json['characterLimit'],
      seoKeywords: List<String>.from(json['seoKeywords']),
      toneOfVoice: json['toneOfVoice'],
    );
  }
}
