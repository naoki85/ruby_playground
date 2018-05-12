import request from '../../utils/requests'

export default {
  namespaced: true,
  state: {
    loggedIn: false
  },
  mutations: {
    login (state, authenticationToken) {
      localStorage.setItem('bookRecorderAuthenticationToken', authenticationToken);
      state.loggedIn = true
    },
    logout (state) {
      state.loggedIn = false
    }
  },
  actions: {
    login ({ commit }, payload) {
      var options = {
        params: {
          email: payload.data.email,
          password: payload.data.password
        }
      };
      console.log(payload);
      request.post('/v1/login', options).then((response) => {
        commit('login', response.data.user.authentication_token);
        payload.router.push('/');
      }, (error) => {
        payload.data.isError = true;
      });
    }
  }
}