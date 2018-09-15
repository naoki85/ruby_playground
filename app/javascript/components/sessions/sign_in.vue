<template>
  <v-container fluid>
    <div class="display-1">ログイン</div>
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
          @click="onLogin"
      >
        ログイン
      </v-btn>
    </v-form>
  </v-container>
</template>

<script>
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
          v => !!v || 'Password は必須です'
        ],
        isError: false
      }
    },
    methods: {
      ...mapActions('auth', [
        'login'
      ]),
      ...mapActions('loader', [
        'loading', 'finish'
      ]),
      ...mapActions('alert', [
        'showSuccessAlert', 'showErrorAlert'
      ]),
      onLogin: function () {
        this.loading();
        this.login({
          router: this.$router,
          data: this.$data
        });
        this.finish();
      }
    }
  }
</script>

<style scoped>

</style>