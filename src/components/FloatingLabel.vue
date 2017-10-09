<template>
    <div class="input__container" :class="containerClasses" :style="inputContainerStyle">
        <div class="icon clear__icon" @mousedown.stop.prevent="clear" v-if="settings.hasClearButton">
            <svg width="10px" height="11px" viewBox="3 3 10 11" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <defs></defs>
                <path id="Combined-Shape" d="M8,6.58578644 L5.17157288,3.75735931 L3.75735931,5.17157288 L6.58578644,8 L3.75735931,10.8284271 L5.17157288,12.2426407 L8,9.41421356 L10.8284271,12.2426407 L12.2426407,10.8284271 L9.41421356,8 L12.2426407,5.17157288 L10.8284271,3.75735931 L8,6.58578644 Z" stroke="none" fill="#FFFFFF" fill-rule="evenodd"></path>
            </svg>
        </div>
        <div class="accessibility__icon" :style="accessibilityStyle" v-if="settings.line"></div>
        <div class="slot-container" ref="input-container">
            <slot
                    v-model="value"
                    @focus="focus"
                    @blur="blur"
                    class="input"></slot>
        </div>
        <label class="label__placeholder" :for="labelName">{{ config.label }}</label>
        <label class="label__active" :class="activeLabelClasses" :style="activeLabelStyle" :for="labelName">{{ config.label }}</label>
    </div>
</template>

<script>
    export default {
        name: 'FloatingLabel',
        props: {
            config: {
                required: true
            }
        },
        computed: {
            activeLabelClasses() {
                return {
                    'label__active--canscale': this.settings.scale
                }
            },
            hasClearButton() {
                if (this.config.hasOwnProperty('hasClearButton')) {
                    return this.config.hasClearButton;
                }
                return false;
            },
            containerClasses() {
                let classes = {
                    'has-line': this.settings.line,
                    'input__container--focus': this.hasFocus,
                    'input__container--content': this.hasContent
                };
                if (this.settings.hasError) {
                    classes[this.settings.classes.error] = true;
                }
                return classes;
            },
            labelName() {
                if (this.config.name !== undefined) {
                    return this.config.name
                }
                return this.config.label.toLowerCase();
            },
            accessibilityStyle() {
                let color = this.settings.color.lineColor;
                if (this.settings.hasError) {
                    color = this.settings.color.errorColor;
                }
                return {
                    'background-color': color
                }
            },
            labelColor() {
                if (!this.settings.hasError) {
                    return this.hasFocus ? this.settings.color.focusColor : this.settings.color.blurredColor
                } else {
                    return this.settings.color.errorColor;
                }
            },
            activeLabelStyle() {
                return {
                    top: this.settings.labelOffset.top + 'px',
                    left: this.settings.labelOffset.left + 'px',
                    color: this.labelColor
                }
            },
            inputContainerStyle() {
                return {
                    height: this.settings.height + 'px'
                }
            },
            settings() {
                return Object.assign({}, this.defaultSettings, this.config);
            }
        },
        methods: {
            clear() {
                this.formElement.value = '';
                this.hasContent = false;
                this.hasFocus = false;
                this.$emit('clear');
            },
            focus(event) {
                this.hasFocus = true;
                this.$emit('focus');
            },
            input(event) {
                this.hasFocus = true;
                this.hasContent = event.target.value !== '';
                this.$emit('input');
            },
            blur(event) {
                this.hasFocus = false;
                this.$emit('blur');
            }
        },
        mounted() {
            this.formElement = this.$refs['input-container'].querySelector('input, select');
            if (this.formElement) {
                this.formElement.addEventListener('input', this.input);
                this.formElement.addEventListener('blur', this.blur);
                this.formElement.addEventListener('focus', this.focus);
                if (this.formElement.type === 'select-one') {
                    this.hasContent = true;
                    this.settings.scale = false;
                    this.settings.hasClearButton = false;
                }
            }
        },
        data () {
            return {
                defaultSettings: {
                    classes: {
                        error: 'has-error'
                    },
                    hasError: false,
                    height: 64,
                    hasClearButton: true,
                    line: true,
                    scale: true,
                    labelOffset: {
                        top: 10,
                        left: 8
                    },
                    color: {
                        focusColor: '#128CED',
                        lineColor: '#128CED',
                        errorColor: '#ff0000',
                        blurredColor: 'rgba(3, 23, 40, 0.34)'
                    }
                },
                hasFocus: false,
                hasContent: false
            }
        }
    }
