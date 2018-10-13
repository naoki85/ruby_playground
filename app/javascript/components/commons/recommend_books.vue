<template>
  <div>
    <h3 class="siimple-h3">最近読んだ本</h3>
    <div class="siimple-grid">
      <div class="siimple-grid-row">
        <div v-for="book in recommendBooks"
             class="siimple-grid-col siimple-grid-col--2 siimple-grid-col--md-3 recommend-book">
          <a target="_blank"
             :href="book.bookLink">
            <img border="0" :src="book.bookImg">
          </a>
          <img :src="book.btnImg"
               width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data: function() {
      return {
        recommendBooks: [
          {
            bookLink: 'https://www.amazon.co.jp/gp/product/4309227368/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=4309227368&linkCode=as2&tag=naoki850c-22&linkId=13df1c7f982d28530f989515303aab97',
            bookImg: '//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=4309227368&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=naoki850c-22',
            btnImg: '//ir-jp.amazon-adsystem.com/e/ir?t=naoki850c-22&l=am2&o=9&a=4309227368'
          },
          {
            bookLink: 'https://www.amazon.co.jp/gp/product/4087452069/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=4087452069&linkCode=as2&tag=naoki850c-22&linkId=4ccd2e215aacc9dffdbc0e23cbd40c63',
            bookImg: '//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=4087452069&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=naoki850c-22',
            btnImg: '//ir-jp.amazon-adsystem.com/e/ir?t=naoki850c-22&l=am2&o=9&a=4087452069'
          },
          {
            bookLink: 'https://www.amazon.co.jp/gp/product/4344427300/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=4344427300&linkCode=as2&tag=naoki850c-22&linkId=c3f75af775a105efeff1eea95c354eb4',
            bookImg: '//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=4344427300&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=naoki850c-22',
            btnImg: '//ir-jp.amazon-adsystem.com/e/ir?t=naoki850c-22&l=am2&o=9&a=4344427300'
          },
          {
            bookLink: 'https://www.amazon.co.jp/gp/product/479739580X/ref=as_li_tl?ie=UTF8&camp=247&creative=1211&creativeASIN=479739580X&linkCode=as2&tag=naoki850c-22&linkId=6428a83e925d4ff1642aff76185ec1d8',
            bookImg: '//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&MarketPlace=JP&ASIN=479739580X&ServiceVersion=20070822&ID=AsinImage&WS=1&Format=_SL250_&tag=naoki850c-22',
            btnImg: '//ir-jp.amazon-adsystem.com/e/ir?t=naoki850c-22&l=am2&o=9&a=479739580X'
          }
        ]
      }
    }
  }

</script>

<style scoped>
  .recommend-book img {
    width: 100%;
  }
</style>