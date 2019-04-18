/**
 * Created by nagesingh on 2/2/2018.
 */

trigger ClosedOpportunityTrigger on Opportunity (before insert, before update, after insert, after update) {


    if (Trigger.isAfter) {
        List<Opportunity> opportunities = (List<Opportunity>) Trigger.new;
        List<Task> tasks = new List<Task>();
        Task task = null;
        for (Opportunity opportunity : opportunities) {
            task = new Task();
            if (opportunity.StageName == 'Closed Won') {
                task.Subject = 'Follow Up Test Task';
                task.WhatId = opportunity.Id;
                tasks.add(task);
            }
        }

        upsert tasks;
    }

}