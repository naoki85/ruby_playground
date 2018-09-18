import Vue from 'vue/dist/vue.esm'
import router from '../router/router'
import store from '../store/store'
import Vuetify from 'vuetify'
Vue.use(Vuetify);
import colors from 'vuetify/es5/util/colors'
Vue.use(Vuetify, {
  theme: {
    primary: colors.teal.base,
    secondary: colors.red.lighten4,
    accent: colors.indigo.base
  }
})

// import 'vuetify/dist/vuetify.css'

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    router,
    store
  })
});