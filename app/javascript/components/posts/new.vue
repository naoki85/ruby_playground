<template>
  <v-container fluid>
    <div class="display-1">新規作成</div>

    <v-post-form :editFlag=false></v-post-form>
  </v-container>
</template>

<script>
  import PostForm from './form';

  export default {
    components: {
      'v-post-form': PostForm,
    }
  }
</script>

<style>

</style>