public with sharing class myController {
    public String variable { get; set; }
    public List<Account> accList { get; set; }


    public void searchRecords() {
        accList = [Select Id, Name from Account where Name = :variable];

    }
}