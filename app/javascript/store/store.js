import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'
import alert from './modules/alert'
import auth from './modules/auth'
import loader from './modules/loader'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    auth, loader, alert
  }
})
