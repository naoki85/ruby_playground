import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import User from '../components/user.vue'
import Router from '../router/router.js'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    router: Router,
    components: {
      'user': User
    }
  }).$mount('#app')
})
