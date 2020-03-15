/**
 * Created by nagesingh on 7/31/2018.
 */

public class DataToServerController {

    @AuraEnabled
    public static void createStudent(Student__c student) {
        try {
            insert student;
        } catch (Exception e) {
            System.debug(e);
        }
    }

}