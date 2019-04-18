/**
 * Created by nagesingh on 2/2/2018.
 */

global class LeadProcessor implements Database.Batchable<SObject>{


    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String queryStr = 'SELECT Id, LeadSource FROM Lead';

        return Database.getQueryLocator(queryStr);
    }

    global void execute(Database.BatchableContext bc, List<SObject> records){

        List<Lead> leads = new List<Lead>();
        for (SObject sobj: records){
            Lead lead = (Lead)sobj;
            lead.LeadSource = 'Dreamforce';
            leads.add(lead);
        }

        update leads;
    }

    global void finish(Database.BatchableContext bc){

    }
}