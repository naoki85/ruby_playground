<template>
  <div class="btn-container" @click="bookmark">
    <button class="btn-hatebu">ブックマーク</button>
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
      bookmark: function() {
        var text = this.text;
        var url = "https://bookrecorder.net" + this.path;
        var redirect_url = "http://b.hatena.ne.jp/add?mode=confirm";
        location.href = redirect_url + '&title=' + encodeURIComponent(text) + '&url=' + encodeURIComponent(url);
      }
    }
  };
</script>

<style scoped>
  .btn-container {
    position: relative;
    margin: 10px 0;
    display: inline-block;
  }
  .btn-hatebu {
    margin: 0px;
    padding-left: 20px;
    background-color: rgb(0, 164, 222);
    color: #fff;
    height: 27px;
    width: 120px;
    font-size: 14px;
    font-weight: 700;
    border-radius: 3px;
  }
  .btn-hatebu:before {
    content: '';
    display: block;
    position: absolute;
    top: 1px;
    left: 1px;
    width: 25px;
    height: 25px;
    background-size: 100%;
    background-image: url("../../images/hatenabookmark-logomark.svg");
  }
  .btn-hatebu:hover {
    background-color: #0091c5;
  }
</style>