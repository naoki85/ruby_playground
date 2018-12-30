<template>
  <div>
    <h3 class="siimple-h3">最近読んだ本</h3>
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <div v-for="book in recommendBooks"
             class="siimple-grid-col siimple-grid-col--2 siimple-grid-col--md-3 recommend-book">
          <a target="_blank"
             :href="book.url">
            <img border="0" :src="book.image_url">
          </a>
          <img :src="book.button_url"
               width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      recommendBooks:  {
        type: Array,
        default: []
      }
    // },
    // data: function() {
    //   return {
    //     recommendBooks: [
    //       {
    //         bookLink: 'https://www.amazon.co.jp/gp/product/4797382228/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=4797382228&linkCode=as2&tag=naoki850c-22&linkId=91c6e0d453dff73ccb50e49212dd97fd',
    //         bookImg: '//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=4797382228&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=naoki850c-22',
    //         btnImg: '//ir-jp.amazon-adsystem.com/e/ir?t=naoki850c-22&l=am2&o=9&a=4797382228'
    //       },
    //       {
    //         bookLink: 'https://www.amazon.co.jp/gp/product/4873118042/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=4873118042&linkCode=as2&tag=naoki850c-22&linkId=2f0832d512b94dbffb202cba2ca930e7',
    //         bookImg: '//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=4873118042&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=naoki850c-22',
    //         btnImg: '//ir-jp.amazon-adsystem.com/e/ir?t=naoki850c-22&l=am2&o=9&a=4873118042'
    //       },
    //       {
    //         bookLink: 'https://www.amazon.co.jp/gp/product/4309227376/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=4309227376&linkCode=as2&tag=naoki850c-22&linkId=d801e11b267caf76121dc311db594779',
    //         bookImg: '//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=4309227376&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=naoki850c-22',
    //         btnImg: '//ir-jp.amazon-adsystem.com/e/ir?t=naoki850c-22&l=am2&o=9&a=4309227376'
    //       },
    //       {
    //         bookLink: 'https://www.amazon.co.jp/gp/product/4094065369/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=4094065369&linkCode=as2&tag=naoki850c-22&linkId=f91ee3c1bbbdaf66b9e4152e615451d6',
    //         bookImg: '//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=4094065369&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=naoki850c-22',
    //         btnImg: '//ir-jp.amazon-adsystem.com/e/ir?t=naoki850c-22&l=am2&o=9&a=4094065369'
    //       }
    //     ]
    //   }
    }
  }

</script>

<style scoped>
  .recommend-book img {
    width: 100%;
  }
</style>