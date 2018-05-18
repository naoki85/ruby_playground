export default {
  namespaced: true,
  state: {
    isLoading: false
  },
  mutations: {
    setLoader(state) {
      state.isLoading = true;
    },
    hideLoader(state) {
      state.isLoading = false;
    }
  },
  actions: {
    loading({ commit }) {
      commit('setLoader');
    },
    finish({ commit }) {
      commit('hideLoader');
    }
  }
}