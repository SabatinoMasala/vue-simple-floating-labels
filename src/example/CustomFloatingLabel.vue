<template>
    <div class="my-custom-floating-label">
        <FloatingLabel
                @focus="focus = true"
                @blur="focus = false"
                :config="config">
            <slot></slot>
        </FloatingLabel>
    </div>
</template>

<script>
    import FloatingLabel from '../components/FloatingLabel'
    export default {
        props: ['config'],
        components: {
            FloatingLabel
        }
    }
</script>
<style lang="scss">
    .my-custom-floating-label {
        .input__container {
            .slot-container {
                position: relative;
            }
            border-radius: 4px;
            box-shadow: 0 0 0 1px #d9d9d9;
            &.input__container--focus {
                box-shadow: 0 0 0 2px #222;
            }
        }
    }
</style>