import { LightningElement,wire } from 'lwc';
import DonorDetailModal from 'c/donorDetailModal';
import getUniqueCities 
from '@salesforce/apex/DonorMapController.getUniqueCities';
import getDonorsByCity 
from '@salesforce/apex/DonorMapController.getDonorsByCity';
export default class LightningMapDemo extends LightningElement {

    // Stores the selected city
    selectedCity;

    // Stores combobox options
    cityOptions = [];

    donors = [];

    columns = [
        { label: 'Donor Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email__c' },
        { label: 'Phone', fieldName: 'Phone__c' },
        { label: 'Street', fieldName: 'Street__c' },
        { label: 'City', fieldName: 'City__c' },
        { label: 'State', fieldName: 'State__c' },
        { label: 'Pincode', fieldName: 'Pincode__c' }
    ];
    mapMarkers = [];

    // Calls Apex automatically when the component loads
    @wire(getUniqueCities)
    wiredCities({ data, error }) {

        if (data) {

            // Convert List<String> into combobox options
            this.cityOptions = data.map(city => {
                return {
                    label: city,
                    value: city
                };
            });

        } else if (error) {

            console.error('Error fetching cities:', error);

        }
    }
    // Runs when a city is selected
    handleCityChange(event) {
        this.selectedCity = event.detail.value;
        getDonorsByCity({ city: this.selectedCity })
            .then(result => {
                //display donors in datatable
                this.donors = result;
                // Display on map
            this.mapMarkers = result.map(donor => {
                return {
                     value: donor.Id, // added value property to identify the marker, for Modal
                    location: {
                        Street: donor.Street__c,
                        City: donor.City__c,
                        State: donor.State__c,
                        PostalCode: donor.Pincode__c,
                    },
                    title: donor.Name,
                    description:
                        'Email: ' + donor.Email__c +
                        '\nPhone: ' + donor.Phone__c
                };
            });

        })
            .catch(error => {

                console.error(error);

            });

    }

    async handleMarkerSelect(event) {

    const donorId = event.detail.selectedMarkerValue;

    const donor = this.donors.find(
        d => d.Id === donorId
    );

    await DonorDetailModal.open({

        size: 'medium',

        donor: donor

    });

}
     
}