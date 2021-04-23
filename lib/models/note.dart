class Note {
  final String id;
  String title;
  String content;
  DateTime lastModify;

  Note({
    this.id,
    this.title,
    this.content,
    this.lastModify,
  });

  ///Use this function to translate the note to map format when interact with
  ///database since it is required.
  ///'alive' defaut is 1.
  Map<String, Object> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'day': lastModify.day,
      'month': lastModify.month,
      'year': lastModify.year,
      'alive': 1,
    };
  }

  ///Only use this function when need to delete the note
  ///Actually hide it from user by set it to 0.
  Map<String, Object> toMapDelete() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'day': lastModify.day,
      'month': lastModify.month,
      'year': lastModify.year,
      'alive': 0,
    };
  }
}
