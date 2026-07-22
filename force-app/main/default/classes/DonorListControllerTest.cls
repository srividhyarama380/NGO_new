/**
 * @description       : 
 * @author            : Srividhya
 * @group             : 
 * @last modified on  : 07-22-2026
 * @last modified by  : Srividhya
**/
@isTest
private class DonorListControllerTest {

    @isTest
    static void testGetDonors() {

        // Create test donor records
        List<Donor__c> donors = new List<Donor__c>();

        donors.add(new Donor__c(
            Name = 'John Smith',
            Email__c = 'john.smith@test.com',
            Status__c = 'Active',
            Donor_Type__c = 'Individual',
            Phone__c = '1234567890'
        ));

        donors.add(new Donor__c(
            Name = 'Sarah Johnson',
            Email__c = 'sarah.johnson@test.com',
            Status__c = 'Active',
            Donor_Type__c = 'Organization',
            Phone__c = '9987654321'
        ));

        // Insert test records
        insert donors;


        // Test Apex method
        Test.startTest();

        List<Donor__c> result = DonorListController.getDonors();

        Test.stopTest();


        // Verify results
        System.assertEquals(2, result.size());

        System.assertEquals('John Smith', result[0].Name);
        System.assertEquals('Sarah Johnson', result[1].Name);
    }
}