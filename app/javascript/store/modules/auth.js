import request from '../../utils/requests'

export default {
  namespaced: true,
  state: {
    loggedIn: false,
    userId: null
  },
  mutations: {
    login(state, user) {
      localStorage.setItem('bookRecorderAuthenticationToken', user.authentication_token);
      localStorage.setItem('bookRecorderUserId', user.id);
      state.loggedIn = true;
      state.userId = user.id;
    },
    logout(state) {
      localStorage.removeItem('bookRecorderAuthenticationToken');
      localStorage.removeItem('bookRecorderUserId');
      state.loggedIn = false;
      state.userId = null;
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
      request.post('/v1/login', options).then((response) => {
        commit('login', response.data.user);
        payload.router.push('/');
      }, (error) => {
        payload.data.isError = true;
      });
    },
    logout({ commit }, payload) {
      request.delete('/v1/logout', { auth: true }).then((response) => {
        commit('logout');
        location.href = '/';
      });
    }
  }
}