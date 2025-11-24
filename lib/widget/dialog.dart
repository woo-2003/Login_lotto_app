import 'package:flutter/material.dart';
import 'package:login_app/widget/lotto_ball.dart';

class PopupDialog extends StatelessWidget {
  final int title;
  final List<int> numbers;

  const PopupDialog({
    super.key,
    required this.title,
    required this.numbers,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$title번째 추첨 번호',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < numbers.length; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: LottoBall(
                        path: 'svg/${numbers[i]}.svg',
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                numbers.join(', '),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

