<script>
  export default {
    methods: {
      showLoading: function() {
        document.getElementsByClassName('turbolinks-loading')[0].classList.add('active');
      },
      hideLoading: function() {
        document.getElementsByClassName('turbolinks-loading')[0].classList.remove('active');
      }
    }
  }
</script>
