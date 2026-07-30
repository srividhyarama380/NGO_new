/**
 * @description       : 
 * @author            : Srividhya
 * @group             : 
 * @last modified on  : 07-29-2026
 * @last modified by  : Srividhya
**/
public with sharing class DonorMapController {
    @AuraEnabled(cacheable=true)
    public static List<String> getUniqueCities() {

        List<String> cityList = new List<String>();

        AggregateResult[] results = [
            SELECT City__c city
            FROM Donor__c
            WHERE City__c != null
            GROUP BY City__c
            ORDER BY City__c
        ];

        for(AggregateResult ar : results) {
            cityList.add((String)ar.get('city'));
        }

        return cityList;
    }

     @AuraEnabled(cacheable=true)
    public static List<Donor__c> getDonorsByCity(String city) {


        return [
            SELECT Id,
                   Name,
                   Email__c,
                   Phone__c,
                   Street__c,
                   City__c,
                   State__c,
                   Pincode__c
            FROM Donor__c
            WHERE City__c = :city
        ];

    }
}