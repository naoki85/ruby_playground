import Vue from 'vue/dist/vue.esm'
import store from '../store/store.js'
import User from '../components/user.vue'
import router from '../router/router.js'
import TurbolinksAdapter from 'vue-turbolinks'

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    router,
    store,
    components: {
      'user': User
    }
  }).$mount('#app')
});
