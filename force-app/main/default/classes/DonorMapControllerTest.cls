/**
 * @description       : 
 * @author            : Srividhya
 * @group             : 
 * @last modified on  : 07-29-2026
 * @last modified by  : Srividhya
**/
@isTest
private class DonorMapControllerTest {
    @testSetup
    static void createTestData() {

         List<Donor__c> donors = new List<Donor__c>();

    donors.add(new Donor__c(
        Name = 'Donor 1',
        City__c = 'Chennai',
        Street__c = 'Anna Salai',
        State__c = 'Tamil Nadu',
        Pincode__c = '600001',
        Email__c = 'donor1@test.com',
        Phone__c = '9876543210',
        Donor_Type__c = 'Individual',
        Status__c = 'Active'
    ));


    donors.add(new Donor__c(
        Name = 'Donor 2',
        City__c = 'Chennai',
        Street__c = 'T Nagar',
        State__c = 'Tamil Nadu',
        Pincode__c = '600017',
        Email__c = 'donor2@test.com',
        Phone__c = '9876543211',
        Donor_Type__c = 'Individual',
        Status__c = 'Active'
    ));


    donors.add(new Donor__c(
        Name = 'Donor 3',
        City__c = 'Bangalore',
        Street__c = 'MG Road',
        State__c = 'Karnataka',
        Pincode__c = '560001',
        Email__c = 'donor3@test.com',
        Phone__c = '9876543212',
        Donor_Type__c = 'Organization',
        Status__c = 'Active'
    ));

        insert donors;
    }

    @isTest
    static void testGetUniqueCities() {

        Test.startTest();

        List<String> cities = DonorMapController.getUniqueCities();

        Test.stopTest();

        System.assertNotEquals(null, cities);
        System.assertEquals(2, cities.size());

        System.assert(cities.contains('Bangalore'));
        System.assert(cities.contains('Chennai'));
    }

    @isTest
    static void testGetDonorsByCity() {

        Test.startTest();

        List<Donor__c> donors =
            DonorMapController.getDonorsByCity('Chennai');

        Test.stopTest();

        System.assertEquals(2, donors.size());

        for(Donor__c donor : donors) {
            System.assertEquals('Chennai', donor.City__c);
        }

    }

}