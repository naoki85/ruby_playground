import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'

Vue.use(Vuex)

export default {
  state: {
    loggedIn: false
  },
  mutations: {
    login (state) {
      state.loggedIn = true
    },
    logout (state) {
      state.loggedIn = false
    }
  }
}