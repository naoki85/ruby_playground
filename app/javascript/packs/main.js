import Vue from 'vue/dist/vue.esm'
import router from '../router/router'
import store from '../store/store'
import loader from '../components/commons/loading'
import previewTextarea from '../components/posts/_preview_textarea'

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#app',
    components: {
      'my-loader': loader,
      'preview-textarea': previewTextarea
    },
    router,
    store
  })
});