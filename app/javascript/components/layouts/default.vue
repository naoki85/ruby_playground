<template>
  <v-app>
    <my-header></my-header>
    <router-view></router-view>
    <my-footer></my-footer>
  </v-app>
</template>

<script>
  import Header from './header'
  import Footer from './footer'

  export default {
    components: {
      'my-header': Header,
      'my-footer': Footer,
    }
  }
</script>

<style>

</style>