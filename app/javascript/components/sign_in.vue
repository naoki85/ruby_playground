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
  import { mapActions } from 'vuex'
  import loading from './commons/loading'

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
        this.showLoading();
          this.login({
            router: this.$router,
            data: this.$data
          });
        this.hideLoading();
      }
    },
    mixins: [loading]
  }
</script>

<style scoped>

</style>