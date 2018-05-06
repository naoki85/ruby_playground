import Vue from 'vue/dist/vue.esm'
import router from '../router/router'
import store from '../store/store'

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    router,
    store
  })
});