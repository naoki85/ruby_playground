<template>
  <div class="btn-container" @click="tweet">
    <button class="btn-twitter">Tweet</button>
  </div>
</template>

<script>
  export default {
    props: {
      text: {
        type: String,
        default: 'test'
      },
      path: {
        type: String,
        default: ''
      }
    },
    methods: {
      tweet: function() {
        var text = this.text;
        var url = "https://bookrecorder.net" + this.path;
        var redirect_url = "https://twitter.com/share";
        location.href = redirect_url + '?text=' + text + '&url=' + url;
      }
    }
  };
</script>

<style scoped>
  .btn-container {
    position: relative;
    margin: 10px 0;
  }
  .btn-twitter {
    margin: 0px;
    padding-left: 15px;
    background-color: #1da1f2;
    color: #fff;
    height: 27px;
    width: 80px;
    font-size: 16px;
  }
  .btn-twitter:before {
    content: '';
    display: block;
    position: absolute;
    top: 1px;
    left: 1px;
    width: 25px;
    height: 25px;
    background-size: 100%;
    background-image: url("../../images/logo_twitter.png");
  }
  .btn-twitter:hover {
    background-color: #1da1f2;
  }
</style>