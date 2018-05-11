import axios from 'axios'

export default {
  request (method, url, options) {
    var promise = null;
    var params = {};
    var headers = {};
    if (options.params) {
      params = options.params;
    }
    if (options.headers) {
      headers = options.headers;
    }
    if (options.auth) {
      var authenticateToken = localStorage.getItem('bookRecorderAuthenticationToken');
      var authorization_header = { Authorization: authenticateToken }
      headers = Object.assign(headers, authorization_header);
    }

    promise = axios({
      method: method,
      url: url,
      data: params,
      headers: headers
    });
    promise.catch(function() {
      return console.log(promise);
    });
    return promise;
  },
  get (url, options) {
    return this.request('get', url, options);
  },
  post (url, options) {
    return this.request('post', url, options);
  },
  patch (url, options) {
    return this.request('patch', url, options);
  },
  delete (url, options) {
    return this.request('delete', url, options);
  }
}