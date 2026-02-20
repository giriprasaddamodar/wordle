// import 'dart:math';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WordleGame(),
//   ));
// }
//
// class WordleGame extends StatefulWidget {
//   const WordleGame({super.key});
//
//   @override
//   State<WordleGame> createState() => _WordleGameState();
// }
//
// class _WordleGameState extends State<WordleGame> {
//   late ConfettiController _confettiController;
//   late FocusNode _textFocusNode;
//
//   final int rows = 8;
//   final int cols = 4;
//   bool isGameOver = false;
//   late String actualWord;
//   final List<String> wordList = [
//     "GAME",
//     "WORD",
//     "FIRE",
//     "TREE",
//     "MOON",
//     "STAR",
//     "WIND",
//     "RAIN",
//     "MATH",
//     "CODE",
//     "PLAY",
//     "KING",
//     "TIME",
//     "ZONE",
//     "FARM",
//     "SHIP",
//     "ROCK",
//     "SAND",
//     "QUIZ",
//     "MYTH",
//     "ZEST"
//   ];
//
//
//   void generateRandomWord() {
//     final random = Random();
//     actualWord = wordList[random.nextInt(wordList.length)];
//   }
//   int currentRow = 0;
//   int currentCol = 0;\
//   @override
//   void initState() {
//     super.initState();
//     generateRandomWord();
//     _textFocusNode = FocusNode();
//     _confettiController = ConfettiController(
//       duration: const Duration(seconds: 3),
//     );
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _textFocusNode.requestFocus(); // opens keyboard
//     });
//   }
//
//   @override
//   void dispose() {
//     _confettiController.dispose();
//     _textFocusNode.dispose();
//     controller.dispose();
//     super.dispose();
//
//   }
//
//
//   void resetGame() {
//     setState(() {
//       // Reset board letters
//       board = List.generate(rows, (_) => List.generate(cols, (_) => ""));
//
//       // Reset colors
//       colors = List.generate(
//         rows,
//             (_) => List.generate(cols, (_) => Colors.grey.shade300),
//       );
//
//       // Reset row pointer
//       currentRow = 0;
//       currentCol = 0;
//
//       isGameOver = false;
//
//       // New random word
//       generateRandomWord();
//
//       // Clear input field
//       controller.clear();
//
//       _confettiController.stop();
//     });
//   }
//
//
//
//   List<List<String>> board =
//   List.generate(8, (_) => List.generate(4, (_) => ""));
//
//   List<List<Color>> colors =
//   List.generate(8, (_) => List.generate(4, (_) => Colors.grey.shade300));
//
//   final TextEditingController controller = TextEditingController();
//
//   // void submitWord() {
//   //   if (isGameOver) return;
//   //
//   //   String guess = controller.text.toUpperCase();
//   //
//   //   if (guess.length != 4 || currentRow >= rows) return;
//   //
//   //   for (int i = 0; i < cols; i++) {
//   //     board[currentRow][i] = guess[i];
//   //   }
//   //
//   //   checkWord(guess);
//   //
//   //   //  WIN CONDITION
//   //   if (guess == actualWord) {
//   //     isGameOver = true;
//   //     _confettiController.play();
//   //
//   //     int level = currentRow + 1;
//   //
//   //     Future.delayed(const Duration(milliseconds: 300), () {
//   //       showDialog(
//   //         context: context,
//   //         builder: (_) => AlertDialog(
//   //           title: const Text("🎉 You Won!"),
//   //           content: Text(
//   //             "You guessed \"$actualWord\" in $level attempts!",
//   //             style: const TextStyle(fontSize: 18),
//   //           ),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () {
//   //                 Navigator.pop(context);
//   //                 resetGame();
//   //               },
//   //               child: const Text("Play Again"),
//   //             )
//   //           ],
//   //         ),
//   //       );
//   //     });
//   //   } else {
//   //     currentRow++;
//   //
//   //     //  LOSE CONDITION (All rows finished)
//   //     if (currentRow >= rows) {
//   //       isGameOver = true;
//   //
//   //       Future.delayed(const Duration(milliseconds: 300), () {
//   //         showDialog(
//   //           context: context,
//   //           builder: (_) => AlertDialog(
//   //             title: const Text("😢 You Lost!"),
//   //             content: Text(
//   //               "The correct word was \"$actualWord\"",
//   //               style: const TextStyle(fontSize: 18),
//   //             ),
//   //             actions: [
//   //               TextButton(
//   //                 onPressed: () {
//   //                   Navigator.pop(context);
//   //                   resetGame();
//   //                 },
//   //                 child: const Text("Try Again"),
//   //               )
//   //             ],
//   //           ),
//   //         );
//   //       });
//   //     }
//   //   }
//   //
//   //   controller.clear();
//   //   setState(() {});
//   // }
//
//   void submitTypedRow() {
//     String guess = board[currentRow].join();
//
//     checkWord(guess);
//
//     if (guess == actualWord) {
//       isGameOver = true;
//       _confettiController.play();
//
//       int level = currentRow + 1;
//
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("🎉 You Won!"),
//           content: Text(
//             "You guessed \"$actualWord\" in $level attempts!",
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 resetGame();
//               },
//               child: const Text("Play Again"),
//             )
//           ],
//         ),
//       );
//     } else {
//       currentRow++;
//       currentCol = 0; //  RESET COLUMN FOR NEXT ROW
//
//       if (currentRow >= rows) {
//         isGameOver = true;
//
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: const Text("😢 You Lost!"),
//             content: Text("The correct word was \"$actualWord\""),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   resetGame();
//                 },
//                 child: const Text("Try Again"),
//               )
//             ],
//           ),
//         );
//       }
//     }
//
//     setState(() {});
//   }
//
//   void checkWord(String guess) {
//     for (int i = 0; i < cols; i++) {
//       if (guess[i] == actualWord[i]) {
//
//         colors[currentRow][i] = Colors.green;
//       } else if (actualWord.contains(guess[i])) {
//
//         colors[currentRow][i] = Colors.yellow;
//       } else {
//
//         colors[currentRow][i] = Colors.grey;
//       }
//     }
//   }
//
//   void handleKey(String key) {
//     // STOP typing if row is full
//     if (currentCol >= cols) {
//       if (key == "Backspace") {
//         setState(() {
//           currentCol--;
//           board[currentRow][currentCol] = "";
//         });
//       } else if (key == "Enter") {
//         submitTypedRow();
//       }
//       return; // VERY IMPORTANT (blocks extra letters)
//     }
//
//     // ✍️ Letter input
//     if (key.length == 1 && RegExp(r'[a-zA-Z]').hasMatch(key)) {
//       setState(() {
//         board[currentRow][currentCol] = key.toUpperCase();
//         currentCol++;
//       });
//     }
//
//     // ⌫ Backspace logic
//     else if (key == "Backspace") {
//       if (currentCol > 0) {
//         setState(() {
//           currentCol--;
//           board[currentRow][currentCol] = "";
//         });
//       }
//     }
//
//     // ⏎ Enter to submit
//     else if (key == "Enter") {
//       if (currentCol == cols) {
//         submitTypedRow();
//       }
//     }
//   }
//
//   Widget buildGrid() {
//     return GridView.builder(
//       itemCount: rows * cols,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         crossAxisSpacing: 6,
//         mainAxisSpacing: 6,
//         childAspectRatio: 1,
//       ),
//       itemBuilder: (context, index) {
//         int row = index ~/ cols;
//         int col = index % cols;
//
//         return Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: colors[row][col],
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.black12),
//           ),
//           child: Text(
//             board[row][col],
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(50),
//             child: Column(
//               children: [
//                 Expanded(child: buildGrid()),
//                 const SizedBox(height: 10),
//
//                 ElevatedButton(
//                   onPressed: resetGame,
//                   child: const Text("Restart"),
//                 ),
//               ],
//             ),
//           ),
//
//           // ⭐ ADD THIS HERE (NOT inside Column)
//           Positioned(
//             bottom: 0,
//             child: SizedBox(
//               width: 1,
//               height: 1,
//               child: TextField(
//                 focusNode: _textFocusNode,
//                 controller: controller,
//                 autofocus: true,
//                 showCursor: false,
//                 enableInteractiveSelection: false,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                 ),
//                 onChanged: (value) {
//                   if (value.isNotEmpty && !isGameOver) {
//                     handleKey(value.characters.last);
//                     controller.clear();
//                   }
//                 },
//               ),
//             ),
//           ),
//
//           // CONFETTI
//           Align(
//             alignment: Alignment.center,
//             child: ConfettiWidget(
//               confettiController: _confettiController,
//               blastDirectionality: BlastDirectionality.explosive,
//               shouldLoop: false,
//               emissionFrequency: 1,
//               numberOfParticles: 20,
//               maxBlastForce: 30,
//               minBlastForce: 10,
//               gravity: 0.05,
//               colors: const [
//                 Colors.red,
//                 Colors.blue,
//                 Colors.green,
//                 Colors.yellow,
//                 Colors.orange,
//                 Colors.purple,
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


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

  int currentRow = 0;
  int currentCol = 0;
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

  List<List<String>> board =
  List.generate(8, (_) => List.generate(4, (_) => ""));

  List<List<Color>> colors =
  List.generate(8, (_) => List.generate(4, (_) => Colors.grey.shade300));

  @override
  void initState() {
    super.initState();
    generateRandomWord();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void generateRandomWord() {
    final random = Random();
    actualWord = wordList[random.nextInt(wordList.length)];
  }

  void resetGame() {
    setState(() {
      board = List.generate(rows, (_) => List.generate(cols, (_) => ""));
      colors = List.generate(
        rows,
            (_) => List.generate(cols, (_) => Colors.grey.shade300),
      );
      currentRow = 0;
      currentCol = 0;
      isGameOver = false;
      generateRandomWord();
      _confettiController.stop();
    });
  }

  // 🎯 Keyboard Tap Handler (Main Input Logic)
  void onKeyTap(String key) {
    if (isGameOver) return;

    // Backspace
    if (key == "BACK") {
      if (currentCol > 0) {
        setState(() {
          currentCol--;
          board[currentRow][currentCol] = "";
        });
      }
      return;
    }

    // Enter Submit
    if (key == "OK") {
      if (currentCol == cols) {
        submitTypedRow();
      }
      return;
    }

    // Letter Input
    if (currentCol < cols && currentRow < rows) {
      setState(() {
        board[currentRow][currentCol] = key;
        currentCol++;
      });
    }
  }

  void submitTypedRow() {
    String guess = board[currentRow].join();

    checkWord(guess);

    // 🟢 WIN
    if (guess == actualWord) {
      isGameOver = true;
      _confettiController.play();

      int level = currentRow + 1;

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
    } else {
      // 🔴 Move to next row
      currentRow++;
      currentCol = 0;

      // 🔴 LOSE CONDITION
      if (currentRow >= rows) {
        isGameOver = true;

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
      }
    }

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
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: row == currentRow ? Colors.black : Colors.black12,
              width: 2,
            ),
          ),
          child: Text(
            board[row][col],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  //  Custom Keyboard (Real Wordle Style)
  Widget buildKeyboard() {
    final keys = [
      ["Q","W","E","R","T","Y","U","I","O","P"],
      ["A","S","D","F","G","H","J","K","L"],
      ["OK","Z","X","C","V","B","N","M","BACK"],
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              final isSpecialKey = key == "OK" || key == "BACK";

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: ElevatedButton(
                    onPressed: isGameOver ? null : () => onKeyTap(key),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isSpecialKey ? 16 : 14,
                      ),
                      minimumSize: const Size(0, 40),
                    ),
                    child: Text(
                      key,
                      style: TextStyle(
                        fontSize: isSpecialKey ? 11 : 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wordle Game"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 🎮 Grid
              Expanded(child: buildGrid()),

              const SizedBox(height: 20),

              // ⌨️ Keyboard
              buildKeyboard(),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: resetGame,
                child: const Text("Restart"),
              ),

              // 🎉 Confetti
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                gravity: 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}