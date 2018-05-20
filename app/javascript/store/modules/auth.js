import request from '../../utils/requests'
import Alert from './alert'

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
        Alert.state.isSuccess = true;
        Alert.state.isError = false;
        Alert.state.successMessage = 'ログインしました';
        payload.router.push('/');
      }, (error) => {
        Alert.state.isSuccess = false;
        Alert.state.isError = true;
        Alert.state.errorMessage = 'ログインに失敗しました';
      });
    },
    logout({ commit }, payload) {
      request.delete('/v1/logout', { auth: true }).then((response) => {
        commit('logout');
        location.href = '/';
      }, (error) => {
        commit('logout');
        location.href = '/';
      });
      Alert.state.isSuccess = true;
      Alert.state.successMessage = 'ログアウトしました';
    }
  }
}