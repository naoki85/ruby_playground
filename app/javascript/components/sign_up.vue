<template>
  <div class="container">
    <h2>新規登録</h2>
    <p v-if="isError" class="alert alert-danger">登録に失敗しました。登録内容を確認してください。</p>
    <p v-if="isSuccess" class="alert alert-success">登録が完了しました。</p>
    <div class="row">
      <label for="email">メール</label>
      <input type="email" autofocus="true" autocomplete="email" class="validate" v-model="email">
    </div>
    <div class="row">
      パスワードは最低6文字必要です。
    </div>
    <div class="row">
      <label for="password">パスワード</label>
      <input type="password" autocomplete="off" class="validate" v-model="password">
    </div>
    <div class="row">
      <input type="button" value="登録" @click="onCreate" class="waves-effect waves-teal btn">
    </div>
  </div>
</template>

<script>
  import request from '../utils/requests'
  import loading from './commons/loading'

  export default {
    data: function() {
      return {
        email: null,
        password: null,
        isError: false,
        isSuccess: false
      }
    },
    methods: {
      onCreate: function () {
        this.showLoading();
        this.isSuccess = false;
        this.isError = false;
        var options = {
          params: {
            user: {
              email: this.email,
              password: this.password
            }
          }
        };
        request.post('/v1/users', options).then((response) => {
          this.isSuccess = true;
          this.email = null;
          this.password = null;
        }, (error) => {
          this.isError = true;
        });
        this.hideLoading();
      }
    },
    mixins: [loading]
  }
</script>

<style scoped>

</style>