import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'
import loader from './modules/loader'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    loader
  }
})
