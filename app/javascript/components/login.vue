<template>
  <div>
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
      <input type="button" value="LOGIN" @click="onLogin" class="waves-effect waves-teal btn">
    </div>
  </div>
</template>

<script>
  import axios from 'axios'

  export default {
    data: function() {
      return {
        email: null,
        password: null,
        isError: false
      }
    },
    methods: {
      onLogin: function () {
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
        var params = {
          email: this.email,
          password: this.password
        };
        axios.post('/v1/login', params).then((response) => {
          console.log(response.data.user);
          localStorage.setItem('bookRecorderAccessToken', response.data.user.authentication_token);
          this.login;
          document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
          location.href = '/';
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