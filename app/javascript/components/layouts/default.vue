<template>
  <v-app>
    <my-header></my-header>
    <v-content>
      <my-alert></my-alert>
      <router-view></router-view>
    </v-content>
    <my-footer></my-footer>
    <my-loader></my-loader>
  </v-app>
</template>

<script>
  import Header from './header'
  import Footer from './footer'
  import Alert from '../commons/alert'
  import Loader from '../commons/loading'

  export default {
    components: {
      'my-alert': Alert,
      'my-header': Header,
      'my-footer': Footer,
      'my-loader': Loader
    }
  }
</script>

<style>

</style>