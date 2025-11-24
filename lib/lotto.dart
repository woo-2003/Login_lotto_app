import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_app/widget/lotto_ball.dart';
import 'package:login_app/widget/dialog.dart';

class Lotto extends StatefulWidget {
  const Lotto({super.key});

  @override
  State<Lotto> createState() => _LottoState();
}

class _LottoState extends State<Lotto> {
  List<List<int>> listlottery = [];
  final ScrollController _scrollController = ScrollController();

  void _createNumber() {
    if (listlottery.length < 15) {
      setState(() {
        List<int> lottery = [];
        while (true) {
          var rand = Random().nextInt(45) + 1;
          if (!lottery.contains(rand)) {
            lottery.add(rand);
          }
          if (lottery.length == 6) {
            break;
          }
        }
        lottery.sort();
        listlottery.add(lottery);
      });
    } else {
      Fluttertoast.showToast(
        msg: "최대 15번까지만 생성가능합니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  // [수정 완료] dialog.dart의 정의에 맞춰 변수명을 title, numbers로 변경
  void showPopup(context, title, number) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupDialog(
          title: title, // title2 -> title 로 변경
          numbers: number, // number2 -> numbers 로 변경
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 125, 198),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 150, 3),
        title: const Text('Lottery App'),
        centerTitle: true,
      ),
      body: RawScrollbar(
        controller: _scrollController,
        thumbColor: const Color.fromARGB(255, 122, 157, 218),
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 10,
        radius: const Radius.circular(20),
        child: ListView.separated(
          controller: _scrollController,
          itemCount: listlottery.length,
          itemBuilder: (BuildContext context, int index) {
            int currentIndex = index + 1;
            // 이미지 경로 설정
            var path1 = 'assets/svg/${listlottery[index][0]}.svg';
            var path2 = 'assets/svg/${listlottery[index][1]}.svg';
            var path3 = 'assets/svg/${listlottery[index][2]}.svg';
            var path4 = 'assets/svg/${listlottery[index][3]}.svg';
            var path5 = 'assets/svg/${listlottery[index][4]}.svg';
            var path6 = 'assets/svg/${listlottery[index][5]}.svg';

            return ListTile(
              title: Text('$currentIndex번째 추첨번호'),
              trailing: IconButton(
                onPressed: () {
                  showPopup(
                    context,
                    currentIndex.toString(),
                    listlottery[index].toString(),
                  );
                },
                icon: const Icon(Icons.summarize_outlined),
              ),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LottoBall(path: path1),
                    const SizedBox(width: 4),
                    LottoBall(path: path2),
                    const SizedBox(width: 4),
                    LottoBall(path: path3),
                    const SizedBox(width: 4),
                    LottoBall(path: path4),
                    const SizedBox(width: 4),
                    LottoBall(path: path5),
                    const SizedBox(width: 4),
                    LottoBall(path: path6),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Colors.grey, thickness: 0.5);
          },
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            right: MediaQuery.of(context).orientation == Orientation.portrait
                ? 10
                : 76,
            bottom: MediaQuery.of(context).orientation == Orientation.portrait
                ? 80
                : 6,
            child: FloatingActionButton(
              heroTag: 'btn2',
              onPressed: () {
                setState(() {
                  listlottery.clear();
                });
              },
              backgroundColor: Colors.redAccent,
              tooltip: 'Clear',
              child: const Icon(Icons.refresh, color: Colors.white),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
              heroTag: 'btn1',
              onPressed: _createNumber,
              backgroundColor: Colors.black,
              tooltip: 'Add',
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
