<template>
  <div v-if="totalPage > 0" class="siimple--text-center">
    <ul class="paginate">
      <li @click="emitClickPage(currentPage - 1)"><i class="fas fa-chevron-left"></i></li>
      <li :class="isCurrent(page)" v-for="page in displayPages" :key="page" @click="emitClickPage(page)">
        {{ page }}
      </li>
      <li @click="emitClickPage(currentPage + 1)"><i class="fas fa-chevron-right"></i></li>
    </ul>
  </div>
</template>

<script>
  export default {
    props: {
      currentPage: {
        type: Number,
        default: 1
      },
      totalPage: {
        type: Number,
        default: 0
      }
    },
    computed: {
      displayPages: function() {
        if (this.totalPage && this.totalPage <= 5) { return this.totalPage; }
        if (this.currentPage - 3 <= 0) { return 5; }
        let tmpPages = [];
        [-2, -1, 0, 1, 2].forEach((i) => {
          const tmpPage = this.currentPage + i;
          if (tmpPage > this.totalPage) { return true; }
          tmpPages.push(tmpPage);
        });
        return tmpPages;
      }
    },
    methods: {
      isCurrent: function(page) {
        let defaultClass = 'page-' + page;
        return (page === this.currentPage) ? defaultClass + ' current' : defaultClass
      },
      emitClickPage(page) {
        this.$emit('click-page', page)
      },
      updateCurrent(page) {
        let current_class_elements = document.getElementsByClassName('current');
        if (current_class_elements.length > 0) {
          current_class_elements[0].classList.remove('current');
          document.getElementsByClassName('page-' + page)[0].classList.add('current');
        }
      }
    }
  }

</script>

<style scoped>
  li {
    list-style: none;
    font-weight: bold;
  }
  .paginate {
    display: inline-flex;
    display: -webkit-inline-box;
    display: -ms-inline-flexbox;
    padding: 9px 8px;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
  }

  .paginate li {
    display: block;
    color: #5ea25a;
    text-decoration: none;
    padding: 9px 12px;
    margin-right: 6px;
    border-radius: 16px;
    background: #fff;
    -webkit-transition: all 0.3s linear;
    -moz-transition: all 0.3s linear;
    transition: all 0.3s linear;
    box-shadow: 0 3px 1px -2px rgba(0,0,0,0.2), 0 2px 2px 0 rgba(0,0,0,0.14), 0 1px 5px 0 rgba(0,0,0,0.12);
  }
  .paginate li:hover {
    color: #4f664e;
    background: #c9dec8;
  }
  .paginate li.current {
    background: #009688;
    color: #fff;
  }
</style>