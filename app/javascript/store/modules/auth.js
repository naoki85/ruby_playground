export default {
  namespaced: true,
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
  },
  actions: {
    login ({ commit }, payload) {
      // ログイン後、リダイレクト
      commit('login');
      payload.router.push('/');
    }
  }
}