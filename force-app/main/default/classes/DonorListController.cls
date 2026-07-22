/**
 * @description       : 
 * @author            : Srividhya
 * @group             : 
 * @last modified on  : 07-21-2026
 * @last modified by  : Srividhya
**/
public with sharing class DonorListController {
     @AuraEnabled(cacheable=true)
    public static List<Donor__c> getDonors() {

        return [
            SELECT Id,
                   Name,
                   Rating__c
            FROM Donor__c
            ORDER BY Name
            LIMIT 100
        ];
    }

}