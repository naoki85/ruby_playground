import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'

import Auth from '../store/modules/auth'

import Top from '../components/top'
import User from '../components/user'
import UserCreate from '../components/user_create'
import Login from '../components/login'

Vue.use(VueRouter)

var router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Top },
    { path: '/users/sign_up', component: UserCreate },
    { path: '/users/sign_in', component: Login },
    { path: '/users/:id', component: User }
  ]
});

router.beforeEach((to, from, next) => {
  var authentication_token = localStorage.getItem('bookRecorderAuthenticationToken');
  if (authentication_token) {
    Auth.state.loggedIn = true;
  } else {
    Auth.state.loggedIn = false;
  }
  next();
});

export default router
