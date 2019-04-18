public with sharing class testExtension {

  public Account acc{get;set;}
  public testExtension(ApexPages.StandardController controller) {

    acc = (Account)controller.getRecord();
    acc = [Select Name from Account where id =: acc.Id];
  }

  public PageReference save(){
    acc.Phone = '123';
    update acc;
    return new Pagereference('/'+acc.Id);
  }

}