import Vue from 'vue/dist/vue.esm'
import router from '../router/router'
import store from '../store/store'
import Loader from '../components/commons/loading'

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    components: {
      'my-loader': Loader
    },
    router,
    store
  })
});