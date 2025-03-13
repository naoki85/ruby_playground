<template>
  <div>
    <div v-if="isLoading" class="siimple-spinner siimple-spinner--teal loading"></div>
  </div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState('loader', [
        'isLoading'
      ])
    }
  }
</script>

<style scoped>
  .loading {
    position: fixed;
    top: 42%;
    right: 0;
    left: 0;
    margin-right: auto;
    margin-left: auto;
    z-index: 100;
  }
</style>
