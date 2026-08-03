import LightningModal from 'lightning/modal';
import { api } from 'lwc';

export default class DonorDetailModal extends LightningModal {

    @api donor;


   /* connectedCallback() {

        console.log(
            'Received donor:',
            JSON.stringify(this.donor)
        );

    }*/


    handleClose() {

        this.close();

    }

}