export default {
  namespaced: true,
  state: {
    isError: false,
    isSuccess: false,
    errorMessage: '',
    successMessage: ''
  },
  mutations: {
    success(state, message) {
      state.isError = false;
      state.isSuccess = true;
      state.successMessage = message;
    },
    error(state, message) {
      state.isError = true;
      state.isSuccess = false;
      state.errorMessage = message;
    }
  },
  actions: {
    showSuccessAlert({ commit }, payload) {
      commit('success', payload.message);
    },
    showErrorAlert({ commit }, payload) {
      commit('error', payload.message);
    }
  }
}