<template>
  <div>
    <v-alert :value="isError" outline color="error" icon="warning">
      {{ errorMessage }}
    </v-alert>
    <v-alert :value="isSuccess" outline color="success" icon="check_circle">
      {{ successMessage }}
    </v-alert>
  </div>
</template>

<script>
  import { mapState } from 'vuex'

  export default {
    computed: {
      ...mapState('alert', [
        'isError', 'isSuccess', 'errorMessage', 'successMessage'
      ])
    }
  }
</script>

<style scoped>

</style>
