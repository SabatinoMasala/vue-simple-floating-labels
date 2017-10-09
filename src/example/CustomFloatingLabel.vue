<template>
    <FloatingLabel
            @focus="focus = true"
            @blur="focus = false"
            :config="config">
        <slot></slot>
    </FloatingLabel>
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
<style lang="scss" scoped>
    .input__container {
        border-radius: 4px;
        box-shadow: 0 0 0 1px #d9d9d9;
        &.input__container--focus {
            box-shadow: 0 0 0 2px #222;
        }
    }
</style>