import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'

import Auth from '../store/modules/auth'

import Top from '../components/top/top'
import SignUp from '../components/sessions/sign_up'
import SignIn from '../components/sessions/sign_in'
import User from '../components/users/show'
// import UserEdit from '../components/users/edit'
import UserBooksIndex from '../components/user_books/index'
import Book from '../components/books/show'
import PrivacyPolicy from '../components/top/privacy_policy'
import UserPolicy from '../components/top/user_policy'
// import Search from '../components/books/search'
import NotFound from '../components/errors/not_found'

Vue.use(VueRouter)

var router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Top },
    { path: '/sign_up', component: SignUp },
    { path: '/sign_in', component: SignIn },
    // { path: '/users/edit', component: UserEdit, meta: { requiresAuth: true } },
    { path: '/users/:id', component: User },
    { path: '/user_books', component: UserBooksIndex, meta: { requiresAuth: true } },
    // { path: '/books/search', component: Search, meta: { requiresAuth: true } },
    { path: '/books/:id', component: Book },
    { path: '/privacy_policy', component: PrivacyPolicy },
    { path: '/user_policy', component: UserPolicy },
    { path: '/not_found', component: NotFound }
  ]
});

router.beforeEach((to, from, next) => {
  var authentication_token = localStorage.getItem('bookRecorderAuthenticationToken');
  var user_id = localStorage.getItem('bookRecorderUserId');
  if (authentication_token) {
    Auth.state.loggedIn = true;
    Auth.state.userId = user_id;
  } else {
    Auth.state.loggedIn = false;
  }

  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!Auth.state.loggedIn) {
      next({ path: '/'});
    } else {
      next();
    }
  } else {
    next();
  }
});

export default router
