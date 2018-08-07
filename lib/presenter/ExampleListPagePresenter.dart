import 'package:flutter_exams/model/example.dart';
import 'package:flutter_exams/enums.dart';

class ExampleListPagePresenter {
  List<Example> examples;
  ExampleListPagePresenter() {
    this.examples = <Example>[
      Example(title: 'Card Layout', exampleType: ExampleEnum.cardLayout),
      Example(
          title: 'Collection View Layout',
          exampleType: ExampleEnum.collectionViewLayout),
      Example(title: 'Map', exampleType: ExampleEnum.map),
      Example(title: 'Top Tab', exampleType: ExampleEnum.topTab),
      Example(title: 'Bottom Tab', exampleType: ExampleEnum.bottomTab)
    ];
  }
}
