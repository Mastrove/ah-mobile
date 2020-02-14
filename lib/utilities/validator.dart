import 'package:validators/validators.dart' as validator;

class Validator {
  String _value;
  String error;
  bool _hasError = false;
  String _label = 'value';
  bool _isOptional = false;

  Validator(String value) {
    _value = value == null ? '' : value.trim();
  }

  Validator label(String label) {
    _label = label;
    return this;
  }

  Validator optional() {
    _isOptional = true;
    return this;
  }

  Validator email([String error]) {
    if (_hasError) return this;
    _hasError = !validator.isEmail(_value);
    this.error = error ?? '$_label is not a valid email';
    return this;
  }

  Validator isLenght(min, [max, String error]) {
    if (_hasError) return this;
    _hasError = !validator.isLength(_value, min, max);
    this.error = error ?? '$label does not meet lenght constraints';
    return this;
  }

  Validator isInt([String error]) {
    if (_hasError) return this;
    _hasError = !validator.isInt(_value);
    this.error = error ?? '$_label must be a valid number';
    return this;
  }

  Validator equals(String value, [String error]) {
    if (_hasError) return this;
    _hasError = !validator.equals(_value, value);
    this.error = error ?? '$_label must be equal to $value';
    return this;
  }

  Validator isIn(List<dynamic> values, [String error]) {
    if (_hasError) return this;
    _hasError = !validator.isIn(_value, values);
    this.error = error ?? '$_label must be in $values';
    return this;
  }

  String validate() {
    if (_value == '' && _isOptional) return null;
    if (!_hasError) return null;
    return error;
  }
}
