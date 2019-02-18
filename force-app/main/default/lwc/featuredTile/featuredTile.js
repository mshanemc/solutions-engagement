import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class FeaturedTile extends NavigationMixin(LightningElement) {

    @api colorHex = '6567A5';
    @api textColor = 'FFFFFF';
    @api title = 'Test Title';
    @api icon = 'utility:attach';
    @api iconVariant;
    @api buttonText = 'Get Started';
    @api buttonVariant = 'neutral';
    @api buttonUrl = 'https://www.salesforce.com';

    get mainStyle() {
        return `background-color:${this.colorHex};color:${this.textColor};`;
    }

    nav(){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: this.buttonUrl
            }
        },
        {
            replace: true
        });
    }
}