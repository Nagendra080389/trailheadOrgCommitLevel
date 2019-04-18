public with sharing class NewCaseListController {

  public List<Case> recordList{get;set;}

  public List<Case> getNewCases(){

    recordList = [Select CaseNumber from Case where status='New'];
    return recordList;
  }

}