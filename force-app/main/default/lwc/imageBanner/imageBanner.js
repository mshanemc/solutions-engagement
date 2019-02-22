import { LightningElement, api } from 'lwc';

export default class ImageBanner extends LightningElement {
    @api headline ='Headline';
    @api subhead;
    @api backgroundImage;
    @api backgroundColor = 'white';
    @api maxHeight = '150px;'
    @api minHeight = '150px;'
    @api textColor;

    get mainStyle() {
        return `background-color:${this.backgroundColor};background-image:url(${this.backgroundImage}); max-height:${this.maxHeight};min-height:${this.minHeight};color:${this.textColor}`;
    }
}