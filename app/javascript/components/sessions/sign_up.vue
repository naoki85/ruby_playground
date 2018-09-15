<template>
  <v-container fluid>
    <div class="display-1">新規登録</div>
    <v-form v-model="valid">
      <v-text-field
          v-model="email"
          :rules="emailRules"
          label="Email"
          required
      ></v-text-field>
      <v-text-field
          v-model="password"
          type="password"
          :rules="passwordRules"
          label="Password"
          required
      ></v-text-field>
      <v-btn
          :disabled="!valid"
          @click="onCreate"
      >
        登録
      </v-btn>
    </v-form>
  </v-container>
</template>

<script>
  import request from '../../utils/requests'
  import { mapActions } from 'vuex'

  export default {
    data: function() {
      return {
        valid: false,
        email: '',
        emailRules: [
          v => !!v || 'E-mail は必須です',
          v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || '無効な E-mail です'
        ],
        password: '',
        passwordRules: [
          v => !!v || 'Password は必須です',
          v => v && v.length >= 6 || 'Password は 6 文字以上で入力してください'
        ]
      }
    },
    methods: {
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      onCreate: function () {
        this.loading();
        var options = {
          params: {
            user: {
              email: this.email,
              password: this.password
            }
          }
        };
        request.post('/v1/users', options).then((response) => {
          this.email = null;
          this.password = null;
          this.showErrorAlert({
            message: '登録が完了しました'
          });
        }, (error) => {
          this.showErrorAlert({
            message: '登録に失敗しました。登録内容を確認してください'
          });
        });
        this.finish();
      }
    }
  }
</script>

<style scoped>

</style>