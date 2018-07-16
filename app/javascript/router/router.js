import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'

// Vuex
import Auth from '../store/modules/auth'
import Alert from '../store/modules/alert'

// Utils
import DateTime from '../utils/date_time'

import Top from '../components/top/top'
import SignIn from '../components/sessions/sign_in'

// User
import User from '../components/users/show'
import UserEdit from '../components/users/edit'

// Book
import Book from '../components/books/show'
import Search from '../components/books/search'

// Static pages
import PrivacyPolicy from '../components/top/privacy_policy'
import UserPolicy from '../components/top/user_policy'

// Publisher
import PublisherShow from '../components/publishers/show'

// Post
import PostsIndex from '../components/posts/index'
import PostsShow from '../components/posts/show'
import PostsNew from '../components/posts/new'
import PostsEdit from '../components/posts/edit'

// Error
import NotFound from '../components/errors/not_found'

Vue.use(VueRouter)

var router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Top },
    { path: '/sign_in', component: SignIn },
    { path: '/users/edit', component: UserEdit, meta: { requiresAuth: true } },
    { path: '/users/:id', component: User },
    { path: '/books/search', component: Search, meta: { requiresAuth: true } },
    { path: '/books/:id', component: Book },
    { path: '/privacy_policy', component: PrivacyPolicy },
    { path: '/user_policy', component: UserPolicy },
    { path: '/publishers/:id', component: PublisherShow },
    { path: '/posts', component: PostsIndex },
    { path: '/posts/new', component: PostsNew, meta: { requiresAuth: true }  },
    { path: '/posts/edit/:id', component: PostsEdit, meta: { requiresAuth: true }  },
    { path: '/posts/:id', component: PostsShow },
    { path: '/not_found', component: NotFound }
  ]
});

router.beforeEach((to, from, next) => {
  Alert.state.isError = false;
  Alert.state.isSuccess = false;

  var authentication_token = localStorage.getItem('bookRecorderAuthenticationToken');
  var user_id = localStorage.getItem('bookRecorderUserId');
  var expired_at = localStorage.getItem('bookRecorderExpiredAt');
  var today = DateTime.today();

  if (authentication_token && expired_at > today) {
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
