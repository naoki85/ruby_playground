<template>
  <div class="container">
    <h2>ログイン</h2>
    <p v-if="isError" class="alert alert-danger">ログインに失敗しました。</p>
    <div class="row">
      <div class="input-field">
        <label for="email">メール</label>
        <input type="email" autofocus="true" autocomplete="email" class="validate" v-model="email">
      </div>
    </div>
    <div class="row">
      <div class="input-field">
        <label for="password">パスワード</label>
        <input type="password" autocomplete="off" class="validate" v-model="password">
      </div>
    </div>
    <div class="row">
      <input type="button" value="ログイン" @click="onLogin" class="waves-effect waves-teal btn">
    </div>
  </div>
</template>

<script>
  import request from '../utils/requests'
  import { mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        email: null,
        password: null,
        isError: false
      }
    },
    methods: {
      ...mapActions('auth', [
        'login'
      ]),
      onLogin: function () {
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
        var options = {
          params: {
            email: this.email,
            password: this.password
          }
        };
        request.post('/v1/login', options).then((response) => {
          console.log(response.data.user);
          localStorage.setItem('bookRecorderAuthenticationToken', response.data.user.authentication_token);
          var self = this;
          document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
          self.login({
            router: self.$router
          });
        }, (error) => {
          console.log(error);
          document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
          this.isError = true;
        });
      }
    }
  }
</script>

<style scoped>

</style>