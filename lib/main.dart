import 'dart:math';
import 'package:confetti/confetti.dart';
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
  late ConfettiController _confettiController;

  final int rows = 8;
  final int cols = 4;
  bool isGameOver = false;
  late String actualWord;
  final List<String> wordList = [
    "GAME",
    "WORD",
    "FIRE",
    "TREE",
    "MOON",
    "STAR",
    "WIND",
    "RAIN",
    "MATH",
    "CODE",
    "PLAY",
    "KING",
    "TIME",
    "ZONE",
    "FARM",
    "SHIP",
    "ROCK",
    "SAND",
    "QUIZ",
    "MYTH",
    "ZEST"
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
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    controller.dispose();
    super.dispose();
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

      _confettiController.stop();
    });
  }



  List<List<String>> board =
  List.generate(8, (_) => List.generate(4, (_) => ""));

  List<List<Color>> colors =
  List.generate(8, (_) => List.generate(4, (_) => Colors.grey.shade300));

  final TextEditingController controller = TextEditingController();

  void submitWord() {
    if (isGameOver) return;

    String guess = controller.text.toUpperCase();

    if (guess.length != 4 || currentRow >= rows) return;

    for (int i = 0; i < cols; i++) {
      board[currentRow][i] = guess[i];
    }

    checkWord(guess);

    // 🟢 WIN CONDITION
    if (guess == actualWord) {
      isGameOver = true;
      _confettiController.play();

      int level = currentRow + 1;

      Future.delayed(const Duration(milliseconds: 300), () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("🎉 You Won!"),
            content: Text(
              "You guessed \"$actualWord\" in $level attempts!",
              style: const TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetGame();
                },
                child: const Text("Play Again"),
              )
            ],
          ),
        );
      });
    } else {
      currentRow++;

      // 🔴 LOSE CONDITION (All rows finished)
      if (currentRow >= rows) {
        isGameOver = true;

        Future.delayed(const Duration(milliseconds: 300), () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("😢 You Lost!"),
              content: Text(
                "The correct word was \"$actualWord\"",
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    resetGame();
                  },
                  child: const Text("Try Again"),
                )
              ],
            ),
          );
        });
      }
    }

    controller.clear();
    setState(() {});
  }




  void checkWord(String guess) {
    for (int i = 0; i < cols; i++) {
      if (guess[i] == actualWord[i]) {

        colors[currentRow][i] = Colors.green;
      } else if (actualWord.contains(guess[i])) {

        colors[currentRow][i] = Colors.yellow;
      } else {

        colors[currentRow][i] = Colors.grey;
      }
    }
  }

  Widget buildGrid() {
    return GridView.builder(
      itemCount: rows * cols,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        int row = index ~/ cols;
        int col = index % cols;

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors[row][col],
            borderRadius: BorderRadius.circular(20),
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
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Expanded(child: buildGrid()),
                const SizedBox(height: 10),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: submitWord,
                      child: const Text("Submit"),
                    ),
                    const SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: resetGame,
                      child: const Text("Restart"),
                    ),
                  ],
                )
              ],
            ),
          ),

          // CONFETTI WIDGET
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 1,
              numberOfParticles: 20,
              maxBlastForce: 30,
              minBlastForce: 10,
              gravity: 0.05,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
