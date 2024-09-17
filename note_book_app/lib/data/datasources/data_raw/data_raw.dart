import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataRaw {
  static const List<dynamic> levels = [
    {
      "id": "N5",
      "name": "N5",
    },
    {
      "id": "N4",
      "name": "N4",
    },
    {
      "id": "N3",
      "name": "N3",
    },
    {
      "id": "N2",
      "name": "N2",
    },
    {
      "id": "N1",
      "name": "N1",
    }
  ];

  static const Map<String, dynamic> lessons = {
    "N5": [
      {
        "id": "hiragana-&-katakana",
        "lesson": "Bảng chữ cái Hiragana và Katakana",
      },
      {
        "id": "lesson-01",
        "lesson": "Bài 1: Xin chào! Tôi là Dũng Mori",
      },
      {
        "id": "lesson-02",
        "lesson": "Bài 2: Đó là cái cặp của tôi",
      },
      {
        "id": "lesson-03",
        "lesson": "Bài 3: Đây là trường học của tôi",
      },
      {
        "id": "lesson-04",
        "lesson": "Bài 4: Tôi đẹp trai",
      },
      {
        "id": "lesson-05",
        "lesson": "Bài 5: Sáng nay, anh dậy lúc mấy giờ?",
      },
      {
        "id": "lesson-06",
        "lesson": "Bài 6: Hôm nay là sinh nhật của cô",
      }
    ]
  };

  static const List<Map<String, dynamic>> characters = [
    {"romanji": "ma", "hiragana": "ま", "katakana": "マ"},
    {"romanji": "mi", "hiragana": "み", "katakana": "ミ"},
    {"romanji": "mu", "hiragana": "む", "katakana": "ム"},
    {"romanji": "me", "hiragana": "め", "katakana": "メ"},
    {"romanji": "mo", "hiragana": "も", "katakana": "モ"},
    {"romanji": "ya", "hiragana": "や", "katakana": "ヤ"},
    {"romanji": " ", "hiragana": " ", "katakana": " "},
    {"romanji": "yu", "hiragana": "ゆ", "katakana": "ユ"},
    {"romanji": " ", "hiragana": " ", "katakana": " "},
    {"romanji": "yo", "hiragana": "よ", "katakana": "ヨ"},
    {"romanji": "ra", "hiragana": "ら", "katakana": "ラ"},
    {"romanji": "ri", "hiragana": "り", "katakana": "リ"},
    {"romanji": "ru", "hiragana": "る", "katakana": "ル"},
    {"romanji": "re", "hiragana": "れ", "katakana": "レ"},
    {"romanji": "ro", "hiragana": "ろ", "katakana": "ロ"},
    {"romanji": "wa", "hiragana": "わ", "katakana": "ワ"},
    {"romanji": " ", "hiragana": " ", "katakana": " "},
    {"romanji": "wo", "hiragana": "を", "katakana": "ヲ"},
    {"romanji": " ", "hiragana": " ", "katakana": " "},
    {"romanji": "n", "hiragana": "ん", "katakana": "ン"}
  ];

  static void main() {
    for (var character in characters) {
      Future.delayed(const Duration(seconds: 1), () {
        FirebaseFirestore.instance.collection('levels').add({
          'romanji': character['romanji'],
          'hiragana': character['hiragana'],
          'katakana': character['katakana'],
          'createdAt': Timestamp.now(),
        });
      });
    }
  }
}
