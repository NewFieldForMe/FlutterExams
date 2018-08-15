import 'package:flutter_exams/model/example.dart';
import 'package:flutter_exams/enums.dart';

class ExampleListPagePresenter {
  List<Example> examples;
  ExampleListPagePresenter() {
    this.examples = <Example>[
      Example(title: 'Card Layout', exampleType: ExampleEnum.cardLayout),
      Example(title: 'Scroll View Layout', exampleType: ExampleEnum.scrollView),
      Example(title: 'Method Channel', exampleType: ExampleEnum.methodChannel),
      Example(
          title: 'Collection View Layout',
          exampleType: ExampleEnum.collectionViewLayout),
      Example(title: 'Map', exampleType: ExampleEnum.map),
      Example(title: 'Bottom Tab', exampleType: ExampleEnum.bottomTab),
      Example(title: 'Stack', exampleType: ExampleEnum.stack),
      Example(title: 'Top Tab', exampleType: ExampleEnum.topTab),
      Example(title: 'Sliver', exampleType: ExampleEnum.sliver),
      Example(title: 'Row and Columns', exampleType: ExampleEnum.rowAndColoumn),
    ];
  }
}
