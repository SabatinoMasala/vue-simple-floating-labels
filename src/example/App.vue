<template>
    <div id="app">
        <div class="container">
            <div class="section section--xl">
                <h3 class="text--center">Simple Floating Labels Vue</h3>
            </div>
            <div class="section section--xl">
                <form action="#">
                    <div class="row">
                        <FloatingLabel
                                :config="{label: 'Default'}">
                            <input name="default" type="text">
                        </FloatingLabel>
                    </div>
                    <div class="row">
                        <FloatingLabel
                                :config="{label: 'Custom color', name: 'custom-color', color: {focusColor: '#ff00ff', lineColor: '#ff00ff'}, hasClearButton: false}">
                            <input name="custom-color" type="text">
                        </FloatingLabel>
                    </div>
                    <div class="row" style="margin: 10px;">
                        <CustomFloatingLabel :config="{label: 'Wrapper Component', name: 'wrapper', line: false, scale: false}">
                            <input name="wrapper" type="text">
                        </CustomFloatingLabel>
                    </div>
                    <div class="row" style="margin: 10px;">
                        <CustomFloatingLabel :config="{label: 'Error example', name: 'error', line: false, scale: false, height: 50, labelOffset: {top: 3, left: 8}, classes: {error: 'has-error'}, hasError: hasError, hasClearButton: false}">
                            <input name="error" type="text" v-model="value">
                        </CustomFloatingLabel>
                        <small v-if="hasError" style="color: #f00; font-weight: bold">This field contains an error.</small>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<script>
    import FloatingLabel from '../components/FloatingLabel'
    import CustomFloatingLabel from './CustomFloatingLabel'
    export default {
        components: {
            CustomFloatingLabel,
            FloatingLabel
        },
        computed: {
            hasError() {
                return this.value !== '';
            }
        },
        data() {
            return {
                value: ''
            }
        }
    }
</script>

<style lang="scss">

    @import '../style/variables';

    body {
        font-family: SFUIText-Regular;
        font-family: -apple-system, BlinkMacSystemFont, sans-serif;
        font-size: $font__size--s;
        color: $color__300;
        line-height: 24px;
        margin: 0;
        background-color: $color__50;
    }
    * {
        box-sizing: border-box;
    }

    .container {
        max-width: 375px;
        margin: $margin--xl auto;
        min-height: 100%;
        overflow: scroll;
        box-shadow: 0 1px 0 0 rgba(3,23,40,0.12), 0 1px 2px 0 rgba(3,23,40,0.10), 0 2px 4px 0 rgba(3,23,40,0.03), 0 2px 8px 0 rgba(3,23,40,0.07);
        background-color: #FCFCFC;
    }
    h1, h2, h3, h4, h5, h6, p {
        // margin-top: 0;
        margin: 0;
    }
    h1, h2, h3 {
        color: $color__500;
    }
    h4, h5, h6 {
        color: $color__400;
    }
    h1 {
        font-size: $font__size--xxl;
        line-height: 40px;
        margin-bottom: $margin--s;
        font-weight: $font__weight--light;
    }
    h2 {
        font-size: $font__size--xl;
        line-height: 32px;
        margin-bottom: $margin--s;
        font-weight: $font__weight--extra-bold;
    }
    h3 {
        font-size: $font__size--l;
        line-height: 24px;
        margin-bottom: $margin--xs;
        font-weight: $font__weight--bold;
    }
    h4 {
        font-size: $font__size--m;
        line-height: 24px;
        margin-bottom: $margin--xs;
    }
    h5 {
        font-size: $font__size--s;
        line-height: 24px;
        margin-bottom: $margin--xs;
    }
    h6 {
        font-size: $font__size--xs;
        line-height: 16px;
        margin-bottom: $margin--xs;
    }
    p + p {
        margin-top: $margin--s;
    }

    .text__callout {
        font-weight: $font__weight--bold;
    }
    .text--blue {
        color: $color__chewy-blue;
    }
    .text--red {
        color: $color__price;
    }
    .text--muted {
        color: $color__200;
    }
    .text--small {
        font-size: $font__size--xs;
    }
    .text--extra-small {
        font-size: $font__size--xxs;
        text-transform: uppercase;
    }
    .text--center {
        text-align: center;
    }
    .text--right {
        text-align: right;
    }
    .text--invert {
        color: #fff;
    }

    h1 + p, h2 + p {
        margin-top: $margin--s;
    }
    h3 + p,h4 + p,h5 + p, h6 + p {
        margin-top: $margin--xs;
    }

    .section--xxl {
        margin-top: $margin--xxl;
        // margin-bottom: $margin--xxl;
    }
    .section--xl {
        margin-top: $margin--xl;
        // margin-bottom: $margin--xl;
    }
    .section--l {
        margin-top: $margin--l;
        // margin-bottom: $margin--l;
    }
    .section--m {
        margin-top: $margin--m;
        // margin-bottom: $margin--m;
    }
    .section--s {
        margin-top: $margin--s;
        // margin-bottom: $margin--s;
    }

    form {
        background-color: #fff;
        box-shadow: 0 -2px 4px 0 rgba(3,23,40,0.02), 0 2px 4px 0 rgba(3,23,40,0.02);
        display: inline-block;
        width: 100%;
        position: relative;

        &:after, &:before {
            content: '';
            position: absolute;
            display: inline-block;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background-color: #E4E7E9;
            z-index: 3;
        }
        &:after {;
            bottom: 0;
            top: auto;
        }
    }
    .row {
        padding: 0 8px;
    }
    .note {
        color: $color__200;
        font-size: $font__size--xs;
        text-align: center;
    }
    .container > :last-child {
        margin-bottom: $margin--l;
    }
</style>