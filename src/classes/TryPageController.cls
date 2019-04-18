/**
 * Description of the TryPageController.
 * <p /><p />
 * @author Nagendra Kumar Singh
 */
public with sharing class TryPageController {

    public List<String> strings {get; set;}
    public Integer counterInteger {get; set;}
    public TryPageController(ApexPages.StandardController controller){

    }
    public void showSection(){
        strings = new List<String>();
        strings.add('Status');
        strings.add('SubStatus__c');
        if(counterInteger == null){
            counterInteger = 0;
        } else {
            counterInteger++;
        }

    }



}