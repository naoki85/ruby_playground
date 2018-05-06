import Vue from 'vue/dist/vue.esm'
import Top from '../components/top.vue'
import store from '../store/store.js'
import TurbolinksAdapter from 'vue-turbolinks'

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',
    store,
    components: {
      'top': Top
    }
  })
});
