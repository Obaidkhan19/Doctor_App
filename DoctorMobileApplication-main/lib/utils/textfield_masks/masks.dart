import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks{
  var maskFormatter =  MaskTextInputFormatter(
  mask: '###-####-#######-#', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);

}