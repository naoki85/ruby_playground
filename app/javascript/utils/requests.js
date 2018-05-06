import axios from 'axios'

export default {
  request (method, url, params) {
    var promise = null;

    if (method === 'get') {
      promise = axios.get(url, { params: params })
    } else if (method === 'post') {
      promise = axios.post(url, params)
    }
    promise.catch(function() {
      return console.log(promise);
    });
    return promise;
  },
  get (url, params) {
    return this.request('get', url, params);
  },
  post (url, params) {
    return this.request('post', url, params);
  }
}