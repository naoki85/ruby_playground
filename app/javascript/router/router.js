import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'

// Post
import PostsIndex from '../components/posts/index'
import PostsShow from '../components/posts/show'

// Error
import NotFound from '../components/errors/not_found'

Vue.use(VueRouter)

var router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: PostsIndex },
    { path: '/posts', component: PostsIndex },
    { path: '/posts/:id', component: PostsShow },
    { path: '/not_found', component: NotFound }
  ]
});

export default router