</script>

<style scoped lang="scss">
    @import '../style/_variables.scss';
    .input__container {
        position: relative;
        padding: 0 8px;
        transition: 0.2s cubic-bezier($easeInOutCubic);
        .slot-container {
            height: 100%;
            input {
                height: 100%;
                font-size: 16px;
                padding: 0 0;
                border: 0;
                display: block;
                width: 100%;
                position: relative;
                background-color: transparent;
                transition: 0.2s cubic-bezier($easeInOutCubic);
            }
        }

        &.has-line{
            &:after, .character-counter-container:after {
                content: '';
                position: absolute;
                display: inline-block;
                top: auto;
                left: 8px;
                right: 8px;
                height: 1px;
                background-color: #E4E7E9;
                z-index: 3;
                bottom: 0;
            }
        }

        & + .input__container:before {
            display: none;
        }
        // Is Focused
        &.input__container--focus {
            .accessibility__icon {
                transform: scaleX(1);
            }
        }

        // Has content
        &.input__container--content {
            .character-counter-container {
                height: 32px;
            }
            label {
                &.label__placeholder {
                    opacity: 0;
                }
            }
            .label__active {
                opacity: 1;
                &.label__active--canscale {
                    transform: translate3d(0, 0px, 0) scale(.85);
                }
            }
            input, .label__placeholder {
                transform: translate3d(0, 6px, 0);
            }
        }

        // Has content & is focused
        &.input__container--focus.input__container--content {
            label {
                &.label__active.label__active--canscale {
                    opacity: 1;
                    transform: translate3d(0, 0px, 0);
                }
                &.label__placeholder {
                    opacity: 0;
                }

            }
            .clear__icon {
                opacity: 1;
            }
            .accessibility__icon {
                transform: scaleX(1);
            }
            .carret__icon--down svg path {
                fill: $color__chewy-blue;
            }
        }
    }
    .icon {
        opacity: 0;
        position: absolute;
        height: 24px;
        width: 24px;
        right: 16px;
        top: 50%;
        z-index: 1;
        transform: translate3d(0, -50%, 0);
    }
    .accessibility__icon {
        position: absolute;
        height: 2px;
        left: 8px;
        right: 8px;
        bottom: 0;
        z-index: 9;
        border-radius: 100px;
        background-color: $color__chewy-blue;
        transition: 0.2s cubic-bezier($easeInOutCubic);
        transform: scaleX(0);
        transform-origin: 0 0;
    }
    .clear__icon {
        cursor: pointer;
        background-color: $color__100;
        font-weight: bold;
        border-radius: 100px;
        z-index: 1;
        color: white;
        text-align: center;
        transition: 0.2s cubic-bezier($easeInOutCubic);
    }
    input {
        font-size: $font__size--s;
        color: $color__300;
        line-height: 24px;
    }
    input:focus{
        outline: none;
    }
    label {
        position: absolute;
        top: 0;
        left: 0;
        pointer-events: none;
        user-select: none;
        transition: 0.2s cubic-bezier($easeInOutCubic);

        &.label__placeholder {
            top: 50%;
            transform: translate(0, -50%);
            color: rgba(3,23,40,0.40);
            left: 8px;
        }
        &.label__active {
            font-size: $font__size--xs;
            color: $color__200;
            font-weight: $font__weight--bold;
            line-height: 16px;
            opacity: 0;
            transform: translate3d(0, 3px, 0);
            transform-origin: 0 0;
        }
        &.label__character-counter {
            font-size: $font__size--xs;
            line-height: 16px;
            color: $color__200;
            position: absolute;
            left: 0;
            bottom: -14px;
            display: inline-block;
            top: auto;
            opacity: 0;
        }
    }
</style>