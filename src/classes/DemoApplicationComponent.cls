/**
 * Created by nagesingh on 7/30/2018.
 */

public class DemoApplicationComponent {

    @AuraEnabled
    public static Opportunity getOpportunity() {
        Opportunity opportunity = null;
        try {
            System.debug('Get Opportunity Called');
            opportunity = [SELECT Id, Name FROM Opportunity LIMIT 1];


        } catch (Exception ex) {

        }

        return opportunity;

    }
}