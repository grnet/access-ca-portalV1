/**
 * @license
 * Copyright (C) 2010 The Libphonenumber Authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

goog.require('goog.dom');
goog.require('goog.json');
goog.require('goog.proto2.ObjectSerializer');
goog.require('goog.string.StringBuffer');
goog.require('i18n.phonenumbers.AsYouTypeFormatter');
goog.require('i18n.phonenumbers.PhoneNumberFormat');
goog.require('i18n.phonenumbers.PhoneNumberType');
goog.require('i18n.phonenumbers.PhoneNumberUtil');
goog.require('i18n.phonenumbers.PhoneNumberUtil.ValidationResult');


function phoneNumberParser() {
  var $ = goog.dom.getElement;
  var phoneNumber = $('person_work_phone').value;
  //var phoneNumber = $('phoneNumber').value;
  var regionCode = 'GR';
  var output = new goog.string.StringBuffer();
  var result = true;
  var reason = '';
  try {
    var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
    var number = phoneUtil.parseAndKeepRawInput(phoneNumber, regionCode);
    var isPossible = phoneUtil.isPossibleNumber(number);
    if (!isPossible) {
      result = false;
      var PNV = i18n.phonenumbers.PhoneNumberUtil.ValidationResult;
      switch (phoneUtil.isPossibleNumberWithReason(number)) {
        case PNV.INVALID_COUNTRY_CODE:
          reason = 'Invalid country code';
          break;
        case PNV.TOO_SHORT:
          reason = 'Phone is too short';
          break;
        case PNV.TOO_LONG:
          reason = 'Phone is too long';
          break;
      }
      // IS_POSSIBLE shouldn't happen, since we only call this if _not_
      // possible.
    } else {
      var isNumberValid = phoneUtil.isValidNumber(number);
      result = result && isNumberValid;
      var region = phoneUtil.getRegionCodeForNumber(number);
      var PNT = i18n.phonenumbers.PhoneNumberType;
      switch (phoneUtil.getNumberType(number)) {
        case PNT.FIXED_LINE:
          break;
        default:
          result = false;
          reason = reason.concat("\nNot a landline.");
      }
    }
    var PNF = i18n.phonenumbers.PhoneNumberFormat;
    if (result == false) {
      output.append(reason);
    }
  } catch (e) {
    result=false
    output.append('\n' + e);
  }
  //$('output').value = output.toString();
  if (phoneNumber == '') {
    $('phone_errors').innerHTML = ''  
  }
  else {
    $('phone_errors').innerHTML = output.toString();
  }
  if (result) {
    $('phone_errors').style.color = "green"
    $('submit_person').disabled = false;
  }
  else {
    $('phone_errors').style.color = "red" 
    $('submit_person').disabled = true;
  }
  return false;
}

goog.exportSymbol('phoneNumberParser', phoneNumberParser);
