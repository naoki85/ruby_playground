import Vue from 'vue/dist/vue.esm'
import router from '../router/router'
import store from '../store/store'
import Footer from '../components/footer'
import Header from '../components/header'

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    router,
    store,
    components: {
      'app-header': Header,
      'app-footer': Footer
    }
  })
});