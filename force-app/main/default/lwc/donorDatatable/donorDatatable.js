import { LightningElement, wire } from 'lwc';
import getDonors from '@salesforce/apex/DonorListController.getDonors';

const COLUMNS = [
    {
        label: 'Donor Name',
        fieldName: 'Name',
        type: 'text'
    },
    {
        label: 'Rating',
        fieldName: 'Rating__c',
        type: 'text'
    }
];

export default class DonorDatatable extends LightningElement {

    columns = COLUMNS;
    donors;
    error;

    @wire(getDonors)
    wiredDonors({ error, data }) {
        if (data) {
            this.donors = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.donors = undefined;
        }
    }
}