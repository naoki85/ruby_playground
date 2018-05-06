import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'

import Top from '../components/top'
import User from '../components/user'
import UserCreate from '../components/user_create'
import Login from '../components/login'

Vue.use(VueRouter)

var router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Top },
    { path: '/user/:id', component: User },
    { path: '/users/sign_up', component: UserCreate },
    { path: '/users/sign_in', component: Login }
  ]
});

export default router
