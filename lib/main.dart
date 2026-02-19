import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WordleGame(),
  ));
}

class WordleGame extends StatefulWidget {
  const WordleGame({super.key});

  @override
  State<WordleGame> createState() => _WordleGameState();
}

class _WordleGameState extends State<WordleGame> {
  final int rows = 8;
  final int cols = 4;
  bool isGameOver = false;
  late String actualWord;
  final List<String> wordList = [
    "FARM",
    "GAME",
    "WORD",
    "FIRE",
    "LION",
    "WIND",
    "TREE",
    "MOON",
  ];

  void generateRandomWord() {
    final random = Random();
    actualWord = wordList[random.nextInt(wordList.length)];
  }
  int currentRow = 0;

  @override
  void initState() {
    super.initState();
    generateRandomWord();
  }

  void resetGame() {
    setState(() {
      // Reset board letters
      board = List.generate(rows, (_) => List.generate(cols, (_) => ""));

      // Reset colors
      colors = List.generate(
        rows,
            (_) => List.generate(cols, (_) => Colors.grey.shade300),
      );

      // Reset row pointer
      currentRow = 0;


      isGameOver = false;

      // New random word
      generateRandomWord();

      // Clear input field
      controller.clear();
    });
  }



  List<List<String>> board =
  List.generate(8, (_) => List.generate(4, (_) => ""));

  List<List<Color>> colors =
  List.generate(8, (_) => List.generate(4, (_) => Colors.grey.shade300));

  final TextEditingController controller = TextEditingController();

  void submitWord() {
    if (isGameOver) return; // Stop if game already won

    String guess = controller.text.toUpperCase();

    if (guess.length != 4 || currentRow >= rows) return;

    for (int i = 0; i < cols; i++) {
      board[currentRow][i] = guess[i];
    }

    checkWord(guess);

    // 🟢 If correct word → end game
    if (guess == actualWord) {
      isGameOver = true;
    } else {
      currentRow++; // move only if not correct
    }

    controller.clear();
    setState(() {});
  }


  void checkWord(String guess) {
    for (int i = 0; i < cols; i++) {
      if (guess[i] == actualWord[i]) {
        // Correct letter & correct position
        colors[currentRow][i] = Colors.green;
      } else if (actualWord.contains(guess[i])) {
        // Correct letter but wrong position
        colors[currentRow][i] = Colors.yellow;
      } else {
        // Letter not in word
        colors[currentRow][i] = Colors.grey;
      }
    }
  }

  Widget buildGrid() {
    return GridView.builder(
      itemCount: rows * cols,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        int row = index ~/ cols;
        int col = index % cols;

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors[row][col],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: Text(
            board[row][col],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              // Grid 4 x 4
              buildGrid(),
              const SizedBox(height: 10),
              // Input Field
              TextField(
                controller: controller,
                enabled: !isGameOver,
                maxLength: 4,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  hintText: "Enter 4 letter word",
                  border: OutlineInputBorder(),
                ),
              ),
              // Submit Button
              Row(
                children: [
                  ElevatedButton(
                onPressed: submitWord,
                child: const Text("Submit"),
              ),
                  const SizedBox(width: 50),
              ElevatedButton(
                onPressed: resetGame,
                child: const Text("New Game"),
              ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
