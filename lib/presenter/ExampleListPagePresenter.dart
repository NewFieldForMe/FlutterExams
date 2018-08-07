import 'package:flutter_exams/model/example.dart';

class ExampleListPagePresenter {
  List<Example> examples;
  ExampleListPagePresenter() {
    this.examples = <Example>[
      Example(title: 'Card Layout'),
      Example(title: 'Collection View Layout'),
      Example(title: 'Map'),
      Example(title: 'Top Tab'),
      Example(title: 'Bottom Tab')
    ];
  }
}
